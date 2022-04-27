const express = require('express')
const router = express.Router()

const Todo = require("../../schema/todo");

router.get('/', async (req, res) => {
    try {
        let todos = await Todo.find();
        res.send(todos);
    } catch(err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
})

router.post('/', async (req, res) => {
    if(!req.body.title) {
        res.status(400).json({ message: "Missing 'title'"});
        return;
    }

    try {
        let newTodo = new Todo({
            title: req.body.title,
            content: req.body.content,
        });

        await newTodo.save();

        console.log(req.body);
        res.sendStatus(200);
    } catch(err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

router.delete("/:id", async (req, res) => {
    try {
        let todo = await Todo.findOne({ _id: req.params.id });
        if(!todo) {
            res.status(400).json({ message: "Invalid 'id'"});
            return;
        }

        await Todo.deleteOne({ _id: todo._id });
        res.sendStatus(200);
    } catch(err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

module.exports = router;