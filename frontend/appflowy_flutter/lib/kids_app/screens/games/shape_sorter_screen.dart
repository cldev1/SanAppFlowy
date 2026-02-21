import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShapeSorterScreen extends StatefulWidget {
  const ShapeSorterScreen({super.key});

  @override
  State<ShapeSorterScreen> createState() => _ShapeSorterScreenState();
}

class _ShapeSorterScreenState extends State<ShapeSorterScreen> {
  bool isCirclePlaced = false;
  bool isSquarePlaced = false;
  bool isTrianglePlaced = false;

  @override
  Widget build(BuildContext context) {
    bool allPlaced = isCirclePlaced && isSquarePlaced && isTrianglePlaced;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6), // background-light
      body: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: WoodPatternPainter()),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 24),
                            const Icon(Icons.star, color: Colors.grey, size: 24),
                            const Icon(Icons.star, color: Colors.grey, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'LEVEL 1',
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildIconButton(Icons.settings, () {}),
                    ],
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [
                      // Source Area
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'PICK A SHAPE',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 12,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              if (!isCirclePlaced)
                                Draggable<String>(
                                  data: 'circle',
                                  feedback: _buildShape(ShapeType.circle, isDragging: true),
                                  childWhenDragging: Opacity(opacity: 0.3, child: _buildShape(ShapeType.circle)),
                                  child: _buildShape(ShapeType.circle),
                                )
                              else
                                const SizedBox(height: 100),

                              if (!isSquarePlaced)
                                Draggable<String>(
                                  data: 'square',
                                  feedback: _buildShape(ShapeType.square, isDragging: true),
                                  childWhenDragging: Opacity(opacity: 0.3, child: _buildShape(ShapeType.square)),
                                  child: _buildShape(ShapeType.square),
                                )
                              else
                                const SizedBox(height: 100),

                              if (!isTrianglePlaced)
                                Draggable<String>(
                                  data: 'triangle',
                                  feedback: _buildShape(ShapeType.triangle, isDragging: true),
                                  childWhenDragging: Opacity(opacity: 0.3, child: _buildShape(ShapeType.triangle)),
                                  child: _buildShape(ShapeType.triangle),
                                )
                              else
                                const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),

                      // Target Area
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'PLACE HERE',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 12,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return _buildTarget(ShapeType.circle, isFilled: isCirclePlaced);
                                },
                                onWillAccept: (data) => data == 'circle',
                                onAccept: (data) {
                                  setState(() => isCirclePlaced = true);
                                },
                              ),
                              DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return _buildTarget(ShapeType.square, isFilled: isSquarePlaced);
                                },
                                onWillAccept: (data) => data == 'square',
                                onAccept: (data) {
                                  setState(() => isSquarePlaced = true);
                                },
                              ),
                              DragTarget<String>(
                                builder: (context, candidateData, rejectedData) {
                                  return _buildTarget(ShapeType.triangle, isFilled: isTrianglePlaced);
                                },
                                onWillAccept: (data) => data == 'triangle',
                                onAccept: (data) {
                                  setState(() => isTrianglePlaced = true);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (allPlaced)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2BEE6C),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2BEE6C).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Level Complete!',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, color: Color(0xFF0F172A)),
                        ],
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

  Widget _buildShape(ShapeType type, {bool isDragging = false}) {
    Color color;
    Widget shape;

    switch (type) {
      case ShapeType.circle:
        color = const Color(0xFF4ECDC4); // shape-blue
        shape = Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: isDragging ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)] : [],
          ),
        );
        break;
      case ShapeType.square:
        color = const Color(0xFFFF6B6B); // shape-red
        shape = Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: isDragging ? [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)] : [],
          ),
        );
        break;
      case ShapeType.triangle:
        color = const Color(0xFFFFE66D); // shape-yellow
        shape = SizedBox(
          width: 80,
          height: 80,
          child: CustomPaint(
            painter: TrianglePainter(color: color, strokeColor: Colors.white, strokeWidth: 4),
          ),
        );
        break;
    }

    if (isDragging) {
      // Scale up feedback
      return Transform.scale(scale: 1.1, child: shape);
    }
    return shape;
  }

  Widget _buildTarget(ShapeType type, {bool isFilled = false}) {
    if (isFilled) {
      return Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildShape(type),
            const Icon(Icons.check, color: Colors.white, size: 40),
          ],
        ),
      );
    }

    Widget shape;
    switch (type) {
      case ShapeType.circle:
        shape = Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFCBD5E1).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        );
        break;
      case ShapeType.square:
        shape = Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFCBD5E1).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
        );
        break;
      case ShapeType.triangle:
        shape = SizedBox(
          width: 80,
          height: 80,
          child: CustomPaint(
            painter: TrianglePainter(color: const Color(0xFFCBD5E1).withOpacity(0.5)),
          ),
        );
        break;
    }

    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: shape,
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}

enum ShapeType { circle, square, triangle }

class TrianglePainter extends CustomPainter {
  final Color color;
  final Color? strokeColor;
  final double strokeWidth;

  TrianglePainter({required this.color, this.strokeColor, this.strokeWidth = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    if (strokeColor != null) {
      final strokePaint = Paint()
        ..color = strokeColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WoodPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Simplified pattern
    for (double i = 0; i < size.width; i+=40) {
      for (double j = 0; j < size.height; j+=40) {
        if ((i/40 + j/40) % 2 == 0) canvas.drawCircle(Offset(i, j), 2, paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
