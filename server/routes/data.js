const express = require('express');

const router = express.Router();

const {
  getTests,
  updateResult,
  deleteResult,
  addEmployee,
} = require('../model/data');

router.get('/pcr', getTests);
router.patch('/pcr/:id', updateResult);
router.delete('/pcr/:id', deleteResult);
router.post('/pcr', addEmployee);

module.exports = router;
