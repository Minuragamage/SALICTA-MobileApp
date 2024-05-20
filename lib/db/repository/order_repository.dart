import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/set_options.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/db/model/order_item.dart';
import 'package:salicta_mobile/db/model/order_model.dart';
import 'package:salicta_mobile/firebase_bloc/repo/firebase_repository.dart';
import '../model/customer_model.dart';

class OrderRepository extends FirebaseRepository<OrderModel> {
  OrderRepository() : super("Orders");

  @override
  OrderModel fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return OrderModel(
      ref: snapshot.reference,
      specialNote: data['specialNote'] ?? '',
      amount: data['amount'],
      orderId: data['orderId'],
      createdAt: data['createdAt'],
      createdUserId: data['createdUserId'],
      createdUserRef: data['createdUserRef'],
      itemCount: data['itemCount'],
      orderItems: List<Map<String, dynamic>>.from(data['orderItems'] ?? [])
          .map<CartModel>((e) => CartModel.fromJson(e))
          .toList(growable: false),
      status: data['status'] ?? 'pending',
      updatedAt: data['updatedAt'],
    );
  }

  @override
  Map<String, Object?> toMap(OrderModel value, SetOptions? options) {
    return {
      'specialNote': value.specialNote,
      'amount': value.amount,
      'orderId': value.orderId,
      'createdAt': value.createdAt,
      'createdUserId': value.createdUserId,
      'createdUserRef': value.createdUserRef,
      'status': value.status,
      'itemCount': value.itemCount,
      'orderItems': value.orderItems.map((e) => e.toJson()),
      'updatedAt': value.updatedAt,
    };
  }
}
