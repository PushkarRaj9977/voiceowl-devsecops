const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 3000;
const MONGO_URI = process.env.MONGO_URI || 'mongodb://mongo:27017/formdb';

app.use(bodyParser.urlencoded({ extended: true }));

mongoose.connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log("✅ Connected to MongoDB"))
    .catch(err => console.error("❌ MongoDB connection error:", err));

const FormSchema = new mongoose.Schema({ name: String, email: String });
const FormModel = mongoose.model('Form', FormSchema);

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/form.html');
});

app.post('/submit', async (req, res) => {
    const { name, email } = req.body;
    const entry = new FormModel({ name, email });
    await entry.save();
    res.send("Form submitted successfully!");
});

app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
