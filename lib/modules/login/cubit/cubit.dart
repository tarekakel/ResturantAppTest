import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app_test/modules/login/cubit/states.dart';
import 'package:resturant_app_test/shared/network/end_points.dart';
import 'package:resturant_app_test/shared/network/remote/DioHelper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  String loginToken;

  void userLogin({
    @required String phone,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'phone_number': phone,
        'otp': '1234',
      },
    ).then((value) {
      //print(value.data['access_token']);
      emit(LoginSuccessState(value.data['access_token']));
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error));
    });
  }
}
