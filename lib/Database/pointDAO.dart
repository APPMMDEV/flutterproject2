
import 'package:floor/floor.dart';
import 'package:nwayooknowledge/Database/pointTable.dart';

@dao
abstract class PointDAO{


  @Query('select * from points')
  Stream<List<PointData>> getAllPoints();

  @insert
  Future<void> addPoint (PointData pointData);

  @delete
  Future<void> deletePoint (PointData pointData);

  @update
  Future<void> updatePoint (PointData pointData);

@update
  Future<void> DeleteAll (List<PointData> pointList);

}