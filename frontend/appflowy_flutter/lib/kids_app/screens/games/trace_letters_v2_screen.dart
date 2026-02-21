import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TraceLettersV2Screen extends StatefulWidget {
  const TraceLettersV2Screen({super.key});

  @override
  State<TraceLettersV2Screen> createState() => _TraceLettersV2ScreenState();
}

class _TraceLettersV2ScreenState extends State<TraceLettersV2Screen> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E3), // sand-light
      body: Stack(
        children: [
          // Sand Texture (Simulated with noise or image - simpler here)
          Container(
            color: const Color(0xFFFDF6E3),
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                size: Size.infinite,
                painter: SandGrainPainter(),
              ),
            ),
          ),

          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(Icons.arrow_back, () => Navigator.pop(context)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                    ),
                    child: Text(
                      'Trace the B!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF78350F), // amber-900
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer
                ],
              ),
            ),
          ),

          // Main Game Area
          Center(
            child: SizedBox(
              width: 300,
              height: 400,
              child: Stack(
                children: [
                  // Letter Track (The "trench")
                  CustomPaint(
                    size: const Size(300, 400),
                    painter: SandLetterPainter(),
                  ),

                  // Drawing Layer
                  GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) => points.add(Offset.infinite),
                    child: CustomPaint(
                      size: const Size(300, 400),
                      painter: DrawingPainter(points: points),
                    ),
                  ),

                  // Stars / Checkpoints
                  Positioned(
                    top: 20,
                    left: 60,
                    child: _buildStar(),
                  ),
                  Positioned(
                    top: 180,
                    left: 60,
                    child: _buildStar(isActive: false),
                  ),
                   Positioned(
                    bottom: 20,
                    left: 60,
                    child: _buildStar(isActive: false),
                  ),
                ],
              ),
            ),
          ),

          // Reset Button
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    points.clear();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.refresh, color: Color(0xFF78350F)),
                      const SizedBox(width: 8),
                      Text(
                        'Smooth Sand',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF78350F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStar({bool isActive = true}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF4C025) : const Color(0xFFE8DCB5),
        shape: BoxShape.circle,
        boxShadow: isActive ? [
          BoxShadow(
            color: const Color(0xFFF4C025).withOpacity(0.6),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ] : [],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Icon(Icons.star, color: Colors.white, size: 20),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF78350F)),
      ),
    );
  }
}

class SandLetterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC5B38A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // B shape
    path.moveTo(60, 20);
    path.lineTo(60, 380);
    path.moveTo(60, 20);
    path.cubicTo(200, 20, 200, 180, 60, 180);
    path.moveTo(60, 180);
    path.cubicTo(220, 180, 220, 380, 60, 380);

    // Inner shadow simulation (draw darker underneath first)
    canvas.drawPath(path, paint..color = const Color(0xFFB09A68));

    // "Dug out" look
    paint.color = const Color(0xFFC5B38A);
    paint.strokeWidth = 40;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF4C025).withOpacity(0.6)
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.infinite && points[i + 1] != Offset.infinite) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SandGrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.brown.withOpacity(0.2);
    for (double i = 0; i < size.width; i += 4) {
      for (double j = 0; j < size.height; j += 4) {
        if ((i + j) % 7 == 0) {
          canvas.drawCircle(Offset(i, j), 1, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
