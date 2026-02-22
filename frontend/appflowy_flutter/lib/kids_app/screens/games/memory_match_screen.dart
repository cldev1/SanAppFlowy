import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  final List<String> items = ['🍎', '🚗', '☀️', '🍎', '🚗', '☀️'];
  List<bool> cardFlipped = [false, false, false, false, false, false];
  List<bool> cardMatched = [false, false, false, false, false, false];
  int? firstFlippedIndex;
  int matches = 0;

  @override
  void initState() {
    super.initState();
    items.shuffle();
  }

  void _onCardTap(int index) {
    if (cardFlipped[index] || cardMatched[index]) return;

    setState(() {
      cardFlipped[index] = true;
    });

    if (firstFlippedIndex == null) {
      firstFlippedIndex = index;
    } else {
      // Check match
      if (items[firstFlippedIndex!] == items[index]) {
        setState(() {
          cardMatched[firstFlippedIndex!] = true;
          cardMatched[index] = true;
          matches++;
          firstFlippedIndex = null;
        });
        if (matches == 3) {
          _showWinDialog();
        }
      } else {
        // No match, flip back
        int tempIndex = firstFlippedIndex!;
        firstFlippedIndex = null;
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              cardFlipped[tempIndex] = false;
              cardFlipped[index] = false;
            });
          }
        });
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Well Done!'),
        content: const Text('You found all matches!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                items.shuffle();
                cardFlipped = [false, false, false, false, false, false];
                cardMatched = [false, false, false, false, false, false];
                matches = 0;
                firstFlippedIndex = null;
              });
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E8FF), // background-light (purple tint)
      body: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: CustomPaint(
              painter: DotPatternPainter(),
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
                      Text(
                        'Memory Match',
                        style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      _buildIconButton(Icons.refresh, () {
                        setState(() {
                          items.shuffle();
                          cardFlipped = [false, false, false, false, false, false];
                          cardMatched = [false, false, false, false, false, false];
                          matches = 0;
                          firstFlippedIndex = null;
                        });
                      }, color: const Color(0xFFEE2B8C)),
                    ],
                  ),
                ),

                // Score
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF475569),
                      ),
                      children: [
                        const TextSpan(text: 'Matches: '),
                        TextSpan(
                          text: '$matches/3',
                          style: const TextStyle(color: Color(0xFFEE2B8C)),
                        ),
                      ],
                    ),
                  ),
                ),

                // Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return _buildCard(index);
                      },
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

  Widget _buildCard(int index) {
    return GestureDetector(
      onTap: () => _onCardTap(index),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotateAnim,
            builder: (context, child) {
              final angle = rotateAnim.value;
              if (angle >= pi / 2) {
                // Back side (during flip)
                 return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  alignment: Alignment.center,
                  child: Container(
                     decoration: BoxDecoration(
                      color: const Color(0xFFEE2B8C),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                );
              } else {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  alignment: Alignment.center,
                  child: child,
                );
              }
            },
            child: child,
          );
        },
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: cardFlipped[index] || cardMatched[index]
            ? _buildCardFront(items[index])
            : _buildCardBack(),
      ),
    );
  }

  Widget _buildCardFront(String item) {
    return Container(
      key: ValueKey(true),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        item,
        style: const TextStyle(fontSize: 64),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      key: ValueKey(false),
      decoration: BoxDecoration(
        color: const Color(0xFFEE2B8C), // primary
        borderRadius: BorderRadius.circular(24),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFC21C6E), width: 8), // primary-dark
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '?',
        style: GoogleFonts.lexend(
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: Colors.white.withOpacity(0.5),
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
          color: color != null ? color : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
          ],
        ),
        child: Icon(
          icon,
          color: color != null ? Colors.white : const Color(0xFFEE2B8C),
          size: 28,
        ),
      ),
    );
  }
}

class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFD8B4FE).withOpacity(0.5);
    for (double x = 0; x < size.width; x += 40) {
      for (double y = 0; y < size.height; y += 40) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
