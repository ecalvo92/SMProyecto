using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace SApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        [HttpPost]
        [Route("Registro")]
        public IActionResult Registro()
        {


            return Ok();
        }


        [HttpPost]
        [Route("Index")]
        public IActionResult Index()
        {


            return Ok();
        }

    }
}
