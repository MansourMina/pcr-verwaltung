const express = require('express');

const router = express.Router();

const {
  getActivitiesFromEmployees,
  getActivitiesFromEmployee,
  getTests,
  getTest,
  updateResult,
  deleteResult,
  addEmployee,
  getAmountOftests,
  login,
  logout,
  sendEmailEmployee,
  sendEmailTest,
  getEmployees,
  deleteEmployee,
} = require('../controllers/data');

router.get('/tests', getTests);
router.get('/employees', getEmployees);
router.get('/tests/:qr', getTest);
router.patch('/tests/:qr', updateResult);
router.delete('/tests/:qr', deleteResult);
router.get('/tests/:city/amount', getAmountOftests);
router.post('/employees', addEmployee);
router.delete('/employees/:id', deleteEmployee);
router.post('/login', login);
router.get('/logout', logout);
router.post('/sendmail/employee', sendEmailEmployee);
router.post('/sendmail/test', sendEmailTest);
router.get('/activities', getActivitiesFromEmployees);
router.get('/activities/:lastname', getActivitiesFromEmployee);

module.exports = router;
