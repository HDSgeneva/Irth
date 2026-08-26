import 'package:flutter/material.dart';

import '../../models/family_membership.dart';
import '../../services/family_repository.dart';
import '../../supabase/supabase_client.dart';
import 'family_home_screen.dart';
import 'family_onboarding_screen.dart';

class FamilyGate extends StatefulWidget {
  const FamilyGate({super.key});

  @override
  State<FamilyGate> createState() => _FamilyGateState();
}

class _FamilyGateState extends State<FamilyGate> {
  final _repository = FamilyRepository(supabase);
  late Future<FamilyMembership?> _membershipFuture;

  @override
  void initState() {
    super.initState();
    _membershipFuture = _repository.myFamily();
  }

  void _refresh() {
    setState(() => _membershipFuture = _repository.myFamily());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FamilyMembership?>(
      future: _membershipFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final membership = snapshot.data;
        if (membership == null) {
          return FamilyOnboardingScreen(onFamilyReady: _refresh);
        }
        return FamilyHomeScreen(membership: membership);
      },
    );
  }
}
