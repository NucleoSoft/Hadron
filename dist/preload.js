"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var electron_1 = require("electron");
electron_1.contextBridge.exposeInMainWorld('api', {
    sendMessage: function (channel, data) {
        electron_1.ipcRenderer.send(channel, data);
    },
    receiveMessage: function (channel, callback) {
        electron_1.ipcRenderer.on(channel, callback);
    }
});
