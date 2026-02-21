import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForestMapCategoryMenuScreen extends StatelessWidget {
  const ForestMapCategoryMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF81D4FA), // sky-blue
      body: Stack(
        children: [
          // Forest Path Background (Simplified)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF66BB6A), // forest-greenish
            ),
          ),
          Center(
            child: Container(
              width: 120,
              height: double.infinity,
              color: const Color(0xFFE6D7A8), // path-sand
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8D6E63), // wood-light
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF5D4037), width: 4),
                        ),
                        child: Text(
                          'FOREST MAP',
                          style: GoogleFonts.fredoka(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8D6E63),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF5D4037), width: 4),
                        ),
                        child: const Icon(Icons.settings, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Nodes
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      _buildMapNode(context, 'Animals!', Icons.pets, const Color(0xFF5D4037), Alignment.centerLeft),
                      const SizedBox(height: 60),
                      _buildMapNode(context, 'Colors!', Icons.palette, const Color(0xFFE91E63), Alignment.centerRight),
                      const SizedBox(height: 60),
                      _buildMapNode(context, 'Numbers!', Icons.filter_7, const Color(0xFF9E9E9E), Alignment.centerLeft),
                      const SizedBox(height: 60),
                      _buildMapNode(context, 'Shapes!', Icons.category, const Color(0xFFFF9800), Alignment.centerRight),
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

  Widget _buildMapNode(BuildContext context, String label, IconData icon, Color color, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 160,
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(icon, size: 48, color: Colors.white.withOpacity(0.8)),
            ),
            Positioned(
              top: -16,
              left: alignment == Alignment.centerRight ? -16 : null,
              right: alignment == Alignment.centerLeft ? -16 : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color, width: 2),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.fredoka(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
