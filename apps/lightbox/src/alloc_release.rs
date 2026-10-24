//! Give memory the system allocator keeps after frees back to the system
//! ([`lightbox_engine::memory::set_release_hook`]). The platform call lives in
//! `lightbox-sysmem`, the workspace's only crate allowed `unsafe`.

/// Install the hook.
pub fn install() {
    lightbox_engine::memory::set_release_hook(release);
}

fn release() {
    let _ = lightbox_sysmem::release_free_memory();
}
