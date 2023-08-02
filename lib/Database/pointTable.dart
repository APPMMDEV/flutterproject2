import 'package:floor/floor.dart';

@Entity(tableName: 'points')
class PointData {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name : 'point')
  int? point;


  @ColumnInfo(name : 'timeStamp')
  int? timeStamp;
  PointData(  this.point, this.timeStamp,{this.id});
}
