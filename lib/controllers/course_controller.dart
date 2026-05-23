import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../services/course_service.dart';

class CourseController extends ChangeNotifier {
  final CourseService _service;

  CourseController({CourseService? service}) : _service = service ?? CourseService();

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadCourses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _courses = await _service.fetchCourses();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Course?> saveCourse(Course course) async {
    try {
      final saved = course.id == null
          ? await _service.createCourse(course)
          : await _service.updateCourse(course);

      final index = _courses.indexWhere((item) => item.id == saved.id);
      if (index >= 0) {
        _courses[index] = saved;
      } else {
        _courses.insert(0, saved);
      }
      notifyListeners();
      return saved;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteCourse(int id) async {
    await _service.deleteCourse(id);
    _courses.removeWhere((course) => course.id == id);
    notifyListeners();
  }
}
