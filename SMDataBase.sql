USE [master]
GO

CREATE DATABASE [SMDataBase]
GO

USE [SMDataBase]
GO

CREATE TABLE [dbo].[TError](
	[IdError] [bigint] IDENTITY(1,1) NOT NULL,
	[Mensaje] [varchar](max) NOT NULL,
	[Origen] [varchar](255) NOT NULL,
	[FechaHora] [datetime] NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
 CONSTRAINT [PK_TError] PRIMARY KEY CLUSTERED 
(
	[IdError] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[TRol](
	[IdRol] [bigint] IDENTITY(1,1) NOT NULL,
	[NombreRol] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TRol] PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TUsuario](
	[IdUsuario] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[CorreoElectronico] [varchar](100) NOT NULL,
	[Identificacion] [varchar](20) NOT NULL,
	[Contrasenna] [varchar](255) NOT NULL,
	[Estado] [bit] NOT NULL,
	[IdRol] [bigint] NOT NULL,
 CONSTRAINT [PK_TUsuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[TError] ON 
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (1, N'Could not find stored procedure ''ValidarInicioSesion2''.', N'/api/Home/Index', CAST(N'2025-06-21T10:21:05.440' AS DateTime), 0)
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (2, N'Could not find stored procedure ''ValidarInicioSesion2''.', N'/api/Home/Index', CAST(N'2025-06-21T10:21:24.190' AS DateTime), 0)
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (3, N'Could not find stored procedure ''ConsultaUsuario2''.', N'/api/Usuario/ConsultarUsuario', CAST(N'2025-07-19T10:20:03.233' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[TError] OFF
GO

SET IDENTITY_INSERT [dbo].[TRol] ON 
GO
INSERT [dbo].[TRol] ([IdRol], [NombreRol]) VALUES (1, N'Usuario Regular')
GO
INSERT [dbo].[TRol] ([IdRol], [NombreRol]) VALUES (2, N'Usuario Administrador')
GO
SET IDENTITY_INSERT [dbo].[TRol] OFF
GO

SET IDENTITY_INSERT [dbo].[TUsuario] ON 
GO
INSERT [dbo].[TUsuario] ([IdUsuario], [Nombre], [CorreoElectronico], [Identificacion], [Contrasenna], [Estado], [IdRol]) VALUES (1, N'JOSUE CAMPOS ACUÑA', N'jcampos40909@ufide.ac.cr', N'118940909', N'RRuOCbl+Uz4MRh1R56n7Nw==', 1, 2)
GO
SET IDENTITY_INSERT [dbo].[TUsuario] OFF
GO

ALTER TABLE [dbo].[TUsuario] ADD  CONSTRAINT [uk_CorreoElectronico] UNIQUE NONCLUSTERED 
(
	[CorreoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TUsuario] ADD  CONSTRAINT [uk_NombreUsuario] UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TUsuario_TRol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[TRol] ([IdRol])
GO
ALTER TABLE [dbo].[TUsuario] CHECK CONSTRAINT [FK_TUsuario_TRol]
GO

CREATE PROCEDURE [dbo].[ActualizarContrasenna]
	@IdUsuario bigint,
    @Contrasenna varchar(255)
AS
BEGIN

	UPDATE dbo.TUsuario
	SET Contrasenna = @Contrasenna
	WHERE IdUsuario = @IdUsuario

END
GO

CREATE PROCEDURE [dbo].[ActualizarUsuario]
	@IdUsuario bigint,
    @Identificacion varchar(20),
	@Nombre varchar(255),
	@CorreoElectronico varchar(100)
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM dbo.TUsuario
				  WHERE Identificacion = @Identificacion
					AND	CorreoElectronico = @CorreoElectronico
					AND IdUsuario != @IdUsuario)
	BEGIN

		UPDATE dbo.TUsuario
		SET Identificacion = @Identificacion,
			Nombre = @Nombre,
			CorreoElectronico = @CorreoElectronico
		WHERE IdUsuario = @IdUsuario
		
	END
END
GO

CREATE PROCEDURE [dbo].[ConsultaUsuario]
	@IdUsuario BIGINT
AS
BEGIN

	SELECT	IdUsuario,
			Nombre,
			CorreoElectronico,
			Identificacion,
			Estado,
			U.IdRol,
			R.NombreRol
	  FROM	dbo.TUsuario U
	  INNER JOIN dbo.TRol R ON U.IdRol = R.IdRol
	WHERE	IdUsuario = @IdUsuario

END
GO

CREATE PROCEDURE [dbo].[RegistrarError]
	@Mensaje varchar(max),
	@Origen varchar(255),
    @IdUsuario bigint
AS
BEGIN

	INSERT INTO dbo.TError (Mensaje,Origen,FechaHora,IdUsuario)
    VALUES (@Mensaje, @Origen, GETDATE(),@IdUsuario)

END
GO

CREATE PROCEDURE [dbo].[RegistrarUsuario]
	@Nombre varchar(255),
    @CorreoElectronico varchar(100),
    @Identificacion varchar(20),
    @Contrasenna varchar(255),
	@Estado bit
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM dbo.TUsuario
				  WHERE Identificacion = @Identificacion
					OR	CorreoElectronico = @CorreoElectronico)
	BEGIN

		INSERT INTO dbo.TUsuario (Nombre,CorreoElectronico,Identificacion,Contrasenna,Estado,IdRol)
		VALUES (@Nombre, @CorreoElectronico, @Identificacion, @Contrasenna, @Estado,1)

	END		
END
GO

CREATE PROCEDURE [dbo].[ValidarCorreo]
	@CorreoElectronico varchar(100)
AS
BEGIN

	SELECT	IdUsuario,
			Nombre,
			CorreoElectronico,
			Identificacion
	  FROM	dbo.TUsuario
	WHERE	CorreoElectronico = @CorreoElectronico

END
GO

CREATE PROCEDURE [dbo].[ValidarInicioSesion]
	@CorreoElectronico varchar(100),
    @Contrasenna varchar(255)
AS
BEGIN

	SELECT	IdUsuario,
			Nombre,
			CorreoElectronico,
			Identificacion,
			Estado,
			U.IdRol,
			R.NombreRol
	  FROM	dbo.TUsuario U
	  INNER JOIN dbo.TRol R ON U.IdRol = R.IdRol
	WHERE	CorreoElectronico = @CorreoElectronico
		AND Contrasenna = @Contrasenna

END
GO