---
title: OsxFUSE Folder Error for macOS BigSur
author: Yichao Yao
Subcollection: Misc
---

## OsxFUSE Error
After the intallation of macOS BigSur version 11.0.1 in your Macbook PC, it will be unable to mount the CSF OsxFUSE folder using **sshfs**.
This problem can be solved following:

Step 1: Install the new version of OsxFUSE:
Download .dmg file and install it following the guidance, here is the link:
```
https://github.com/osxfuse/osxfuse/releases/tag/macfuse-4.0.3
```

Step 2: When you try to mount the folder using sshfs after the installation of MacFuse 4.0.3, you may have this error:
```
dyld: Library not loaded: /usr/local/lib/libosxfuse_i64.2.dylib
```

Step 3: You need to run the following command in Terminal to create a symlink pointing to the new version of the library:
```
cd /usr/local/lib/
ln -s “libosxfuse.2.dylib” “/usr/local/lib/libosxfuse_i64.2.dylib”
```

If permission denied, use this command and enter admin password:
```
sudo ln -s “libfuse.2.dylib” “/usr/local/lib/libosxfuse_i64.2.dylib”
```

Step 4: **sshfs** should work well now, mount the folder as normal

*Thanks Benjamin Fleischer(Member of FUSE for macOS) for his help*
