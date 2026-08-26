import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/family.dart';
import '../models/family_membership.dart';

class FamilyRepository {
  FamilyRepository(this._client);

  final SupabaseClient _client;

  User? get currentUser => _client.auth.currentUser;

  Future<void> signUp({required String email, required String password}) {
    return _client.auth.signUp(email: email, password: password);
  }

  Future<void> signIn({required String email, required String password}) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() => _client.auth.signOut();

  Future<FamilyMembership?> myFamily() async {
    final userId = currentUser?.id;
    if (userId == null) return null;

    final rows = await _client
        .from('family_members')
        .select('role, families(id, name)')
        .eq('user_id', userId)
        .limit(1);

    if (rows.isEmpty) return null;

    final row = rows.first;
    final family = row['families'] as Map<String, dynamic>;
    return FamilyMembership(
      familyId: family['id'] as String,
      familyName: family['name'] as String,
      role: row['role'] as String,
    );
  }

  Future<Family> createFamily(String name) async {
    final userId = currentUser!.id;

    final familyRow = await _client
        .from('families')
        .insert({'name': name, 'created_by': userId})
        .select()
        .single();
    final family = Family.fromMap(familyRow);

    await _client.from('family_members').insert({
      'family_id': family.id,
      'user_id': userId,
      'role': 'founder',
    });

    return family;
  }

  Future<String> createInvite(String familyId) async {
    final code = _generateCode();

    await _client.from('invites').insert({
      'family_id': familyId,
      'code': code,
      'created_by': currentUser!.id,
    });

    return code;
  }

  Future<Family> joinWithCode(String code) async {
    final rows = await _client.rpc(
      'accept_invite',
      params: {'invite_code': code.trim().toUpperCase()},
    ) as List;

    if (rows.isEmpty) throw Exception('Invalid invite code');
    return Family.fromMap(rows.first as Map<String, dynamic>);
  }

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random.secure();
    return List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
  }
}
