import 'package:supabase_flutter/supabase_flutter.dart';

class TerritoryApi {
  final SupabaseClient client;
  TerritoryApi(this.client);

  Future<Map<String, dynamic>> captureTerritory({
    required String runSessionId,
    required Map<String, dynamic> polygonGeoJson,
  }) async {
    final response = await client.functions.invoke(
      'capture-territory',
      body: {
        'runSessionId': runSessionId,
        'polygonGeoJson': polygonGeoJson,
      },
    );
    if (response.status != 200) {
      throw Exception('Capture failed: ${response.data}');
    }
    return Map<String, dynamic>.from(response.data as Map);
  }
}
