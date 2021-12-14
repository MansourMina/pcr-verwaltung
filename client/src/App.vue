<template>
  <v-app>
    <template v-if="$route.name != 'Login'">
      <v-app-bar app height="60" clipped-left style="display: block">
        <v-toolbar-title>
          <router-link to="/" name="Back to Home"
            ><img
              src="http://localhost:8080/logo.png"
              class="mt-3 mb-2 hidden-xs-only mr-5"
              height="50"
              name="Logo HTL Wien West"
              alt="Logo"
              title="HTL Wien West Logo"
          /></router-link>
        </v-toolbar-title>
        <v-toolbar-title>Vienna Laborbefunde gmbH</v-toolbar-title>
      </v-app-bar>
      <v-navigation-drawer
        v-model="drawer"
        app
        expand-on-hover
        clipped
        permanent
      >
        <v-list nav dense>
          <v-list-item class="pl-0">
            <v-list-item-avatar>
              <v-img
                v-if="user.image == null"
                :src="`http://localhost:8080/placeholder.jpeg`"
                class="pa-1"
                alt=""
              ></v-img>
              <v-img
                v-else
                :src="`http://localhost:8080/${user.image}`"
                class="pa-1"
                alt="placeholder.jpg"
              ></v-img>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title class="body-1">
                {{ user.first_name }} {{ user.last_name }}
              </v-list-item-title>
              <v-list-item-subtitle>{{ user.typ }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>

        <v-divider class="blue-grey lighten-4"></v-divider>

        <v-list nav dense>
          <v-list-item
            link
            v-for="n of drawerItems"
            :key="n.name"
            :to="n.route"
          >
            <v-list-item-icon>
              <v-icon>{{ n.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-title>{{ n.name }}</v-list-item-title>
          </v-list-item>
        </v-list>
        <v-divider class="blue-grey lighten-4"></v-divider>

        <v-list nav dense v-if="checkAdmin">
          <v-list-item link v-for="n of adminItems" :key="n.name" :to="n.route">
            <v-list-item-icon>
              <v-icon>{{ n.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-title>{{ n.name }}</v-list-item-title>
          </v-list-item>
        </v-list>
        <v-divider class="blue-grey lighten-4"></v-divider>

        <v-list nav dense>
          <v-list-item link to="/about">
            <v-list-item-icon>
              <v-icon>mdi-open-in-new</v-icon>
            </v-list-item-icon>
            <v-list-item-title>About Us</v-list-item-title>
          </v-list-item>
        </v-list>
        <v-divider class="blue-grey lighten-4"></v-divider>

        <v-list class="mt-5">
          <v-list-item-title class="text-center blue--text text-darken-4"
            ><a @click="logout()">Logout</a></v-list-item-title
          >
        </v-list>
      </v-navigation-drawer>
    </template>

    <v-main class="blue-grey lighten-4">
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import axios from 'axios';
export default {
  name: 'App',
  mounted() {
    document.onreadystatechange = () => {
      if (document.readyState == 'complete') {
        this.isloaded = true;
      }
    };
  },
  created() {
    this.getUser();

    const storageLogin = JSON.parse(localStorage.getItem('loginBleiben'));

    if (performance.navigation.type == performance.navigation.TYPE_RELOAD) {
      console.info('This page is reloaded');
    } else {
      if (storageLogin != null) {
        if (!storageLogin.login) {
          console.info('didtn wanted to stay');
          this.logout();
        } else {
          console.info('wanted to stay');
        }
      }

      console.info('This page is not reloaded');
    }
  },
  computed: {
    checkAdmin() {
      if (this.user.typ.includes('Admin')) {
        return true;
      }
      return false;
    },
  },
  methods: {
    getUser() {
      let user = JSON.parse(localStorage.getItem('user'));
      if (user != null) {
        this.user = user;
      }
    },
    async logout() {
      await axios({
        url: '/logout',
        method: 'GET',
      });
      localStorage.clear();
      this.$router.push('/login');
    },
  },
  data: () => ({
    isloaded: false,

    drawer: false,
    group: null,
    logged: false,
    angemeldetBleiben: true,
    drawerItems: [
      {
        name: 'Startseite',
        route: '/user',
        icon: 'mdi-home-account',
      },
      { name: 'PCR Tests', route: '/data', icon: 'mdi-folder' },
    ],
    adminItems: [
      {
        name: 'Mitarbeiter hinzufügen',
        route: '/add-employee',
        icon: 'mdi-account-group',
      },
      {
        name: 'Mitarbeiter verwalten',
        route: '/employees',
        icon: 'mdi-text-box-multiple',
      },
    ],
    user: {},
  }),
};
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@300;400;700&display=swap');

html * {
  font-family: 'Roboto Condensed', sans-serif;
}
.center {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}
</style>
