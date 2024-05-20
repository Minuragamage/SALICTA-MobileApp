import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireStorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salicta_mobile/db/authentication.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/db/model/customer_model.dart';
import 'package:salicta_mobile/db/model/notification_model.dart';
import 'package:salicta_mobile/db/model/order_model.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/db/model/review.dart';
import 'package:salicta_mobile/db/repository/cart_repository.dart';
import 'package:salicta_mobile/db/repository/customer_repository.dart';
import 'package:salicta_mobile/db/repository/notification_repository.dart';
import 'package:salicta_mobile/db/repository/order_repository.dart';
import 'package:salicta_mobile/db/repository/product_repository.dart';
import 'package:salicta_mobile/firebase_bloc/spec/multi_query_transformer.dart';
import 'package:salicta_mobile/firebase_bloc/spec/query_transformer_utils.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:uuid/uuid.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit(BuildContext context) : super(RootState.initialState);

  final _userRepository = CustomerRepository();
  final _notificationRepository = NotificationRepository();
  final _productsRepository = ProductRepository();
  final _cartRepository = CartRepository();
  final _orderRepository = OrderRepository();

  final auth = Authentication();

  void _getUsersByEmail(final String email) {
    _userRepository.query(spec: ComplexWhere('email', isEqualTo: email)).listen(
      (users) {
        users.isNotEmpty ? _changeCurrentUser(users.first) : null;
      },
    );
  }

  void handleUserLogged(String email) {
    if (state.userLogged) {
      return;
    }
    emit(state.clone(userLogged: true));
    _getUsersByEmail(email);
  }

  bool isUserAvailable() {
    if (state.currentUser == null) {
      return false;
    }
    return true;
  }

  _changeCurrentUser(CustomerModel user) {
    log(user.toString(), name: "ROOT_BLOC");
    emit(
      state.clone(
        currentUser: user,
      ),
    );

    /// other methods call here
    _getNotifications(user);
    _getAllCartItems(user);
    _getAllOrders(user);
    _getProductsList();
  }

  updateUserName(String name) async {
    await _userRepository.update(
      item: state.currentUser!,
      mapper: (_) => {
        'name': name,
      },
    );
  }

  addShippingAddress(Address address) {
    emit(state.clone(shippingAddress: [address]));
  }

  updateUserAddress(String address) async {
    await _userRepository.update(
      item: state.currentUser!,
      mapper: (_) => {
        'name': address,
      },
    );
  }

  _getNotifications(CustomerModel user) {
    _notificationRepository
        .query(spec: ComplexWhere('targetUserRef', isEqualTo: user.ref))
        .listen(
      (event) {
        event.isNotEmpty
            ? _changeNotifications(
                event.toList(growable: false),
              )
            : null;
      },
    );
  }

  readNotification(NotificationModel notificationModel) async {
    if (!notificationModel.isRead) {
      await _notificationRepository.update(
        item: notificationModel,
        mapper: (_) => {
          'isRead': true,
        },
      );
    }
  }

  addReview(String review, int rate, ProductModel productModel) async {
    if (review.isNotEmpty) {
      emit(state.clone(addReviewStatus: 0));

      final current = List<Review>.from(productModel.reviews).toList();
      int currentRate = productModel.rating;

      currentRate = currentRate + rate;

      final rev = Review(
        review: review,
        userId: state.currentUser!.ref!.id,
        userName: state.currentUser!.name!,
        rate: rate,
        userRef: state.currentUser!.ref!,
        addedDate: Timestamp.now(),
      );

      current.add(rev);

      emit(state.clone(addReviewStatus: 1));

      await _productsRepository.update(
        item: productModel,
        mapper: (_) => {
          'reviews': current.map((e) => e.toJson()),
          'rating': currentRate,
        },
      );
      emit(state.clone(addReviewStatus: 2));
    }
  }

  _changeNotifications(List<NotificationModel> data) {
    data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(state.clone(notifications: data));
  }

  _getProductsList() {
    _productsRepository.query(spec: MultiQueryTransformer([])).listen(
      (event) {
        _changeProductsList(
          event.toList(growable: false),
        );
      },
    );
  }

  _changeProductsList(List<ProductModel> data) {
    emit(state.clone(products: data));
    changeSelectedCategory('all');
  }

  changeSelectedCategory(String cat) {
    emit(
      state.clone(selectedCategory: cat),
    );

    final clone = List<ProductModel>.from(state.products ?? []);

    final data = clone
        .where((element) => element.category == state.selectedCategory)
        .toList();

    if (state.selectedCategory == "all") {
      emit(state.clone(selectedProducts: clone));
    } else {
      emit(state.clone(selectedProducts: data));
    }
  }

  updateProfileImage(XFile imgFile) async {
    emit(state.clone(isImageAdding: true));

    final image = imgFile.path;

    final fileType = image.split('.').last;

    final storagePath =
        'ProfileImages/${state.currentUser} ${DateTime.now().toString()}.$fileType';

    final storageRef =
        fireStorage.FirebaseStorage.instance.ref().child(storagePath);

    fireStorage.TaskSnapshot uploadTask = await storageRef.putFile(File(image));

    if (uploadTask.state == fireStorage.TaskState.error ||
        uploadTask.state == fireStorage.TaskState.canceled) {
      emit(state.clone(isImageAdding: false));
      return;
    }

    final downloadUrl = await uploadTask.ref.getDownloadURL();

    if (state.currentUser != null) {
      await _userRepository.update(
        item: state.currentUser!,
        mapper: (_) => {
          'profileImage': downloadUrl,
        },
      );
    }

    emit(state.clone(isImageAdding: false));
  }

  Future<void> handleUserLoggedOut() async {
    await auth.logout();
    emit(RootState.initialState);
  }

  /// Cart Related Methods ///

  _getAllCartItems(CustomerModel user) {
    _cartRepository
        .query(spec: ComplexWhere('userRef', isEqualTo: user.ref))
        .listen((event) {
      _changeCartItems(event.toList(growable: false));
    });
  }

  _changeCartItems(List<CartModel> data) {
    emit(state.clone(cartItems: data));
  }

  addToCart(CartModel data) async {
    emit(state.clone(addToCartStatus: 0));
    try {
      emit(state.clone(addToCartStatus: 1));

      final isExist =
          state.cartItems.where((element) => data.itemRef == element.itemRef);

      if (isExist.isNotEmpty) {
        emit(state.clone(addToCartStatus: 3));
        return;
      }

      await _cartRepository.add(item: data);
      emit(state.clone(addToCartStatus: 2));
    } catch (e) {
      emit(state.clone(addToCartStatus: 0));
    }
    emit(state.clone(addToCartStatus: 0));
  }

  removeFromCart(CartModel data) async {
    await _cartRepository.remove(item: data);
  }

  increaseItemCount(CartModel data) async {
    emit(state.clone(stockExceeded: false));

    final current = data.count;
    final updated = current + 1;

    final prod = state.products!
        .where((element) => element.ref == data.itemRef)
        .toList();

    if (prod.isNotEmpty) {
      final product = prod.first;

      if (updated > product.stock) {
        emit(state.clone(stockExceeded: true));
        return;
      }

      final price = updated * data.item.price;
      await _cartRepository.update(
        item: data,
        mapper: (_) => {
          'count': updated,
          "price": price,
        },
      );
    }
  }

  decreaseItemCount(CartModel data) async {
    final current = data.count;
    if (current > 1) {
      final updated = current - 1;
      final price = updated * data.item.price;
      await _cartRepository.update(
        item: data,
        mapper: (_) => {
          'count': updated,
          "price": price,
        },
      );
    }
  }

  addToFavourite(DocumentReference reference) async {
    if (state.currentUser != null) {
      final current =
          List<DocumentReference>.from(state.currentUser!.favourites).toList();

      final isExist = current.where((element) => element == reference).toList();

      if (isExist.isEmpty) {
        current.add(reference);
      } else {
        current.remove(reference);
      }

      log('DATA > ${isExist} ${reference} ${current.toString()}');

      await _userRepository.update(
        item: state.currentUser!,
        mapper: (_) => {
          'favourites': current,
        },
      );
    }
  }

  /// Item Purchase Related Methods ///

  createOrder({
    required int itemCount,
    required int price,
    required List<CartModel> items,
  }) async {
    const uuid = Uuid();

    emit(state.clone(addOrderStatus: 0));

    if (state.shippingAddress.isEmpty) {
      emit(state.clone(addOrderStatus: 4));
      return;
    }

    final orderId = uuid.v4();
    final item = OrderModel(
      createdAt: Timestamp.now(),
      status: 'pending',
      amount: price,
      createdUserId: state.currentUser!.ref!.id,
      createdUserRef: state.currentUser!.ref!,
      itemCount: itemCount,
      orderId: orderId,
      orderItems: items,
      deliveryAddress: state.currentUser!.address[0],
      deliveryMethod: 'Fast Shipping',
      paymentMethod: 'Cash',
      specialNote: '',
      updatedAt: Timestamp.now(),
    );

    final notification = NotificationModel(
      title: 'New Order Added',
      createdAt: Timestamp.now(),
      type: 'order',
      isRead: false,
      targetUserId: state.currentUser!.ref!.id,
      targetUserRef: state.currentUser!.ref!,
      description:
          'Your order $orderId has been placed!. Thanks for your order! We`ll keep you updated.',
    );

    try {
      emit(state.clone(addOrderStatus: 1));

      await _orderRepository.add(item: item);
      await _notificationRepository.add(item: notification);

      await Future.forEach<CartModel>(item.orderItems, (item) async {
        await _cartRepository.remove(item: item);
      });

      emit(state.clone(addOrderStatus: 2, shippingAddress: []));
    } catch (e) {
      log(
        e.toString(),
      );
      emit(state.clone(addOrderStatus: 0));
    }
  }

  _getAllOrders(CustomerModel user) {
    _orderRepository
        .query(spec: ComplexWhere('createdUserRef', isEqualTo: user.ref))
        .listen((event) {
      _changeOrders(event.toList(growable: false));
    });
  }

  _changeOrders(List<OrderModel> list) {
    emit(state.clone(orderItems: list));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    _addErr(error);
    super.onError(error, stackTrace);
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      errorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      );
    } catch (e) {
      errorEvent("Something went wrong. Please try again !");
    }
  }

  void errorEvent(String error) {
    emit(state.clone(error: ''));
    emit(state.clone(error: error));
  }
}
