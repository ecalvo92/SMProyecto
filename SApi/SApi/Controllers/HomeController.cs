using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SApi.Models;
using SApi.Services;

namespace SApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        public HomeController(IConfiguration configuration, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _utilitarios = utilitarios;
        }

        [HttpPost]
        [Route("Registro")]
        public IActionResult Registro(Autenticacion autenticacion)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Execute("RegistrarUsuario", new
                {
                    autenticacion.Nombre,
                    autenticacion.CorreoElectronico,
                    autenticacion.NombreUsuario,
                    autenticacion.Contrasenna,
                    autenticacion.Estado
                });

                if (resultado > 0)
                    return Ok(_utilitarios.RespuestaCorrecta(autenticacion));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("Su información no fue registrada correctamente"));
            }
        }

        [HttpPost]
        [Route("Index")]
        public IActionResult Index(Autenticacion autenticacion)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.QueryFirstOrDefault<Autenticacion>("ValidarInicioSesion", new
                {
                    autenticacion.NombreUsuario,
                    autenticacion.Contrasenna
                });

                if (resultado != null)
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("Su información no fue validada correctamente"));                
            }
        }

    }
}
