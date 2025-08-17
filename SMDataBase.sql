USE [master]
GO

CREATE DATABASE [SMDataBase]
GO

USE [SMDataBase]
GO

CREATE TABLE [dbo].[TCarrito](
	[IdCarrito] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_TCarrito] PRIMARY KEY CLUSTERED 
(
	[IdCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TDetalle](
	[IdDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdMaestro] [bigint] NOT NULL,
	[IdProducto] [bigint] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
	[SubTotal] [decimal](18, 2) NOT NULL,
	[Impuesto] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TDetalle] PRIMARY KEY CLUSTERED 
(
	[IdDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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

CREATE TABLE [dbo].[TMaestro](
	[IdMaestro] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TMaestro] PRIMARY KEY CLUSTERED 
(
	[IdMaestro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TProducto](
	[IdProducto] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Inventario] [int] NOT NULL,
	[Imagen] [varchar](255) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_TProducto] PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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

SET IDENTITY_INSERT [dbo].[TDetalle] ON 
GO
INSERT [dbo].[TDetalle] ([IdDetalle], [IdMaestro], [IdProducto], [Cantidad], [Precio], [SubTotal], [Impuesto], [Total]) VALUES (1, 1, 4, 2, CAST(500.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), CAST(130.00 AS Decimal(18, 2)), CAST(1130.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TDetalle] ([IdDetalle], [IdMaestro], [IdProducto], [Cantidad], [Precio], [SubTotal], [Impuesto], [Total]) VALUES (2, 1, 3, 1, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), CAST(260.00 AS Decimal(18, 2)), CAST(2260.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TDetalle] ([IdDetalle], [IdMaestro], [IdProducto], [Cantidad], [Precio], [SubTotal], [Impuesto], [Total]) VALUES (3, 2, 3, 1, CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), CAST(260.00 AS Decimal(18, 2)), CAST(2260.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TDetalle] ([IdDetalle], [IdMaestro], [IdProducto], [Cantidad], [Precio], [SubTotal], [Impuesto], [Total]) VALUES (4, 3, 4, 6, CAST(500.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(390.00 AS Decimal(18, 2)), CAST(3390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TDetalle] ([IdDetalle], [IdMaestro], [IdProducto], [Cantidad], [Precio], [SubTotal], [Impuesto], [Total]) VALUES (5, 4, 5, 1, CAST(500.00 AS Decimal(18, 2)), CAST(500.00 AS Decimal(18, 2)), CAST(65.00 AS Decimal(18, 2)), CAST(565.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[TDetalle] OFF
GO

SET IDENTITY_INSERT [dbo].[TError] ON 
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (1, N'Could not find stored procedure ''ValidarInicioSesion2''.', N'/api/Home/Index', CAST(N'2025-06-21T10:21:05.440' AS DateTime), 0)
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (2, N'Could not find stored procedure ''ValidarInicioSesion2''.', N'/api/Home/Index', CAST(N'2025-06-21T10:21:24.190' AS DateTime), 0)
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (3, N'Could not find stored procedure ''ConsultaUsuario2''.', N'/api/Usuario/ConsultarUsuario', CAST(N'2025-07-19T10:20:03.233' AS DateTime), 1)
GO
INSERT [dbo].[TError] ([IdError], [Mensaje], [Origen], [FechaHora], [IdUsuario]) VALUES (4, N'Error converting data type varchar to bigint.', N'/api/Productos/RegistrarProducto', CAST(N'2025-08-09T09:20:30.583' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[TError] OFF
GO

SET IDENTITY_INSERT [dbo].[TMaestro] ON 
GO
INSERT [dbo].[TMaestro] ([IdMaestro], [IdUsuario], [Fecha], [Total]) VALUES (1, 2, CAST(N'2025-08-16T10:03:34.743' AS DateTime), CAST(3390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TMaestro] ([IdMaestro], [IdUsuario], [Fecha], [Total]) VALUES (2, 2, CAST(N'2025-08-16T10:04:32.067' AS DateTime), CAST(2260.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TMaestro] ([IdMaestro], [IdUsuario], [Fecha], [Total]) VALUES (3, 2, CAST(N'2025-08-16T10:06:27.560' AS DateTime), CAST(3390.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TMaestro] ([IdMaestro], [IdUsuario], [Fecha], [Total]) VALUES (4, 2, CAST(N'2025-08-16T10:28:49.877' AS DateTime), CAST(565.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[TMaestro] OFF
GO

SET IDENTITY_INSERT [dbo].[TProducto] ON 
GO
INSERT [dbo].[TProducto] ([IdProducto], [Nombre], [Descripcion], [Precio], [Inventario], [Imagen], [Estado]) VALUES (3, N'PS2', N'PLAY STATION 2', CAST(2000.00 AS Decimal(10, 2)), 0, N'/productos/3.png', 1)
GO
INSERT [dbo].[TProducto] ([IdProducto], [Nombre], [Descripcion], [Precio], [Inventario], [Imagen], [Estado]) VALUES (4, N'ps4', N'PLLAY STATION 4', CAST(500.00 AS Decimal(10, 2)), 0, N'/productos/4.png', 1)
GO
INSERT [dbo].[TProducto] ([IdProducto], [Nombre], [Descripcion], [Precio], [Inventario], [Imagen], [Estado]) VALUES (5, N'ps5', N'Consola de videojuesgos ps5', CAST(500.00 AS Decimal(10, 2)), 7, N'/productos/5.png', 1)
GO
SET IDENTITY_INSERT [dbo].[TProducto] OFF
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
INSERT [dbo].[TUsuario] ([IdUsuario], [Nombre], [CorreoElectronico], [Identificacion], [Contrasenna], [Estado], [IdRol]) VALUES (1, N'JOSUE CAMPOS ACUÑA', N'jcampos40909@ufide.ac.cr', N'118940909', N'FryXUM3ksBjsPEmTHastDw==', 1, 2)
GO
INSERT [dbo].[TUsuario] ([IdUsuario], [Nombre], [CorreoElectronico], [Identificacion], [Contrasenna], [Estado], [IdRol]) VALUES (2, N'EDUARDO JOSE CALVO CASTILLO', N'ecalvo90415@ufide.ac.cr', N'304590415', N'm492i8KL8cOxlO4Cg/gt8g==', 1, 1)
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

ALTER TABLE [dbo].[TCarrito]  WITH CHECK ADD  CONSTRAINT [FK_TCarrito_TProducto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[TProducto] ([IdProducto])
GO
ALTER TABLE [dbo].[TCarrito] CHECK CONSTRAINT [FK_TCarrito_TProducto]
GO

ALTER TABLE [dbo].[TCarrito]  WITH CHECK ADD  CONSTRAINT [FK_TCarrito_TUsuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[TUsuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[TCarrito] CHECK CONSTRAINT [FK_TCarrito_TUsuario]
GO

ALTER TABLE [dbo].[TDetalle]  WITH CHECK ADD  CONSTRAINT [FK_TDetalle_TProducto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[TProducto] ([IdProducto])
GO
ALTER TABLE [dbo].[TDetalle] CHECK CONSTRAINT [FK_TDetalle_TProducto]
GO

ALTER TABLE [dbo].[TMaestro]  WITH CHECK ADD  CONSTRAINT [FK_TMaestro_TUsuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[TUsuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[TMaestro] CHECK CONSTRAINT [FK_TMaestro_TUsuario]
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

CREATE PROCEDURE [dbo].[ActualizarDatosUsuario]
	@IdUsuario bigint,
    @Estado bit,
	@IdRol bigint
AS
BEGIN

	UPDATE dbo.TUsuario
	SET Estado = @Estado,
		IdRol = @IdRol
	WHERE IdUsuario = @IdUsuario
		
END
GO

CREATE PROCEDURE [dbo].[ActualizarProducto]
	@IdProducto bigint,
	@Nombre varchar(50),
    @Descripcion varchar(255),
    @Precio decimal(10,2),
    @Inventario int
AS
BEGIN

	UPDATE dbo.TProducto
	   SET Nombre = @Nombre,
		   Descripcion = @Descripcion,
		   Precio = @Precio,
		   Inventario = @Inventario
	 WHERE IdProducto = @IdProducto

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

CREATE PROCEDURE [dbo].[ConsultarCarrito]
    @IdUsuario BIGINT
AS
BEGIN

	SELECT  IdCarrito,
            C.IdProducto,
            P.Nombre,
            Cantidad,
            P.Precio,
            (P.Precio * Cantidad) 'SubTotal',
            (P.Precio * Cantidad) * 0.13 'Impuesto',
            (P.Precio * Cantidad) * 1.13 'Total',
            Fecha
    FROM    dbo.TCarrito C
    INNER   JOIN dbo.TProducto P ON C.IdProducto = P.IdProducto
    WHERE   IdUsuario = @IdUsuario

END
GO

CREATE PROCEDURE [dbo].[ConsultarCompras]
    @IdUsuario BIGINT
AS
BEGIN

	SELECT	M.IdMaestro,
			Fecha,
			SUM(D.Cantidad) 'Cantidad',
			SUM(D.SubTotal) 'SubTotal',
			SUM(D.Impuesto) 'Impuesto',
			SUM(D.Total) 'Total'
	FROM	TMaestro M
	INNER	JOIN TDetalle D ON M.IdMaestro = D.IdMaestro
	WHERE	M.IdUsuario = @IdUsuario
	GROUP BY M.IdMaestro, Fecha

END
GO

CREATE PROCEDURE [dbo].[ConsultarDetalleCompras]
    @IdMaestro BIGINT
AS
BEGIN

	SELECT	IdDetalle,
			IdMaestro,
			D.IdProducto,
			P.Nombre,
			Cantidad,
			D.Precio,
			SubTotal,
			Impuesto,
			Total
	FROM	TDetalle D
	INNER	JOIN TProducto P ON D.IdProducto = P.IdProducto
	WHERE	IdMaestro = @IdMaestro

END
GO

CREATE PROCEDURE [dbo].[ConsultarProducto]
	@IdProducto bigint
AS
BEGIN

	SELECT	IdProducto,
			Nombre,
			Descripcion,
			Precio,
			Inventario,
			Imagen,
			Estado
	  FROM	dbo.TProducto
	  WHERE IdProducto = @IdProducto
	
END
GO

CREATE PROCEDURE [dbo].[ConsultarProductos]

AS
BEGIN

	SELECT	IdProducto,
			Nombre,
			Descripcion,
			Precio,
			Inventario,
			Imagen,
			Estado
	  FROM	dbo.TProducto
	  ORDER BY IdProducto ASC
	
END
GO

CREATE PROCEDURE [dbo].[ConsultarRoles]

AS
BEGIN

	SELECT	IdRol,
			NombreRol
	  FROM	dbo.TRol

END
GO

CREATE PROCEDURE [dbo].[ConsultarUsuario]
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

CREATE PROCEDURE [dbo].[ConsultarUsuarios]

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

END
GO

CREATE PROCEDURE [dbo].[EliminarProductoCarrito]
	@IdUsuario bigint,
	@IdProducto bigint
AS
BEGIN

	DELETE FROM TCarrito WHERE IdProducto = @IdProducto 
		AND IdUsuario = @IdUsuario

END
GO

CREATE PROCEDURE [dbo].[ProcesarPagoCarrito]
	@IdUsuario bigint
AS
BEGIN

    INSERT INTO dbo.TMaestro(IdUsuario,Fecha,Total)
	SELECT	C.IdUsuario, GETDATE(), SUM(C.Cantidad * P.Precio) * 1.13
	FROM	TCarrito C
	INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
	WHERE	IdUsuario = @IdUsuario
	GROUP BY C.IdUsuario

	DECLARE @IdMaestroGenerado BIGINT = SCOPE_IDENTITY()

    INSERT INTO dbo.TDetalle(IdMaestro,IdProducto,Cantidad,Precio,SubTotal,Impuesto,Total)
    SELECT	@IdMaestroGenerado, C.IdProducto, C.Cantidad, P.Precio,
			(C.Cantidad * P.Precio),
			(C.Cantidad * P.Precio) * 0.13,
			(C.Cantidad * P.Precio) * 1.13
	FROM	TCarrito C
	INNER	JOIN TProducto P ON C.IdProducto = P.IdProducto
	WHERE	IdUsuario = @IdUsuario

	UPDATE	P
	SET	P.Inventario = P.Inventario - C.Cantidad
	FROM TProducto P
	INNER JOIN TCarrito C ON P.IdProducto = C.IdProducto
	WHERE	IdUsuario = @IdUsuario

	DELETE FROM TCarrito WHERE	IdUsuario = @IdUsuario

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

CREATE PROCEDURE [dbo].[RegistrarProducto]
	@Nombre varchar(50),
    @Descripcion varchar(255),
    @Precio decimal(10,2),
    @Inventario int
AS
BEGIN

	INSERT INTO dbo.TProducto (Nombre,Descripcion,Precio,Inventario,Imagen,Estado)
    VALUES (@Nombre, @Descripcion, @Precio, @Inventario, '', 1)

	DECLARE @IdProductoGenerado BIGINT = @@IDENTITY

	UPDATE	dbo.TProducto
	SET		Imagen = '/productos/' + CONVERT(VARCHAR,@IdProductoGenerado) + '.png'
	WHERE	IdProducto = @IdProductoGenerado

	SELECT @IdProductoGenerado 'IdProducto'

END
GO

CREATE PROCEDURE [dbo].[RegistrarProductoCarrito]
	@IdUsuario bigint,
	@IdProducto bigint
AS
BEGIN

	IF NOT EXISTS(SELECT 1 FROM TCarrito
				  WHERE IdUsuario = @IdUsuario
					AND IdProducto = @IdProducto)
	BEGIN

		INSERT dbo.TCarrito(IdUsuario,IdProducto,Cantidad,Fecha)
		VALUES (@IdUsuario, @IdProducto, 1, GETDATE())

	END
	ELSE
	BEGIN

		UPDATE	dbo.TCarrito
		SET		Cantidad = Cantidad + 1,
				Fecha = GETDATE()
		WHERE	IdUsuario = @IdUsuario
			AND IdProducto = @IdProducto

	END

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