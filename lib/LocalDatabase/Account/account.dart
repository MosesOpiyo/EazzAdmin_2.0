import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account {
  Account({required this.username, required this.email});

  @HiveField(0)
  String username;

  @HiveField(1)
  String email;
}
