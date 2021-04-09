import 'package:hive/hive.dart';

part 'product.g.dart';
@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  String itemName;
  @HiveField(1)
  String barCode;
  @HiveField(2)
  String bcType;
  
  Product(this.itemName, this.barCode, this.bcType);
}
