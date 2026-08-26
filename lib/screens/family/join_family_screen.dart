import 'package:flutter/material.dart';

import '../../services/family_repository.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({super.key, required this.onJoined});

  final VoidCallback onJoined;

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends State<JoinFamilyScreen> {
  final _repository = FamilyRepository(supabase);
  final _codeController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await _repository.joinWithCode(code);
      if (!mounted) return;

      Navigator.of(context).popUntil((route) => route.isFirst);
      widget.onJoined();
    } catch (e) {
      setState(() => _error = "That code didn't work. Check it and try again.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Join a family')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Invite code', border: OutlineInputBorder()),
                textCapitalization: TextCapitalization.characters,
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(_error!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
              ],
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _loading ? null : _join,
                child: _loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Join'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
