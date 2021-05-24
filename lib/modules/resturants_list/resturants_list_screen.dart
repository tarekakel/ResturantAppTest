import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:resturant_app_test/models/resturants_list_model.dart';
import 'package:resturant_app_test/modules/resturants_list/cubit/cubit.dart';
import 'package:resturant_app_test/modules/resturants_list/cubit/states.dart';
import 'package:resturant_app_test/shared/components/components.dart';
import 'package:resturant_app_test/shared/styles/colors.dart';

class RestruantsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) =>
          ResturantListCubit()..getResturantData(),
      child: BlocConsumer<ResturantListCubit, ResturantListStates>(
        listener: (context, state) {
          if (state is ResturantListSuccessState) {
            print(state.resturnatModel);
          }
        },
        builder: (context, state) {
          ResturantListCubit restCubit = ResturantListCubit.get(context);

          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: deviceSize.width * 0.096,
                      top: deviceSize.height * 0.104,
                      bottom: deviceSize.height * 0.027,
                    ),
                    width: deviceSize.width * 0.805,
                    child: Text(
                      "Best New York City restaurants",
                      style: TextStyle(
                        color: text_color,
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceSize.width * 0.096,
                    ),
                    child: Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is ResturantListSuccessState,
                      widgetBuilder: (BuildContext context) => Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            height: 1800,
                            width: deviceSize.width * 0.805,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: restCubit.resturantModel.length,
                              itemBuilder: (context, index) {
                                return builderWidget(restCubit.resturantModel,
                                    index, deviceSize, context);
                              },
                            ),
                          ),
                        ],
                      ),
                      fallbackBuilder: (BuildContext context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget builderWidget(List<ResturantModel> model, index, deviceSize, context) =>
    Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 20, left: 11, right: 11),
            height: deviceSize.height * 0.372,
            width: deviceSize.width * 0.805,
            child: CarouselSlider(
              items: model[index]
                  .images
                  .map(
                    (e) => Image(
                      image: NetworkImage(e),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: deviceSize.width * 0.325,
                  child: Text(
                    model[index].name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  width: deviceSize.width * 0.325,
                  child: Text(
                    model[index].cuisine,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                buildRatePart(
                  model: model,
                  index: index,
                  context: context,
                )
              ],
            ),
          ),
        ],
      ),
    );
