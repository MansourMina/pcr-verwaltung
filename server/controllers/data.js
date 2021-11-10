const asyncHandler = require('express-async-handler');

const pcrModel = require('../model/data');

const getTests = asyncHandler(async (req, res) => {
  const { data, code } = await pcrModel.getTests();
  res.status(code).json(data);
});

module.exports = { getTests };
