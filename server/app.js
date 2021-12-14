const express = require('express');
const morgan = require('morgan');
const helmet = require('helmet');
const path = require('path');
const cors = require('cors');
const session = require('express-session');
const history = require('connect-history-api-fallback');

const routes = require('./routes/data');

const { errorHandler, notFound } = require('./middleware/errorHandler');
require('colors');

require('dotenv').config();

const app = express();

app.use(morgan('dev'));
app.use(cors());

app.use(express.static(path.join(__dirname, '/public')));

app.use(helmet());
app.use(express.json());
const { PORT, NODE_ENV, SESSION_LIFETIME, SESSION_NAME, SESSION_SECRET } =
  process.env;

app.use(express.static(path.join(__dirname, '/public')));
app.use(history());
app.use(express.static(path.join(__dirname, '/public')));

app.use(
  session({
    secret: SESSION_SECRET,
    // eslint-disable-next-line global-require
    // store: new (require('connect-pg-simple')(session))(),
    name: SESSION_NAME,
    saveUninitialized: false,
    resave: false,
    cookie: {
      maxAge: SESSION_LIFETIME * 1000 * 60 * 60,
      httpOnly: false,
      sameSite: true,
      secure: NODE_ENV === 'production',
    },
  }),
);

app.use('/', routes);
app.use(notFound);
app.use(errorHandler);

const POR = PORT ?? 5000;

app.listen(POR);
