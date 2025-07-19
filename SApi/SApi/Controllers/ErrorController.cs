using Dapper;
using Microsoft.AspNetCore.Diagnostics;
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
    [ApiExplorerSettings(IgnoreApi = true)]
    public class ErrorController : ControllerBase
    {
        private readonly IUtilitarios _utilitarios;
        private readonly IConfiguration _configuration;
        public ErrorController(IUtilitarios utilitarios, IConfiguration configuration)
        {
            _utilitarios = utilitarios;
            _configuration = configuration;
        }

        [Route("CapturarError")]
        public IActionResult CapturarError()
        {
            var ex = HttpContext.Features.Get<IExceptionHandlerFeature>();

            var Mensaje = ex!.Error.Message;
	        var Origen = ex!.Path;
            var IdUsuario = _utilitarios.ObtenerIdUsuario(User.Claims);

            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Execute("RegistrarError", new
                {
                    Mensaje,
                    Origen,
                    IdUsuario
                });
            }

            return StatusCode(StatusCodes.Status500InternalServerError, _utilitarios.RespuestaIncorrecta("Se presentó un error en el servicio"));
        }

    }
}
