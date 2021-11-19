const db = require('../db');

async function getTests() {
  const { rows } = await db.query(
    'SELECT * FROM tests JOIN personen USING(testperson_id)',
  );
  return rows;
}
async function findTest(id) {
  const { rows } = await db.query('SELECT * FROM tests where qr_id= $1', [id]);
  return rows;
}
async function getTest(qr) {
  const { rows } = await db.query(
    'SELECT * FROM tests JOIN personen USING(testperson_id) where tests.qr_id=$1',
    [qr],
  );
  return rows;
}
async function updateResult(id, body) {
  await db.query('UPDATE tests SET result = $1 where qr_id = $2', [
    body.result,
    id,
  ]);
}
async function deleteResult(id) {
  await db.query('DELETE from tests where qr_id = $1', [id]);
}
async function addEmployee(body) {
  const { rows } = await db.query(
    'Insert into laboranten (first_name, last_name, gebdatum, tel) values ($1,$2,$3,$4) returning lab_id',
    [body.first_name, body.last_name, body.gebdatum, body.tel],
  );
  return rows[0];
}

module.exports = {
  getTests,
  getTest,
  updateResult,
  deleteResult,
  addEmployee,
  findTest,
};
