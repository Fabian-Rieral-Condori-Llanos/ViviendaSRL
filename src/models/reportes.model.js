const db = require('../config/db');

// 1. Reporte de Contratos Activos y Vencidos
exports.obtenerContratos = (callback) => {
    const consulta = 'CALL ReporteContratos()';
    db.query(consulta, (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 2. Reporte de Pagos Pendientes por Cliente o Inmueble
exports.obtenerPagosPendientes = (mes, anio, callback) => {
    const consulta = 'CALL ReportePagosPendientes(?, ?)';
    db.query(consulta, [mes, anio], (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 3. Reporte de Ingresos Mensuales
exports.obtenerIngresosMensuales = (mes, anio, callback) => {
    const consulta = 'CALL ReporteIngresosMensuales(?, ?)';
    db.query(consulta, [mes, anio], (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 4. Reporte de Comisiones por Agente
exports.obtenerComisiones = (callback) => {
    const consulta = 'CALL ReporteComisiones()';
    db.query(consulta, (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};

// 5. Reporte de Visitas a Inmuebles
exports.obtenerVisitas = (callback) => {
    const consulta = 'CALL ReporteVisitas()';
    db.query(consulta, (err, resultado) => {
        if (err) return callback(err);
        callback(null, resultado[0]);
    });
};
