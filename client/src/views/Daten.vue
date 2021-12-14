<template>
  <v-container class="my-10 font-weight-light">
    <StatusData />
    <div>
      <v-simple-table class="mt-10 table text-center spacing-table transparent">
        <template v-slot:default>
          <thead>
            <tr>
              <th class="font-weight-bold pa-5 text-left">
                <span class="py-5">City</span>
              </th>
              <th class="text-center">
                <span class="py-5">Anzahl</span>
              </th>
              <th class="green--text text-center">
                <span class="py-5">Negativ</span>
              </th>
              <th class="error--text text-center">
                <span class="py-5">Positiv</span>
              </th>
              <th class="text-center">
                <span class="py-5">Unbekannt</span>
              </th>

              <th class="text-center">
                <span class="py-5">Nicht bearbeitet</span>
              </th>
              <th class="text-center">
                <span class="py-5">Action</span>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="d of citytests" :key="d.city">
              <td class="font-weight-bold text-left">
                {{ d.city_name.toUpperCase() }}
              </td>
              <td>
                {{ d.amount_of_tests }}
              </td>

              <td class="green--text font-weight-bold">
                {{ d.negativ }}
              </td>
              <td class="error--text font-weight-bold">
                {{ d.positiv }}
              </td>
              <td class=" font-weight-bold">
                {{ d.unbekannt }}
              </td>

              <td><v-icon small>mdi-</v-icon>{{ d.nichtbearbeitet }}</td>
              <td>
                <v-btn icon :to="`/data/${d.city_name.toLowerCase()}`"
                  ><v-icon>mdi-view-list</v-icon></v-btn
                >
              </td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </div>
  </v-container>
</template>

<script>
import axios from 'axios';
import StatusData from '@/components/StatusData.vue';
export default {
  name: 'Home',
  components: {
    StatusData,
  },
  created() {
    this.getCitiesTests();
    console.log(this.citytests)
  },
  data() {
    return {
      citytests: [],
    };
  },
  methods: {
    async getCitiesTests() {
      const { data } = await axios({
        url: `/tests/all/amount`,
        method: 'GET',
      });
      this.citytests = data;
    },
  },
};
</script>

<style scoped>
.spacing-table {
  font-family: 'Helvetica', 'Arial', sans-serif;
  font-size: 15px;
  border-collapse: separate;
  table-layout: fixed;
  width: 100%;
  border-spacing: 0 5px; /* this is the ultimate fix */
}
.spacing-table th {
  text-align: left;
  padding: 5px 15px;
}
.spacing-table td {
  border-width: 3px 0;
  width: 50%;
  background-color: white;
  padding: 5px 15px;
}
.spacing-table td:first-child {
  border-left-width: 3px;
  border-radius: 5px 0 0 5px;
}
.spacing-table td:last-child {
  border-right-width: 3px;
  border-radius: 0 5px 5px 0;
}
.spacing-table thead {
  display: table;
  table-layout: fixed;
  width: 100%;
}
.spacing-table tbody {
  display: table;
  table-layout: fixed;
  width: 100%;
  border-spacing: 0 30px;
}
</style>
