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
    public class CarritoController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        public CarritoController(IConfiguration configuration, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _utilitarios = utilitarios;
        }

        [HttpPost]
        [Route("RegistrarProductoCarrito")]
        public IActionResult RegistrarProductoCarrito(Carrito carrito)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Execute("RegistrarProductoCarrito", new
                {
                    carrito.IdUsuario,
                    carrito.IdProducto
                });

                if (resultado > 0)
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("El producto no fue registrado en su carrito"));
            }
        }

        [HttpPost]
        [Route("ConsultarCarrito")]
        public IActionResult ConsultarCarrito(Carrito carrito)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Query<Carrito>("ConsultarCarrito", new
                {
                    carrito.IdUsuario,
                });

                if (resultado.Any())
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("No hay productos registrados en el carrito"));
            }
        }

        [HttpPost]
        [Route("EliminarProductoCarrito")]
        public IActionResult EliminarProductoCarrito(Carrito carrito)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Execute("EliminarProductoCarrito", new
                {
                    carrito.IdUsuario,
                    carrito.IdProducto
                });

                if (resultado > 0)
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("El producto no fue eliminado de su carrito"));
            }
        }
        

    }
}
