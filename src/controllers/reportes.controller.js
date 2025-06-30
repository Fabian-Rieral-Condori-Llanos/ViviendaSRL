const ReporteModel = require('../models/reportes.model');

exports.reporteContratos = (req, res) => {
    ReporteModel.obtenerContratos((err, datos) => {
        if (err) return res.status(500).json({ error: err });
        res.json(datos);
    });
};

exports.reportePagosPendientes = (req, res) => {
    const { mes, anio } = req.params;
    ReporteModel.obtenerPagosPendientes(mes, anio, (err, datos) => {
        if (err) return res.status(500).json({ error: err });
        res.json(datos);
    });
};

exports.reporteIngresos = (req, res) => {
    const { mes, anio } = req.params;
    ReporteModel.obtenerIngresosMensuales(mes, anio, (err, datos) => {
        if (err) return res.status(500).json({ error: err });
        res.json(datos);
    });
};

exports.reporteComisiones = (req, res) => {
    ReporteModel.obtenerComisiones((err, datos) => {
        if (err) return res.status(500).json({ error: err });
        res.json(datos);
    });
};

exports.reporteVisitas = (req, res) => {
    ReporteModel.obtenerVisitas((err, datos) => {
        if (err) return res.status(500).json({ error: err });
        res.json(datos);
    });
};
