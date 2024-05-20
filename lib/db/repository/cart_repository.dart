import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/set_options.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/db/model/order_item.dart';
import 'package:salicta_mobile/db/model/order_model.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/firebase_bloc/repo/firebase_repository.dart';
import '../model/customer_model.dart';

class CartRepository extends FirebaseRepository<CartModel> {
  CartRepository() : super("CartItems");

  @override
  CartModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return CartModel(
      ref: snapshot.reference,
      addedDate: data['addedDate'],
      itemRef: data['itemRef'],
      color: data['color'],
      item: ProductModel.fromJson(data['item']),
      userRef: data['userRef'],
      userId: data['userId'],
      count: data['count'],
      price: data['price'],
      status: data['status'],
    );
  }

  @override
  Map<String, Object?> toMap(CartModel value, SetOptions? options) {
    return {
      'addedDate': value.addedDate,
      'itemRef': value.itemRef,
      'color': value.color,
      'item': value.item.toJson(),
      'userRef': value.userRef,
      'price': value.price,
      'userId': value.userId,
      'count': value.count,
      'status': value.status,
    };
  }
}
