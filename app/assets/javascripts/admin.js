$(function() {
  $(".update-on-click").on("click", function(event) {
    $.ajax({
      method: "put", dataType: "script", url: this.href, data: { secret: $(this).data() }
    });
    event.preventDefault();
  });
});
