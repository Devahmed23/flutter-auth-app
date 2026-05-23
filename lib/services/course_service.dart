import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Course>> fetchCourses() async {
    final uri = Uri.parse('$_baseUrl/posts');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map((e) => Course.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Course> createCourse(Course course) async {
    final uri = Uri.parse('$_baseUrl/posts');
    final res = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(course.toJson()));
    if (res.statusCode == 201) {
      return Course.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to create course');
    }
  }

  Future<Course> updateCourse(Course course) async {
    if (course.id == null) throw Exception('Course id is required for update');
    final uri = Uri.parse('$_baseUrl/posts/${course.id}');
    final res = await http.put(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(course.toJson()));
    if (res.statusCode == 200) {
      return Course.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to update course');
    }
  }

  Future<void> deleteCourse(int id) async {
    final uri = Uri.parse('$_baseUrl/posts/$id');
    final res = await http.delete(uri);
    if (res.statusCode == 200) return;
    throw Exception('Failed to delete course');
  }
}
