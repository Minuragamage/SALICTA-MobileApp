import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  String itemName;
  DocumentReference itemRef;
  String itemId;
  String? description;
  double price;
  int count;
  double discount;
  String color;
  String itemCode;

  OrderItem({
    required this.itemName,
    required this.itemRef,
    required this.itemId,
    this.description,
    required this.price,
    required this.count,
    required this.discount,
    required this.color,
    required this.itemCode,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemName: json['itemName'],
      itemRef: json['itemRef'],
      itemId: json['itemId'],
      description: json['description'],
      price: json['price'],
      count: json['count'],
      discount: json['discount'],
      color: json['color'],
      itemCode: json['itemCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "itemName": itemName,
      "itemRef": itemRef,
      "itemId": itemId,
      "description": description,
      "price": price,
      "count": count,
      "discount": discount,
      "color": color,
      "itemCode": itemCode
    };
  }
}
