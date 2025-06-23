// backend/server.js
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: { origin: "*" }, // allow your iOS app to connect during development
});
const addon = require("./build/Release/addon");

io.on("connection", (socket) => {
  console.log("New client connected:", socket.id);
  const game = new addon.newGame();

  socket.on("drawCard", (data) => {
    console.log(`Player ${socket.id} drawing a card`);
    const result = game.drawCard(socket.id);
    io.emit("drawCard", { playerID: socket.id, card: JSON.parse(result) });
  });

  socket.on("getState", (data) => {
    console.log(`Getting game stack from perspective of ${socket.id}`);
    const result = game.getState(socket.id);
    socket.emit("getState", JSON.parse(result));
  });

  socket.on("disconnect", () => {
    console.log(`Player ${socket.id} disconnected:`, socket.id);
  });
});

server.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
