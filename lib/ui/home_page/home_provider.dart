
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/ui/home_page/home_cubit.dart';
import 'package:salicta_mobile/ui/home_page/views/home_view.dart';

class HomeProvider extends BlocProvider<HomeCubit> {
  HomeProvider({
    Key? key,
  }) : super(
    key: key,
    create: (context) => HomeCubit(context),
    child:   HomeView(),
  );
}
