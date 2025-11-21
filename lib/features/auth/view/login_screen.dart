import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:magicslide/features/auth/view/signup_screen.dart';
import 'package:magicslide/features/home/home_screen.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Welcome Back',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Consumer<LoginViewModel>(
                builder: (context, vm, _) {
                  return Column(
                    children: [
                      // Logo + Title
                      Text(
                        'Magic',
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                          shadows: const [
                            Shadow(color: Colors.cyanAccent, blurRadius: 20),
                          ],
                        ),
                      ),
                      const Text(
                        'Slides',
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.black54),
                      ),
                      const SizedBox(height: 50),

                      // Glass Card
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.78),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.black.withOpacity(0.08)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 40, offset: const Offset(0, 20)),
                            BoxShadow(color: Colors.white.withOpacity(0.9), blurRadius: 20, offset: const Offset(-10, -10)),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: const TextStyle(color: Colors.black38),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.75),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: Colors.black12)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Colors.black87, width: 1.5)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.black38),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.75),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: Colors.black12)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Colors.black87, width: 1.5)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              ),
                            ),

                            if (vm.error != null) ...[
                              const SizedBox(height: 16),
                              Text(vm.error!, style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
                            ],

                            const SizedBox(height: 28),
                            SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: ElevatedButton(
                                onPressed: vm.loading ? null : () async {
                                  final success = await vm.login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  if (success && context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  elevation: 18,
                                  shadowColor: Colors.black45,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: vm.loading
                                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                                    : const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                            ),

                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())),
                              child: const Text(
                                'Don\'t have an account? Sign up',
                                style: TextStyle(color: Colors.black54, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}