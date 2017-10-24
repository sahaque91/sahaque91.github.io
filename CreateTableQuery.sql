USE [HiDive]
GO

/****** Object:  Table [dbo].[Anime]    Script Date: 10/22/2017 5:44:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Anime](
	[AnimeID] [int] NOT NULL,
	[ShortSynopsis] [nvarchar](max) NULL,
	[MediumSynopsis] [nvarchar](max) NULL,
	[LongSynopsis] [nvarchar](max) NULL,
	[KeyArtUrl] [nvarchar](max) NULL,
	[MasterArtUrl] [nvarchar](max) NULL,
	[Rating] [nchar](20) NULL,
	[StarRating] [decimal](3, 2) NULL,
	[RunTime] [int] NULL,
	[FirstPremiereDate] [datetime] NULL,
	[ShowInfoTitle] [nvarchar](50) NULL,
	[EpisodeCount] [int] NULL,
	[SeasonName] [nvarchar](20) NULL,
	[IsSimulcast] [bit] NULL,
	[IsDub] [bit] NULL,
	[IsExclusive] [bit] NULL,
	[IsRecentlyAdded] [bit] NULL,
	[IsPopular] [bit] NULL,
	[IsTrending] [bit] NULL,
 CONSTRAINT [PK_Anime] PRIMARY KEY CLUSTERED 
(
	[AnimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


