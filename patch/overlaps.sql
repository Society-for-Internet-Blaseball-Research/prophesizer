/* Correct three players that have Chronicler overlaps for their team movement */

/* Francisca Sasquatch */
update data.team_roster set valid_until='2020-09-08 09:46:53.883' where player_id='8903a74f-f322-41d2-bd75-dbf7563c4abb' and valid_from='2020-07-29 08:12:22.438' and valid_until='2020-09-08 09:47:13.884';
/* Lori Boston */
update data.team_roster set valid_until='2020-10-11 19:25:00.339452' where player_id='019ce117-2399-4382-8036-8c14db7e1d30' and valid_from='2020-09-27 19:00:06.043756' and valid_until='2020-10-11 19:25:20.338318';
/* Ortiz Morse */
update data.team_roster set valid_until='2020-10-11 19:25:00.339452' where player_id='d8742d68-8fce-4d52-9a49-f4e33bd2a6fc' and valid_from='2020-10-07 20:16:43.364552' and valid_until='2020-10-11 19:25:20.338318';