import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const routes = [
  {
    path: '/data',
    name: 'Data',
    component: () => import('../views/Daten.vue'),
  },

  {
    path: '/about',
    name: 'About',
    component: () => import('../views/About.vue'),
  },
  {
    path: '/user/:employee',
    name: 'User',
    component: () => import('../views/User.vue'),
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
  },
  {
    path: '/data/:city',
    props: true,
    name: 'Data-City',
    component: () => import('../views/DataOfCity.vue'),
  },
  {
    path: '*',
    name: '404',
  },
  {
    path: '/add-employee',
    name: 'AddEmployee',
    component: () => import('../views/AddEmployee.vue'),
  },
  {
    path: '/employees',
    name: 'Activities',
    component: () => import('../views/Activities.vue'),
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

router.beforeEach(async (to, from, next) => {
  const user = JSON.parse(localStorage.getItem('user'));

  if (!isAuthenticated() && to.name != 'Login') {
    next('/login');
    return;
  }
  try {
    if (isAuthenticated()) {
      if (
        (to.name == 'Login' ||
          to.name == '404' ||
          to.name == 'AddEmployee' ||
          to.name == 'Activities' ||
          (to.path.startsWith('/user') &&
            to.path != `/user/${user.benutzername}`)) &&
        !user.typ.includes('Admin')
      ) {
        next(`/user/${user.benutzername}`);
      } else if (
        (to.name == 'Login' ||
          to.name == '404' ||
          (to.path.startsWith('/user') &&
            to.path != `/user/${user.benutzername}`)) &&
        user.typ.includes('Admin')
      ) {
        next(`/user/${user.benutzername}`);
      }
    }
    next();
  } catch (err) {
    console.log(err);
  }
  next();
});

function isAuthenticated() {
  if (Vue.$cookies.get('sid')) return true;
  else return false;
}
export default router;
