const express = require('express');
const router = express.Router();
const controller = require('../controllers/reportes.controller');

router.get('/contratos', controller.reporteContratos);
router.get('/pagos-pendientes/:mes/:anio', controller.reportePagosPendientes);
router.get('/ingresos/:mes/:anio', controller.reporteIngresos);
router.get('/comisiones', controller.reporteComisiones);
router.get('/visitas', controller.reporteVisitas);

module.exports = router;
