const mysql = require('mysql');
require('dotenv').config();
const connection = mysql.createConnection({
    host: 'localhost',
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE_NAME
});

connection.connect((error) => {
    if (error) throw error;
    console.log('Connected to MySQL database!');
});
async function executeQuery(query, values) {
    const results = await new Promise((resolve) => {
        connection.query(query, values, (err, res) => {
            if (err) {
                console.log(err,'error in database')
                resolve(err)

            }
            resolve(res)

        })
    })
    return results

}
module.exports = {
    connection,
    executeQuery
}