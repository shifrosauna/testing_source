DROP VIEW IF EXISTS activations;
CREATE OR REPLACE VIEW activations AS 
    SELECT
        substring(MIN(aff_sub4) from 0 for 11)::date AS date_install,
        aff_sub1 AS visitor_guid,
        offer_id,
        aff_id,
        aff_sub2 AS mediator,
        country,
        min(payout) AS payout,
        min(currency) AS currency
    FROM conversions
    WHERE goal_id > 0 AND payout > 0::double precision AND status = 'approved'::text
    GROUP BY aff_sub1, aff_sub2, aff_id, offer_id, country
    HAVING MIN(aff_sub4) ~ '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'
    ORDER BY aff_sub1;