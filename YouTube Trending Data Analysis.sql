

--no of category 
SELECT  count (DISTINCT(category)) FROM "public"."youtube";

-- which r the categories
SELECT DISTINCT(category) FROM "public"."youtube";

-- country
SELECT DISTINCT(publish_country) FROM "public"."youtube";

--popular category based on country

SELECT publish_country,category,sum("views"),rank() OVER (PARTITION BY publish_country ORDER BY sum("views") DESC)AS ranks FROM "public"."youtube" GROUP BY publish_country,category ;

--channel with highest vdoes
SELECT channel_title,count(title)AS no_of_vdoes FROM "public"."youtube" GROUP BY channel_title ORDER BY no_of_vdoes DESC 
;

--no of vdo tht has been uploded by channel and anlysis of the category 
SELECT channel_title,category,count(title)AS no_of_video FROM "public"."youtube" GROUP BY channel_title,category ORDER BY  no_of_video DESC;

--how frquently the vdoes are uploaded by the channels

SELECT channel_title,count(title) AS uploded_video ,EXTRACT(MONTH FROM publish_date)AS months FROM "public"."youtube" GROUP BY channel_title,months ORDER BY channel_title ASC,months ASC;

--channel with highest vdo  on LAST YR
SELECT channel_title,count(title)AS no_of_vdoes, EXTRACT(YEAR FROM publish_date)AS LAST_YR FROM "public"."youtube" GROUP BY channel_title,LAST_YR ORDER BY no_of_vdoes DESC ;


--top 5 chnnel with highest trending vdos
SELECT 
  channel_title,
  COUNT(DISTINCT video_id) AS count_of_trending_videos
FROM "public"."youtube"
GROUP BY channel_title
ORDER BY count_of_trending_videos DESC
LIMIT 10;


--channel with highest views
SELECT channel_title,sum("views")AS total_views FROM "public"."youtube" GROUP BY channel_title ORDER BY total_views DESC;

--avg view of each channel
SELECT channel_title, round(avg("views"),2) FROM "public"."youtube" GROUP BY channel_title ;


--channel with highest likes
SELECT channel_title,sum("likes")AS total_like FROM "public"."youtube" GROUP BY channel_title ORDER BY total_like DESC;

--channel with highest dislikes
SELECT channel_title,sum("dislikes")AS total_dislike FROM "public"."youtube" GROUP BY channel_title ORDER BY total_dislike DESC;

--channel with highest comment
SELECT channel_title,sum("comment_count")AS total_comment FROM "public"."youtube" GROUP BY channel_title ORDER BY total_comment DESC;


--count of vdo removed
SELECT count(video_removed) FROM "public"."youtube" WHERE video_removed=TRUE  ;

--how many vdo has been dlt from each channel
SELECT channel_title, COUNT(video_removed) AS number_of_deleted_videos FROM "public"."youtube" WHERE video_removed = TRUE GROUP BY channel_title
ORDER BY COUNT(video_removed);

--Category Performance by Country:
SELECT publish_country,category,AVG(VIEWS) AS avg_views,AVG(likes) AS avg_likes,AVG(dislikes) AS avg_dislikes,AVG(comment_count) AS avg_comments
FROM "public"."youtube" GROUP BY publish_country, category ORDER BY publish_country, category DESC;
--peak Upload Month

SELECT
    EXTRACT(MONTH FROM publish_date) AS upload_month,
    COUNT(*) AS number_of_uploads
FROM "public"."youtube"
GROUP BY upload_month
ORDER BY number_of_uploads DESC;


--To rank by popularity
SELECT channel_title,COUNT(*) FILTER (WHERE EXTRACT(YEAR FROM publish_date) = 2017) AS videos_2017,COUNT(*) FILTER (WHERE EXTRACT(YEAR FROM publish_date) = 2018) AS videos_2018,COUNT(*) FILTER (WHERE EXTRACT(YEAR FROM publish_date) IN (2017, 2018)) AS total_videos
FROM "public"."youtube" WHERE EXTRACT(YEAR FROM publish_date) IN (2017, 2018) GROUP BY  channel_title
ORDER BY total_videos DESC
LIMIT 10;






