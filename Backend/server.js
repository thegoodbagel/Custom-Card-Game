const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const cors = require("cors");
const authRoutes = require("./api/auth");
const deckRoutes = require("./api/decks");
const addon = require("./build/Release/addon");
const { PrismaClient } = require("@prisma/client");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: ["http://localhost:3000", "http://192.168.0.10:3000"],
    methods: ["GET", "POST"],
  },
});

app.use(cors());
app.use(express.json()); // for req.body parsing
app.use("/api/auth", authRoutes);
app.use("/api/decks", deckRoutes);

const prisma = new PrismaClient();

// -- SOCKET.IO LOGIC --
const game = new addon.newGame();

io.on("connection", (socket) => {
  console.log("Client connected:", socket.id);
  game.addPlayer(socket.id);
  socket.emit("getState", JSON.parse(game.getState(socket.id)));

  socket.on("drawCard", () => {
    game.drawCard(socket.id);
    socket.emit("getState", JSON.parse(game.getState(socket.id)));
  });

  socket.on("playCard", (cardID) => {
    game.playCard(socket.id, cardID);
    socket.emit("getState", JSON.parse(game.getState(socket.id)));
  });

  socket.on("disconnect", () => {
    console.log(`Disconnected: ${socket.id}`);
    game.removePlayer(socket.id);
  });
});

server.listen(3000, "0.0.0.0", () => {
  console.log("Server running on http://0.0.0.0:3000");
});
