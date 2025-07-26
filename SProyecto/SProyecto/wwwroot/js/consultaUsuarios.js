$(function () {

  $(document).on("click", ".btnUserModal", function () {

    const id = $(this).data("id");
    const estado = $(this).data("estado");
    const rol = $(this).data("rol");

    const estadoBool = estado.toString().toLowerCase() === 'true';

    $("#IdUsuario").val(id);
    $("#estadoUsuario").prop("checked", estadoBool);
    $("#rolUsuario").val(rol);

  });

  $("#btnActualizarDatosUsuario").on("click", function () {

    var Autenticacion = {
      IdUsuario: $("#IdUsuario").val(),
      Estado: $("#estadoUsuario").is(":checked"),
      IdRol: $("#rolUsuario").val()
    };

    $.ajax({
      url: "/Usuario/ActualizarDatosUsuario",
      type: "POST",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(Autenticacion),
      success: function () {
        location.reload();
      }
    });

  });

});