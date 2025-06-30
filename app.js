const express = require('express');
const path = require('path');
const app = express();

// Sirve archivos estáticos desde la carpeta 'views'
app.use(express.static(path.join(__dirname, 'views')));
app.use(express.json());

// Rutas de reportes (controladores y lógica)
const reportesRoutes = require('./src/routes/reportes.routes');
app.use('/api/reportes', reportesRoutes);

// Página de inicio redirige al índice de vistas
app.get('/', (req, res) => res.redirect('/index.html'));

// Servidor
const PORT = 4000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
