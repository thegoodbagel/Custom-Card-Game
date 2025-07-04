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
// For now, only have one game
// const games = new Map();
const game = new addon.newGame();

io.on("connection", (socket) => {
  console.log("New client connected:", socket.id);
  game.addPlayer(socket.id);
  const result = game.getState(socket.id); // returns JSON string
  socket.emit("getState", JSON.parse(result));

  socket.on("drawCard", () => {
    const cardDrawn = game.drawCard(socket.id); // returns JSON string
    console.log(`Player ${socket.id} drew a card:`, cardDrawn);
    const result = game.getState(socket.id); // returns JSON string
    socket.emit("getState", JSON.parse(result));
    console.log(result);
  });

  socket.on("getState", () => {
    console.log("State requested from player:", socket.id);
    const result = game.getState(socket.id); // returns JSON string
    socket.emit("getState", JSON.parse(result));
  });

  socket.on("disconnect", () => {
    console.log(`Player ${socket.id} disconnected`);
    // TODO: Remove player from game
  });
});

server.listen(3000, "0.0.0.0", () => {
  console.log("Server running on http://0.0.0.0:3000");
});
