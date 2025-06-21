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

CREATE TABLE [dbo].[TUsuario](
	[IdUsuario] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[CorreoElectronico] [varchar](100) NOT NULL,
	[NombreUsuario] [varchar](20) NOT NULL,
	[Contrasenna] [varchar](10) NOT NULL,
	[Estado] [bit] NOT NULL,
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
SET IDENTITY_INSERT [dbo].[TError] OFF
GO

SET IDENTITY_INSERT [dbo].[TUsuario] ON 
GO
INSERT [dbo].[TUsuario] ([IdUsuario], [Nombre], [CorreoElectronico], [NombreUsuario], [Contrasenna], [Estado]) VALUES (1, N'Nathalie', N'npoveda1@ufide.ac.cr', N'npoveda1', N'1', 1)
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
	[NombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
    @NombreUsuario varchar(20),
    @Contrasenna varchar(10),
	@Estado bit
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM dbo.TUsuario
				  WHERE NombreUsuario = @NombreUsuario
					OR	CorreoElectronico = @CorreoElectronico)
	BEGIN

		INSERT INTO dbo.TUsuario (Nombre,CorreoElectronico,NombreUsuario,Contrasenna,Estado)
		VALUES (@Nombre, @CorreoElectronico, @NombreUsuario, @Contrasenna, @Estado)

	END		
END
GO

CREATE PROCEDURE [dbo].[ValidarInicioSesion]
	@NombreUsuario varchar(20),
    @Contrasenna varchar(10)
AS
BEGIN

	SELECT	IdUsuario,
			Nombre,
			CorreoElectronico,
			NombreUsuario
	  FROM	dbo.TUsuario
	WHERE	NombreUsuario = @NombreUsuario
		AND Contrasenna = @Contrasenna

END
GO
