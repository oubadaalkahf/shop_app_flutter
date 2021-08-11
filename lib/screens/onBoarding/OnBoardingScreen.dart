import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/screens/Login/LoginScreen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  static String id = "OnBoardingScreen";
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/image1.png',
        title: 'on Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/image2.png',
        title: 'on Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/image3.png',
        title: 'on Board 3 Title',
        body: 'On Board 3 body'),
  ];
  bool isLast = false;
  void submit() {
    print('hiilooo');
    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
      print(CacheHelper.getData(key: 'onboarding'));
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: submit, child: Text('SKIP')),
          ],
          title: Text('Shop App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(height: 150.0),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      activeDotColor: defaultColor,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_outlined),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('${model.image}')),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );
}
