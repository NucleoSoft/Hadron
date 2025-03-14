import { contextBridge, ipcRenderer } from "electron";

contextBridge.exposeInMainWorld('api', {
    sendMessage: (channel: string, data: unknown) => {
        ipcRenderer.send(channel, data);
    },
    receiveMessage: (channel: string, callback: ( ...args: unknown[]) => void ) => {
        ipcRenderer.on(channel, callback);
    }
});