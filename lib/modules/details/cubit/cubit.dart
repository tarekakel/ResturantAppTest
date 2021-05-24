import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app_test/models/detail_list.dart';
import 'package:resturant_app_test/modules/details/cubit/states.dart';
import 'package:resturant_app_test/shared/components/constans.dart';
import 'package:resturant_app_test/shared/network/end_points.dart';
import 'package:resturant_app_test/shared/network/remote/DioHelper.dart';

class DetailsListCubit extends Cubit<DetailsListStates> {
  DetailsListCubit() : super(DetailsListInitialState());
  List<Details> detailsModel = [];

  static DetailsListCubit get(context) => BlocProvider.of(context);
  void getDetailsData(int id) {
    emit(DetailsListLoadingState());

    DioHelper.getData(
      url: MENU + '$id',
      token: token,
    ).then((value) {
      // print(value.data);
      value.data.forEach((element) {
        detailsModel.add(Details.fromJson(element));
      });

      emit(DetailsListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DetailsListErrorState(error));
    });
  }
}
