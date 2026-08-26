import 'package:flutter/material.dart';

import '../../services/family_repository.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';
import 'invite_code_screen.dart';

class CreateFamilyScreen extends StatefulWidget {
  const CreateFamilyScreen({super.key, required this.onCreated});

  final VoidCallback onCreated;

  @override
  State<CreateFamilyScreen> createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends State<CreateFamilyScreen> {
  final _repository = FamilyRepository(supabase);
  final _nameController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final family = await _repository.createFamily(name);
      if (!mounted) return;

      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => InviteCodeScreen(familyId: family.id)),
      );
      if (!mounted) return;

      Navigator.of(context).popUntil((route) => route.isFirst);
      widget.onCreated();
    } catch (e) {
      setState(() => _error = 'Could not create the family. Try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Create a family')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Family name', border: OutlineInputBorder()),
                textCapitalization: TextCapitalization.words,
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(_error!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
              ],
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _loading ? null : _create,
                child: _loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
