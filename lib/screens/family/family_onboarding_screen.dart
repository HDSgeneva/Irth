import 'package:flutter/material.dart';

import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';
import 'create_family_screen.dart';
import 'join_family_screen.dart';

class FamilyOnboardingScreen extends StatelessWidget {
  const FamilyOnboardingScreen({super.key, required this.onFamilyReady});

  final VoidCallback onFamilyReady;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => supabase.auth.signOut()),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Join your family', style: theme.textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Start a new family on Irth or join one with an invite code.',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CreateFamilyScreen(onCreated: onFamilyReady)),
                ),
                child: const Text('Create a family'),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => JoinFamilyScreen(onJoined: onFamilyReady)),
                ),
                child: const Text('Join with a code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
