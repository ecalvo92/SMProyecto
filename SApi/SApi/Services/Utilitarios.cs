using SApi.Models;
using System.Net.Mail;
using System.Net;
using System.Text.RegularExpressions;

namespace SApi.Services
{
    public class Utilitarios : IUtilitarios
    {
        private IConfiguration _configuration;
        public Utilitarios(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public RespuestaEstandar RespuestaCorrecta(object contenido)
        {
            return new RespuestaEstandar
            {
                Codigo = 0,
                Mensaje = "Operación exitosa",
                Contenido = contenido
            };
        }

        public RespuestaEstandar RespuestaIncorrecta(string mensaje)
        {
            return new RespuestaEstandar
            {
                Codigo = 99,
                Mensaje = mensaje,
                Contenido = null
            };
        }

        public string GenerarContrasena()
        {
            const string caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            var resultado = new System.Text.StringBuilder(8);

            for (int i = 0; i < 8; i++)
            {
                int indice = random.Next(caracteres.Length);
                resultado.Append(caracteres[indice]);
            }

            return resultado.ToString();
        }

        public void EnviarCorreo(string destinatario, string asunto, string cuerpo)
        {
            var remitente = _configuration.GetSection("SMTP:Remitente").Value;
            var contrasenna = _configuration.GetSection("SMTP:Contrasenna").Value;

            if (!string.IsNullOrEmpty(remitente) && !string.IsNullOrEmpty(contrasenna))
            {
                var mensaje = new MailMessage(remitente, destinatario, asunto, cuerpo);
                mensaje.IsBodyHtml = true;

                var smtp = new SmtpClient("smtp.office365.com", 587)
                {
                    Credentials = new NetworkCredential(remitente, contrasenna),
                    EnableSsl = true
                };

                smtp.Send(mensaje);
            }
        }

    }
}
