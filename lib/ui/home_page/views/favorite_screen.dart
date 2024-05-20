import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/widgets/tiles/favorite_list_tile.dart';

import '../../../db/model/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => kOnExitConfirmation(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: kOffBlack,
              size: 20,
            ),
          ),
          title: const Text(
            "FAVORITE",
            style: kMerriweatherBold16,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){

              },
              icon: SvgPicture.asset("assets/icons/cart_icon.svg"),
            )
          ],
        ),
        body: Stack(
          children: [
            BlocBuilder<RootCubit, RootState>(
                buildWhen: (previous, current) =>
                    previous.currentUser != current.currentUser ||
                    previous.products != current.products,
                builder: (context, state) {
                  final current = state.currentUser!.favourites;

                  final products = state.products;

                  List<ProductModel> commonElements = [];

                  for (DocumentReference dr in current) {
                    final a = products!
                        .where((element) => element.ref == dr)
                        .toList();

                    if (a.isNotEmpty) {
                      commonElements.add(a[0]);
                    }
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: commonElements.length,
                    itemBuilder: (context, index) {
                      final product = commonElements[index];

                      return FavoriteListTile(
                        product: product,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 12,
                        thickness: 1,
                        color: kSnowFlakeWhite,
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
