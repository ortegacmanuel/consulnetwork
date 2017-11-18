const vm = new Vue({
  el: '#app',
  data() {
    return {
      cities: [],
      loading: false
    }
  },
  mounted() {
    this.loading = true;
    this.getCities();
  },
  methods: {
    getCities() {
      axios.get('api/cities').then(response => {
        this.loading = false;
        this.cities = response.data;
      }).catch( error => { console.log(error); });
    }
  }
});
