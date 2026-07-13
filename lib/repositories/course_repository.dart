import 'package:hive/hive.dart';
import '../models/course_model.dart';
import '../services/course_service.dart';

class CourseRepository {
  final CourseService _service;
  final Box<Course> _box;

  CourseRepository(this._service, this._box);

  Future<List<Course>> fetchCourses() async {
    try {
      final remote = await _service.fetchCourses();
      await _saveToLocal(remote);
      return remote;
    } catch (e) {
      // On error, return local cache
      final cached = _box.values.toList();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<Course> createCourse(Course course) async {
    final created = await _service.createCourse(course);
    await _box.put(created.id ?? DateTime.now().millisecondsSinceEpoch, created);
    return created;
  }

  Future<Course> updateCourse(Course course) async {
    final updated = await _service.updateCourse(course);
    await _box.put(updated.id ?? DateTime.now().millisecondsSinceEpoch, updated);
    return updated;
  }

  Future<void> deleteCourse(int id) async {
    await _service.deleteCourse(id);
    await _box.delete(id);
  }

  Future<void> _saveToLocal(List<Course> list) async {
    await _box.clear();
    for (final c in list) {
      await _box.put(c.id ?? DateTime.now().millisecondsSinceEpoch, c);
    }
  }
}
