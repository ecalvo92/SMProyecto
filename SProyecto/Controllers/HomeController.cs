using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
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



        ViewBag.Mensaje = "No se ha podido validar su información";
        return View();
        //return RedirectToAction("Principal", "Home");
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



        ViewBag.Mensaje = "No se ha podido registrar su información";
        return View();
        //return RedirectToAction("Principal", "Home");
    }

    #endregion

    [HttpGet]
    public IActionResult Principal()
    {
        return View();
    }
}
