import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resturant_app_test/models/detail_list.dart';
import 'package:resturant_app_test/models/resturants_list_model.dart';
import 'package:resturant_app_test/modules/details/cubit/cubit.dart';
import 'package:resturant_app_test/modules/details/cubit/states.dart';
import 'package:resturant_app_test/shared/components/components.dart';
import 'package:resturant_app_test/shared/styles/colors.dart';

class DetailsScreen extends StatelessWidget {
  final ResturantModel resturantModel;
  //final String id;
  const DetailsScreen({@required this.resturantModel});
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) =>
          DetailsListCubit()..getDetailsData(resturantModel.id),
      child: BlocConsumer<DetailsListCubit, DetailsListStates>(
        listener: (context, state) {
          if (state is DetailsListSuccessState) {
            // print(state.resturnatModel);
          }
        },
        builder: (context, state) {
          DetailsListCubit detailCubit = DetailsListCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              centerTitle: false,
              toolbarHeight: deviceSize.height * 0.159,
              title: Transform(
                transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        resturantModel.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 23),
                      ),
                    ),
                    buildRatePartWidget(
                      resturantModel,
                      deviceSize,
                      context,
                    ),
                  ],
                ),
              ),
              leadingWidth: 50,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceSize.width * 0.096,
                    ),
                    child: Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is DetailsListSuccessState,
                      widgetBuilder: (BuildContext context) => Column(
                        children: [
                          Container(
                            width: deviceSize.width * 0.864,
                            height: deviceSize.height * 0.29,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: detailCubit.detailsModel.length,
                              itemBuilder: (context, index) {
                                return buildDetailWidget(
                                    detailCubit.detailsModel,
                                    index,
                                    deviceSize);
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

Widget buildRatePartWidget(model, deviceSize, context) => Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: deviceSize.width * 0.325,
            child: Text(
              model.cuisine,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Row(
            children: [
              RatingBar.builder(
                initialRating: double.tryParse(model.rate.toString()) ?? 0,
                minRating: 1,
                updateOnDrag: false,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 19,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                  child: Icon(
                    Icons.circle,
                    color: secondary_color,
                  ),
                ),
                onRatingUpdate: (rating) {},
              ),
              Spacer(),
              defaultTextButton(
                function: () {},
                text: 'Open Now',
                textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: primary_color,
                ),
              ),
            ],
          ),
        ],
      ),
    );

Widget buildDetailWidget(List<Details> model, index, Size deviceSize) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 25,
          ),
          child: Text(
            model[index].menu,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: Color(0xFF6A6A6A),
            ),
          ),
        ),
        Container(
          height: deviceSize.height * 0.269,
          width: deviceSize.width * 0.864,
          child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.separated(
                itemCount: model[index].items.length,
                itemBuilder: (context, i) => Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 75,
                        child: Image.network(
                          model[index].items[i].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: ListTile(
                          title: Text(
                            model[index].items[i].name,
                          ),
                          subtitle: Text(
                            model[index].items[i].price,
                            style: TextStyle(
                              color: primary_color,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primary_color, width: 1),
                        ),
                        onPressed: () {},
                        child: Text(
                          '+Add',
                          style: TextStyle(
                            color: primary_color,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    customDivider(),
              )),
        ),
      ],
    );
