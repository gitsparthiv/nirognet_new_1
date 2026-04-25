// lib/screens/specialty_doctors_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SpecialtyDoctorsScreen extends StatelessWidget {
  // ✅ 1. This is the "sticky note". The screen demands a name before it opens.
  final String specialtyName;

  const SpecialtyDoctorsScreen({super.key, required this.specialtyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        // ✅ 2. The title changes automatically! (e.g., "Cardiology Doctors")
        title: Text(
          '$specialtyName Doctors',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.manage_search,
              size: 80,
              color: Colors.blue.shade200,
            ),
            const SizedBox(height: 16),
            // ✅ 3. The body updates dynamically too!
            Text(
              'Looking for $specialtyName specialists...',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Later, your backend will load the list of doctors here.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}