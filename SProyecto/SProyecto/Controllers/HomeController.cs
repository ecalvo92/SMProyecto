using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using SProyecto.Models;
using SProyecto.Services;

namespace SProyecto.Controllers;

public class HomeController : Controller
{
    private readonly IConfiguration _configuration;
    private readonly IHttpClientFactory _http;
    private readonly IUtilitarios _utilitarios;
    public HomeController(IConfiguration configuration, IHttpClientFactory http, IUtilitarios utilitarios)
    {
        _configuration = configuration;
        _http = http;
        _utilitarios = utilitarios;
    }

    #region Index

    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Index(Autenticacion autenticacion)
    {
        autenticacion.Contrasenna = _utilitarios.Encrypt(autenticacion.Contrasenna!);

        using (var http = _http.CreateClient())
        {
            http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
            var resultado = http.PostAsJsonAsync("api/Home/Index", autenticacion).Result;

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

    #region Registro

    [HttpGet]
    public IActionResult Registro()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Registro(Autenticacion autenticacion)
    {
        autenticacion.Contrasenna = _utilitarios.Encrypt(autenticacion.Contrasenna!);

        using (var http = _http.CreateClient())
        {
            http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
            var resultado = http.PostAsJsonAsync("api/Home/Registro", autenticacion).Result;

            if (resultado.IsSuccessStatusCode)
            {
                return RedirectToAction("Index", "Home");
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

    #region Recuperar Acceso

    [HttpGet]
    public IActionResult RecuperarAcceso()
    {
        return View();
    }

    [HttpPost]
    public IActionResult RecuperarAcceso(Autenticacion autenticacion)
    {
        using (var http = _http.CreateClient())
        {
            http.BaseAddress = new Uri(_configuration.GetSection("Start:ApiUrl").Value!);
            var resultado = http.PostAsJsonAsync("api/Home/RecuperarAcceso", autenticacion).Result;

            if (resultado.IsSuccessStatusCode)
            {
                return RedirectToAction("Index", "Home");
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

    [HttpGet]
    public IActionResult Principal()
    {
        return View();
    }

}
