const mysql = require('mysql');
require('dotenv').config();

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE_NAME,
    port:process.env.PORT
});

connection.connect((error) => {
    if (error) throw error;
    console.log('Connected to MySQL database!');
});

async function executeQuery(query, values) {
    try {
        const results = await new Promise((resolve, reject) => {
            connection.query(query, values, (err, res) => {
                if (err) {
                    console.log('Error in database:', err);
                    reject(err); // Reject with error
                    return;
                }
                resolve(res); // Resolve with results
            });
        });
        return results;
    } catch (error) {
        console.error('executeQuery error:', error);
        throw error;
    }
}

module.exports = {
    connection,
    executeQuery
};
