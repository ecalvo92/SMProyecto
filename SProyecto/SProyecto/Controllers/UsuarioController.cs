using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SProyecto.Models;
using SProyecto.Services;
using static System.Net.WebRequestMethods;

namespace SProyecto.Controllers
{
    [Sesiones]
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public class UsuarioController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly IHttpClientFactory _http;
        private readonly IUtilitarios _utilitarios;
        public UsuarioController(IConfiguration configuration, IHttpClientFactory http, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _http = http;
            _utilitarios = utilitarios;
        }

        #region ActualizarPerfil

        [HttpGet]
        public IActionResult ActualizarPerfil()
        {
            using (var http = _http.CreateClient())
            {
                var IdUsuario = HttpContext.Session.GetString("IdUsuario");
                http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);

                http.DefaultRequestHeaders.Add("Authorization", "Bearer " + HttpContext.Session.GetString("JWT"));
                var resultado = http.GetAsync("api/Usuario/ConsultarUsuario?IdUsuario=" + IdUsuario).Result;

                if (resultado.IsSuccessStatusCode)
                {
                    var datos = resultado.Content.ReadFromJsonAsync<RespuestaEstandar<Autenticacion>>().Result;
                    return View(datos!.Contenido);
                }
                else
                {
                    var respuesta = resultado.Content.ReadFromJsonAsync<RespuestaEstandar>().Result;
                    ViewBag.Mensaje = respuesta!.Mensaje;
                    return View();
                }
            }
        }

        [HttpPost]
        public IActionResult ActualizarPerfil(Autenticacion autenticacion)
        {
            using (var http = _http.CreateClient())
            {
                var IdUsuario = HttpContext.Session.GetString("IdUsuario");
                autenticacion.IdUsuario = long.Parse(IdUsuario!);

                http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
                http.DefaultRequestHeaders.Add("Authorization", "Bearer " + HttpContext.Session.GetString("JWT"));
                var resultado = http.PutAsJsonAsync("api/Usuario/ActualizarUsuario", autenticacion).Result;

                if (resultado.IsSuccessStatusCode)
                {
                    HttpContext.Session.SetString("Nombre", autenticacion?.Nombre!);                   
                    return RedirectToAction("Principal", "Home");
                }
                else
                {
                    var respuesta = resultado.Content.ReadFromJsonAsync<RespuestaEstandar>().Result;
                    ViewBag.Mensaje = respuesta!.Mensaje;
                    return View();
                }
            }
        }

        #endregion

        #region CambiarContrasenna

        [HttpGet]
        public IActionResult CambiarContrasenna()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CambiarContrasenna(Autenticacion autenticacion)
        {
            if (autenticacion.Contrasenna != autenticacion.ConfirmarContrasenna)
            {
                ViewBag.Mensaje = "Las contraseñas no coinciden";
                return View();
            }

            autenticacion.Contrasenna = _utilitarios.Encrypt(autenticacion.Contrasenna!);

            using (var http = _http.CreateClient())
            {
                var IdUsuario = HttpContext.Session.GetString("IdUsuario");
                autenticacion.IdUsuario = long.Parse(IdUsuario!);

                http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
                http.DefaultRequestHeaders.Add("Authorization", "Bearer " + HttpContext.Session.GetString("JWT"));
                var resultado = http.PutAsJsonAsync("api/Usuario/CambiarContrasenna", autenticacion).Result;

                if (resultado.IsSuccessStatusCode)
                {
                    return RedirectToAction("Principal", "Home");
                }
                else
                {
                    var respuesta = resultado.Content.ReadFromJsonAsync<RespuestaEstandar>().Result;
                    ViewBag.Mensaje = respuesta!.Mensaje;
                    return View();
                }
            }
        }

        #endregion
    }
}
