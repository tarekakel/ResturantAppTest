import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app_test/models/resturants_list_model.dart';
import 'package:resturant_app_test/modules/resturants_list/cubit/states.dart';
import 'package:resturant_app_test/shared/components/constans.dart';
import 'package:resturant_app_test/shared/network/end_points.dart';
import 'package:resturant_app_test/shared/network/remote/DioHelper.dart';

class ResturantListCubit extends Cubit<ResturantListStates> {
  ResturantListCubit() : super(ResturantListInitialState());

  static ResturantListCubit get(context) => BlocProvider.of(context);
  List<ResturantModel> resturantModel = [];
  void getResturantData() {
    emit(ResturantListLoadingState());

    DioHelper.getData(
      url: RESTURANT,
      token: token,
    ).then((value) {
      value.data.forEach((element) {
        resturantModel.add(ResturantModel.fromJson(element));
      });

      emit(ResturantListSuccessState(resturantModel));
    }).catchError((error) {
      print(error);
      emit(ResturantListErrorState(error));
    });
  }
}
