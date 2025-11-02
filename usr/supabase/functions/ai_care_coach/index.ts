import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_ANON_KEY') ?? ''
  )

  const { query } = await req.json()

  // Simulate AI response (integrate OpenAI API here)
  const response = `For your plant query: "${query}", I recommend checking the soil moisture and ensuring it gets sunlight. Keep growing! 🌿`

  return new Response(JSON.stringify({ response }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  })
})