<template>
  <div>
    <span style="font-size: 25px">PCR</span>
    <span style="font-size: 25px" class="mx-5">/</span>

    <span v-if="city != null">
      <span style="font-size: 25px">{{ city.toUpperCase() }}</span>
      <span style="font-size: 25px" class="mx-5">/</span>
      <v-icon medium class="mx-1 pb-2">mdi-database</v-icon>
    </span>
    <span v-if="city == null" style="font-size: 25px">Cities</span>

    <v-divider dark class="black"></v-divider>
  </div>
</template>

<script>
export default {
  props: {
    city: {
      type: String,
    },
  },
};
</script>

<style lang="scss" scoped></style>
