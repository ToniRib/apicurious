$(document).ready(function() {
  $("#steps-icon").click(function() {
    $("#daily-steps-chart").show();
    $("#daily-floors-chart").hide();
    $("#daily-calories-chart").hide();
  });

  $("#stairs-icon").click(function() {
    $("#daily-steps-chart").hide();
    $("#daily-floors-chart").show();
    $("#daily-calories-chart").hide();
  });

  $("#calories-icon").click(function() {
    $("#daily-steps-chart").hide();
    $("#daily-floors-chart").hide();
    $("#daily-calories-chart").show();
  });
});
