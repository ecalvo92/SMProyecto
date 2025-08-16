using Microsoft.AspNetCore.Mvc;
using SProyecto.Models;
using SProyecto.Services;

namespace SProyecto.Controllers
{
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    [Sesiones]
    public class CarritoController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly IUtilitarios _utilitarios;
        private readonly IHttpClientFactory _http;
        public CarritoController(IConfiguration configuration, IUtilitarios utilitarios, IHttpClientFactory http)
        {
            _configuration = configuration;
            _utilitarios = utilitarios;
            _http = http;
        }

        [HttpGet]
        public IActionResult RegistrarProductoCarrito(long IdProducto)
        {
            var carrito = new Carrito
            {
                IdProducto = IdProducto,
                IdUsuario = long.Parse(HttpContext.Session.GetString("IdUsuario")!)
            };

            using (var http = _http.CreateClient())
            {
                http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
                http.DefaultRequestHeaders.Add("Authorization", "Bearer " + HttpContext.Session.GetString("JWT"));
                var resultado = http.PostAsJsonAsync("api/Carrito/RegistrarProductoCarrito", carrito).Result;

                if (resultado.IsSuccessStatusCode)
                {
                     return RedirectToAction("Principal", "Home");
                }
                else
                {
                    var respuesta = resultado.Content.ReadFromJsonAsync<RespuestaEstandar>().Result;
                    ViewBag.Mensaje = respuesta?.Mensaje;
                    return View();
                }
            }
        }

        [HttpGet]
        public IActionResult ConsultarCarrito()
        {
            var resultado = _utilitarios.ConsultarDatosCarrito();
            return View(resultado); 
        }

        [HttpGet]
        public IActionResult EliminarProductoCarrito(long IdProducto)
        {
            var carrito = new Carrito
            {
                IdProducto = IdProducto,
                IdUsuario = long.Parse(HttpContext.Session.GetString("IdUsuario")!)
            };

            using (var http = _http.CreateClient())
            {
                http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
                http.DefaultRequestHeaders.Add("Authorization", "Bearer " + HttpContext.Session.GetString("JWT"));
                var resultado = http.PostAsJsonAsync("api/Carrito/EliminarProductoCarrito", carrito).Result;

                if (resultado.IsSuccessStatusCode)
                {
                    return RedirectToAction("ConsultarCarrito", "Carrito");
                }
                else
                {
                    var respuesta = resultado.Content.ReadFromJsonAsync<RespuestaEstandar>().Result;
                    ViewBag.Mensaje = respuesta?.Mensaje;
                    return View();
                }
            }
        }

        
    }
}
