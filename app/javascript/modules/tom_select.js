import TomSelect from "tom-select";

new TomSelect('#input-tags',{
  plugins: {
    remove_button:{
      title:'Remove this item',
    },
    clear_button:{
      title:'Remove all selected options',
    }
  },
  persist: false,
  create: true,
  onDelete: function(values) {
    return confirm(values.length > 1 ? 'Are you sure you want to remove these ' + values.length + ' items?' : 'Are you sure you want to remove "' + values[0] + '"?');
  }
});
