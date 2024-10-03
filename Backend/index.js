const express = require('express');
const cors = require('cors'); // Import the CORS middleware
const mongoose = require('mongoose'); // Import Mongoose for MongoDB
const app = express();

// Use the CORS middleware with default options to allow all origins
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Connect to MongoDB
mongoose.connect('mongodb+srv://Aayasya:Saa%402004@poolmate.dtfmu.mongodb.net/transportation', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(() => {
        console.log("Connected");
    })
    .catch((error) => {
        console.error("Error connecting to mongoose:", error);
    });



// Define Mongoose schemas and models
const Source = mongoose.model('Source', new mongoose.Schema({ address: String }));
const Destination = mongoose.model('Destination', new mongoose.Schema({ address: String }));
const EstimatedTime = mongoose.model('EstimatedTime', new mongoose.Schema({ time: String }));
const StartTime = mongoose.model('StartTime', new mongoose.Schema({ time: String }));
const Card = mongoose.model('Card', new mongoose.Schema({
    source: { type: mongoose.Schema.Types.ObjectId, ref: 'Source' },
    destination: { type: mongoose.Schema.Types.ObjectId, ref: 'Destination' },
    estimatedTime: { type: mongoose.Schema.Types.ObjectId, ref: 'EstimatedTime' },
    startTime: { type: mongoose.Schema.Types.ObjectId, ref: 'StartTime' }
}));

app.listen(2000, () => {
    console.log("Connected to server on port 2000");
});

// POST method to add a new source
app.post("/api/source", async (req, res) => {
    const source = new Source({ address: req.body.address });
    await source.save();
    res.status(201).send({ message: "Source added successfully", source });
});

// GET method to retrieve all sources
app.get("/api/source", async (req, res) => {
    const sources = await Source.find();
    res.status(200).send(sources);
});

// POST method to add a new destination
app.post("/api/destination", async (req, res) => {
    const destination = new Destination({ address: req.body.address });
    await destination.save();
    res.status(201).send({ message: "Destination added successfully", destination });
});

// GET method to retrieve all destinations
app.get("/api/destination", async (req, res) => {
    const destinations = await Destination.find();
    res.status(200).send(destinations);
});

// POST method to add a new estimated time
app.post("/api/estimatedTime", async (req, res) => {
    const estimatedTime = new EstimatedTime({ time: req.body.time });
    await estimatedTime.save();
    res.status(201).send({ message: "Estimated time added successfully", estimatedTime });
});

// GET method to retrieve all estimated times
app.get("/api/estimatedTime", async (req, res) => {
    const estimatedTimes = await EstimatedTime.find();
    res.status(200).send(estimatedTimes);
});

// POST method to add a new start time
app.post("/api/startTime", async (req, res) => {
    const startTime = new StartTime({ time: req.body.time });
    await startTime.save();
    res.status(201).send({ message: "Start time added successfully", startTime });
});

// GET method to retrieve all start times
app.get("/api/startTime", async (req, res) => {
    const startTimes = await StartTime.find();
    res.status(200).send(startTimes);
});

// POST method to create a new card
app.post("/api/card", async (req, res) => {
    const { sourceId, destinationId, estimatedTimeId, startTimeId } = req.body;

    // Log IDs for debugging
    console.log("Source ID: ", sourceId);
    console.log("Destination ID: ", destinationId);
    console.log("Estimated Time ID: ", estimatedTimeId);
    console.log("Start Time ID: ", startTimeId);

    try {
        // Validate the existence of source, destination, estimated time, and start time
        const source = await Source.findById(sourceId);
        const destination = await Destination.findById(destinationId);
        const estimatedTime = await EstimatedTime.findById(estimatedTimeId);
        const startTime = await StartTime.findById(startTimeId);

        if (!source || !destination || !estimatedTime || !startTime) {
            return res.status(400).send({ message: "Invalid source, destination, estimated time, or start time." });
        }

        // Create and save the card
        const card = new Card({
            source: source._id,
            destination: destination._id,
            estimatedTime: estimatedTime._id,
            startTime: startTime._id
        });

        await card.save();
        res.status(201).send({ message: "Card created successfully", card });

    } catch (error) {
        console.error("Error creating card:", error);
        res.status(500).send({ message: "Server error" });
    }
});


// GET method to retrieve all cards
app.get("/api/card", async (req, res) => {
    const cards = await Card.find().populate('source destination estimatedTime startTime');
    res.status(200).send(cards);
});

// GET method to retrieve a card by ID
app.get("/api/card/:id", async (req, res) => {
    const card = await Card.findById(req.params.id).populate('source destination estimatedTime startTime');
    if (!card) return res.status(404).send({ message: "Card not found." });
    res.status(200).send(card);
});

// PUT method to update a card by ID
app.put("/api/card/:id", async (req, res) => {
    const { sourceId, destinationId, estimatedTimeId, startTimeId } = req.body;
    const card = await Card.findById(req.params.id);

    if (!card) return res.status(404).send({ message: "Card not found." });

    // Validate the new IDs
    const source = await Source.findById(sourceId);
    const destination = await Destination.findById(destinationId);
    const estimatedTime = await EstimatedTime.findById(estimatedTimeId);
    const startTime = await StartTime.findById(startTimeId);

    if (!source || !destination || !estimatedTime || !startTime) {
        return res.status(400).send({ message: "Invalid source, destination, estimated time, or start time." });
    }

    card.source = source._id;
    card.destination = destination._id;
    card.estimatedTime = estimatedTime._id;
    card.startTime = startTime._id;

    await card.save();
    res.status(200).send({ message: "Card updated successfully", card });
});

// DELETE method to remove a card by ID
app.delete("/api/card/:id", async (req, res) => {
    const card = await Card.findByIdAndDelete(req.params.id);
    if (!card) return res.status(404).send({ message: "Card not found." });
    res.status(200).send({ message: "Card deleted successfully" });
});
