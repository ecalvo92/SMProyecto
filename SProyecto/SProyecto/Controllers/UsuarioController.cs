using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SProyecto.Models;
using SProyecto.Services;
using static System.Net.WebRequestMethods;

namespace SProyecto.Controllers
{
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

        #region Index

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
                    return View(datos);
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
        public IActionResult Index(Autenticacion autenticacion)
        {
            return View();

            //autenticacion.Contrasenna = _utilitarios.Encrypt(autenticacion.Contrasenna!);

            //using (var http = _http.CreateClient())
            //{
            //    http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
            //    var resultado = http.PostAsJsonAsync("api/Home/Index", autenticacion).Result;

            //    if (resultado.IsSuccessStatusCode)
            //    {
            //        var datos = resultado.Content.ReadFromJsonAsync<RespuestaEstandar<Autenticacion>>().Result;

            //        HttpContext.Session.SetString("Nombre", datos?.Contenido?.Nombre!);
            //        HttpContext.Session.SetString("JWT", datos?.Contenido?.Token!);

            //        return RedirectToAction("Principal", "Home");
            //    }
            //    else
            //    {
            //        var respuesta = resultado.Content.ReadFromJsonAsync<RespuestaEstandar>().Result;
            //        ViewBag.Mensaje = respuesta!.Mensaje;
            //        return View();
            //    }
            //}
        }

        #endregion
    }
}
