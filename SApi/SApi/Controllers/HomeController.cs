﻿using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SApi.Models;
using SApi.Services;
using System.Reflection.Metadata.Ecma335;

namespace SApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IHostEnvironment _environment;
        private readonly IUtilitarios _utilitarios;
        public HomeController(IConfiguration configuration, IHostEnvironment environment, IUtilitarios utilitarios)
        {
            _configuration = configuration;
            _environment = environment;
            _utilitarios = utilitarios;
        }

        [HttpPost]
        [Route("Registro")]
        public IActionResult Registro(Autenticacion autenticacion)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.Execute("RegistrarUsuario", new
                {
                    autenticacion.Nombre,
                    autenticacion.CorreoElectronico,
                    autenticacion.Identificacion,
                    autenticacion.Contrasenna,
                    autenticacion.Estado
                });

                if (resultado > 0)
                    return Ok(_utilitarios.RespuestaCorrecta(autenticacion));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("Su información no fue registrada correctamente"));
            }
        }

        [HttpPost]
        [Route("Index")]
        public IActionResult Index(Autenticacion autenticacion)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.QueryFirstOrDefault<Autenticacion>("ValidarInicioSesion", new
                {
                    autenticacion.CorreoElectronico,
                    autenticacion.Contrasenna
                });

                if (resultado != null)
                    return Ok(_utilitarios.RespuestaCorrecta(resultado));
                else
                    return BadRequest(_utilitarios.RespuestaIncorrecta("Su información no fue validada correctamente"));
            }
        }

        [HttpPost]
        [Route("RecuperarAcceso")]
        public IActionResult RecuperarAcceso(Autenticacion autenticacion)
        {
            using (var contexto = new SqlConnection(_configuration.GetSection("ConnectionStrings:Connection").Value))
            {
                var resultado = contexto.QueryFirstOrDefault<Autenticacion>("ValidarCorreo", new
                {
                    autenticacion.CorreoElectronico
                });

                if (resultado != null)
                {
                    var Contrasenna = _utilitarios.GenerarContrasena();

                    var resultadoActuallizacion = contexto.Execute("ActualizarContrasenna", new
                    {
                        resultado.IdUsuario,
                        Contrasenna
                    });

                    if (resultadoActuallizacion > 0)
                    {
                        var ruta = Path.Combine(_environment.ContentRootPath, "Correos.html");
                        var html = System.IO.File.ReadAllText(ruta);

                        html = html.Replace("@@NombreUsuario", resultado.Nombre);
                        html = html.Replace("@@Contrasenna", Contrasenna);

                        _utilitarios.EnviarCorreo(resultado.CorreoElectronico!, "Acceso al Sistema", html);
                        return Ok(_utilitarios.RespuestaCorrecta(resultado));
                    }
                }
                
                return BadRequest(_utilitarios.RespuestaIncorrecta("Su información no fue validada correctamente"));
            }
        }

    }
}
