import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/screens/cubit/cubit.dart';
import 'package:shop_app/screens/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => categoriesWidgetBuilder(
              ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) => SizedBox(
                height: 10.0,
              ),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length),
    );
  }
}

Widget categoriesWidgetBuilder(DataModel modelCategories) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              modelCategories.image,
            ),
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            modelCategories.name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 15.0),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
