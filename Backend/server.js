// backend/server.js
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: { origin: "*" }, // allow your iOS app to connect during development
});

io.on("connection", (socket) => {
  console.log("New client connected:", socket.id);

  socket.on("move", (data) => {
    console.log("move:", data);
    socket.broadcast.emit("move", data);
  });

  socket.on("disconnect", () => {
    console.log("Client disconnected:", socket.id);
  });
});

server.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
