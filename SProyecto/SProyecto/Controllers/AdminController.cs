using Microsoft.AspNetCore.Mvc;
using SProyecto.Services;

namespace SProyecto.Controllers
{
    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    [Sesiones]
    [Administradores]
    public class AdminController : Controller
    {
        public IActionResult Dashboard()
        {
            return View();
        }
    }
}
