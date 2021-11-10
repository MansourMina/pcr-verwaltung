const db = require('../db');

function getTests() {
  const { rows } = db.query('SELECT * FROM tests');
  return {
    code: 200,
    data: rows,
  };
}
function updateResult() {}
function deleteResult() {}
function addEmployee() {}

module.exports = { getTests, updateResult, deleteResult, addEmployee };
