const express = require('express');
const User = require('../models/user.model');

const router = express.Router();

router.post('/signup', async (req, res) => {
  try {
    const existingUser = await User.findOne({ email: req.body.email });

    if (!existingUser) {
      const newUser = new User({
        email: req.body.email,
        password: req.body.password
      });

      try {
        const savedUser = await newUser.save();
        console.log(savedUser);
        res.json(savedUser);
      } catch (saveError) {
        console.log(saveError);
        res.status(500).json(saveError);
      }
    } else {
      res.json({
        message: 'Email is not available'
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

router.post('/signin', async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email, password: req.body.password });
    if (user) {
      res.json(user);
    } else {
      res.status(404).json({ message: 'User not found or incorrect credentials' });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json(error);
  }
});

module.exports = router;
