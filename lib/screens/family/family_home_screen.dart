import 'package:flutter/material.dart';

import '../../app_shell.dart';
import '../../models/family_membership.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';
import 'invite_code_screen.dart';

class FamilyHomeScreen extends StatelessWidget {
  const FamilyHomeScreen({super.key, required this.membership});

  final FamilyMembership membership;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(membership.familyName),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => supabase.auth.signOut()),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Icon(Icons.groups_outlined, color: theme.colorScheme.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              membership.familyName,
                              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Your role: ${membership.role}',
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => InviteCodeScreen(familyId: membership.familyId)),
                ),
                child: const Text('Invite someone'),
              ),
              const SizedBox(height: AppSpacing.sm),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AppShell()),
                ),
                child: const Text('Continue to Irth'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
