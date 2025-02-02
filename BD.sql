USE [master]
GO
/****** Object:  Database [Test]    Script Date: 8/6/2024 6:18:42 PM ******/
CREATE DATABASE [Test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Test] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Test] SET ARITHABORT OFF 
GO
ALTER DATABASE [Test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Test] SET  MULTI_USER 
GO
ALTER DATABASE [Test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Test] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Test] SET QUERY_STORE = ON
GO
ALTER DATABASE [Test] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Test]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[n_identificacion] [varchar](16) NOT NULL,
	[tipo_identificacion] [char](1) NOT NULL,
	[primer_nombre] [varchar](50) NOT NULL,
	[segundo_nombre] [varchar](50) NULL,
	[primer_apellido] [varchar](50) NOT NULL,
	[segundo_apellido] [varchar](50) NULL,
	[Id_direccion] [int] NOT NULL,
	[estado] [char](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_cliente_id]    Script Date: 8/6/2024 6:18:42 PM ******/
CREATE CLUSTERED INDEX [IDX_cliente_id] ON [dbo].[Cliente]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direccion]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direccion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [text] NOT NULL,
 CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamo]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamo](
	[n_prestamo] [int] NOT NULL,
	[tipo_prestamo] [char](1) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[fecha_inicio] [date] NOT NULL,
	[fecha_fin] [date] NOT NULL,
	[monto_solicitado] [numeric](10, 2) NOT NULL,
	[moneda] [varchar](10) NOT NULL,
	[plazo_financiamiento] [int] NOT NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK_Prestamo] PRIMARY KEY CLUSTERED 
(
	[n_prestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_clientes_prestamos]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[vw_clientes_prestamos] AS SELECT c.n_identificacion as identificacion, c.primer_nombre,c.segundo_nombre,c.primer_apellido,c.segundo_apellido, d.Descripcion as direccion, p.n_prestamo,
p.tipo_prestamo,p.fecha_inicio,p.fecha_fin,p.monto_solicitado,p.moneda,p.plazo_financiamiento, p.estado FROM Cliente  c
INNER JOIN Direccion d ON d.Id = c.Id_direccion
INNER JOIN Prestamo p ON p.id_cliente =  c.Id
WHERE p.estado = 'A' and plazo_financiamiento > 36
GO
/****** Object:  View [dbo].[vw_cantidad_prestamo_estado]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_cantidad_prestamo_estado] AS SELECT estado,moneda, COUNT(*) as cantidad FROM Prestamo WHERE monto_solicitado > 10000 GROUP BY estado,moneda
GO
/****** Object:  View [dbo].[vw_clientes]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[vw_clientes]
AS
SELECT c.Id as id_cliente, c.n_identificacion as identificacion,c.tipo_identificacion, c.primer_nombre,c.segundo_nombre,c.primer_apellido,c.segundo_apellido,d.Id as id_direccion, d.Descripcion as direccion,CASE WHEN estado = 'A' THEN 'Activo' ELSE 'Inactivo' END as estado FROM Cliente  c
INNER JOIN Direccion d ON d.Id = c.Id_direccion
GO
/****** Object:  View [dbo].[vw_direccion]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_direccion] as select * from Direccion;
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([Id], [n_identificacion], [tipo_identificacion], [primer_nombre], [segundo_nombre], [primer_apellido], [segundo_apellido], [Id_direccion], [estado]) VALUES (1, N'1211310940006D', N'N', N'Juan', N'Jose', N'Bolaños', N'Cruz', 1, N'A')
INSERT [dbo].[Cliente] ([Id], [n_identificacion], [tipo_identificacion], [primer_nombre], [segundo_nombre], [primer_apellido], [segundo_apellido], [Id_direccion], [estado]) VALUES (6, N'1210508120005F', N'N', N'Rosa', N'Marina', N'Lumbi', N'Suarez', 2, N'I')
INSERT [dbo].[Cliente] ([Id], [n_identificacion], [tipo_identificacion], [primer_nombre], [segundo_nombre], [primer_apellido], [segundo_apellido], [Id_direccion], [estado]) VALUES (7, N'1211310940006D', N'P', N'Luisa', N'Alfre', N'Guzman', N'Torrez', 2, N'I')
INSERT [dbo].[Cliente] ([Id], [n_identificacion], [tipo_identificacion], [primer_nombre], [segundo_nombre], [primer_apellido], [segundo_apellido], [Id_direccion], [estado]) VALUES (12, N'1211310940006D', N'N', N'Camilo', N'Alfre', N'Guzman', N'Torrez', 1, N'I')
INSERT [dbo].[Cliente] ([Id], [n_identificacion], [tipo_identificacion], [primer_nombre], [segundo_nombre], [primer_apellido], [segundo_apellido], [Id_direccion], [estado]) VALUES (13, N'1211103100004C', N'N', N'Teodoro', N'Gonzalez', N'Ruiz', N'Otero', 2, N'I')
INSERT [dbo].[Cliente] ([Id], [n_identificacion], [tipo_identificacion], [primer_nombre], [segundo_nombre], [primer_apellido], [segundo_apellido], [Id_direccion], [estado]) VALUES (14, N'1211103100004C', N'N', N'Teodora', N'Gonzalez', N'Ruiz', N'Otero', 1, N'A')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Direccion] ON 

INSERT [dbo].[Direccion] ([Id], [Descripcion]) VALUES (1, N'Iglesia Maranatha 3c Oeste')
INSERT [dbo].[Direccion] ([Id], [Descripcion]) VALUES (2, N'HOSPITAL')
SET IDENTITY_INSERT [dbo].[Direccion] OFF
GO
INSERT [dbo].[Prestamo] ([n_prestamo], [tipo_prestamo], [id_cliente], [fecha_inicio], [fecha_fin], [monto_solicitado], [moneda], [plazo_financiamiento], [estado]) VALUES (1, N'C', 1, CAST(N'2024-08-06' AS Date), CAST(N'2025-08-06' AS Date), CAST(11000.00 AS Numeric(10, 2)), N'Cordoba', 12, N'A')
GO
/****** Object:  Index [PK_Cliente]    Script Date: 8/6/2024 6:18:42 PM ******/
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [PK_Cliente] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_direccion]    Script Date: 8/6/2024 6:18:42 PM ******/
CREATE NONCLUSTERED INDEX [IDX_direccion] ON [dbo].[Direccion]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_numero_prestamo]    Script Date: 8/6/2024 6:18:42 PM ******/
CREATE NONCLUSTERED INDEX [IDX_numero_prestamo] ON [dbo].[Prestamo]
(
	[n_prestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [DF_Cliente_estado]  DEFAULT ('A') FOR [estado]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Direccion] FOREIGN KEY([Id_direccion])
REFERENCES [dbo].[Direccion] ([Id])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Direccion]
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD  CONSTRAINT [FK_Prestamo_Cliente] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Cliente] ([Id])
GO
ALTER TABLE [dbo].[Prestamo] CHECK CONSTRAINT [FK_Prestamo_Cliente]
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_cliente]
@Id int = 0,
@n_identificacion varchar(16),
@tipo_identificacion varchar(1),
@primer_nombre varchar(50),
@segundo_nombre varchar(50),
@primer_apellido varchar(50),
@segundo_apellido varchar(50),
@id_direccion int,
@estado char(1) = 'A',
@accion char(1)
AS
BEGIN

	IF @accion = 'I' 
	BEGIN
		INSERT INTO Cliente(n_identificacion,tipo_identificacion,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,Id_direccion) 
		VALUES(@n_identificacion,@tipo_identificacion,@primer_nombre,@segundo_nombre,@primer_apellido,@segundo_apellido,@id_direccion);
	END
	ELSE IF @accion ='U'
	BEGIN
		UPDATE Cliente SET n_identificacion =@n_identificacion, tipo_identificacion=@tipo_identificacion, primer_nombre=@primer_nombre, segundo_nombre =@segundo_nombre, primer_apellido=@primer_apellido,
		segundo_apellido =@segundo_apellido, Id_direccion = @id_direccion
		WHERE Id=@Id;
	END
	ELSE IF @accion ='D'
	BEGIN
		UPDATE Cliente SET estado = @estado WHERE Id = @Id;
	END;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_direccion]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_direccion]
