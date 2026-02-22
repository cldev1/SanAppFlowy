import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StickerRewardsScreen extends StatelessWidget {
  const StickerRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E5C28), // forest-bg
      body: Stack(
        children: [
          // Background Gradient & Pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.1, -0.6),
                  radius: 1.0,
                  colors: [
                    const Color(0xFF76A958).withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
                color: const Color(0xFF2E5C28),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIconButton(Icons.arrow_back, () => Navigator.pop(context)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4E342E).withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF8D6E63)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Color(0xFFFFD54F)),
                                const SizedBox(width: 8),
                                Text(
                                  '12 / 20',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFFE0B2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildIconButton(Icons.celebration, () {}, color: const Color(0xFFFFD54F)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8D6E63), // wood-sign
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF5D4037), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          'FOREST TREASURES',
                          style: GoogleFonts.fredoka(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF3E2723),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Sticker Grid
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D4C41),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF5D4037), width: 4),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF33691E),
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: NetworkImage('https://www.transparenttextures.com/patterns/grass.png'),
                          repeat: ImageRepeat.repeat,
                          opacity: 0.3,
                        ),
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildSticker(Icons.star, 'Super Star', Colors.amber),
                          _buildSticker(Icons.sunny, 'Sunny Day', Colors.orange),
                          _buildSticker(Icons.cruelty_free, 'Panda Pal', Colors.black87),
                          _buildSticker(Icons.rocket_launch, 'Blast Off', Colors.red),
                          _buildSlot(),
                          _buildSlot(),
                        ],
                      ),
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

  Widget _buildSticker(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFCFD8DC),
            borderRadius: BorderRadius.circular(20), // Stone slot shape approximation
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(icon, size: 60, color: color),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFFFECB3)),
          ),
          child: Text(
            label,
            style: GoogleFonts.fredoka(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3E2723),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlot() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4E342E), // dirt-slot
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2), style: BorderStyle.solid), // Dashed effect hard in basic container, solid for now
      ),
      child: Center(
        child: Icon(
          Icons.question_mark,
          size: 40,
          color: const Color(0xFF6D4C41).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed, {Color? color}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color ?? const Color(0xFF8D6E63),
          shape: BoxShape.circle,
          border: Border(bottom: BorderSide(color: const Color(0xFF5D4037), width: 4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF3E2723), size: 24),
      ),
    );
  }
}
