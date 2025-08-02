using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using SApi.Models;
using SApi.Services;

namespace SApi.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        public ProductosController(IConfiguration configuration, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _utilitarios = utilitarios;
        }

        [HttpGet]
        [Route("ConsultarProductos")]
        public IActionResult ConsultarProductos()
        {
            using (var context = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = context.Query<Producto>("ConsultarProductos",
                    new
                    {
                    });

                if (resultado != null)
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("No hay información registrada"));
            }
        }

    }
}
