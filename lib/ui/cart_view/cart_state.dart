import 'package:flutter/material.dart';

@immutable
class CartState {
  final String error;


  CartState({
    required this.error,
  });

  CartState clone({
    String? error,
  }) {
    return CartState(
      error: error ?? this.error,

    );
  }

  static CartState get initialState => CartState(
    error: "",
  );
}
