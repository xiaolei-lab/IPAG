Shiny.addCustomMessageHandler("UpdateShinyFiles", function(data) {
      Shiny.onInputChange(data.id, data.message);
});

