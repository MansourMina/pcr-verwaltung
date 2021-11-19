const asyncHandler = require('express-async-handler');

const pcrModel = require('../model/data');

const getTests = asyncHandler(async (req, res) => {
  const rows = await pcrModel.getTests();
  res.status(200).json(rows);
});
const getTest = asyncHandler(async (req, res) => {
  const rows = await pcrModel.getTest(req.params.qr);
  if (rows.length > 0) {
    res.status(200).json(rows);
  } else {
    res
      .status(404)
      .send(`Test with the Qr Code (${req.params.qr}) was not found`);
  }
});
const updateResult = asyncHandler(async (req, res) => {
  const qrid = req.params.qr;
  const test = await pcrModel.findTest(qrid);
  if (test.length > 0) {
    await pcrModel.updateResult(qrid, req.body);
    res.status(200).send(`Updated ${qrid}`);
  } else {
    res
      .status(404)
      .send(`Test with the Qr Code (${req.params.qr}) was not found`);
  }
});

const deleteResult = asyncHandler(async (req, res) => {
  const qrid = req.params.qr;
  if (await pcrModel.checkRowTest(qrid)) {
    await pcrModel.deleteResult(qrid);
    res.status(200).send(`Deleted ${qrid}`);
  } else {
    res
      .status(404)
      .send(`Test with the Qr Code (${req.params.qr}) was not found`);
  }
});

const addEmployee = asyncHandler(async (req, res) => {
  if (
    req.body.first_name &&
    req.body.last_name &&
    req.body.gebdatum &&
    req.body.tel
  ) {
    const rows = await pcrModel.addEmployee(req.body);
    res.status(201).send(`Added ${rows.lab_id}`);
  } else {
    res.status(400).send('No enough Content for adding an employee');
  }
});

module.exports = { getTests, getTest, updateResult, deleteResult, addEmployee };
