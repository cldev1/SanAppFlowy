import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BalloonPopScreen extends StatefulWidget {
  const BalloonPopScreen({super.key});

  @override
  State<BalloonPopScreen> createState() => _BalloonPopScreenState();
}

class _BalloonPopScreenState extends State<BalloonPopScreen> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  int score = 12;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (index) {
      return AnimationController(
        duration: Duration(seconds: 4 + index),
        vsync: this,
      )..repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB), // sky-blue
      body: Stack(
        children: [
          // Background Clouds
          Positioned(top: 80, left: -20, child: _buildCloud(width: 200, height: 100)),
          Positioned(top: 150, right: -20, child: _buildCloud(width: 150, height: 80)),
          Positioned(bottom: 100, left: 40, child: _buildCloud(width: 180, height: 90)),

          // HUD
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(Icons.pause),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xFFF48C25).withOpacity(0.2), width: 4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.stars, color: Color(0xFFF48C25), size: 32),
                            const SizedBox(width: 12),
                            Text(
                              '$score',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'SCORE',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  _buildIconButton(Icons.volume_up),
                ],
              ),
            ),
          ),

          // Center Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$score',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 96,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Twelve!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),

          // Balloons
          _buildBalloon(0, Colors.red, 0.1, 0.6),
          _buildBalloon(1, Colors.blue, 0.35, 0.5),
          _buildBalloon(2, Colors.green, 0.6, 0.7),
          _buildBalloon(3, const Color(0xFFF48C25), 0.8, 0.4),
          _buildBalloon(4, Colors.purple, 0.2, 0.8),
        ],
      ),
    );
  }

  Widget _buildBalloon(int index, Color color, double left, double bottomStart) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      bottom: -150, // Start just below the screen
      child: AnimatedBuilder(
        animation: _controllers[index],
        builder: (context, child) {
          final screenHeight = MediaQuery.of(context).size.height;
          return Transform.translate(
            offset: Offset(0, -(screenHeight + 300) * _controllers[index].value),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  score++;
                  _controllers[index].reset();
                  _controllers[index].forward();
                });
              },
              child: child,
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.elliptical(80, 100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(-4, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      width: 20,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(Radius.elliptical(20, 30)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 2,
              height: 60,
              color: Colors.white.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloud({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFFF48C25), size: 32),
        onPressed: () {},
      ),
    );
  }
}
