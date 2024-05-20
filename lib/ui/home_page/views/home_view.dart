import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/home_page/views/favorite_screen.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/context_extension.dart';
import 'package:salicta_mobile/util/widgets/tabbed/category_tab_bar.dart';
import 'package:salicta_mobile/util/widgets/tiles/product_grid_tile.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => kOnExitConfirmation(),
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     showSearch(context: context, delegate: ProductSearchDelegate());
          //   },
          //   icon: SvgPicture.asset(
          //     'assets/icons/search_icon_grey.svg',
          //   ),
          // ),
          title: Column(
            children: [
              Text(
                'Make Home',
                style: kGelasio18.copyWith(color: kTinGrey, fontSize: 20),
              ),
              Text(
                'BEAUTIFUL',
                style: kGelasio18.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kOffBlack,
                    fontSize: 24),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/icons/favorite_selected_icon.svg',
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            const CategoryTabBar(),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<RootCubit, RootState>(
                  buildWhen: (previous, current) =>
                      previous.products != current.products || previous.selectedProducts!=current.selectedProducts,
                  builder: (context, state) {
                    if (state.products == null) {
                      return Column(
                        children: [
                          SizedBox(height: context.dynamicHeight(0.25),),
                          loadingCircularWidget,
                        ],
                      );
                    }

                    if (state.selectedProducts.isEmpty) {
                      return const Text("Empty");
                    }

                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 18,
                      ),
                      children: List.generate(
                        state.selectedProducts.length,
                        (index) {
                          final product = state.selectedProducts[index];
                          return ProductGridTile(
                            product: product,
                            heroMode: true,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
