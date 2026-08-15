import 'package:hive/hive.dart';

part 'notes.g.dart';

@HiveType(typeId: 0)
class Note{
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  Note({
    required this.title,
    required this.content,
  });
}