import 'package:flutter/material.dart';
import '../controllers/course_controller.dart';
import '../models/course_model.dart';

class CourseFormScreen extends StatefulWidget {
  final Course? course;
  final CourseController controller;
  const CourseFormScreen({super.key, required this.controller, this.course});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _titleCtrl.text = widget.course!.title;
      _bodyCtrl.text = widget.course!.body;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      final saved = await widget.controller.saveCourse(
        Course(
          id: widget.course?.id,
          userId: widget.course?.userId ?? 1,
          title: _titleCtrl.text.trim(),
          body: _bodyCtrl.text.trim(),
        ),
      );
      if (!mounted) return;
      Navigator.pop(context, saved);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.course != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Course' : 'Add Course')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Course name required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bodyCtrl,
                decoration: const InputDecoration(labelText: 'Course Description'),
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Course description required' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving ? const CircularProgressIndicator() : Text(isEdit ? 'Update' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
