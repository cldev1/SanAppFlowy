import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TraceLettersV1Screen extends StatefulWidget {
  const TraceLettersV1Screen({super.key});

  @override
  State<TraceLettersV1Screen> createState() => _TraceLettersV1ScreenState();
}

class _TraceLettersV1ScreenState extends State<TraceLettersV1Screen> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // sky-light
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE0F7FA), Color(0xFFB3E5FC)],
              ),
            ),
          ),

          // Clouds
          Positioned(top: 50, left: 20, child: Icon(Icons.cloud, size: 120, color: Colors.white.withOpacity(0.6))),
          Positioned(top: 150, right: -40, child: Icon(Icons.cloud, size: 180, color: Colors.white.withOpacity(0.4))),
          Positioned(bottom: 100, left: -20, child: Icon(Icons.cloud, size: 150, color: Colors.white.withOpacity(0.5))),

          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(Icons.arrow_back, () => Navigator.pop(context)),
                  Column(
                    children: [
                      Text(
                        'Trace the A!',
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Color(0xFFF2CC0D), size: 24),
                          Icon(Icons.star, color: Colors.white54, size: 24),
                          Icon(Icons.star, color: Colors.white54, size: 24),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        points.clear();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Reset',
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Letter A
          Center(
            child: Container(
              width: 320,
              height: 420,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.6), width: 4),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Left Stroke
                  Positioned(
                    left: 60,
                    top: 40,
                    bottom: 40,
                    width: 40,
                    child: Transform.rotate(
                      angle: -0.26, // approx -15 deg
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                          ), // Simulated dashed line
                        ),
                      ),
                    ),
                  ),
                   // Right Stroke
                  Positioned(
                    right: 60,
                    top: 40,
                    bottom: 40,
                    width: 40,
                    child: Transform.rotate(
                      angle: 0.26, // approx 15 deg
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                   // Horizontal Stroke
                  Positioned(
                    top: 200,
                    child: Container(
                      width: 160,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                       child: const Center(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                    ),
                  ),

                  // Drawing Area
                  GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        points.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) => points.add(Offset.infinite),
                    child: CustomPaint(
                      size: const Size(320, 420),
                      painter: DrawingPainter(points: points),
                    ),
                  ),

                  // Bee Character (Simplified Movement)
                  Positioned(
                    bottom: 110,
                    left: 40,
                    child: _buildBee(),
                  ),

                  // Indicators
                  const Positioned(
                    top: 20,
                    left: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 20,
                      child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                   const Positioned(
                    top: 20,
                    right: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 20,
                      child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBee() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF2CC0D), width: 4),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
              ],
            ),
            const SizedBox(height: 4),
            Container(width: 10, height: 2, color: Colors.black),
          ],
        ),
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
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF0F172A)),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF2CC0D).withOpacity(0.8)
      ..strokeWidth = 25
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
