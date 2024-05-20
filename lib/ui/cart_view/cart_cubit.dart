import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salicta_mobile/ui/cart_view/cart_state.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit(BuildContext context) : super(CartState.initialState);


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
