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

    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Index(Autenticacion autenticacion)
    {
        /*
         * 
         * 
         * 
        */

        ViewBag.Mensaje = "No se ha podido validar su información";
        return View();
        //return RedirectToAction("Principal", "Home");
    }

    [HttpGet]
    public IActionResult Principal()
    {
        return View();
    }
}
