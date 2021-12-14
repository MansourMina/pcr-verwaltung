const db = require('../db');

// eslint-disable-next-line import/order
const mailjet = require('node-mailjet').connect(
  '61e5f161a81575b0b6f40516b77b83fa',
  '2ced6cfcb9136649168c72096e9ecf7a',
);

function sendEmailTest(body) {
  const request = mailjet.post('send', { version: 'v3.1' }).request({
    Messages: [
      {
        From: {
          Email: 'mansourmina10@gmail.com',
          Name: 'Vienna Laborbefunde gmbH',
        },
        To: [
          {
            Email: body.email,
            Name: body.name,
          },
        ],
        Subject: 'Laborbefund',
        TextPart: 'My first Mailjet email',
        HTMLPart: `<h4>Hallo ${
          body.name
        },</h4>Dein Laborbefund von Vienna Laborbefunde steht bereit. <br />Testergebnis vom ${body.datum.substring(
          0,
          10,
        )}: <br /><br /> Resultat: <b>${
          body.result
        }</b> <br /><br /> Bleib gesund! <br /><br /> <img src="https://cdr-health.com/wp-content/uploads/2020/12/Test-Icon_PCR1-300x300.png" width="100" height="100"/><br/> Vienna Laborbefunde gmbH`,
        CustomID: 'AppGettingStartedTest',
      },
    ],
  });
  request
    .then((result) => {
      console.log(result.body);
    })
    .catch((err) => {
      console.log(err.statusCode);
    });
}
function sendEmailEmployee(body) {
  const request = mailjet.post('send', { version: 'v3.1' }).request({
    Messages: [
      {
        From: {
          Email: 'mansourmina10@gmail.com',
          Name: 'Vienna Laborbefunde gmbH',
        },
        To: [
          {
            Email: body.email,
            Name: body.name,
          },
        ],
        Subject: 'Zugangsdaten',
        TextPart: 'My first Mailjet email',
        HTMLPart: `<h4>Hallo ${body.name},</h4>Deine Zugangsdaten für den Mitarbeiter Login der Vienna Laborbefunde stehen bereit.<br /><br /> Benutzername: <b>${body.benutzername}</b> <br /> Passwort: <b>${body.password}</b> <br /><br /> Bleib gesund! <br /><br /> <img src="https://cdr-health.com/wp-content/uploads/2020/12/Test-Icon_PCR1-300x300.png" width="100" height="100"/><br/> Vienna Laborbefunde gmbH`,
        CustomID: 'AppGettingStartedTest',
      },
    ],
  });
  request
    .then((result) => {
      console.log(result.body);
    })
    .catch((err) => {
      console.log(err.statusCode);
    });
}

async function getAmountOftests(city) {
  if (city !== 'all') {
    const { rows } = await db.query(
      'SELECT COUNT(*) as amount_of_tests, result, cities.name city_name from tests JOIN cities USING(city_id) where cities.name = $1 GROUP BY result,cities.name;',
      [city.toLowerCase()],
    );
    return rows;
  }
  const { rows } = await db.query(
    "SELECT COUNT(*) as amount_of_tests, Count(*) FILTER (where result = 'negativ') as negativ,Count(*) FILTER (where result = 'unbekannt') as unbekannt, Count(*) FILTER (where result = 'positiv') as positiv, Count(*) FILTER (where result IS NULL) as nichtbearbeitet, cities.name as city_name from tests JOIN cities USING (city_id) GROUP BY cities.name;",
  );
  return rows;
}

async function getLaboranten() {
  const { rows } = await db.query('SELECT * FROM laboranten ');
  return rows;
}

async function getEmployees() {
  const { rows } = await db.query('SELECT * from laboranten');
  return rows;
}
async function getTests(query) {
  const { city } = query;
  if (city) {
    const { rows } = await db.query(
      'SELECT * from tests JOIN cities USING (city_id) JOIN personen p on Tests.testperson_id = p.testperson_id where cities.name=$1',
      [city],
    );
    return rows;
  }
  const allrows = await db.query(
    'SELECT * from tests JOIN cities USING (city_id) JOIN personen p on Tests.testperson_id = p.testperson_id',
  );
  return allrows.rows;
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
  const newTestProps = [];

  // eslint-disable-next-line guard-for-in
  for (const key in body) {
    newTestProps.push(`${key}= '${body[key]}'`);
  }

  await db.query(
    `UPDATE tests SET ${newTestProps.join(',')} where qr_id = $1`,
    [id],
  );
}
async function deleteResult(id) {
  await db.query('DELETE from tests where qr_id = $1', [id]);
}
async function addEmployee(body) {
  const { rows } = await db.query(
    'Insert into laboranten (lab_id,first_name, last_name, gebdatum, tel,benutzername,password,image,typ,email) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) returning lab_id',
    [
      body.lab_id,
      body.first_name,
      body.last_name,
      body.gebdatum,
      body.tel,
      body.benutzername,
      body.password,
      body.image,
      body.typ,
      body.email,
    ],
  );
  return rows[0];
}

async function getTestOfCity(city) {
  const { rows } = await db.query('SELECT * FROM tests where city = $1', [
    city,
  ]);
  return rows;
}

async function getActivitiesFromEmployees() {
  const { rows } = await db.query(
    'SELECT lab_id, l.first_name,l.last_name,l.email,l.typ,l.tel,l.gebdatum, l.last_name,l.image, COUNT(t.lab_id) as amount_of_tests from laboranten l LEFT JOIN tests t USING (lab_id)  group by lab_id, l.first_name, l.last_name,l.image,l.email,l.gebdatum,l.typ,l.tel',
  );
  return rows;
}

async function getActivitiesFromEmployee(lastname) {
  const { rows } = await db.query(
    'SELECT lab_id, l.first_name,l.last_name,l.email,l.typ,l.tel,l.gebdatum, l.last_name,l.image, COUNT(t.lab_id) as amount_of_tests from laboranten l LEFT JOIN tests t USING (lab_id) where lab_id IS NOT NULL AND Lower(l.last_name)=$1 group by lab_id, l.first_name, l.last_name,l.image,l.email,l.gebdatum,l.typ,l.tel',
    [lastname.toLowerCase()],
  );
  return rows;
}
async function deleteEmployee(id) {
  await db.query('DELETE from laboranten where lab_id=$1', [id]);
}

module.exports = {
  getTests,
  getTest,
  updateResult,
  deleteResult,
  addEmployee,
  findTest,
  getTestOfCity,
  getAmountOftests,
  getLaboranten,
  sendEmailTest,
  sendEmailEmployee,
  getEmployees,
  getActivitiesFromEmployees,
  getActivitiesFromEmployee,
  deleteEmployee,
};
