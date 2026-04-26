import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, String> subject;
  const DetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E27),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(subject['code'] ?? '',
            style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            Container(
              width: double.infinity,
              height: 210,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4361EE), Color(0xFF7B2FBE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(subject['icon']!,
                      style: const TextStyle(fontSize: 64)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      subject['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('About This Course'),
                  _card(subject['description']!, Icons.info_outline),
                  const SizedBox(height: 20),

                  _label('Class Schedule'),
                  _card(subject['time']!, Icons.schedule),
                  const SizedBox(height: 20),

                  _label('Course Code'),
                  _card(subject['code']!, Icons.tag),
                  const SizedBox(height: 20),

                  _label('Instructor'),
                  _card(subject['instructor'] ?? 'Instructor not assigned', Icons.person),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              color: Color(0xFF4361EE),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2),
        ),
      );

  Widget _card(String content, IconData icon) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1E3A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2E4A)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF4361EE), size: 20),
            const SizedBox(width: 12),
            Expanded(
                child: Text(content,
                    style:
                        const TextStyle(color: Colors.white, height: 1.5))),
          ],
        ),
      );
}