@Id int = 0,
@descripcion text,
@accion char(1),
@pid INT OUTPUT
AS
BEGIN

	IF @accion = 'I' 
	BEGIN
		INSERT INTO Direccion(Descripcion)VALUES(@descripcion);
		SET @pid = SCOPE_IDENTITY();
	END
	ELSE IF @accion ='U'
	BEGIN
		UPDATE Direccion SET Descripcion =@descripcion
		WHERE Id=@Id;
	END
	ELSE 
	BEGIN
		DELETE FROM Direccion WHERE Id=@Id;
	END;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_prestamo]    Script Date: 8/6/2024 6:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_prestamo]
@n_prestamo int,
@tipo_prestamo char(1),
@id_cliente int,
@fecha_inicio date,
@fecha_fin date,
@monto_solicitado numeric(10,2),
@moneda varchar(10),
@plazo_financiamiento int,
@estado char(1) ='A',
@accion char(1)
AS
BEGIN

	IF @accion = 'I' 
	BEGIN
		INSERT INTO Prestamo(tipo_prestamo,id_cliente,fecha_inicio,fecha_fin,monto_solicitado,moneda,plazo_financiamiento,estado)
		VALUES(@tipo_prestamo,@id_cliente,@fecha_inicio,@fecha_fin,@monto_solicitado,@moneda,@plazo_financiamiento,@estado)
	END
	ELSE IF @accion ='U'
	BEGIN
		UPDATE Prestamo SET tipo_prestamo=@tipo_prestamo,id_cliente=@id_cliente,fecha_inicio=@fecha_inicio,fecha_fin=@fecha_fin,monto_solicitado=@monto_solicitado,moneda=@moneda,
		plazo_financiamiento=@plazo_financiamiento
		WHERE n_prestamo=@n_prestamo
	END
	ELSE 
	BEGIN
		UPDATE Prestamo SET estado=@estado WHERE n_prestamo=@n_prestamo
	END;

END
GO
USE [master]
GO
ALTER DATABASE [Test] SET  READ_WRITE 
GO
