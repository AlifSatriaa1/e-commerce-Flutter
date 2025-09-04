import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSubmitting = false;
  bool _rememberMe = false;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  // simpler pressed state for button animation
  bool _isPressed = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email tidak boleh kosong';
    final email = v.trim();
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(email)) return 'Format email tidak valid';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
    if (v.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _autoValidate = AutovalidateMode.always);

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa input terlebih dahulu')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 600)); // simulate work
    setState(() => _isSubmitting = false);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, 'AccountPage');
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4C53A5);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenWidth > 600 ? 540 : double.infinity),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // header gradient + logo
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4C53A5), Color(0xFF6C5CE7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            const CircleAvatar(
                              radius: 34,
                              backgroundColor: Colors.white24,
                              child: FlutterLogo(size: 36),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Welcome Back!',
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Sign in to continue',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Form fields
                      Form(
                        key: _formKey,
                        autovalidateMode: _autoValidate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: _validateEmail,
                            ),
                            const SizedBox(height: 14),

                            // Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: _validatePassword,
                              onFieldSubmitted: (_) => _submit(),
                            ),

                            const SizedBox(height: 8),

                            // remember + forgot
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      activeColor: primary,
                                      onChanged: (v) => setState(() => _rememberMe = v ?? false),
                                    ),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(context, '/forgotPassword'),
                                  child: const Text('Forgot password?'),
                                )
                              ],
                            ),

                            const SizedBox(height: 12),

                            // --- Fixed login button: AnimatedScale + explicit white text color
                            GestureDetector(
                              onTapDown: (_) => setState(() => _isPressed = true),
                              onTapUp: (_) => setState(() => _isPressed = false),
                              onTapCancel: () => setState(() => _isPressed = false),
                              child: AnimatedScale(
                                scale: _isPressed ? 0.97 : 1.0,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeOut,
                                child: ElevatedButton(
                                  onPressed: _isSubmitting ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 3,
                                  ),
                                  child: _isSubmitting
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                        )
                                      : const Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Sign up link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account?'),
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(context, 'RegisterPage'),
                                  child: Text('Sign Up', style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
