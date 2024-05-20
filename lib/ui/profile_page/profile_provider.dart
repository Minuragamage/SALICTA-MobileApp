import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/ui/profile_page/profile_cubit.dart';
import 'package:salicta_mobile/ui/profile_page/views/profile_view.dart';

class ProfileProvider extends BlocProvider<ProfileCubit> {
  ProfileProvider({
    Key? key,
  }) : super(
          key: key,
          create: (context) => ProfileCubit(context),
          child: ProfileView(),
        );
}
