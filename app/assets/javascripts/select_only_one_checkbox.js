$("input[type=checkbox]").click(function(){
   $('input[type="checkbox"]').not(this).prop("checked", false);
});
