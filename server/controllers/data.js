const asyncHandler = require('express-async-handler');

const pcrModel = require('../model/data');

const redirectLogin = (req, res, next) => {
  if (!req.session.userId) console.log('You are not logged in!');
  else next();
};

const login = asyncHandler(async (req, res) => {
  const { benutzername, password } = req.body;
  if (benutzername && password) {
    const user = await (
      await pcrModel.getLaboranten()
    ).find(
      (el) => el.benutzername === benutzername && el.password === password,
    );
    if (user) {
      req.session.userId = user.lab_id;
      res.status(200).json({ user });
    } else res.status(401).send('Wrong name or password');
  } else res.status(400).send('Login failed');
});

const logout =
  (redirectLogin,
  (req, res) => {
    req.session.destroy();
    res.clearCookie(process.env.SESSION_NAME);
    res.status(200).send('erfolgreich ausgeloggt');
  });

const getTests = asyncHandler(async (req, res) => {
  const rows = await pcrModel.getTests(req.query);
  if (rows.length > 0) {
    res.status(200).json(rows);
  } else {
    res.status(404).send('Tests were not found');
  }
});

const getAmountOftests = asyncHandler(async (req, res) => {
  const rows = await pcrModel.getAmountOftests(req.params.city);
  if (rows.length > 0) {
    res.status(200).json(rows);
  } else {
    res.status(404).send('Tests were not found');
  }
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
  const rows = await pcrModel.addEmployee(req.body);
  res.status(201).send(`Added ${rows.lab_id}`);
});

const sendEmailTest = asyncHandler((req, res) =>
  res.status(200).json(pcrModel.sendEmailTest(req.body)),
);

const sendEmailEmployee = asyncHandler((req, res) =>
  res.status(200).json(pcrModel.sendEmailEmployee(req.body)),
);

const getActivitiesFromEmployees = asyncHandler(async (req, res) =>
  res.status(200).json(await pcrModel.getActivitiesFromEmployees()),
);

const getEmployees = asyncHandler(async (req, res) =>
  res.status(200).json(await pcrModel.getEmployees()),
);

const getActivitiesFromEmployee = asyncHandler(async (req, res) =>
  res
    .status(200)
    .json(await pcrModel.getActivitiesFromEmployee(req.params.lastname)),
);
const deleteEmployee = asyncHandler(async (req, res) =>
  res.status(200).json(await pcrModel.deleteEmployee(req.params.id)),
);
module.exports = {
  getTests,
  getTest,
  updateResult,
  deleteResult,
  addEmployee,
  getAmountOftests,
  getActivitiesFromEmployees,
  getActivitiesFromEmployee,
  login,
  getEmployees,
  sendEmailTest,
  sendEmailEmployee,
  logout,
  redirectLogin,
  deleteEmployee,
};
