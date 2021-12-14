<template>
  <v-container fluid fill-height>
    <v-layout align-center justify-center>
      <v-flex xs12 sm8 md4>
        <v-card class="elevation-12">
          <v-toolbar dark color="white">
            <v-toolbar-title class="black--text"
              >Employee-Login</v-toolbar-title
            >
          </v-toolbar>
          <v-card-text>
            <v-form>
              <v-text-field
                prepend-icon="mdi-account"
                name="Benutzername"
                v-model="benutzername"
                label="Benutzername"
                type="text"
                @keyup.enter="login()"
              ></v-text-field>
              <v-text-field
                id="password"
                prepend-icon="mdi-lock"
                name="password"
                v-model="password"
                label="Password"
                type="password"
                @keyup.enter="login()"
              ></v-text-field>
              <v-checkbox
                v-model="angemeldetBleiben"
                label="Angemeldet bleiben"
                value="true"
              ></v-checkbox>
              <p class="red--text" v-if="showWrong">
                Falscher Benutzername oder Passwort
              </p>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="login()">Login</v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      benutzername: '',
      password: '',
      showWrong: false,
      angemeldetBleiben: 'false',
    };
  },
  methods: {
    async login() {
      try {
        let { data } = await axios({
          url: `/login`,
          method: 'POST',
          contentType: 'application/json',
          data: {
            benutzername: this.benutzername,
            password: this.password,
          },
        });
        if (
          this.angemeldetBleiben == 'false' ||
          this.angemeldetBleiben == false
        ) {
          localStorage.setItem(
            'loginBleiben',
            JSON.stringify({ login: false }),
          );
        } else if (
          this.angemeldetBleiben == 'true' ||
          this.angemeldetBleiben == true
        ) {
          localStorage.setItem('loginBleiben', JSON.stringify({ login: true }));
        }
        localStorage.setItem('user', JSON.stringify(data.user));
        const user = localStorage.getItem('user');
        if (user != null) {
          this.$router.push(`/user/${user.benutzername}`);
          this.$router.go();
        }
        return;
      } catch (err) {
        this.showWrong = true;
      }
    },
  },
};
</script>

<style lang="scss" scoped></style>
