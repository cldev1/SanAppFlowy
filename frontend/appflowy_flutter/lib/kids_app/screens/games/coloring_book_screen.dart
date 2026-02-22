import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColoringBookScreen extends StatefulWidget {
  const ColoringBookScreen({super.key});

  @override
  State<ColoringBookScreen> createState() => _ColoringBookScreenState();
}

class _ColoringBookScreenState extends State<ColoringBookScreen> {
  Color selectedColor = const Color(0xFFF4F425); // primary yellow
  Map<int, Color> petalColors = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F5), // background-light
      body: Stack(
        children: [
          // Paper Texture (simulated)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Container(
                color: Colors.white,
                child: CustomPaint(painter: NoisePainter()),
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
                      _buildIconButton(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                      Row(
                        children: [
                          const Icon(Icons.wb_sunny, color: Color(0xFFF4F425), size: 32),
                          const SizedBox(width: 8),
                          Text(
                            'Sunflower',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1E293B), // slate-800
                            ),
                          ),
                        ],
                      ),
                      _buildIconButton(Icons.refresh, () {
                        setState(() {
                          petalColors.clear();
                        });
                      }, color: const Color(0xFFF43F5E)), // rose-500
                    ],
                  ),
                ),

                // Canvas
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTapUp: (details) {
                                // Simple hit detection logic (mock)
                                // In a real app, we'd check paths.
                                // Here we just randomize a petal color for demo
                                setState(() {
                                  petalColors[DateTime.now().millisecondsSinceEpoch % 12] = selectedColor;
                                });
                              },
                              child: CustomPaint(
                                size: const Size(300, 400),
                                painter: SunflowerPainter(petalColors: petalColors),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Helper Text
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    'Pick a color!',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),

                // Palette
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 40,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCrayon(const Color(0xFFFF5252)), // Red
                      _buildCrayon(const Color(0xFFF4F425)), // Yellow
                      _buildCrayon(const Color(0xFF448AFF)), // Blue
                      _buildCrayon(const Color(0xFF69F0AE)), // Green
                      _buildCrayon(const Color(0xFFFF4081)), // Pink
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCrayon(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: isSelected ? 110 : 90,
        margin: const EdgeInsets.only(bottom: 0),
        child: Column(
          children: [
            // Tip
            Container(
              width: 0,
              height: 0,
              borderStyle: BorderStyle.solid,
              borderLeftWidth: 10,
              borderRightWidth: 10,
              borderBottomWidth: 16,
              borderLeftColor: Colors.transparent,
              borderRightColor: Colors.transparent,
              borderBottomColor: color,
            ),
            // Body
            Expanded(
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: isSelected ? Border.all(color: Colors.white, width: 4) : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 24)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed, {Color? color}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, color: color ?? const Color(0xFF334155), size: 28),
      ),
    );
  }
}

class SunflowerPainter extends CustomPainter {
  final Map<int, Color> petalColors;

  SunflowerPainter({required this.petalColors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 50);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final fillPaint = Paint()..style = PaintingStyle.fill;

    // Stem
    final stemPath = Path();
    stemPath.moveTo(center.dx, center.dy + 50);
    stemPath.quadraticBezierTo(center.dx + 10, center.dy + 150, center.dx - 10, center.dy + 250);
    canvas.drawPath(stemPath, paint);

    // Leaves
    // Left
    final leafLeft = Path();
    leafLeft.moveTo(center.dx, center.dy + 150);
    leafLeft.quadraticBezierTo(center.dx - 60, center.dy + 130, center.dx - 80, center.dy + 180);
    leafLeft.quadraticBezierTo(center.dx - 40, center.dy + 190, center.dx, center.dy + 160);
    canvas.drawPath(leafLeft, paint..color = const Color(0xFF181811)); // Reset paint color

    // Petals
    for (int i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * 30 * 3.14159 / 180);

      final petalPath = Path();
      petalPath.moveTo(0, -40);
      petalPath.quadraticBezierTo(-20, -100, 0, -110);
      petalPath.quadraticBezierTo(20, -100, 0, -40);

      // Fill
      if (petalColors.containsKey(i)) {
        fillPaint.color = petalColors[i]!;
        canvas.drawPath(petalPath, fillPaint);
      } else {
        fillPaint.color = Colors.white;
        canvas.drawPath(petalPath, fillPaint);
      }

      // Stroke
      canvas.drawPath(petalPath, paint..color = const Color(0xFF181811));
      canvas.restore();
    }

    // Center Face
    fillPaint.color = Colors.white;
    canvas.drawCircle(center, 40, fillPaint);
    canvas.drawCircle(center, 40, paint);

    // Eyes
    fillPaint.color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 15, center.dy - 10), 5, fillPaint);
    canvas.drawCircle(Offset(center.dx + 15, center.dy - 10), 5, fillPaint);

    // Mouth
    final mouthPath = Path();
    mouthPath.moveTo(center.dx - 15, center.dy + 10);
    mouthPath.quadraticBezierTo(center.dx, center.dy + 25, center.dx + 15, center.dy + 10);
    canvas.drawPath(mouthPath, paint..strokeWidth = 4);
  }

  @override
  bool shouldRepaint(covariant SunflowerPainter oldDelegate) => true;
}

class NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Basic noise simulation (dots)
    final paint = Paint()..color = Colors.grey.withOpacity(0.1);
    /*for (int i = 0; i < 1000; i++) {
      canvas.drawCircle(
        Offset(
          (DateTime.now().microsecondsSinceEpoch % size.width.toInt()).toDouble(),
          (DateTime.now().microsecondsSinceEpoch % size.height.toInt()).toDouble()
        ),
        1,
        paint
      );
    }*/
    // Optimized: just draw a few random dots
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
