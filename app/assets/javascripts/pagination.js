/*
* This file contains different methods to help with pagination using AJAX
* Uses jquery.ba-url.js in vendors/assets/javascripts
*
* */

$(function() {
   $(document).on("click", "#past-appointments .pagination a",function () {
       console.log($.queryString(this.href));
       // this.href holds the page number that was clicked or the page number associated with the next and previous buttons
       $.setFragment({ "past": $.queryString(this.href).page }); // adds a 'past' key to the fragment
       // loader that's shown while the page is loading
       $("#past-appointments").html("<div class=\"ui segment\"><p></p><div class=\"ui active inverted dimmer centered inline\"><div class=\"ui massive loader\"></div></div></div>")
       return false;
   });

   $(document).on("click", "#future-appointments .pagination a",function () {
       // this.href holds the page number that was clicked or the page number associated with the next and previous buttons
       $.setFragment({ "future": $.queryString(this.href).page }); // adds a 'past' key to the fragment
       // loader that's shown while the page is loading
       $("#future-appointments").html("<div class=\"ui segment\"><p></p><div class=\"ui active inverted dimmer centered inline\"><div class=\"ui massive loader\"></div></div></div>")
       return false;
   });

   $.fragmentChange(true);
   $(document).bind("fragmentChange.past", function () {
       // API call to the past_appointments route with the page number as a parameter
       $.getScript($.queryString(`http://localhost:3000/past_appointments#past=${$.fragment().past}`, { "page": $.fragment().past }));
   });
   $(document).bind("fragmentChange.future", function () {
       // API call to the future_appointments route with the page number as a parameter
       $.getScript($.queryString(`http://localhost:3000/future_appointments#future=${$.fragment().future}`, { "page": $.fragment().future }));
   });

   if ($.fragment().past) {
       $(document).trigger("fragmentChange.past") // triggers the callback so it works on other non-click events
   } else if ($.fragment().future) {
   }
});