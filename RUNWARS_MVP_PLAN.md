# RunWars MVP — Production-Ready Blueprint

## 1) Complete Project Folder Structure

```text
runwars/
├─ README.md
├─ .env.example
├─ analysis_options.yaml
├─ pubspec.yaml
├─ assets/
│  ├─ fonts/
│  │  ├─ Orbitron-Regular.ttf
│  │  └─ Inter-Regular.ttf
│  ├─ images/
│  │  ├─ logo.png
│  │  ├─ splash_bg.png
│  │  └─ avatar_placeholder.png
│  └─ map_styles/
│     └─ dark_gaming_style.json
├─ lib/
│  ├─ main.dart
│  ├─ app/
│  │  ├─ app.dart
│  │  ├─ router.dart
│  │  ├─ theme/
│  │  │  ├─ app_theme.dart
│  │  │  ├─ colors.dart
│  │  │  └─ text_styles.dart
│  │  └─ di/
│  │     └─ providers.dart
│  ├─ core/
│  │  ├─ constants/
│  │  │  ├─ api_constants.dart
│  │  │  └─ game_constants.dart
│  │  ├─ errors/
│  │  │  ├─ failures.dart
│  │  │  └─ exceptions.dart
│  │  ├─ network/
│  │  │  ├─ connectivity_service.dart
│  │  │  └─ supabase_client_provider.dart
│  │  ├─ services/
│  │  │  ├─ location_service.dart
│  │  │  ├─ mapbox_service.dart
│  │  │  └─ geometry_service.dart
│  │  ├─ utils/
│  │  │  ├─ result.dart
│  │  │  ├─ logger.dart
│  │  │  └─ extensions.dart
│  │  └─ widgets/
│  │     ├─ glass_card.dart
│  │     ├─ neon_button.dart
│  │     └─ loading_overlay.dart
│  ├─ features/
│  │  ├─ auth/
│  │  │  ├─ data/
│  │  │  │  ├─ datasources/auth_remote_datasource.dart
│  │  │  │  ├─ models/user_model.dart
│  │  │  │  └─ repositories/auth_repository_impl.dart
│  │  │  ├─ domain/
│  │  │  │  ├─ entities/user_entity.dart
│  │  │  │  ├─ repositories/auth_repository.dart
│  │  │  │  └─ usecases/
│  │  │  │     ├─ sign_in.dart
│  │  │  │     ├─ sign_up.dart
│  │  │  │     └─ sign_out.dart
│  │  │  └─ presentation/
│  │  │     ├─ providers/auth_provider.dart
│  │  │     ├─ screens/splash_screen.dart
│  │  │     └─ screens/login_signup_screen.dart
│  │  ├─ run_tracking/
│  │  │  ├─ data/
│  │  │  │  ├─ datasources/run_remote_datasource.dart
│  │  │  │  ├─ models/run_session_model.dart
│  │  │  │  └─ repositories/run_repository_impl.dart
│  │  │  ├─ domain/
│  │  │  │  ├─ entities/gps_point_entity.dart
│  │  │  │  ├─ entities/run_session_entity.dart
│  │  │  │  ├─ repositories/run_repository.dart
│  │  │  │  └─ usecases/
│  │  │  │     ├─ start_run.dart
│  │  │  │     ├─ stream_gps.dart
│  │  │  │     └─ finish_run.dart
│  │  │  └─ presentation/
│  │  │     ├─ providers/run_provider.dart
│  │  │     └─ screens/running_screen.dart
│  │  ├─ territory/
│  │  │  ├─ data/
│  │  │  │  ├─ datasources/territory_remote_datasource.dart
│  │  │  │  ├─ models/territory_model.dart
│  │  │  │  └─ repositories/territory_repository_impl.dart
│  │  │  ├─ domain/
│  │  │  │  ├─ entities/territory_entity.dart
│  │  │  │  ├─ entities/polygon_entity.dart
│  │  │  │  ├─ repositories/territory_repository.dart
│  │  │  │  └─ usecases/
│  │  │  │     ├─ detect_closed_polygon.dart
│  │  │  │     ├─ calculate_area.dart
│  │  │  │     ├─ capture_territory.dart
│  │  │  │     └─ resolve_overlaps.dart
│  │  │  └─ presentation/
│  │  │     ├─ providers/territory_provider.dart
│  │  │     └─ widgets/territory_layers.dart
│  │  ├─ leaderboard/
│  │  │  ├─ data/datasources/leaderboard_remote_datasource.dart
│  │  │  ├─ domain/usecases/get_leaderboard.dart
│  │  │  └─ presentation/
│  │  │     ├─ providers/leaderboard_provider.dart
│  │  │     └─ screens/leaderboard_screen.dart
│  │  └─ profile/
│  │     ├─ data/datasources/profile_remote_datasource.dart
│  │     ├─ domain/usecases/get_profile.dart
│  │     └─ presentation/
│  │        ├─ providers/profile_provider.dart
│  │        └─ screens/profile_screen.dart
│  └─ shared/
│     ├─ models/paginated_response.dart
│     └─ widgets/app_scaffold.dart
├─ supabase/
│  ├─ migrations/
│  │  ├─ 001_extensions.sql
│  │  ├─ 002_profiles.sql
│  │  ├─ 003_run_sessions.sql
│  │  ├─ 004_territories.sql
│  │  ├─ 005_leaderboard_views.sql
│  │  └─ 006_rls_policies.sql
│  └─ functions/
│     ├─ capture-territory/index.ts
│     └─ update-leaderboard/index.ts
└─ test/
   ├─ unit/
   │  ├─ geometry_service_test.dart
   │  └─ territory_overlap_test.dart
   └─ widget/
      └─ running_screen_test.dart
```

