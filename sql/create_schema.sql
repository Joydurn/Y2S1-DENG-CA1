USE [master]
GO
/****** Object:  Database [VideoStore]    Script Date: 5/6/2022 9:09:46 pm ******/
CREATE DATABASE [VideoStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VideoStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\VideoStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VideoStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\VideoStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [VideoStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VideoStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VideoStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VideoStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VideoStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VideoStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [VideoStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VideoStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VideoStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VideoStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VideoStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VideoStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VideoStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VideoStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VideoStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VideoStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VideoStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VideoStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VideoStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VideoStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VideoStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VideoStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VideoStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VideoStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VideoStore] SET  MULTI_USER 
GO
ALTER DATABASE [VideoStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VideoStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VideoStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VideoStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VideoStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VideoStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [VideoStore] SET QUERY_STORE = OFF
GO
USE [VideoStore]
GO
/****** Object:  Table [dbo].[address]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[street] [varchar](100) NOT NULL,
	[zipcode] [varchar](10) NOT NULL,
	[state] [varchar](100) NULL,
	[city] [varchar](100) NULL,
	[country] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[street] ASC,
	[zipcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customerId] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](4) NOT NULL,
	[firstName] [varchar](40) NOT NULL,
	[lastName] [varchar](40) NOT NULL,
	[password] [varchar](200) NOT NULL,
	[phone] [varchar](12) NOT NULL,
	[zipcode] [varchar](10) NULL,
	[street] [varchar](100) NULL,
	[driverLicense] [varchar](50) NULL,
	[cardNo] [varchar](50) NULL,
	[cardType] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[customerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[employeeId] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](40) NOT NULL,
	[firstName] [varchar](40) NULL,
	[lastName] [varchar](40) NULL,
	[salary] [decimal](8, 2) NOT NULL,
	[street] [varchar](100) NOT NULL,
	[zipCode] [varchar](10) NOT NULL,
	[title] [varchar](4) NOT NULL,
	[storeId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[employeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventory]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[invId] [int] IDENTITY(1,1) NOT NULL,
	[itemId] [int] NOT NULL,
	[storeId] [int] NOT NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[invId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[itemCatalog]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itemCatalog](
	[itemId] [int] IDENTITY(1,1) NOT NULL,
	[itemName] [varchar](255) NOT NULL,
	[chargeDaily] [decimal](6, 2) NOT NULL,
	[purchaseDate] [date] NOT NULL,
	[categoryName] [varchar](20) NOT NULL,
	[imageUrl] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[itemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lateCharge]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lateCharge](
	[categoryName] [varchar](20) NOT NULL,
	[lateCharge] [decimal](6, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[maxItems]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[maxItems](
	[storeId] [int] NOT NULL,
	[itemId] [int] NOT NULL,
	[maxItems] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[storeId] ASC,
	[itemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movieDetails]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movieDetails](
	[movieId] [int] IDENTITY(1,1) NOT NULL,
	[movieTitle] [varchar](100) NOT NULL,
	[director] [varchar](100) NOT NULL,
	[producer] [varchar](100) NOT NULL,
	[actor] [varchar](100) NOT NULL,
	[actor2] [varchar](100) NULL,
	[releaseDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[movieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movieItem]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movieItem](
	[itemId] [int] NOT NULL,
	[movieId] [int] NOT NULL,
	[type] [varchar](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[itemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rentPayment]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rentPayment](
	[paymentId] [int] IDENTITY(1,1) NOT NULL,
	[transId] [int] NOT NULL,
	[returnDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[store]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[store](
	[storeId] [int] IDENTITY(1,1) NOT NULL,
	[location] [varchar](100) NULL,
	[street] [varchar](100) NULL,
	[zipCode] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[storeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactions]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[transId] [int] IDENTITY(1,1) NOT NULL,
	[storeId] [int] NOT NULL,
	[customerId] [int] NOT NULL,
	[type] [varchar](10) NOT NULL,
	[startDate] [date] NOT NULL,
	[dueDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transItems]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transItems](
	[transId] [int] NOT NULL,
	[invId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transId] ASC,
	[invId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vcr]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vcr](
	[itemId] [int] NOT NULL,
	[type] [varchar](10) NOT NULL,
	[brand] [varchar](40) NOT NULL,
	[madeBy] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[itemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[videoCamera]    Script Date: 5/6/2022 9:09:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[videoCamera](
	[itemId] [int] NOT NULL,
	[brand] [varchar](40) NOT NULL,
	[madeBy] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[itemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD FOREIGN KEY([street], [zipcode])
REFERENCES [dbo].[address] ([street], [zipcode])
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD FOREIGN KEY([street], [zipCode])
REFERENCES [dbo].[address] ([street], [zipcode])
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[store] ([storeId])
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD FOREIGN KEY([itemId])
REFERENCES [dbo].[itemCatalog] ([itemId])
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[store] ([storeId])
GO
ALTER TABLE [dbo].[itemCatalog]  WITH CHECK ADD FOREIGN KEY([categoryName])
REFERENCES [dbo].[lateCharge] ([categoryName])
GO
ALTER TABLE [dbo].[maxItems]  WITH CHECK ADD FOREIGN KEY([itemId])
REFERENCES [dbo].[itemCatalog] ([itemId])
GO
ALTER TABLE [dbo].[maxItems]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[store] ([storeId])
GO
ALTER TABLE [dbo].[movieItem]  WITH CHECK ADD FOREIGN KEY([itemId])
REFERENCES [dbo].[itemCatalog] ([itemId])
GO
ALTER TABLE [dbo].[movieItem]  WITH CHECK ADD FOREIGN KEY([movieId])
REFERENCES [dbo].[movieDetails] ([movieId])
GO
ALTER TABLE [dbo].[rentPayment]  WITH CHECK ADD FOREIGN KEY([transId])
REFERENCES [dbo].[transactions] ([transId])
GO
ALTER TABLE [dbo].[store]  WITH CHECK ADD FOREIGN KEY([street], [zipCode])
REFERENCES [dbo].[address] ([street], [zipcode])
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD FOREIGN KEY([customerId])
REFERENCES [dbo].[customer] ([customerId])
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD FOREIGN KEY([storeId])
REFERENCES [dbo].[store] ([storeId])
GO
ALTER TABLE [dbo].[transItems]  WITH CHECK ADD FOREIGN KEY([invId])
REFERENCES [dbo].[inventory] ([invId])
GO
ALTER TABLE [dbo].[transItems]  WITH CHECK ADD FOREIGN KEY([transId])
REFERENCES [dbo].[transactions] ([transId])
GO
ALTER TABLE [dbo].[vcr]  WITH CHECK ADD FOREIGN KEY([itemId])
REFERENCES [dbo].[itemCatalog] ([itemId])
GO
ALTER TABLE [dbo].[videoCamera]  WITH CHECK ADD FOREIGN KEY([itemId])
REFERENCES [dbo].[itemCatalog] ([itemId])
GO
USE [master]
GO
ALTER DATABASE [VideoStore] SET  READ_WRITE 
GO
