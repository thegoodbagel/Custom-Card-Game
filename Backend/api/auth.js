const express = require("express");
const bcrypt = require("bcrypt");
const prisma = require("../db/prisma"); // Adjust path as needed

const router = express.Router();

// Register
router.post("/register", async (req, res) => {
  const { username, password } = req.body;
  try {
    const hash = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: {
        username,
        passwordHash: hash,
      },
    });

    res.status(201).json({ userId: user.id });
  } catch (err) {
    console.error(err);
    // Prisma throws error code P2002 for unique constraint violation (duplicate username)
    if (err.code === "P2002") {
      res.status(409).json({ error: "Username already taken" });
    } else {
      res.status(500).json({ error: "Server error" });
    }
  }
});

// Login
router.post("/login", async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await prisma.user.findUnique({
      where: { username },
    });

    if (!user) return res.status(404).json({ error: "User not found" });

    const valid = await bcrypt.compare(password, user.passwordHash);
    if (!valid) return res.status(403).json({ error: "Invalid password" });

    res.json({ userId: user.id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;
