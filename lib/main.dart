import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/auth_controller.dart';
import 'screens/login_screen.dart';
import 'models/course_hive_adapter.dart';
import 'models/course_model.dart';
import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'controllers/course_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  final box = await Hive.openBox<Course>('courses');

  final courseService = CourseService();
  final courseRepo = CourseRepository(courseService, box);
  final courseController = CourseController(repository: courseRepo);
  final authController = AuthController();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: authController),
      ChangeNotifierProvider.value(value: courseController),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Auth Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4361EE),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(authController: Provider.of<AuthController>(context, listen: false)),
    );
  }
}