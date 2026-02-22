import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalSoundMatchScreen extends StatelessWidget {
  const AnimalSoundMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6), // background-light
      body: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: CustomPaint(
                painter: MeadowPatternPainter(),
              ),
            ),
          ),
          // Decor
          Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF2BEE6C).withOpacity(0.2), // primary/20
                borderRadius: const BorderRadius.vertical(top: Radius.circular(100)),
              ),
            ),
          ),

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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              '2/5',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Instructions
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2BEE6C),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.volume_up, size: 40, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF2BEE6C).withOpacity(0.2), width: 2),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                            ),
                            children: const [
                              TextSpan(text: 'Tap the '),
                              TextSpan(
                                text: 'Cow',
                                style: TextStyle(color: Color(0xFF1FA84D)),
                              ),
                              TextSpan(text: '!'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Cards
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _buildAnimalCard(
                        'Cow',
                        '"Moo!"',
                        Icons.pets, // Placeholder for Cow image
                        Colors.orange.shade100,
                        true,
                      ),
                      const SizedBox(height: 24),
                      _buildAnimalCard(
                        'Duck',
                        '"Quack!"',
                        Icons.cruelty_free, // Placeholder for Duck image
                        Colors.yellow.shade100,
                        false,
                      ),
                      const SizedBox(height: 24),
                      _buildAnimalCard(
                        'Sheep',
                        '"Baa!"',
                        Icons.pets, // Placeholder for Sheep image
                        Colors.blue.shade100,
                        false,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                // Play Sound Button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Playing cow sound... Moo!')),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2BEE6C),
                        borderRadius: BorderRadius.circular(32),
                        border: Border(
                          bottom: BorderSide(color: Colors.green.shade700, width: 4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_circle, size: 32, color: Color(0xFF0F172A)),
                          const SizedBox(width: 8),
                          Text(
                            'Play Sound',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
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

  Widget _buildAnimalCard(String name, String sound, IconData icon, Color bgColor, bool isSelected) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You selected $name! $sound')),
        );
      },
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF2BEE6C) : Colors.transparent,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 64, color: Colors.black.withOpacity(0.5)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    sound,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.touch_app, size: 24, color: Color(0xFF94A3B8)),
                ),
              ),
          ],
        ),
      ),
    );
  }
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 64, color: Colors.black.withOpacity(0.5)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  sound,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.touch_app, size: 24, color: Color(0xFF94A3B8)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF0F172A), size: 28),
      ),
    );
  }
}

class MeadowPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2BEE6C).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += 40) {
      for (double y = 0; y < size.height; y += 40) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
