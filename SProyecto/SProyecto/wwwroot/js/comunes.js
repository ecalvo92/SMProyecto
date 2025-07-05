﻿function ConsultarPersonaApi() {

  let identificacion = $("#Identificacion").val();
  $("#Nombre").val("");

  if (identificacion.length >= 9) {

    $.ajax({
      url: "https://apis.gometa.org/cedulas/" + identificacion,
      type: "GET",
      dataType: "json",
      success: function (data) {
        $("#Nombre").val(data.nombre);
      },
    });

  }
}