const express = require("express");
const prisma = require("../db/prisma"); // Adjust path as needed

const router = express.Router();

// Save a deck
router.post("/", async (req, res) => {
  const { userId, name, cards, imageUrl } = req.body;

  try {
    const deck = await prisma.deck.create({
      data: {
        userId,
        name,
        cards, // Prisma accepts JSON directly for Json type
        imageUrl,
      },
    });

    res.status(201).json({ deckId: deck.id });
  } catch (err) {
    console.error(err);
    res.status(500).send("Failed to save deck");
  }
});

// Get decks for a user
router.get("/:userId", async (req, res) => {
  const { userId } = req.params;

  try {
    const decks = await prisma.deck.findMany({
      where: { userId: Number(userId) },
    });
    res.json(decks);
  } catch (err) {
    console.error(err);
    res.status(500).send("Failed to fetch decks");
  }
});

module.exports = router;
