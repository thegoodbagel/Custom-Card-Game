// backend/server.js
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: ["http://localhost:3000", "http://192.168.0.10:3000"], // Your Mac's IP
    methods: ["GET", "POST"],
  },
});
const addon = require("./build/Release/addon");
const games = new Map();

io.on("connection", (socket) => {
  console.log("New client connected:", socket.id);

  const game = new addon.newGame();
  game.addPlayer(socket.id); // Add player to game
  games.set(socket.id, game);

  socket.on("drawCard", () => {
    const game = games.get(socket.id);
    if (!game) return;

    const result = game.drawCard(socket.id); // returns JSON string
    socket.emit("drawCard", { playerID: socket.id, card: JSON.parse(result) });
  });

  socket.on("getState", () => {
    const game = games.get(socket.id);
    if (!game) return;

    const result = game.getState(socket.id); // returns JSON string
    socket.emit("getState", JSON.parse(result));
  });

  socket.on("disconnect", () => {
    console.log(`Player ${socket.id} disconnected`);
    games.delete(socket.id);
  });
});

server.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
