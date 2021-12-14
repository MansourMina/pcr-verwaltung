<template>
  <v-container class="d-flex flex-wrap centercontainer">
    <v-row class="justify-center">
      <v-col cols="6">
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          label="Mitarbeiter Nachname"
          single-line
          width="50"
          hide-details
          filled
          class="white"
          rounded
          @keyup.enter="searchEmployees()"
        ></v-text-field>
      </v-col>
    </v-row>
    <v-dialog v-model="dialog" max-width="80%">
      <v-card>
        <v-toolbar>
          <v-btn icon dark @click="dialog = false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title class="mr-2">
            {{ employees.length }}
          </v-toolbar-title>

          <v-toolbar-title v-if="employees.length > 1"
            >Personen gefunden
          </v-toolbar-title>
          <v-toolbar-title v-if="employees.length == 1"
            >Person gefunden
          </v-toolbar-title>
        </v-toolbar>
        <div v-for="(e, i) of employees" :key="e.lab_id">
          <v-list subheader>
            <v-subheader
              >Mitarbeiter
              <span class="ml-2">
                <v-chip>{{ e.lab_id }}</v-chip></span
              ></v-subheader
            >
            <v-row>
              <v-col>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>Vor -und Nachname</v-list-item-title>
                    <v-list-item-subtitle>
                      {{ e.first_name }} {{ e.last_name }}</v-list-item-subtitle
                    >
                  </v-list-item-content>
                </v-list-item>
              </v-col>
              <v-col>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>Geburtsdatum</v-list-item-title>
                    <v-list-item-subtitle>{{
                      e.gebdatum
                    }}</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item>
              </v-col>
            </v-row>
            <v-row>
              <v-col
                ><v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>Email</v-list-item-title>
                    <v-list-item-subtitle>{{ e.email }}</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item>
              </v-col>
              <v-col>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title>Mitarbeiter-Typ</v-list-item-title>
                    <v-list-item-subtitle>{{ e.typ }}</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item>
              </v-col>
            </v-row>
          </v-list>
          <v-divider></v-divider>

          <v-list subheader>
            <v-subheader>Aktivitäten </v-subheader>
            <v-row>
              <v-col>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title
                      >Anzahl an bearbeiteten Tests</v-list-item-title
                    >
                    <v-list-item-subtitle>{{ e.amount_of_tests }} </v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item>
              </v-col>
              <v-col>
                <v-list-item>
                  <v-list-item-content>
                    <v-list-item-title
                      ><v-btn
                        color="error"
                        @click="deleteEmployee(e.lab_id)"
                        v-if="e.lab_id != user.lab_id"
                        >Aus dem System löschen</v-btn
                      ></v-list-item-title
                    >
                  </v-list-item-content>
                </v-list-item>
              </v-col>
            </v-row>
          </v-list>
          <div v-if="i == 0 && employees.length > 1">
            <v-divider class="black"></v-divider>
            <v-divider class="black"></v-divider>
          </div>
        </div>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            class="white--text"
            @click="dialog = false"
          >
            Fertig
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="dialogNotFound" max-width="80%">
      <v-card>
        <v-toolbar>
          <v-btn icon dark @click="dialogNotFound = false">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Person nicht gefunden </v-toolbar-title>
        </v-toolbar>
        <v-list subheader>
          <v-subheader>Mitarbeiter </v-subheader>
          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Vor -und Nachname</v-list-item-title>
                  <v-list-item-subtitle>N/A</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Geburtsdatum</v-list-item-title>
                  <v-list-item-subtitle>N/A</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
          <v-row>
            <v-col
              ><v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Email</v-list-item-title>
                  <v-list-item-subtitle>N/A</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Mitarbeiter-Typ</v-list-item-title>
                  <v-list-item-subtitle>N/A</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-list>
        <v-divider></v-divider>

        <v-list subheader>
          <v-subheader>Aktivitäten </v-subheader>
          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title
                    >Anzahl an bearbeiteten Tests</v-list-item-title
                  >
                  <v-list-item-subtitle>N/A </v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-list>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            class="white--text"
            @click="dialogNotFound = false"
          >
            Fertig
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      search: '',
      user: '',
      employees: [],
      dialog: false,
      dialogNotFound: false,
      // date: '',
    };
  },
  created() {
    this.getUser();
  },
  methods: {
    getUser() {
      let user = JSON.parse(localStorage.getItem('user'));
      if (user != null) {
        this.user = user;
      }
    },
    async searchEmployees() {
      try {
        const { data } = await axios({
          url: `/activities`,
          method: 'GET',
        });
        this.employees = data.filter(
          (el) =>
            `${el.first_name.toLowerCase()} ${el.last_name.toLowerCase()}`.includes(
              this.search.trim().toLowerCase(),
            ) ||
            `${el.last_name.toLowerCase()} ${el.first_name.toLowerCase()}`.includes(
              this.search.trim().toLowerCase(),
            ),
        );
        if (this.employees.length > 0) {
          this.employees.forEach(
            (el, i) =>
              (this.employees[i].gebdatum = el.gebdatum.substring(0, 10)),
          );

          this.dialog = true;
          console.log(data.length);
        } else {
          this.dialogNotFound = true;
        }
      } catch (err) {
        this.dialogNotFound = true;

        console.log('nd geudndne');
      }
    },
    async deleteEmployee(id) {
      await axios({
        url: '/employees/' + id,
        method: 'DELETE',
      });
      if (this.employees.length > 1) {
        this.searchEmployees();
      } else {
        this.dialogNotFound = false;
        this.dialog = false;
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.centercontainer {
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;

  height: 100%;
}
</style>
