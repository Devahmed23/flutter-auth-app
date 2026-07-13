import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../repositories/course_repository.dart';

class CourseController extends ChangeNotifier {
  final CourseRepository _repository;

  CourseController({required CourseRepository repository}) : _repository = repository;

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
      _courses = await _repository.fetchCourses();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Course?> saveCourse(Course course) async {
    _errorMessage = null;
    // create
    if (course.id == null) {
      final tempId = -DateTime.now().millisecondsSinceEpoch;
      final temp = Course(id: tempId, userId: course.userId, title: course.title, body: course.body);
      _courses.insert(0, temp);
      notifyListeners();
      try {
        final created = await _repository.createCourse(course);
        final idx = _courses.indexWhere((c) => c.id == tempId);
        if (idx >= 0) _courses[idx] = created;
        notifyListeners();
        return created;
      } catch (e) {
        _courses.removeWhere((c) => c.id == tempId);
        _errorMessage = e.toString();
        notifyListeners();
        rethrow;
      }
    } else {
      // update optimistic
      final index = _courses.indexWhere((c) => c.id == course.id);
      Course? old;
      if (index >= 0) {
        old = _courses[index];
        _courses[index] = course;
        notifyListeners();
      }
      try {
        final updated = await _repository.updateCourse(course);
        final idx = _courses.indexWhere((c) => c.id == updated.id);
        if (idx >= 0) _courses[idx] = updated;
        notifyListeners();
        return updated;
      } catch (e) {
        if (old != null) {
          final oldId = old.id;
          final idx = _courses.indexWhere((c) => c.id == oldId);
          if (idx >= 0) _courses[idx] = old;
        }
        _errorMessage = e.toString();
        notifyListeners();
        rethrow;
      }
    }
  }

  Future<void> deleteCourse(int id) async {
    _errorMessage = null;
    final index = _courses.indexWhere((c) => c.id == id);
    Course? removed;
    if (index >= 0) {
      removed = _courses.removeAt(index);
      notifyListeners();
    }
    try {
      await _repository.deleteCourse(id);
    } catch (e) {
      if (removed != null) {
        _courses.insert(index >= 0 ? index : 0, removed);
        notifyListeners();
      }
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
