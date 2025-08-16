using SProyecto.Models;

namespace SProyecto.Services
{
    public interface IUtilitarios
    {
        string Encrypt(string texto);
        List<Carrito> ConsultarDatosCarrito();
    }
}
