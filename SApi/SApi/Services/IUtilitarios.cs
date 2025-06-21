using SApi.Models;

namespace SApi.Services
{
    public interface IUtilitarios
    {

        RespuestaEstandar RespuestaCorrecta(object contenido);

        RespuestaEstandar RespuestaIncorrecta(string mensaje);

    }
}
