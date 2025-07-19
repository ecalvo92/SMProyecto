using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using SApi.Models;
using SApi.Services;

namespace SApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IHostEnvironment _environment;
        private readonly IUtilitarios _utilitarios;
        public UsuarioController(IConfiguration configuration, IHostEnvironment environment, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _environment = environment;
            _utilitarios = utilitarios;
        }

        [HttpGet]
        [Route("ConsultarUsuario")]
        public IActionResult ConsultarUsuario(long IdUsuario)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.QueryFirstOrDefault<Autenticacion>("ConsultaUsuario", new
                {
                    IdUsuario
                });

                if (resultado != null)
                {
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                }
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("No se encontró información"));
            }
        }

        [HttpPut]
        [Route("ActualizarUsuario")]
        public IActionResult ActualizarUsuario(Autenticacion autenticacion)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Execute("ActualizarUsuario", new
                {
                    autenticacion.IdUsuario,
                    autenticacion.Identificacion,
                    autenticacion.Nombre,
                    autenticacion.CorreoElectronico
                });

                if (resultado > 0)
                    return Ok(_utilitarios.RespuestaCorrecta(autenticacion));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("Su información no fue actualizada correctamente"));
            }
        }        

    }
}
