import 'package:hive/hive.dart';

part 'known_fact.g.dart';

@HiveType(typeId: 0)
class KnownFact extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late String fact;
}
