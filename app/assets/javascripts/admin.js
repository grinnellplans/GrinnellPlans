$(function() {
  $(".update-on-click").on("click", function(event) {
    $.ajax({
      method: "put",
      dataType: "script",
      url: this.href,
      data: { secret: $(this).data() },
      success: (function() { $(this).addClass("selected") }).bind(this),
      error: function(_, e) { alert(e) }
    });
    event.preventDefault();
  });
});
