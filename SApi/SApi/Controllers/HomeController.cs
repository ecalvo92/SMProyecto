using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SApi.Models;

namespace SApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public HomeController(IConfiguration configuration)
        {
            _configuration = configuration;
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
                {
                    return Ok(new RespuestaEstandar
                    {
                        codigo = 0
                    });
                }
                else
                {
                    return BadRequest(new RespuestaEstandar
                    {
                        codigo = 99,
                        mensaje = "Su información no fue registrada correctamente"
                    });
                }
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
                {
                    return Ok(new RespuestaEstandar
                    {
                        codigo = 0,
                        contenido = resultado
                    });
                }
                else
                {
                    return BadRequest(new RespuestaEstandar {
                        codigo = 99,
                        mensaje = "Su información no fue validada correctamente"
                    });
                }
                
            }
        }

    }
}
