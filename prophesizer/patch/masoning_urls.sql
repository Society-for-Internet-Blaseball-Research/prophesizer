--Fix redirect url_slugs for non-NaN players affected by the Wyatt Masoning
UPDATE DATA.players p
SET url_slug = 
(
	SELECT url_slug
	FROM taxa.player_url_slugs x
	WHERE p.player_id = x.player_id
	AND p.player_name = x.player_name
)
WHERE p.player_name = 'Wyatt Mason'
AND player_id <> '1f159bab-923a-4811-b6fa-02bfde50925a';