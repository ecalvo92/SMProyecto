using System.Diagnostics;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using SProyecto.Models;

namespace SProyecto.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
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
        using (var contexto = new SqlConnection("Server=EDUARDO; DataBase=SMDataBase; Integrated Security=True; TrustServerCertificate=True;"))
        {
            var resultado = contexto.QueryFirstOrDefault<Autenticacion>("ValidarInicioSesion", new
            {
                autenticacion.NombreUsuario,
                autenticacion.Contrasenna
            });

            if (resultado != null)
                return RedirectToAction("Principal", "Home");

            ViewBag.Mensaje = "No se ha podido validar su información";
            return View();
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
        using (var contexto = new SqlConnection("Server=EDUARDO; DataBase=SMDataBase; Integrated Security=True; TrustServerCertificate=True;"))
        {
            var Estado = true;

            var resultado = contexto.Execute("RegistrarUsuario", new { 
                autenticacion.Nombre, 
                autenticacion.CorreoElectronico, 
                autenticacion.NombreUsuario, 
                autenticacion.Contrasenna,
                Estado
            });
        
            if(resultado > 0)
                return RedirectToAction("Index", "Home");

            ViewBag.Mensaje = "No se ha podido registrar su información";
            return View();
        }
    }

    #endregion

    [HttpGet]
    public IActionResult Principal()
    {
        return View();
    }
}
