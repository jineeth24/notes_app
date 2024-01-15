import 'package:isar/isar.dart';

//need to generate note.g.dart file
//by running dart run build_runner build
part 'note.g.dart';

@Collection()
class Note{
  Id id=Isar.autoIncrement;
  late String text;
}