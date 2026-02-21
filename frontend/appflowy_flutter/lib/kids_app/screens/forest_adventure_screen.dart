import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'games/animal_sound_match_screen.dart';
import 'games/balloon_pop_screen.dart';
import 'games/coloring_book_screen.dart';
import 'games/memory_match_screen.dart';
import 'games/trace_letters_v1_screen.dart';
import 'games/trace_letters_v2_screen.dart';
import 'games/xylophone_screen.dart';
import 'games/shape_sorter_screen.dart';
import 'daily_challenge_screen.dart';
import 'parental_gate_screen.dart';

class ForestAdventureScreen extends StatelessWidget {
  const ForestAdventureScreen({super.key});

  static const routeName = '/kids_app/forest_adventure';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6), // background-light
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFF13EC13).withOpacity(0.1), // primary
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeaderIcon(Icons.local_florist, const Color(0xFF13EC13)),
                  Text(
                    'Forest Adventure!',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A), // slate-900
                    ),
                  ),
                  _buildHeaderIcon(Icons.stars, const Color(0xFF13EC13)),
                ],
              ),
            ),
            // Puppy Guide Welcome
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF13EC13).withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF13EC13).withOpacity(0.3),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF13EC13),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.pets,
                        size: 40,
                        color: Color(0xFF13EC13),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi friend!',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF13EC13),
                            ),
                          ),
                          Text(
                            'Follow the paws to find new games!',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF475569), // slate-600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Organic Adventure Map
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  _buildCategoryTile(
                    context,
                    title: 'Animals',
                    subtitle: 'Start Here',
                    icon: Icons.pets,
                    color: const Color(0xFF10B981), // emerald-500
                    bgColor: const Color(0xFFD1FAE5), // emerald-100
                    borderColor: const Color(0xFFA7F3D0), // emerald-200
                    alignment: MainAxisAlignment.start,
                    destination: const AnimalSoundMatchScreen(),
                  ),
                  const SizedBox(height: 32),
                  _buildCategoryTile(
                    context,
                    title: 'Shapes',
                    subtitle: 'Mushroom Match',
                    icon: Icons.category,
                    color: const Color(0xFFEA580C), // orange-600
                    bgColor: const Color(0xFFFFEDD5), // orange-100
                    borderColor: const Color(0xFFFED7AA), // orange-200
                    alignment: MainAxisAlignment.end,
                    isRight: true,
                    destination: const ShapeSorterScreen(),
                  ),
                  const SizedBox(height: 32),
                  _buildCategoryTile(
                    context,
                    title: 'Numbers',
                    subtitle: 'Berry Count',
                    icon: Icons.filter_7,
                    color: const Color(0xFF2563EB), // blue-600
                    bgColor: const Color(0xFFDBEAFE), // blue-100
                    borderColor: const Color(0xFFBFDBFE), // blue-200
                    alignment: MainAxisAlignment.start,
                    destination: const BalloonPopScreen(),
                  ),
                  const SizedBox(height: 32),
                  _buildCategoryTile(
                    context,
                    title: 'Colors',
                    subtitle: 'Rainbow Sky',
                    icon: Icons.palette,
                    color: const Color(0xFFE11D48), // rose-600
                    bgColor: const Color(0xFFFFE4E6), // rose-100
                    borderColor: const Color(0xFFFECDD3), // rose-200
                    alignment: MainAxisAlignment.end,
                    isRight: true,
                    destination: const TraceLettersV1Screen(), // Using Trace V1 as placeholder for colors
                  ),
                  const SizedBox(height: 32),
                  _buildCategoryTile(
                    context,
                    title: 'Music',
                    subtitle: 'Log Drums',
                    icon: Icons.music_note,
                    color: const Color(0xFFCA8A04), // yellow-600
                    bgColor: const Color(0xFFFEF9C3), // yellow-100
                    borderColor: const Color(0xFFFEF08A), // yellow-200
                    alignment: MainAxisAlignment.start,
                    destination: const XylophoneScreen(),
                  ),
                  const SizedBox(height: 32),
                  _buildCategoryTile(
                    context,
                    title: 'Coloring',
                    subtitle: 'Flower Petals',
                    icon: Icons.brush,
                    color: const Color(0xFF9333EA), // purple-600
                    bgColor: const Color(0xFFF3E8FF), // purple-100
                    borderColor: const Color(0xFFE9D5FF), // purple-200
                    alignment: MainAxisAlignment.end,
                    isRight: true,
                    destination: const ColoringBookScreen(),
                  ),
                  const SizedBox(height: 32),
                  // Memory Match
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MemoryMatchScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF13EC13),
                        borderRadius: BorderRadius.circular(999),
                        border: Border(
                          bottom: BorderSide(
                            color: const Color(0xFF13EC13).withOpacity(0.4),
                            width: 8,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.visibility, size: 48, color: Colors.white),
                              SizedBox(width: 16),
                              Icon(Icons.visibility, size: 48, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'MEMORY MATCH',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'BIG CHALLENGE!',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 80), // Space for footer
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          border: Border(
            top: BorderSide(
              color: const Color(0xFF13EC13).withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(context, Icons.home, 'Home', true),
            _buildNavItem(context, Icons.map, 'Path', false, destination: const DailyChallengeScreen()),
            Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF13EC13),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.pets, size: 32, color: Colors.white),
              ),
            ),
            _buildNavItem(context, Icons.emoji_events, 'Prizes', false),
            _buildNavItem(context, Icons.settings, 'Grown-ups', false, destination: const ParentalGateScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required Color borderColor,
    required MainAxisAlignment alignment,
    bool isRight = false,
    Widget? destination,
  }) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: GestureDetector(
            onTap: () {
              if (destination != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destination),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border(
                  bottom: BorderSide(
                    color: borderColor,
                    width: 4,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (isRight) ...[
                    Icon(Icons.pets, color: const Color(0xFF13EC13)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                              height: 1.0,
                            ),
                          ),
                          Text(
                            subtitle.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF64748B),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 32, color: color),
                  ),
                  if (!isRight) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                              height: 1.0,
                            ),
                          ),
                          Text(
                            subtitle.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF64748B),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.pets, color: const Color(0xFF13EC13)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isActive, {Widget? destination}) {
    return GestureDetector(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isActive ? const Color(0xFF13EC13) : const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF13EC13) : const Color(0xFF94A3B8),
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
