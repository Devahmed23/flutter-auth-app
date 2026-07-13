import 'package:hive/hive.dart';
import 'course_model.dart';

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 1;

  @override
  Course read(BinaryReader reader) {
    final id = reader.read() as int?;
    final userId = reader.read() as int?;
    final title = reader.read() as String;
    final body = reader.read() as String;
    return Course(id: id, userId: userId, title: title, body: body);
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer.write(obj.id);
    writer.write(obj.userId);
    writer.write(obj.title);
    writer.write(obj.body);
  }
}
