"use strict";

import * as express from "express";
const passport = require("passport");
const router = express.Router();

const query = require("../queries/queries");
const ctrlAuth = require("../queries/authentication");

router.post("/elephant/register", ctrlAuth.registerUser);
router.post("/elephant/login", ctrlAuth.loginUser);

router.get("/elephant/profile/:id", passport.authenticate("jwt", { session : false }), query.getUserById);

router.get("/elephant", query.getAllUsers);
router.post("/elephant", query.createUser);
router.put("/elephant/:id", query.updateUserByID);
router.delete("/elephant/:id", query.removeUserById);

module.exports = router;
