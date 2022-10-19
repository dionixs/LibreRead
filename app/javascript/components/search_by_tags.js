import '@selectize/selectize'

$("#search-by-tags").selectize({
  delimiter: ",",
  persist: false,
  create: function (input) {
    return {
      value: input,
      text: input,
    };
  },
});
