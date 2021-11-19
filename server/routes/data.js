const express = require('express');

const router = express.Router();

const {
  getTests,
  getTest,
  updateResult,
  deleteResult,
  addEmployee,
} = require('../controllers/data');

router.get('/tests', getTests);
router.get('/tests/:qr', getTest);
router.patch('/tests/:qr', updateResult);
router.delete('/tests/:qr', deleteResult);
router.post('/employees', addEmployee);

module.exports = router;
