# RunWars MVP

Flutter + Supabase MVP for a GPS territory capture game.

## Implemented in this scaffold
- Splash, Login/Signup, Home(Map placeholder), Running, Leaderboard, Profile screens
- Riverpod state management for run tracking
- GPS stream service via Geolocator
- Polygon closure + area utility functions
- Supabase migration starter + capture-territory edge function template

## Run
1. Install Flutter 3.22+
2. `flutter pub get`
3. `flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`
