import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'games/animal_sound_match_screen.dart';
import 'games/balloon_pop_screen.dart';
import 'games/shape_sorter_screen.dart';
import 'games/trace_letters_v1_screen.dart';

class GameCategoryMenuScreen extends StatelessWidget {
  const GameCategoryMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9C3), // background-light (pastel yellow)
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Let's Play!",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.settings, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
            ),
            // Content Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(24),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.8,
                children: [
                  _buildCard(
                    context,
                    title: 'Animals',
                    color: const Color(0xFFFFB74D), // card-orange
                    icon: Icons.pets,
                    destination: const AnimalSoundMatchScreen(),
                    rotation: 2,
                  ),
                  _buildCard(
                    context,
                    title: 'Colors',
                    color: const Color(0xFF4FC3F7), // card-blue
                    icon: Icons.palette,
                    destination: const TraceLettersV1Screen(), // Placeholder
                    rotation: -2,
                  ),
                  _buildCard(
                    context,
                    title: 'Numbers',
                    color: const Color(0xFF2BEE6C), // primary
                    icon: Icons.filter_7,
                    destination: const BalloonPopScreen(),
                    rotation: 1,
                  ),
                  _buildCard(
                    context,
                    title: 'Shapes',
                    color: const Color(0xFFF06292), // card-pink
                    icon: Icons.category,
                    destination: const ShapeSorterScreen(),
                    rotation: -1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required Color color,
    required IconData icon,
    required Widget destination,
    double rotation = 0,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Transform.rotate(
        angle: rotation * 3.14159 / 180,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
