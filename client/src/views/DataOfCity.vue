<template>
  <v-container class="my-10 font-weight-light">
    <StatusData :city="city" />

    <v-select
      :items="status"
      label="Status"
      solo
      class="my-10"
      v-model="selectedStatus"
    ></v-select>
    <v-expansion-panels class="my-10">
      <v-expansion-panel v-for="t of getTestsStatus" :key="t.qr_id">
        <v-expansion-panel-header>
          <v-row no-gutters>
            <v-col cols="4" class="font-weight-bold">
              {{ t.first_name }}
            </v-col>
            <v-col cols="8" class="text--secondary">
              <v-fade-transition leave-absolute>
                <v-row no-gutters style="width: 100%">
                  <v-col cols="6" class="font-weight-bold">
                    {{ t.last_name }}
                  </v-col>
                  <v-col cols="6">
                    status:
                    <span
                      v-if="t.status == 'bearbeitet'"
                      class="green--text font-weight-bold"
                      >bearbeitet</span
                    ><span v-else class="red--text font-weight-bold"
                      >unbearbeitet</span
                    >
                  </v-col>
                </v-row>
              </v-fade-transition>
            </v-col>
          </v-row>
        </v-expansion-panel-header>
        <v-divider class="blue-grey lighten-4"></v-divider>

        <v-expansion-panel-content class="blue-grey lighten-5 pt-5">
          <v-subheader class="ml-0">
            <span class="ml-0">Person</span>
          </v-subheader>

          <v-divider class="ml-4"> </v-divider>
          <v-row class="ml-2">
            <v-spacer></v-spacer>
            <v-col cols="12" md="4" class="my-2">
              <v-icon medium class="mr-2">mdi-email</v-icon>
              <span class="font-weight-bold">{{ t.email }} </span></v-col
            >

            <v-col cols="12" md="4" class="my-2">
              Geb.datum:
              <span class="font-weight-bold">{{
                t.gebdatum.substring(0, 10)
              }}</span>
            </v-col>
            <v-col cols="12" md="4" class="my-2">
              <v-icon medium class="mr-2">mdi-phone</v-icon>
              <span class="font-weight-bold">{{ t.tel }}</span>
            </v-col>
          </v-row>
          <v-subheader class="mt-5"> Test </v-subheader>

          <v-divider class="ml-4"> </v-divider>

          <v-row class="ml-2">
            <v-col cols="12" md="6" class="my-2">
              <v-icon medium class="mr-2">mdi-qrcode</v-icon>
              <span class="font-weight-bold">{{ t.qr_id }}</span>
            </v-col>
            <v-col cols="12" md="6" class="my-2">
              <v-icon medium class="mr-2">mdi-map-marker</v-icon>
              <span class="font-weight-bold">{{ t.name.toUpperCase() }}</span>
            </v-col>
          </v-row>

          <div v-if="t.status == 'bearbeitet'">
            <v-subheader class="mt-5"> Resultat </v-subheader>

            <v-divider class="ml-4"> </v-divider>

            <v-row class="ml-2">
              <v-col cols="12" md="6" class="my-2">
                Resultat
                <span class="font-weight-bold">{{ t.result }}</span>
              </v-col>
              <v-col cols="12" md="6" class="my-2">
                Bearbeitet von
                <span class="font-weight-bold">ID {{ t.lab_id }}</span>
              </v-col>
            </v-row>
          </div>

          <v-row>
            <v-col class="text-right">
              <v-dialog v-model="dialog" persistent max-width="600px">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    text
                    color="primary"
                    v-if="t.status == 'unbearbeitet'"
                    v-bind="attrs"
                    v-on="on"
                  >
                    Resultalt setzen
                  </v-btn>
                </template>
                <SetResult
                  :dialog="dialog"
                  @changeDialog="dialog = false"
                  :person="t"
                  @getTestsAgain="getTests"
                />
              </v-dialog>

              <v-btn
                text
                color="red"
                disabled
                v-if="t.status == 'bearbeitet'"
                style="color: red !important"
              >
                Resultalt bereits abgesendet
              </v-btn>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import axios from 'axios';
import StatusData from '@/components/StatusData.vue';
import SetResult from '@/components/SetResult.vue';
export default {
  props: {
    city: {
      type: String,
    },
  },
  data() {
    return {
      tests: [],
      status: ['bearbeitet', 'unbearbeitet'],
      selectedStatus: 'unbearbeitet',
      dialog: false,
    };
  },
  created() {
    this.getTests();
    console.log(this.getTestsStatus);
  },
  methods: {
    async getTests() {
      const { data } = await axios({
        url: `/tests?city=${this.city}`,
        method: 'GET',
      });
      this.tests = data;
    },
    convertToBoolean(status) {
      if (status == 'bearbeitet') return 'u';
    },
  },
  computed: {
    getTestsStatus() {
      return this.tests.filter((t) => t.status == this.selectedStatus);
    },
  },
  components: {
    StatusData,
    SetResult,
  },
};
</script>

<style lang="scss" scoped></style>
