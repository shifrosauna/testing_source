--Rename colomns in offers_goals table
ALTER TABLE offers_goals RENAME COLUMN cpa TO payout;
ALTER TABLE offers_goals RENAME COLUMN rpa TO revenue;
ALTER TABLE offers_goals RENAME COLUMN cpa_currency TO payout_currency;
ALTER TABLE offers_goals RENAME COLUMN rpa_currency TO revenue_currency;
