import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ CHANGED: Converted to StatelessWidget
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // ❌ REMOVED: _selectedIndex state and _onItemTapped method

  @override
  Widget build(BuildContext context) {
    // ✅ KEPT: Scaffold and AppBar remain, as this is a separate page
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3ECFCF), // Consider using Theme primaryColor
        title: Text(
          'Profile',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600, color: Colors.white), // Added white color for better contrast
        ),
        leading: IconButton( // Added a back button
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),

      // BODY remains the same
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Language selection ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                DropdownButton<String>(
                  value: 'English', // Consider making this dynamic
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'हिन्दी', child: Text('हिन्दी')),
                    DropdownMenuItem(value: 'বাংলা', child: Text('বাংলা')),
                    DropdownMenuItem(value: 'ગુજરાતી', child: Text('ગુજરાતી')),
                  ],
                  onChanged: (value) {
                    // TODO: Implement language change logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Basic Info ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Basic Info',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                     // TODO: Implement edit basic info logic
                  },
                  icon: const Icon(Icons.edit, color: Colors.black54),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F9F9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [ // Consider making these dynamic
                  Text('Name: Guest'),
                  Text('Age: 25'),
                  Text('Gender: Female'),
                  Text('Contact: +91 9876543210'),
                  Text('Email: guest@example.com'),
                  Text('Address: Kolkata, West Bengal, India'),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- Health Info ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Health Info',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                     // TODO: Implement edit health info logic
                  },
                  icon: const Icon(Icons.edit, color: Colors.black54),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F9F9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [ // Consider making these dynamic
                  Text('Blood Group: B+'),
                  Text('Blood Pressure: 120/80 mmHg'),
                ],
              ),
            ),
          ],
        ),
      ),

      // ❌ REMOVED: The entire bottomNavigationBar section
    );
  }
}