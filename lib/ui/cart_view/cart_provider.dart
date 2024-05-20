import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/ui/cart_view/cart_cubit.dart';
import 'package:salicta_mobile/ui/cart_view/views/cart_screen.dart';
import 'package:salicta_mobile/ui/home_page/views/favorite_screen.dart';

class CartProvider extends BlocProvider<CartCubit> {
  CartProvider({
    Key? key,
  }) : super(
          key: key,
          create: (context) => CartCubit(context),
          child: const CartScreen(),
        );
}
