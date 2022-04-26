const mongoose = require("mongoose");

const TodoSchema = {
    title: {
        type: String,
        required: true,
    },

    content: {
        type: String,
    }
};

const Todo = mongoose.model("Todo", TodoSchema);

module.exports = Todo;