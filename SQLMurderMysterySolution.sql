-- The SQL Murder Mystery Solution
-- https://mystery.knightlab.com/

-- Crime Report
SELECT cs.date, cs.type, cs.description, cs.city
FROM crime_scene_report cs
WHERE cs.date = 20180115 AND cs.type = 'murder' AND cs.city = 'SQL City'

---- Results
-- Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".


-- Witnesses

---- Witness 1
SELECT * FROM person p
WHERE p.address_street_name = 'Northwestern Dr'
ORDER BY p.address_number DESC

---- Witness 2
SELECT * FROM person p
WHERE p.address_street_name = 'Franklin Ave'
ORDER BY p.name ASC


-- Interviews
SELECT * FROM interview
WHERE person_id = 14887 OR person_id = 16371


-- Putting all the clues together
SELECT p.name FROM person p
JOIN get_fit_now_member gm ON p.id = gm.person_id
JOIN get_fit_now_check_in gc ON gm.id = gc.membership_id
JOIN drivers_license dl ON p.license_id = dl.id
WHERE gc.membership_id LIKE '48Z%' AND gm.membership_status = 'gold' AND dl.plate_number LIKE '%H42W%' 


-- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer 
-- to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. 


-- Suspect Interview
SELECT * FROM person p
JOIN interview i ON p.id = i.person_id
WHERE p.id = 67318

-- I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
-- She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.


-- Mastermind
SELECT * FROM person p
JOIN drivers_license dl ON p.license_id = dl.id
JOIN income i ON p.ssn = i.ssn
WHERE dl.hair_color = 'red' AND dl.car_make = 'Tesla' AND dl.height BETWEEN 65 AND 67
ORDER BY i.annual_income DESC

-- Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!