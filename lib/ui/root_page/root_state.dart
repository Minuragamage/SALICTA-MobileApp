import 'package:flutter/material.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/db/model/customer_model.dart';
import 'package:salicta_mobile/db/model/notification_model.dart';
import 'package:salicta_mobile/db/model/order_model.dart';
import 'package:salicta_mobile/db/model/product_model.dart';

@immutable
class RootState {
  final bool initialized;
  final CustomerModel? currentUser;
  final bool userLogged;
  final bool isProcessing;
  final bool isImageAdding;
  final List<NotificationModel> notifications;
  final List<ProductModel>? products;
  final List<ProductModel> selectedProducts;
  final List<CartModel> cartItems;
  final List<OrderModel> orderItems;
  final List<Address> shippingAddress;
  final String selectedCategory;
  final int addToCartStatus;
  final int addReviewStatus;
  final int addOrderStatus;
  final String error;
  final bool stockExceeded;

  const RootState({
    required this.initialized,
    this.currentUser,
    required this.userLogged,
    required this.isProcessing,
    required this.isImageAdding,
    required this.notifications,
    required this.selectedCategory,
    this.products,
    required this.selectedProducts,
    required this.cartItems,
    required this.addToCartStatus,
    required this.addOrderStatus,
    required this.error,
    required this.orderItems,
    required this.shippingAddress,
    required this.stockExceeded,
    required this.addReviewStatus,
  });

  static RootState get initialState => const RootState(
        initialized: false,
        currentUser: null,
        userLogged: false,
        isProcessing: false,
        isImageAdding: false,
        notifications: [],
        products: null,
        selectedCategory: 'all',
        selectedProducts: [],
        cartItems: [],
        orderItems: [],
        shippingAddress: [],
        addToCartStatus: 0,
        addOrderStatus: 0,
        addReviewStatus: 0,
        error: "",
        stockExceeded: false,
      );

  RootState clone({
    bool? initialized,
    CustomerModel? currentUser,
    bool? userLogged,
    bool? isProcessing,
    bool? isImageAdding,
    List<NotificationModel>? notifications,
    List<ProductModel>? products,
    List<ProductModel>? selectedProducts,
    List<OrderModel>? orderItems,
    List<Address>? shippingAddress,
    String? selectedCategory,
    String? error,
    List<CartModel>? cartItems,
    int? addToCartStatus,
    int? addOrderStatus,
    int? addReviewStatus,
    bool? stockExceeded,
  }) {
    return RootState(
      initialized: initialized ?? this.initialized,
      currentUser: currentUser ?? this.currentUser,
      userLogged: userLogged ?? this.userLogged,
      isProcessing: isProcessing ?? this.isProcessing,
      isImageAdding: isImageAdding ?? this.isImageAdding,
      notifications: notifications ?? this.notifications,
      products: products ?? this.products,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      cartItems: cartItems ?? this.cartItems,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      addOrderStatus: addOrderStatus ?? this.addOrderStatus,
      orderItems: orderItems ?? this.orderItems,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      stockExceeded: stockExceeded ?? this.stockExceeded,
      addReviewStatus: addReviewStatus ?? this.addReviewStatus,
      error: error ?? this.error,
    );
  }
}
