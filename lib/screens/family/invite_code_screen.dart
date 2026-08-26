import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/family_repository.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';

class InviteCodeScreen extends StatefulWidget {
  const InviteCodeScreen({super.key, required this.familyId});

  final String familyId;

  @override
  State<InviteCodeScreen> createState() => _InviteCodeScreenState();
}

class _InviteCodeScreenState extends State<InviteCodeScreen> {
  final _repository = FamilyRepository(supabase);
  late Future<String> _codeFuture;

  @override
  void initState() {
    super.initState();
    _codeFuture = _repository.createInvite(widget.familyId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Invite someone')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FutureBuilder<String>(
            future: _codeFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Could not create an invite. Try again.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }

              final code = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Share this code. Anyone who enters it joins your family.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Card(
                    color: theme.colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        code,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          letterSpacing: 4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Code copied')),
                      );
                    },
                    child: const Text('Copy code'),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Done'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
