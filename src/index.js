import { app, BrowserWindow, ipcMain } from "electron";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

let mainWindow;
// create window for main load window
function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      preload: path.join(__dirname, "preload.js"), 
      contextIsolation: true,
      enableRemoteModule: false,
      nodeIntegration: false,
    },
  });

// load a main window
  mainWindow.loadURL("https://www.office.com/");
// load seconds windows
  mainWindow.webContents.on("did-finish-load", () => {
    mainWindow.webContents.executeJavaScript(`
      document.addEventListener("click", (event) => {
        const target = event.target.closest("a");
        if (!target) return;
  
        const url = target.href;
        if (url.includes("word.office.com")) {
          window.electron.openApp("https://word.office.com/");
          event.preventDefault();
        } else if (url.includes("excel.office.com")) {
          window.electron.openApp("https://excel.office.com/");
          event.preventDefault();
        } else if (url.includes("powerpoint.office.com")) {
          window.electron.openApp("https://powerpoint.office.com/");
          event.preventDefault();
        }
      });
    `);
  });
}





// Make a new window
function createChildWindow(url) {
  const childWindow = new BrowserWindow({
    width: 1000,
    height: 700,
    webPreferences: {
      contextIsolation: true,
      enableRemoteModule: false,
      nodeIntegration: false,
    },
  });
  childWindow.loadURL(url);
}

// Listen events of render
ipcMain.on("open-app", (event, appUrl) => {
  createChildWindow(appUrl);
});

app.whenReady().then(() => {
  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") app.quit();
});
