import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MissionControlScreen extends StatelessWidget {
  const MissionControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1026), // background-dark
      body: Stack(
        children: [
          // Stars (Simplified)
          Positioned(top: 50, left: 30, child: _buildStar(2)),
          Positioned(top: 150, right: 40, child: _buildStar(3)),
          Positioned(bottom: 200, left: 60, child: _buildStar(4)),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.rocket_launch, color: Color(0xFFF4C025), size: 32),
                              const SizedBox(width: 8),
                              Text(
                                'Mission Control',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Ready for blast off, Captain?',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B33).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4C025),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.star, size: 16, color: Colors.black),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '1,240',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Timeline
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Line
                      Container(
                        width: 2,
                        height: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.0),
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPlanetNode(
                            title: 'Counting Comet',
                            status: 'Locked',
                            color: Colors.redAccent,
                            isLocked: true,
                          ),
                          _buildPlanetNode(
                            title: 'Colors Planet',
                            status: 'Ready to play!',
                            color: Colors.blueAccent,
                            isActive: true,
                          ),
                          _buildPlanetNode(
                            title: 'Shapes World',
                            status: 'Completed',
                            color: Colors.green,
                            isCompleted: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Weekly Progress
                Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B33).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Weekly Streak',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '5 / 7 Days',
                            style: GoogleFonts.plusJakartaSans(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDayDot('M', true),
                          _buildDayDot('T', true),
                          _buildDayDot('W', true),
                          _buildDayDot('T', true),
                          _buildDayDot('F', true),
                          _buildDayDot('S', false, isToday: true),
                          _buildDayDot('S', false),
                        ],
                      ),
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

  Widget _buildPlanetNode({
    required String title,
    required String status,
    required Color color,
    bool isLocked = false,
    bool isActive = false,
    bool isCompleted = false,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (isActive)
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
              ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isLocked ? Colors.grey.withOpacity(0.2) : color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? const Color(0xFFF4C025) : Colors.transparent,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: isLocked
                  ? const Icon(Icons.lock, color: Colors.grey, size: 40)
                  : (isCompleted ? const Icon(Icons.check, color: Colors.white, size: 40) : null),
            ),
            if (isActive)
              const Positioned(
                left: -20,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.rocket, color: Color(0xFFF4C025), size: 32),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF161B33).withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isActive ? const Color(0xFFF4C025).withOpacity(0.3) : Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  color: isActive ? const Color(0xFFF4C025) : Colors.white,
                ),
              ),
              Text(
                status,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayDot(String day, bool completed, {bool isToday = false}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isToday ? const Color(0xFFF4C025) : (completed ? Colors.green.withOpacity(0.2) : Colors.white.withOpacity(0.05)),
            shape: BoxShape.circle,
            border: Border.all(
              color: completed ? Colors.green : Colors.transparent,
            ),
          ),
          child: Center(
            child: completed
                ? const Icon(Icons.check, size: 16, color: Colors.green)
                : (isToday ? const Text('TD', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)) : null),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStar(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
