<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" max-width="80%">
      <v-card>
        <v-toolbar>
          <v-btn icon dark @click="$emit('changeDialog')">
            <v-icon color="black">mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Resultat setzen </v-toolbar-title>
        </v-toolbar>
        <v-list subheader>
          <v-subheader>Testperson</v-subheader>
          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Vor -und Nachname</v-list-item-title>
                  <v-list-item-subtitle
                    >{{ person.last_name }}
                    {{ person.first_name }}</v-list-item-subtitle
                  >
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Alter</v-list-item-title>
                  <v-list-item-subtitle
                    >{{ getAge }} ({{
                      person.gebdatum.substring(0, 10)
                    }})</v-list-item-subtitle
                  >
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
          <v-row>
            <v-col
              ><v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Email</v-list-item-title>
                  <v-list-item-subtitle>{{
                    person.email
                  }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Telefonnummer</v-list-item-title>
                  <v-list-item-subtitle>{{ person.tel }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-list>
        <v-divider></v-divider>
        <v-list subheader>
          <v-subheader>Test</v-subheader>
          <v-row>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Test abgegeben</v-list-item-title>
                  <v-list-item-subtitle>{{
                    person.name.toUpperCase()
                  }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Code</v-list-item-title>
                  <v-list-item-subtitle>{{
                    person.qr_id
                  }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
          <v-row>
            <v-col
              ><v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Resultat</v-list-item-title>
                  <v-list-item-subtitle
                    ><v-select :items="resultat" v-model="result"></v-select
                  ></v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Bearbeitet von</v-list-item-title>
                  <v-list-item-subtitle
                    ><v-btn
                      @click="
                        me = true;
                        bearbeitet_von = user;
                      "
                      v-if="!me"
                      >Me</v-btn
                    ></v-list-item-subtitle
                  >
                  <v-list-item-subtitle
                    ><v-btn
                      @click="
                        me = false;
                        bearbeitet_von = '';
                      "
                      v-if="me"
                      >Delete</v-btn
                    ></v-list-item-subtitle
                  >
                  <v-list-item-subtitle v-if="me"
                    >{{ user.first_name }} {{ user.last_name }} (Lab ID:
                    {{ user.lab_id }})</v-list-item-subtitle
                  >
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-list>
        <v-divider></v-divider>
        <v-list subheader>
          <v-subheader>Send Test</v-subheader>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Type</v-list-item-title>

              <v-chip-group
                multiple
                active-class="primary--text"
                v-model="type"
              >
                <v-chip value="SMS"> SMS </v-chip>
                <v-chip value="Email"> Email </v-chip>
              </v-chip-group>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            :disabled="
              sure ||
              result.length == 0 ||
              bearbeitet_von.length == 0 ||
              type.length == 0
            "
            :loading="sure"
            class="white--text"
            @click="ask = true"
          >
            Fertig
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="ask" persistent max-width="290" dark>
      <v-card>
        <v-card-title class="text-h5"> Absenden? </v-card-title>
        <v-card-text>Sind Sie sich sicher, diesen Test abzusenden?</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="green darken-1"
            text
            @click="
              ask = false;
              sure = true;
            "
          >
            Ja
          </v-btn>
          <v-btn color="red darken-1" text @click="ask = false"> Nein </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="sure" hide-overlay persistent width="300">
      <v-card color="black" dark>
        <v-card-text>
          Resultat wird gesetzt
          <v-progress-linear
            indeterminate
            color="white"
            class="mb-0"
          ></v-progress-linear>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import axios from 'axios';
export default {
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
    async setResult() {
      await axios({
        url: '/tests/' + this.person.qr_id,
        method: 'PATCH',
        contentType: 'application/json',
        data: {
          result: this.result,
          lab_id: this.bearbeitet_von.lab_id,
          status: 'bearbeitet',
        },
      });
      this.$emit('getTestsAgain');

      await axios({
        url: '/sendmail/test',
        method: 'POST',
        contentType: 'application/json',
        data: {
          email: this.person.email,
          result: this.result,
          name: `${this.person.first_name} ${this.person.last_name}`,
          datum: this.person.gültig_von,
        },
      });
    },
  },
  props: {
    dialog: {
      type: Boolean,
    },
    person: {
      type: Object,
    },
  },
  watch: {
    sure(val) {
      if (!val) return;

      setTimeout(
        () => (
          (this.sure = false), this.$emit('changeDialog'), this.setResult()
        ),
        2000,
      );
    },
  },
  data() {
    return {
      type: '',
      user: {},
      ask: false,
      me: false,
      bearbeitet_von: '',
      resultat: ['negativ', 'positiv', 'unbekannt'],
      result: '',
      sure: false,
    };
  },
  computed: {
    getAge() {
      const date = this.person.gebdatum.substring(0, 10);
      var today = new Date();
      var birthDate = new Date(date);
      var age = today.getFullYear() - birthDate.getFullYear();
      var m = today.getMonth() - birthDate.getMonth();
      if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
      }
      return age;
    },
  },
};
</script>

<style lang="scss" scoped></style>
