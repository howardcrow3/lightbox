#!/usr/bin/env bash
# App-specific installer and package assertions retained alongside shared packaging lint.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

for want in '<UIRef Id="LightboxUI" />' 'Value="InstallDirDlg"' '<Property Id="WIXUI_INSTALLDIR" Value="INSTALLFOLDER" />' \
    'Key="Software\Lightbox" Name="InstallFolder"' 'Value="LaunchLightbox"'; do
  grep -qF "$want" packaging/windows/lightbox.wxs || { echo "::error::lightbox.wxs lost: $want" >&2; exit 1; }
done
grep -qF '<DialogRef Id="ExitDialog" />' packaging/windows/lightbox.wxs \
  || { echo "::error::ExitDialog is not referenced; installs and removes end without a completion dialog" >&2; exit 1; }

python3 - <<'PYEOF'
import yaml
manifests = []
for name in ("ai.storyteller.lightbox.yml", "ai.storyteller.lightbox.bundle.yml"):
    with open("packaging/linux/flatpak/" + name) as source:
        manifest = yaml.safe_load(source)
    assert manifest["id"] == "ai.storyteller.lightbox" and manifest["command"] == "lightbox", name
    manifests.append(manifest)
for key in ("runtime", "runtime-version", "sdk", "finish-args"):
    assert manifests[0][key] == manifests[1][key], f"Flatpak manifests disagree on {key}"
print("Lightbox package identity ok")
PYEOF

# The macOS bundle must declare only file types Lightbox can open. It used to carry PhotoCraft's
# `.pcraft` document type and imported PSB/QOI declarations, so Launch Services typed PhotoCraft
# documents as Lightbox's and `.pcraft` had three claimant apps (issue #1951). plistlib parses the
# template as a property list too, which is the syntax check package.sh's `plutil -lint` repeats on
# the substituted file.
python3 - <<'PYEOF'
import plistlib
with open("packaging/macos/Info.plist.in", "rb") as source:
    plist = plistlib.load(source)
for key, value in {
    "CFBundleIdentifier": "ai.storyteller.lightbox",
    "CFBundleExecutable": "Lightbox",
    "CFBundleIconFile": "Lightbox",
    "LSMinimumSystemVersion": "11.0",
}.items():
    assert plist.get(key) == value, f"Info.plist {key}: {plist.get(key)!r}, expected {value!r}"
for key in ("CFBundleShortVersionString", "CFBundleVersion", "LightboxVersion", "LightboxBuildCommit"):
    assert plist.get(key), f"Info.plist lost {key}"
declared = set()
for section in ("UTExportedTypeDeclarations", "UTImportedTypeDeclarations"):
    for entry in plist.get(section, []):
        tags = entry.get("UTTypeTagSpecification", {})
        declared.update(tags.get("public.filename-extension", []))
        declared.update(tags.get("public.mime-type", []))
        declared.add(entry.get("UTTypeIdentifier", ""))
unsupported = {name.lower() for name in declared} & {
    "pcraft",
    "psb",
    "qoi",
    "application/x-lightbox",
    "ai.storyteller.lightbox.document",
    "ai.storyteller.lightbox.qoi",
    "com.adobe.photoshop-large-image",
}
assert not unsupported, f"Info.plist declares types Lightbox cannot open: {sorted(unsupported)}"
print("Lightbox macOS bundle types ok")
PYEOF
