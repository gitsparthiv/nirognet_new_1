import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/consultation_service.dart';

class ConsultationModePage extends StatefulWidget {
  final int consultationId;
  final String token;

  const ConsultationModePage({
    super.key,
    required this.consultationId,
    required this.token,
  });

  @override
  State<ConsultationModePage> createState() =>
      _ConsultationModePageState();
}

class _ConsultationModePageState
    extends State<ConsultationModePage> {
  bool isLoading = false;

  Future<void> selectMode(int appointmentTypeId) async {
    setState(() => isLoading = true);

    try {
      print("UPDATING TYPE...");
      print("Consultation ID: ${widget.consultationId}");
      print("Type: $appointmentTypeId");

      final success =
          await ConsultationService.updateConsultationType(
        consultationId: widget.consultationId,
        appointmentTypeId: appointmentTypeId,
        token: widget.token,
      );

      print("UPDATE RESULT: $success");

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              appointmentTypeId == 1
                  ? "Online consultation selected"
                  : "Offline consultation selected",
              style: GoogleFonts.poppins(),
            ),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/main',
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to update consultation type",
              style: GoogleFonts.poppins(),
            ),
          ),
        );
      }
    } catch (e) {
      print("MODE ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Something went wrong",
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Widget buildModeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Consultation Mode",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "Choose how you’d like to consult",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Select your preferred appointment type",
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              buildModeCard(
                icon: Icons.video_call,
                title: "Online Consultation",
                subtitle:
                    "Video/phone consultation from home",
                color: Colors.blueAccent,
                onTap: () => selectMode(1),
              ),

              buildModeCard(
                icon: Icons.local_hospital,
                title: "Offline Consultation",
                subtitle:
                    "Visit hospital/clinic physically",
                color: Colors.green,
                onTap: () => selectMode(2),
              ),

              const Spacer(),

              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}