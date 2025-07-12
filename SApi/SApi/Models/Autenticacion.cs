namespace SApi.Models
{
    public class Autenticacion
    {
        public long IdUsuario { get; set; }
        public string? Nombre { get; set; }
        public string? CorreoElectronico { get; set; }
        public string? Identificacion { get; set; }
        public string? Contrasenna { get; set; }
        public bool Estado { get; set; }
        public string? Token { get; set; }
    }
}
