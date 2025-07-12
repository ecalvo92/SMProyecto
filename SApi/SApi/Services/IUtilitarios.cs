using SApi.Models;

namespace SApi.Services
{
    public interface IUtilitarios
    {

        RespuestaEstandar RespuestaCorrecta(object contenido);

        RespuestaEstandar RespuestaIncorrecta(string mensaje);

        string GenerarContrasena();

        void EnviarCorreo(string destinatario, string asunto, string cuerpo);

        string GenerarToken(long IdUsuario);

        string Encrypt(string texto);

    }
}
