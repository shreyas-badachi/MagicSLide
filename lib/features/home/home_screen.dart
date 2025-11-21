// lib/features/home/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:magicslide/core/services/magicslides_service.dart';
import 'package:magicslide/features/generate/view/generate_result_screen.dart';
import 'package:magicslide/core/services/supabase_service.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Frosted glass input
  InputDecoration _glassInput(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
      filled: true,
      fillColor: Colors.white.withOpacity(0.75),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.black87, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'MagicSlides',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: 24,
              letterSpacing: 1.2,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black54),
              onPressed: () async {
                await SupabaseService.client.auth.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Consumer<HomeViewModel>(
              builder: (context, vm, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stunning title – only "Magic" has cyan glow
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                          children: [
                            const TextSpan(text: 'Create Your ', style: TextStyle(color: Colors.black54)),
                            TextSpan(
                              text: 'Magic',
                              style: TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.w900,
                                foreground: Paint()
                                  ..shader = const LinearGradient(
                                    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                                shadows: const [
                                  Shadow(color: Colors.cyanAccent, blurRadius: 16),
                                ],
                              ),
                            ),
                            const TextSpan(text: ' Presentation', style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Main frosted glass card
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.78),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.black.withOpacity(0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            blurRadius: 20,
                            offset: const Offset(-10, -10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('Topic'),
                          const SizedBox(height: 10),
                          TextField(
                            onChanged: (v) => vm.topic = v,
                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                            decoration: _glassInput('Enter your presentation topic...'),
                          ),

                          const SizedBox(height: 28),
                          _label('Template Style'),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _glassRadio('Default', vm.template == 'bullet-point1', () {
                                vm.template = 'bullet-point1';
                                vm.notifyListeners();
                              })),
                              const SizedBox(width: 16),
                              Expanded(child: _glassRadio('Editable', vm.template == 'ed-bullet-point1', () {
                                vm.template = 'ed-bullet-point1';
                                vm.notifyListeners();
                              })),
                            ],
                          ),

                          const SizedBox(height: 28),
                          _glassDropdown(
                            label: 'Template',
                            value: vm.template,
                            items: const ['bullet-point1', 'bullet-point2', 'bullet-point4', 'ed-bullet-point1', 'pitchdeckorignal'],
                            onChanged: (v) => vm.template = v!,
                          ),
                          const SizedBox(height: 20),
                          _glassDropdown(
                            label: 'Language',
                            value: vm.language,
                            items: const ['en', 'hi'],
                            onChanged: (v) => vm.language = v!,
                          ),
                          const SizedBox(height: 20),
                          _glassDropdown(
                            label: 'Model',
                            value: vm.model,
                            items: const ['gpt-4', 'gpt-3.5-turbo', 'gpt-3.5'],
                            onChanged: (v) => vm.model = v!,
                          ),

                          const SizedBox(height: 28),
                          _label('Slide Count'),
                          const SizedBox(height: 12),
                          SliderTheme(
                            data: SliderThemeData(
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
                              activeTrackColor: Colors.black,
                              inactiveTrackColor: Colors.black26,
                              thumbColor: Colors.black,
                              overlayColor: Colors.black.withOpacity(0.2),
                            ),
                            child: Slider(
                              value: vm.slideCount.toDouble(),
                              min: 1,
                              max: 50,
                              divisions: 49,
                              onChanged: (v) {
                                vm.slideCount = v.toInt();
                                vm.notifyListeners();
                              },
                            ),
                          ),
                          Center(
                            child: Text(
                              '${vm.slideCount} slides',
                              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),

                          const SizedBox(height: 32),
                          _switchTile('AI Images', vm.aiImages, (v) => vm.aiImages = v),
                          _switchTile('Image on Each Slide', vm.imageEach, (v) => vm.imageEach = v),
                          _switchTile('Google Images', vm.googleImage, (v) => vm.googleImage = v),
                          _switchTile('Google Text', vm.googleText, (v) => vm.googleText = v),

                          const SizedBox(height: 40),

                          // Pure black generate button
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 62,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (vm.topic.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter a topic')),
                                    );
                                    return;
                                  }

                                  final user = SupabaseService.client.auth.currentUser;
                                  final email = user?.email ?? 'unknown@example.com';
                                  final request = vm.buildRequest(email);

                                  final res = await MagicSlidesService().generate(request);
                                  if (!context.mounted) return;

                                  if (res.success && res.data?['url'] != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => GenerateResultScreen(fileUrl: res.data!['url'])),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(res.message ?? 'Failed to generate')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  elevation: 20,
                                  shadowColor: Colors.black54,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text(
                                  'Generate Magic',
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.8),
                                ),
                              ),
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
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
  );

  Widget _glassRadio(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? Colors.black : Colors.black12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8)),
          ],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _glassDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    final safeValue = items.contains(value) ? value : items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 6)),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: safeValue,
              isExpanded: true,
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black87, fontSize: 15),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => v != null ? onChanged(v) : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _switchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(color: Colors.black87, fontSize: 15)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.black,
      activeTrackColor: Colors.black26,
      inactiveThumbColor: Colors.black38,
      inactiveTrackColor: Colors.black12,
    );
  }
}