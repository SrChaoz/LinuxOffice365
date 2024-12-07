# **LinuxOffice365**

**LinuxOffice365** is an application developed with the Electron.js framework that acts as a client for the Microsoft 365 online suite, optimized for Linux users.

This app turns Microsoft Office 365 tools into a desktop experience, providing quick and convenient access to your favorite apps like Word, Excel, PowerPoint, and more, right from your Linux operating system.

## Main Features:
- **Desktop integration**: Add shortcuts to the application menu with custom icons.
- **Optimization for Linux**: Designed especially for users of Linux distributions.

## Installation instructions

Follow these steps to install the application on your Linux system:

1. Clone this repository:
    ```bash
    git clone https://github.com/SrChaoz/LinuxOffice365.git
    ```

2. Access the cloned repository:
    ```bash
    cd LinuxOffice365
    ```

3. Grant permissions to the installation script:
    ```bash
    chmod +x install.sh
    ```

4. Run the installation script:
    ```bash
    ./install.sh
    ```

## Uninstallation instructions

To uninstall **LinuxOffice365**, follow these steps:

1. Remove the installed files:
    ```bash
    rm -rf ~/.local/bin/LinuxOficce365-1.0.0.AppImage
    rm -rf ~/.local/share/applications/LinuxOficce365.desktop
    rm -rf ~/.local/share/icons/linuxoficce365.png
    ```

2. Optionally, remove the cloned repository folder:
    ```bash
    rm -rf LinuxOffice365
    ```

---

