import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StoryRepository {
  StoryRepository(this._client);

  final SupabaseClient _client;

  static const _bucket = 'recordings';
  static const _signedUrlValiditySeconds = 60 * 60 * 24 * 365 * 10; // 10 years

  Future<void> saveRecording({
    required String familyId,
    required String userId,
    required File audioFile,
  }) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.m4a';
    final storagePath = '$familyId/$fileName';

    await _client.storage.from(_bucket).upload(storagePath, audioFile);

    final audioUrl = await _client.storage
        .from(_bucket)
        .createSignedUrl(storagePath, _signedUrlValiditySeconds);

    await _client.from('stories').insert({
      'family_id': familyId,
      'user_id': userId,
      'audio_url': audioUrl,
    });
  }
}