## 2) Database Schema for Supabase

Use PostgreSQL + PostGIS.

```sql
-- 001_extensions.sql
create extension if not exists postgis;
create extension if not exists pgcrypto;

-- 002_profiles.sql
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  avatar_url text,
  color_hex text not null default '#00E5FF',
  total_area_m2 double precision not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 003_run_sessions.sql
create table public.run_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  started_at timestamptz not null default now(),
  ended_at timestamptz,
  distance_m double precision not null default 0,
  points_count int not null default 0,
  created_at timestamptz not null default now()
);

create table public.run_points (
  id bigserial primary key,
  run_session_id uuid not null references public.run_sessions(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  seq int not null,
  geom geography(point, 4326) not null,
  recorded_at timestamptz not null default now()
);
create index run_points_run_session_seq_idx on public.run_points(run_session_id, seq);
create index run_points_geom_idx on public.run_points using gist (geom);

-- 004_territories.sql
create table public.territories (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  source_run_session_id uuid references public.run_sessions(id) on delete set null,
  geom geography(polygon, 4326) not null,
  area_m2 double precision not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index territories_geom_idx on public.territories using gist (geom);
create index territories_owner_idx on public.territories(owner_id);

create table public.territory_events (
  id uuid primary key default gen_random_uuid(),
  attacker_id uuid not null references public.profiles(id) on delete cascade,
  defender_id uuid references public.profiles(id) on delete set null,
  captured_area_m2 double precision not null,
  new_territory_id uuid references public.territories(id) on delete set null,
  event_type text not null check (event_type in ('capture','split','merge')),
  created_at timestamptz not null default now()
);

-- 005_leaderboard_views.sql
create materialized view public.leaderboard_total_area as
select p.id as user_id, p.username, p.avatar_url, p.color_hex,
       coalesce(sum(t.area_m2), 0) as total_area_m2
from public.profiles p
left join public.territories t on t.owner_id = p.id and t.is_active = true
group by p.id;

create unique index leaderboard_total_area_user_idx on public.leaderboard_total_area(user_id);

-- 006_rls_policies.sql
alter table public.profiles enable row level security;
alter table public.run_sessions enable row level security;
alter table public.run_points enable row level security;
alter table public.territories enable row level security;
alter table public.territory_events enable row level security;

create policy "profiles readable by all" on public.profiles for select using (true);
create policy "profiles owned update" on public.profiles for update using (auth.uid() = id);

create policy "run sessions owned" on public.run_sessions for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "run points owned" on public.run_points for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "territories readable by all" on public.territories for select using (true);
create policy "territories inserted by owner" on public.territories for insert with check (auth.uid() = owner_id);
create policy "events readable by all" on public.territory_events for select using (true);
```

