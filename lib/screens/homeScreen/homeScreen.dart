import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/homeScreen/cubit/cubit.dart';
import 'package:shop_app/screens/homeScreen/cubit/states.dart';
import 'package:shop_app/screens/homeScreen/search/search_screen.dart';
import 'package:shop_app/shared/components.dart';

class HomeScreen extends StatelessWidget {
  static String id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search))
            ],
            title: Text('JUMIA'),
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
                label: 'CATEGORIES',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'FAVORITES',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'SETTINGS',
              ),
            ],
          ),
        );
      },
    );
  }
}
