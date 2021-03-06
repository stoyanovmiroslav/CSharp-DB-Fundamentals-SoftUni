CREATE FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATETIME2, @People INT) RETURNS VARCHAR(MAX)
AS BEGIN

   DECLARE @BookedRooms TABLE(Id INT)
                       INSERT INTO @BookedRooms
                   SELECT DISTINCT R.Id
                              FROM Rooms R
                         LEFT JOIN Trips T on R.Id = T.RoomId
                             WHERE R.HotelId = @HotelId AND @Date BETWEEN T.ArrivalDate AND T.ReturnDate AND T.CancelDate IS NULL

   DECLARE @AvailableRoom NVARCHAR(MAX) = 
                     (SELECT TOP(1) CONCAT('Room ', r.Id, ': ', r.Type,' (', r.Beds, ' beds) - $',
					                     (h.BaseRate + r.Price) * @People)
                              FROM Hotels AS h
                              JOIN Rooms AS r
                                ON r.HotelId = h.Id
                              JOIN Trips AS t
                                ON t.RoomId = r.Id
                             WHERE r.Id NOT IN(SELECT Id FROM @BookedRooms)
                               AND h.Id = @HotelId AND r.Beds >= @People
                          ORDER BY r.Price DESC)

		IF(@AvailableRoom IS NULL)
		BEGIN
		   RETURN 'No rooms available' 
		END 
		
	    RETURN @AvailableRoom	
END
GO

SELECT dbo.udf_GetAvailableRoom(112, '2011-12-17', 2)
--Room 211: First Class (5 beds) - $202.80

SELECT dbo.udf_GetAvailableRoom(94, '2015-07-26', 3)
--No rooms available