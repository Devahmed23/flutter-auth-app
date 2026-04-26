import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'detail_screen.dart';
import 'login_screen.dart';
import '../widgets/profile_avatar.dart';

class DashboardScreen extends StatelessWidget {
  final AuthController authController;
  const DashboardScreen({super.key, required this.authController});

 static const List<Map<String, String>> subjects = [
  {
    'name': 'Mobile Application Development (BS-SE-8B)',
    'code': 'SE-4308-CS-252-BS-SE-8B',
    'icon': '📱',
    'time': 'Sat  —  13:10 AM to 15:10 PM',
    'instructor': 'Roshana Mughal',
    'description':
        'An in-depth study of cross-platform mobile application development '
        'using the Flutter framework and Dart programming language. Topics include '
        'widget trees, state management, navigation, RESTful API integration, '
        'and publishing apps to the Google Play Store and Apple App Store.',
  },
  {
    'name': 'Software Re-engineering (BS-SE-8B)',
    'code': 'SE-4402-CS-252-BS-SE-8B',
    'icon': '🔧',
    'time': 'Sat  —  08:30 AM to 10:30 AM',
    'instructor': 'Anusha Fahad Iqbal',
    'description':
        'A comprehensive study of methodologies and techniques used to analyze, '
        'restructure, and modernize legacy software systems. Topics include '
        'reverse engineering, refactoring, software quality metrics, code smell '
        'detection, architecture recovery, and migration strategies for outdated systems.',
  },
  {
    'name': 'Management Information System (BS-SE-8B)',
    'code': 'MS-3302-MS-252-BS-SE-8B',
    'icon': '💼',
    'time': 'Wed —  10:30 AM to 12:30 AM',
    'instructor': "Conrad D' Silva",
    'description':
        'An introduction to the role of information systems in modern organizational '
        'management and decision-making. Topics include database management, '
        'enterprise resource planning (ERP), decision support systems, business '
        'intelligence, and the strategic use of technology in business operations.',
  },
  {
    'name': 'Final Year Project - II (BS-SE-8B)',
    'code': 'SE-4002-CS-252-BS-SE-8B',
    'icon': '🎓',
    'time': 'Flexible Schedule — By Supervisor Appointment',
    'instructor': 'Arsal Ahmed',
    'description':
        'The second and final phase of the capstone project where students complete '
        'the implementation, testing, and documentation of their software project. '
        'Emphasis is placed on project delivery, presentation skills, technical '
        'writing, and live demonstration of the developed system to a panel of evaluators.',
  },
  {
    'name': 'Game Programming (BS-SE-8B)',
    'code': 'SE-4310-CS-252-BS-SE-8B',
    'icon': '🎮',
    'time': 'Sat  —  10:30 AM to 12:30 AM',
    'instructor': 'Muhammad Usama Sarfaraz',
    'description':
        'An exploration of the core concepts and techniques used in modern game '
        'development. Topics include game loops, physics engines, collision detection, '
        'sprite animation, input handling, AI for games, and an introduction to '
        'popular game engines. Students will build playable games as part of the coursework.',
  },
];

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E27),
        automaticallyImplyLeading: false,
        title: const Text('Dashboard',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () {
              authController.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      LoginScreen(authController: authController),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1E3A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF4361EE),
                    child: buildProfileAvatar(),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${user?.fullName ?? 'Student'}!',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(user?.email ?? '',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            const Text('My Subjects',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Subjects list
            Expanded(
              child: ListView.separated(
                itemCount: subjects.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailScreen(subject: subject)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1E3A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF2A2E4A)),
                      ),
                      child: Row(
                        children: [
                          Text(subject['icon']!,
                              style: const TextStyle(fontSize: 34)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subject['name']!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(height: 4),
                                Text(subject['code']!,
                                    style:
                                        const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Colors.grey, size: 16),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}