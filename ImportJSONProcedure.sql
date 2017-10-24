Use [HiDive]
GO

ALTER PROCEDURE [dbo].[ImportJSON]
(
	@JSONPath nvarchar(150)
)

AS

declare @sql nvarchar(4000) = 
'select  rows.name, anime.*,Row_number() OVER (Order BY ID) AS rownumber
INTO #anime
FROM OPENROWSET (BULK ''' + @JSONPath + ''', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
with
(
	TitleRows nvarchar(max) AS JSON
	
) 
CROSS APPLY OPENJSON(TitleRows)
WITH
(
Name nvarchar(50),
Titles nvarchar(max) as JSON
 
) as [Rows]
CROSS APPLY OPENJSON(Titles)
WITH ( Id int,  ShortSynopsis nvarchar(max), MediumSynopsis nvarchar(max), LongSynopsis nvarchar(max), KeyArtUrl nvarchar(max), 
MasterArtUrl nvarchar(max), Rating nvarchar(20), StarRating decimal(3,2), RunTime int, Episodes varchar(50), FirstPremiereDate datetime, ShowInfoTitle nvarchar(50),
EpisodeCount int, SeasonName nvarchar(20)) AS anime





declare @rownumber int = 1
declare @Type varchar(50) 
declare @ID int 

WHILE (@rownumber < (SELECT count(*) from #anime))
BEGIN

	SET @type = (SELECT name from #anime where @rownumber = rownumber)
	SET @ID = (SELECT ID from #anime where @rownumber = rownumber)

	IF NOT EXISTS
	(
		SELECT 1
		FROm Anime
		WHERE AnimeID = @ID
	)
	BEGIN
	INSERT INTO [dbo].[Anime](AnimeID, ShortSynopsis, MediumSynopsis, LongSynopsis, KeyArtUrl, masterArtUrl, Rating, StarRating, RunTime, FirstPremiereDate, ShowInfoTitle, EpisodeCount, SeasonName)
	SELECT ID, ShortSynopsis, MediumSynopsis, LongSynopsis, KeyArtUrl, masterArtUrl, Rating, StarRating, RunTime, FirstPremiereDate, ShowInfoTitle, EpisodeCount, SeasonName
	FROM #Anime
	WHERE @Rownumber = rownumber 

	END



	IF (@type = ''Most Popular'')
	BEGIN
		Update Anime
		Set IsPopular = 1
		WHERE @ID = AnimeID
	END
	ELSE IF (@type = ''HIDIVE  Exclusives'')
	BEGIN
		UPDATE Anime 
		SET IsExclusive = 1
		WHERE @ID = AnimeID
	END
	ELSE IF (@type = ''Dubs'')
	BEGIN
		UPDATE Anime 
		SET IsDub = 1
		WHERE @ID = AnimeID
	END
	ELSE IF (@type = ''Trending Now'')
	BEGIN
		UPDATE Anime 
		SET IsTrending = 1
		WHERE @ID = AnimeID
	END
	ELSE IF (@type = ''Simulcasts'')
	BEGIN
		UPDATE Anime 
		SET IsSimulcast = 1
		WHERE @ID = AnimeID
	END
	ELSE IF (@type = ''Recently Added'')
	BEGIN
		UPDATE Anime 
		SET IsRecentlyAdded = 1
		WHERE @ID = AnimeID
	END
	SET @rownumber = @rownumber + 1
END

DROP TABLE #anime'
Exec(@sql)