## 3) Flutter Package List

- **State management**: `flutter_riverpod`, `riverpod_annotation`
- **Navigation**: `go_router`
- **Supabase**: `supabase_flutter`
- **Map**: `mapbox_maps_flutter`
- **Location**: `geolocator`, `permission_handler`
- **Geometry**: `turf`, `latlong2`
- **Serialization**: `freezed`, `freezed_annotation`, `json_serializable`, `json_annotation`
- **Storage/cache**: `hive`, `hive_flutter`, `path_provider`
- **Utilities**: `equatable`, `intl`, `logger`, `uuid`, `collection`
- **UI**: `flutter_animate`, `google_fonts`, `flutter_svg`
- **Dev**: `build_runner`, `riverpod_generator`, `very_good_analysis`

## 4) Full Architecture

**Pattern**: Clean Architecture + Feature-first modules.

- **Presentation layer**
  - Riverpod providers/notifiers own UI state.
  - Screens render map, run state, and territory overlays.
- **Domain layer**
  - Use cases: `StartRun`, `StreamGps`, `DetectClosedPolygon`, `CaptureTerritory`, `ResolveOverlaps`.
  - Pure entities for deterministic tests.
- **Data layer**
  - Repositories coordinate Supabase, Mapbox, and local cache.
  - Remote datasources call SQL RPC or Edge Functions for heavy geometry.
- **Backend responsibilities**
  - PostGIS computes polygon intersections/differences.
  - Edge Function wraps capture transaction (atomic update).

## 5) Step-by-Step Implementation Plan

1. Bootstrap Flutter app with dark theme, routing, environment config.
2. Integrate Supabase auth (email/password for MVP).
3. Add profile bootstrap on first login.
4. Integrate Mapbox map on Home screen.
5. Implement GPS stream service with permission handling.
6. Build Running screen with start/stop state machine.
7. Draw live polyline as points arrive.
8. Implement closure detection (distance to start threshold + min points).
9. Build polygon, compute area, validate minimal area.
10. Send polygon to `capture-territory` Edge Function.
11. In backend transaction: compute overlap, split existing territories, insert attacker territory.
12. Broadcast updates via Supabase Realtime channels.
13. Subscribe in app and refresh territory layers incrementally.
14. Implement leaderboard query (materialized view + refresh cadence).
15. Build profile screen with total area + recent captures.
16. Add unit tests for geometry and overlap resolution.
17. Harden for production: retry strategy, background-safe tracking, abuse limits.

## 6) UI Wireframe Descriptions

1. **Splash**: centered glowing RunWars logo, animated pulse, then auth redirect.
2. **Login/Signup**: split card UI, email/password fields, neon CTA, subtle background grid.
3. **Home (Map)**:
   - Fullscreen dark map.
   - Floating `Start Run` button.
   - Top chip: total owned area.
   - Bottom nav: Home / Leaderboard / Profile.
4. **Running**:
   - Map remains primary.
   - HUD card: elapsed time, distance, pace, live area candidate.
   - Action buttons: Pause (optional MVP skip), Stop & Capture.
5. **Leaderboard**:
   - Ranked list with avatar, username, total area.
   - Current user highlighted.
6. **Profile**:
   - Avatar + username + user color swatch.
   - Stats cards (total area, sessions count).
   - Recent capture events list.

## 7) Data Flow Explanation

1. User taps **Start Run**.
2. `RunProvider` calls `StartRun` use case -> creates `run_session` row.
3. GPS stream emits points every N meters / seconds.
4. Points update polyline locally and batch-write to `run_points`.
5. `DetectClosedPolygon` checks if path loops.
6. On closure, create GeoJSON polygon, compute approximate client area.
7. Send capture request to Edge Function (authoritative server geometry).
8. Function updates `territories` and `territory_events` atomically.
9. Realtime broadcasts changed territory rows.
10. `TerritoryProvider` patches map layers and updates UI stats.

