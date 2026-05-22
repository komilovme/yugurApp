import { serve } from "https://deno.land/std/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  const { runSessionId, polygonWkt } = await req.json();

  const { data, error } = await supabase.rpc("capture_territory_tx", {
    p_run_session_id: runSessionId,
    p_polygon_wkt: polygonWkt,
  });

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 400 });
  }
  return new Response(JSON.stringify(data), { status: 200 });
});
