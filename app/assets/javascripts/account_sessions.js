//= require jquery
//= require chroma-hash

$(function() {
  $("#username").focus();
  $("input:password").chromaHash({bars: 3, salt: "5bf999ac93430ed303cd0b56f976e289", minimum: 4});
});
