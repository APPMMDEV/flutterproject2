

import 'package:floor/floor.dart';
import 'package:nwayooknowledge/Database/pointDAO.dart';
import 'package:nwayooknowledge/Database/pointTable.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'pointDatabase.g.dart';
@Database(version: 1, entities: [PointData])
abstract class PointDatabase extends FloorDatabase{

  PointDAO get pointDao;
}