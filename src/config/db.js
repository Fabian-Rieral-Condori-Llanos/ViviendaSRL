const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: '192.168.0.5',
  user: 'root',
  password: 'password',
  database: 'Vivienda'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Conexión a MySQL establecida.');
});

module.exports = connection;
