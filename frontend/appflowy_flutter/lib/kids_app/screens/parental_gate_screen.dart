import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentalGateScreen extends StatefulWidget {
  const ParentalGateScreen({super.key});

  @override
  State<ParentalGateScreen> createState() => _ParentalGateScreenState();
}

class _ParentalGateScreenState extends State<ParentalGateScreen> {
  bool isUnlocked = false;

  void _checkAnswer(int answer) {
    if (answer == 5) {
      setState(() {
        isUnlocked = true;
      });
      // In a real app, this would navigate to the actual settings page or unlock features.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Access Granted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try Again!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isUnlocked) {
      return Scaffold(
        appBar: AppBar(title: const Text('Parent Dashboard')),
        body: const Center(child: Text('Settings Unlocked')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6), // background-light
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.95),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Parental Gate',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF64748B)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFF1F5F9)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2BEE6C).withOpacity(0.2), // primary/20
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock, color: Color(0xFF2BEE6C), size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'For Parents Only',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please solve this to continue accessing settings',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      '2 + 3 = ?',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOption(4),
                      _buildOption(5, isCorrect: true),
                      _buildOption(9),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int value, {bool isCorrect = false}) {
    return GestureDetector(
      onTap: () => _checkAnswer(value),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isCorrect ? const Color(0xFF2BEE6C) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: isCorrect ? const Color(0xFF2BEE6C) : const Color(0xFFF1F5F9),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isCorrect ? const Color(0xFF2BEE6C).withOpacity(0.3) : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          value.toString(),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isCorrect ? const Color(0xFF0F172A) : const Color(0xFF0F172A),
          ),
        ),
      ),
    );
  }
}
