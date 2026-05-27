CREATE DATABASE ipl_analysis;

USE ipl_analysis;
show tables;

SELECT COUNT(*) AS total_matches
FROM matches;

SELECT COUNT(*) AS total_deliveries
FROM deliveries;

-- =====================================================
-- IPL DATA ANALYTICS PROJECT
-- SQL ANALYTICS QUERIES
-- =====================================================


-- =====================================================
-- TOP 10 RUN SCORERS
-- =====================================================

SELECT batter,
       SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;


-- =====================================================
--  TOP WICKET TAKERS
-- =====================================================

SELECT bowler,
       COUNT(*) AS wickets
FROM deliveries
WHERE is_wicket = 1
GROUP BY bowler
ORDER BY wickets DESC
LIMIT 10;


-- =====================================================
--  MOST SUCCESSFUL IPL TEAMS
-- =====================================================

SELECT winner,
       COUNT(*) AS total_wins
FROM matches
GROUP BY winner
ORDER BY total_wins DESC;


-- =====================================================
--  TOSS DECISION ANALYSIS
-- =====================================================

SELECT toss_decision,
       COUNT(*) AS total
FROM matches
GROUP BY toss_decision;


-- =====================================================
--  TOP VENUES BY MATCHES HOSTED
-- =====================================================

SELECT venue,
       COUNT(*) AS matches_hosted
FROM matches
GROUP BY venue
ORDER BY matches_hosted DESC
LIMIT 10;


-- =====================================================
--  PLAYER OF THE MATCH LEADERS
-- =====================================================

SELECT player_of_match,
       COUNT(*) AS awards
FROM matches
GROUP BY player_of_match
ORDER BY awards DESC
LIMIT 10;


-- =====================================================
--  HIGHEST TEAM SCORES
-- =====================================================

SELECT batting_team,
       match_id,
       SUM(total_runs) AS total_score
FROM deliveries
GROUP BY batting_team, match_id
ORDER BY total_score DESC
LIMIT 10;
-- =====================================================
--  TEAM WITH HIGHEST AVERAGE SCORE
-- =====================================================

SELECT batting_team,
       AVG(team_score) AS avg_score
FROM (
    SELECT batting_team,
           match_id,
           SUM(total_runs) AS team_score
    FROM deliveries
    GROUP BY batting_team, match_id
) AS scores
GROUP BY batting_team
ORDER BY avg_score DESC;
-- =====================================================
--  SEASON-WISE MATCH COUNT
-- =====================================================

SELECT season,
       COUNT(*) AS total_matches
FROM matches
GROUP BY season
ORDER BY season;
-- =====================================================
-- TOP BATSMEN WITH MOST SIXES
-- =====================================================

SELECT batter,
       COUNT(*) AS total_sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batter
ORDER BY total_sixes DESC
LIMIT 10;
-- =====================================================
-- TOP BATSMEN WITH MOST FOURS
-- =====================================================

SELECT batter,
       COUNT(*) AS total_fours
FROM deliveries
WHERE batsman_runs = 4
GROUP BY batter
ORDER BY total_fours DESC
LIMIT 10;
-- =====================================================
--  TEAM WIN PERCENTAGE
-- =====================================================

SELECT winner,
       COUNT(*) * 100.0 /
       (SELECT COUNT(*) FROM matches) AS win_percentage
FROM matches
GROUP BY winner
ORDER BY win_percentage DESC;
-- =====================================================
--  MATCHES WON AFTER WINNING TOSS
-- =====================================================

SELECT COUNT(*) AS toss_and_match_wins
FROM matches
WHERE toss_winner = winner;
-- =====================================================
--  VENUE WITH HIGHEST AVERAGE SCORE
-- =====================================================

SELECT m.venue,
       AVG(d.total_runs) AS avg_runs
FROM deliveries d
JOIN matches m
ON d.match_id = m.id
GROUP BY m.venue
ORDER BY avg_runs DESC
LIMIT 10;