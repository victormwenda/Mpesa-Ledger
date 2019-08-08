import 'package:sqflite/sqflite.dart';

abstract class BaseRepository {
  Future<Database> get database;
}