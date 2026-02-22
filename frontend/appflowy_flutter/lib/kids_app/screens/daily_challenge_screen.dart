import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daily_challenge_gift_screen.dart';

class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D5A2D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Puppy's Path",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2D5A2D),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Path Background (Simplified)
          Center(
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              painter: PathPainter(),
            ),
          ),
          // Nodes
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNode(
                context,
                isCompleted: true,
                icon: Icons.check_circle,
                label: 'Color Match',
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 60),
              _buildNode(
                context,
                isActive: true,
                icon: Icons.looks_3,
                label: 'Count to 3',
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 60),
              _buildNode(
                context,
                isLocked: true,
                icon: Icons.lock,
                label: 'Animal Sounds',
                alignment: Alignment.centerRight,
              ),
            ],
          ),
          // Treasure Chest
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DailyChallengeGiftScreen()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFFFBBF24), Color(0xFFF97316)]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Big Sticker!',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFB45309), width: 4),
                      ),
                      child: const Icon(Icons.lock, color: Color(0xFFB45309), size: 32),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNode(
    BuildContext context, {
    bool isCompleted = false,
    bool isActive = false,
    bool isLocked = false,
    required IconData icon,
    required String label,
    required Alignment alignment,
  }) {
    Color bgColor = isLocked ? const Color(0xFFCBD5CB) : (isActive ? const Color(0xFF13EC13) : const Color(0xFF2D5A2D));
    Color iconColor = isLocked ? Colors.grey : (isActive ? const Color(0xFF2D5A2D) : Colors.white);
    Color borderColor = isLocked ? Colors.white : (isActive ? Colors.white : const Color(0xFF13EC13));

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 40),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF13EC13).withOpacity(0.3)),
              ),
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D5A2D),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.5, 80);
    path.cubicTo(
      size.width * 0.8, size.height * 0.2,
      size.width * 0.2, size.height * 0.4,
      size.width * 0.5, size.height * 0.6,
    );
    path.cubicTo(
      size.width * 0.8, size.height * 0.8,
      size.width * 0.5, size.height * 0.9,
      size.width * 0.5, size.height,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
