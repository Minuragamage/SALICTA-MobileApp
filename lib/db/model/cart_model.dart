import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/firebase_bloc/model/db_model.dart';

class CartModel extends DBModel {
  DocumentReference userRef;
  DocumentReference itemRef;
  String userId;
  String color;
  Timestamp addedDate;
  int count;
  int price;
  String status;
  ProductModel item;

  CartModel({
    DocumentReference? ref,
    required this.price,
    required this.itemRef,
    required this.color,
    required this.addedDate,
    required this.count,
    required this.userId,
    required this.userRef,
    required this.item,
    required this.status,
  }):super(ref: ref);


  static CartModel fromJson(Map<String, dynamic> data) {
    return CartModel(
      status: data['status'],
      addedDate: data['addedDate'],
      count: data['count'] ?? 0,
      item: ProductModel.fromJson(data['item']),
      itemRef: data['itemRef'],
      userId: data['userId'],
      userRef: data['userRef'],
      price: data['price'] ?? 0,
      color: data['color'],
    );
  }

  Map<String, dynamic>  toJson() {
    return {
      "status": status,
      "addedDate": addedDate,
      "count": count,
      "item": item.toJson(),
      "itemRef": itemRef,
      "userId": userId,
      "userRef": userRef,
      "color": color,
      "price": price,
    };
  }


}
