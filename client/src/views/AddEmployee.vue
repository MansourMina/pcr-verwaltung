<template>
  <v-container>
    <v-card class="pa-4">
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-list subheader>
          <v-subheader>Daten der Person</v-subheader>
          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="first_name"
                    :rules="nameRules"
                    label="First name"
                    required
                  ></v-text-field>
                </v-list-item-content>
              </v-list-item>
            </v-col>

            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="last_name"
                    :rules="nameRules"
                    label="Last name"
                    required
                  ></v-text-field>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-menu
                    ref="startMenu"
                    :close-on-content-click="false"
                    :return-value.sync="date"
                    offset-y
                    min-width="290px"
                  >
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field
                        v-model="date"
                        label="Geburtsdatum"
                        prepend-icon="mdi-calendar"
                        readonly
                        v-bind="attrs"
                        v-on="on"
                      ></v-text-field>
                    </template>
                    <v-date-picker v-model="date" no-title scrollable>
                      <v-spacer></v-spacer>
                      <v-btn
                        text
                        color="primary"
                        @click="$refs.startMenu.isActive = false"
                      >
                        Cancel
                      </v-btn>
                      <v-btn
                        text
                        color="primary"
                        @click="$refs.startMenu.save(date)"
                      >
                        OK
                      </v-btn>
                    </v-date-picker>
                  </v-menu>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>

          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="email"
                    :rules="emailRules"
                    label="Email"
                    required
                  ></v-text-field>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="tel"
                    :rules="phoneRules"
                    label="Telefonnummer"
                    required
                  ></v-text-field>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-list>
        <v-list subheader>
          <v-subheader>Account</v-subheader>
          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-file-input
                    v-model="files"
                    :rules="rules"
                    accept="image/png, image/jpeg, image/bmp"
                    placeholder="Pick an avatar"
                    prepend-icon="mdi-camera"
                    label="Avatar"
                  ></v-file-input>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>

          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="lab_id"
                    disabled
                    label="Lab ID"
                    required
                    :rules="labRules"
                  ></v-text-field>
                  <v-btn @click="createLabID()">Create Lab-ID</v-btn>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="benutzername"
                    label="Benutzername"
                    required
                    :rules="benutzernameRules"
                  ></v-text-field>
                  <v-btn
                    @click="createBenutzername()"
                    :disabled="first_name.length == 0 || last_name.length == 0"
                    >Create Benutzername</v-btn
                  >
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-text-field
                    v-model="password"
                    label="Passwort"
                    disabled
                    required
                    :rules="passwordRules"
                  ></v-text-field>
                  <v-btn @click="createPassword()">Create Passwort</v-btn>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-combobox
                    v-model="select"
                    :items="items"
                    label="Mitarbeiter Typ"
                    multiple
                    chips
                  ></v-combobox>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-list>
        <v-divider></v-divider>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            :disabled="sure || !valid"
            :loading="sure"
            class="white--text text-center"
            @click="sure = true"
          >
            Fertigstellen
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card>
    <v-dialog v-model="sure" hide-overlay persistent width="300">
      <v-card color="black" dark>
        <v-card-text>
          Mitarbeiter wird hinzugefügt
          <v-progress-linear
            indeterminate
            color="white"
            class="mb-0"
          ></v-progress-linear>
        </v-card-text>
      </v-card>
    </v-dialog>
    <v-snackbar v-model="snackbar" :timeout="2000" :color="snackStyle">
      {{ snackbartext }}

      <template v-slot:action="{ attrs }">
        <v-btn
          color="blue"
          text
          v-bind="attrs"
          @click="
            snackbar = false;
            $refs.form.reset();
          "
        >
          Close
        </v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>

<script>
import axios from 'axios';
export default {
  created() {
    this.getEmployees();
  },
  watch: {
    sure(val) {
      if (!val) return;
      setTimeout(
        async () => (
          (this.sure = false), await this.addEmployee(), this.$refs.form.reset()
        ),
        2000,
      );
    },
  },
  data() {
    return {
      valid: true,
      employees: [],
      select: [],
      snackStyle: '',
      files: [],
      items: ['Verwalter', 'Admin'],
      sure: false,
      date: null,
      lab_id: '',
      snackbar: false,
      email: '',
      snackbartext: '',
      tel: '',
      password: '',
      benutzername: '',
      showdate: null,
      first_name: '',
      gebdatum: '',
      last_name: '',
      phoneRules: [
        (v) => !!v || 'Phone number is required',
        (v) =>
          !this.employees.find((el) => el.tel == v) ||
          'Phone number already taken',
      ],
      labRules: [
        (v) => !!v || 'Is required',
        (v) =>
          !this.employees.find((el) => el.lab_id == v) ||
          'Lab ID already taken',
      ],
      benutzernameRules: [
        (v) => !!v || 'Is required',
        (v) =>
          !this.employees.find((el) => el.benutzername == v) ||
          'Benutzername already taken',
      ],
      passwordRules: [(v) => !!v || 'Is required'],
      emailRules: [
        (v) => !!v || 'E-mail is required',
        (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
      nameRules: [(v) => !!v || 'Name is required'],
      rules: [
        (value) =>
          !value ||
          value.size < 2000000 ||
          'Avatar size should be less than 2 MB!',
      ],
    };
  },
  methods: {
    async getEmployees() {
      const { data } = await axios({
        url: '/employees',
        method: 'GET',
      });
      this.employees = data;
    },
    async addEmployee() {
      console.log(this.files.name);
      try {
        await axios({
          url: '/employees',
          method: 'POST',
          contentType: 'application/json',
          data: {
            lab_id: this.lab_id,
            first_name: this.first_name,
            last_name: this.last_name,
            gebdatum: this.date,
            tel: this.tel,
            benutzername: this.benutzername,
            password: this.password,
            image: `images/${this.files.name}`,
            typ: this.select.toString(),
            email: this.email,
          },
        });

        this.snackbar = true;
        this.snackbartext = 'Erfolgreich hinzugefügt';
        this.snackStyle = 'primary';

        await axios({
          url: '/sendmail/employee',
          method: 'POST',
          contentType: 'application/json',
          data: {
            email: this.email,
            name: `${this.first_name} ${this.last_name}`,
            benutzername: this.benutzername,
            password: this.password,
          },
        });
      } catch (err) {
        console.log('diesdas');
        this.snackbar = true;
        this.snackStyle = 'red';
        this.snackbartext = 'Konnte nicht hinzugefügt werde';
      }
    },
    createBenutzername() {
      this.benutzername = `${this.first_name.toLowerCase()}-${this.last_name.toLowerCase()}`;
    },
    createPassword() {
      this.password = 'xxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (Math.random() * 16) | 0,
          v = c == 'x' ? r : (r & 0x3) | 0x8;
        return v.toString(16);
      });
    },
    createLabID() {
      this.lab_id = Math.floor(100000 + Math.random() * 900000);
    },
  },
};
</script>

<style lang="scss" scoped></style>
