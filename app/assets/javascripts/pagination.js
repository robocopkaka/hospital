$(function() {
   $(document).on("click", "#past-appointments .pagination a",function () {
       console.log($.queryString(this.href))
       // page_
       $.setFragment({ "page": $.queryString(this.href).page },2);
       $("#past-appointments").html("<div class=\"ui segment\"><p></p><div class=\"ui active inverted dimmer centered inline\"><div class=\"ui massive loader\"></div></div></div>")
       return false;
   });

   $(document).on("click", "#future-appointments .pagination a",function () {
       $.setFragment({ "flint": $.queryString(this.href).page }, 2);
       console.log($.queryString(this.href))
       $("#future-appointments").html("<div class=\"ui segment\"><p></p><div class=\"ui active inverted dimmer centered inline\"><div class=\"ui massive loader\"></div></div></div>")
       return false;
   });

   $.fragmentChange(true);
   $(document).bind("fragmentChange.page", function () {
       console.log($.fragment());
       $.getScript($.queryString(`http://localhost:3000/past_appointments#page=${$.fragment().page}`, { "page": $.fragment().page }));
       // $.getScript($.queryString(document.location.href, { "page": $.fragment().flint }));
       console.log($.queryString(document.location.href, { "page": $.fragment().page }));
   });
   $(document).bind("fragmentChange.flint", function () {
       // console.log($.fragment().flint)
       $.getScript($.queryString(document.location.href, { "page": $.fragment().flint }));
   });

   if ($.fragment().page) {
       $(document).trigger("fragmentChange.page")
   }
   if ($.fragment().flint) {
       $(document).trigger("fragmentChange.flint")
   }
});