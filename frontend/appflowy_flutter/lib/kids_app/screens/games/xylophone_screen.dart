import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XylophoneScreen extends StatefulWidget {
  const XylophoneScreen({super.key});

  @override
  State<XylophoneScreen> createState() => _XylophoneScreenState();
}

class _XylophoneScreenState extends State<XylophoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF), // sky-50
      body: Stack(
        children: [
          // Background Decor
          Positioned(top: 80, left: 40, child: Icon(Icons.music_note, size: 120, color: Colors.blue.withOpacity(0.05))),
          Positioned(bottom: 100, right: 60, child: Icon(Icons.music_note, size: 80, color: Colors.blue.withOpacity(0.05))),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconButton(Icons.arrow_back, () => Navigator.pop(context)),
                      Column(
                        children: [
                          Text(
                            'Xylophone Fun',
                            style: GoogleFonts.splineSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'Twinkle Twinkle',
                            style: GoogleFonts.splineSans(
                              fontSize: 14,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      _buildIconButton(Icons.volume_up, () {}),
                    ],
                  ),
                ),

                // Keys
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildKey('C', 'Do', const Color(0xFFFF6B6B), 0.9),
                        _buildKey('D', 'Re', const Color(0xFFFF9F43), 0.85),
                        _buildKey('E', 'Mi', const Color(0xFFFECA57), 0.8),
                        _buildKey('F', 'Fa', const Color(0xFF2BEE6C), 0.75),
                        _buildKey('G', 'Sol', const Color(0xFF48DBFB), 0.7),
                        _buildKey('A', 'La', const Color(0xFF54A0FF), 0.65),
                        _buildKey('B', 'Si', const Color(0xFF5F27CD), 0.6),
                        _buildKey('C', 'Do', const Color(0xFFFF9FF3), 0.55),
                      ],
                    ),
                  ),
                ),

                // Bottom Controls
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildModeButton(Icons.piano, 'Free Play', true),
                        _buildModeButton(Icons.school, 'Learn', false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String note, String solfege, Color color, double heightFactor) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTapDown: (_) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Playing note: $note'),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: Container(
                height: constraints.maxHeight * heightFactor,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(bottom: 80), // Screw position
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note,
                      style: GoogleFonts.splineSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      solfege,
                      style: GoogleFonts.splineSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
        ),
        child: Icon(icon, color: const Color(0xFF1E293B)),
      ),
    );
  }

  Widget _buildModeButton(IconData icon, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2BEE6C) : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: isSelected ? const Color(0xFF102216) : const Color(0xFF64748B)),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.splineSans(
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF102216) : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
