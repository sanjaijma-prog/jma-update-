-- ONE-TIME FIX: old check_in / check_out times were saved in UTC (Render server time).
-- This adds 5 hours 30 minutes so they become India time (IST).
-- RUN ONLY ONCE, in the Supabase SQL Editor, AFTER deploying the new server.js.
-- Only rows saved before the fix should be updated: change the cutoff below to the
-- date/time you deploy the new server.js (UTC).

update public.attendance
set check_in  = case when check_in  ~ '^\d{2}:\d{2}$' then to_char((check_in::time  + interval '5 hours 30 minutes'), 'HH24:MI') else check_in  end,
    check_out = case when check_out ~ '^\d{2}:\d{2}$' then to_char((check_out::time + interval '5 hours 30 minutes'), 'HH24:MI') else check_out end
where updated_at < '2026-11-10 06:30:00+00';  -- <== CHANGE to your deploy time
