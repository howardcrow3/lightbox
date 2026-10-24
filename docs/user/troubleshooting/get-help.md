---
title: Get help with a problem
description: What to include when you ask for help with a Lightbox bug, and where to post it.
order: 30
verified: 0.7.1
---

Open an issue in the [issue tracker](https://github.com/howardcrow3/lightbox/issues). Include your version, your system, what you did, and what you expected.

## What to include

1. **Your version.** Choose **Help** > **About Lightbox** (on macOS, **Lightbox** > **About Lightbox**).
2. **Your system.** For example Windows 11, 64-bit. **Help** > **System Info…** shows details about your computer.
3. **The steps.** What you clicked, in order, and what happened.
4. **The camera and file type**, if the problem is with a photo.
5. **A sample file**, if a raw or other photo renders wrong. Maintainers ask for the original file, not an export. A link to a shared folder works. Uploading raws to [raw.pixls.us](https://raw.pixls.us) also helps, because every file there becomes a permanent test sample for that camera.
6. **A screenshot** of Lightbox next to the camera JPEG or the other app, for colour problems.
7. **The log file.** Choose **Help** > **Open Log Folder** and attach `lightbox.log`.

## Where the log is

Lightbox writes its log to `logs/lightbox.log` in its settings folder. On Windows that is `%APPDATA%\Lightbox\logs\`. Each start moves the previous log to `lightbox.1.log`, and that one to `lightbox.2.log`, so the log of a run that crashed survives the next start.

## Still stuck?

Open an issue in the [issue tracker](https://github.com/howardcrow3/lightbox/issues).
