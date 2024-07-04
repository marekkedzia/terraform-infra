const AWS = require('aws-sdk');
const MongoClient = require('mongodb').MongoClient;

const s3 = new AWS.S3();
const mongoUrl = process.env.MONGO_URL;
const bucketName = process.env.S3_BUCKET_NAME;
const dbName = process.env.MONGO_DB_NAME;
const collectionName = process.env.MONGO_COLLECTION_NAME;

exports.handler = async (event) => {
    const fileId = event.fileId;

    try {
        const params = {
            Bucket: bucketName,
            Key: fileId,
        };
        const data = await s3.getObject(params).promise();
        const fileSize = data.ContentLength;

        const client = await MongoClient.connect(mongoUrl, { useNewUrlParser: true, useUnifiedTopology: true });
        const db = client.db(dbName);
        const collection = db.collection(collectionName);

        await collection.updateOne(
            { _id: fileId },
            { $set: { size: fileSize } }
        );

        return { statusCode: 200, body: JSON.stringify({ message: "File size updated successfully!" }) };
    } catch (error) {
        console.error(error);
        return { statusCode: 500, body: JSON.stringify({ message: "Failed to update file size" }) };
    }
};