## 8) Core Algorithms

- **Closure detection**
  - Need min points (e.g., >= 10).
  - Compute haversine distance from latest point to first point.
  - Closed when `distance <= closureThresholdMeters` and perimeter >= min distance.
- **Area calculation**
  - Use Turf area on GeoJSON polygon (client estimate).
  - Server recomputes with PostGIS `ST_Area(geom::geography)`.
- **Overlap resolution** (server-side)
  - `attackerPolygon = ST_GeogFromText(...)`
  - Find intersecting active territories.
  - For each defender territory:
    - `remaining = ST_Difference(defender.geom, attackerPolygon)`
    - Replace old row with remaining multipolygon parts.
  - Insert attacker territory polygon.
  - Recompute totals and refresh leaderboard view.

## 9) Example Code for GPS Tracking

```dart
class LocationService {
  final GeolocatorPlatform _geo = GeolocatorPlatform.instance;

  Stream<Position> track() async* {
    final enabled = await _geo.isLocationServiceEnabled();
    if (!enabled) throw Exception('Location service disabled');

    var permission = await _geo.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geo.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }

    const settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5, // meters
    );

    yield* _geo.getPositionStream(locationSettings: settings);
  }
}
```

## 10) Example Code for Polygon Detection

```dart
bool isClosedPolygon(List<LatLng> points, {double thresholdMeters = 20}) {
  if (points.length < 10) return false;

  final start = points.first;
  final end = points.last;

  final d = const Distance().as(
    LengthUnit.Meter,
    start,
    end,
  );

  return d <= thresholdMeters;
}

Map<String, dynamic> toGeoJsonPolygon(List<LatLng> points) {
  final ring = points.map((p) => [p.longitude, p.latitude]).toList();
  if (ring.first[0] != ring.last[0] || ring.first[1] != ring.last[1]) {
    ring.add([ring.first[0], ring.first[1]]);
  }

  return {
    'type': 'Polygon',
    'coordinates': [ring],
  };
}
```

## 11) Example Code for Territory Capture

```ts
// supabase/functions/capture-territory/index.ts (simplified)
import { serve } from "https://deno.land/std/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  const { runSessionId, polygonWkt } = await req.json();
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  );

  const { data, error } = await supabase.rpc("capture_territory_tx", {
    p_run_session_id: runSessionId,
    p_polygon_wkt: polygonWkt,
  });

  if (error) return new Response(JSON.stringify({ error: error.message }), { status: 400 });
  return new Response(JSON.stringify(data), { status: 200 });
});
```

## 12) Example API Structure

MVP can use Supabase Edge Functions + PostgREST.

- `POST /functions/v1/capture-territory`
  - Input: `runSessionId`, `polygonGeoJson`
  - Output: `newTerritoryId`, `capturedAreaM2`, `overlapSummary`
- `GET /rest/v1/territories?select=*`
  - Live map territory fetch
- `GET /rest/v1/leaderboard_total_area?select=*`
  - Leaderboard
- `POST /auth/v1/signup` / `token`
  - Auth

## 13) Difficult Parts and Solutions

1. **Noisy GPS creates invalid polygons**
   - Apply smoothing (Douglas-Peucker lite) and discard jumps > 40m within 1s.
2. **Self-intersecting paths**
   - Validate with Turf `kinks`; reject or auto-fix using server `ST_MakeValid`.
3. **Fair overlap rules**
   - Keep server authoritative and transactional in SQL function.
4. **Realtime scale**
   - Partition territory subscriptions by viewport or geohash buckets.
5. **Battery drain**
   - `distanceFilter` + adaptive sampling based on speed.
6. **Cheating/spoofing**
   - Detect impossible speed spikes and mark suspicious captures for exclusion.
7. **Race conditions (simultaneous captures)**
   - Serializable transaction in Postgres + row-level locks on overlapping territories.
8. **Leaderboard freshness**
   - Refresh materialized view every 30–60 seconds or on capture commit.

---

This scope is intentionally MVP-focused: only the minimum features needed to validate gameplay, retention, and fairness while keeping architecture production-safe.
