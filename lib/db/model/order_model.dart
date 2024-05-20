import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/db/model/order_item.dart';
import 'package:salicta_mobile/firebase_bloc/model/db_model.dart';

class OrderModel extends DBModel {
  String? specialNote;
  Timestamp createdAt;
  Timestamp? updatedAt;
  String createdUserId;
  DocumentReference createdUserRef;
  List<CartModel> orderItems;
  int amount;
  String status;
  String orderId;
  String? paymentMethod;
  String? deliveryMethod;
  Address? deliveryAddress;
  int itemCount;

  OrderModel({
    DocumentReference? ref,
    required this.createdAt,
    required this.status,
    this.specialNote,
    required this.amount,
    required this.createdUserId,
    required this.createdUserRef,
    required this.orderItems,
    required this.orderId,
    required this.itemCount,
    this.updatedAt,
    this.paymentMethod,
    this.deliveryAddress,
    this.deliveryMethod,
  });
}
