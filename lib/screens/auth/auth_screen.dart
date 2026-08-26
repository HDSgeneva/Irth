import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';

enum _AuthMode { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  _AuthMode _mode = _AuthMode.signIn;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _message;
  bool _messageIsError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;

    setState(() {
      _loading = true;
      _message = null;
    });

    try {
      if (_mode == _AuthMode.signUp) {
        final response = await supabase.auth.signUp(email: email, password: password);
        if (response.session == null && mounted) {
          setState(() {
            _mode = _AuthMode.signIn;
            _message = 'Check your email to confirm your account, then log in.';
            _messageIsError = false;
          });
        }
      } else {
        await supabase.auth.signInWithPassword(email: email, password: password);
      }
    } on AuthException catch (e) {
      setState(() {
        _message = e.message;
        _messageIsError = true;
      });
    } catch (e) {
      setState(() {
        _message = 'Something went wrong. Try again.';
        _messageIsError = true;
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSignUp = _mode == _AuthMode.signUp;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('إرث', style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  isSignUp ? 'Create your account' : 'Welcome back',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                ),
                if (_message != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _message!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _messageIsError ? theme.colorScheme.error : context.appColors.success,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(isSignUp ? 'Sign up' : 'Log in'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: _loading
                      ? null
                      : () => setState(() {
                          _mode = isSignUp ? _AuthMode.signIn : _AuthMode.signUp;
                          _message = null;
                        }),
                  child: Text(isSignUp ? 'Already have an account? Log in' : "New here? Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
