import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/db/model/category_model.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/widgets/buttons/category_button.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({super.key});

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  List<CategoryModel> categoryList = [
    CategoryModel(name: 'All', key: 'all', image: 'assets/icons/popular_icon.svg'),
    CategoryModel(name: 'Chair', key: 'chair', image: 'assets/icons/chair_icon.svg'),
    CategoryModel(name: 'Table', key: 'table', image: 'assets/icons/table_icon.svg'),
    CategoryModel(name: 'Sofa', key: 'sofa', image: 'assets/icons/armchair_icon.svg'),
    CategoryModel(name: 'Bed', key: 'bed', image: 'assets/icons/bed_icon.svg'),
    CategoryModel(name: 'Lamp', key: 'lamp', image: 'assets/icons/lamp_icon.svg'),

  ];

  @override
  Widget build(BuildContext context) {

    final rootCubit=BlocProvider.of<RootCubit>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categoryList.length; i++)
            BlocBuilder<RootCubit, RootState>(
                buildWhen: (previous, current) =>
                previous.selectedCategory != current.selectedCategory,
              builder: (context, snapshot) {
                return CategoryButton(
                  name: categoryList[i].name,
                  iconPath: categoryList[i].image,
                  isSelected: snapshot.selectedCategory==categoryList[i].key,
                  onTap: () {
                    rootCubit.changeSelectedCategory(categoryList[i].key);
                  },
                );
              }
            )
        ],
      ),
    );
  }
}
