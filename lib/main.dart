import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app_test/modules/login/login_screen.dart';
import 'package:resturant_app_test/modules/resturants_list/resturants_list_screen.dart';
import 'package:resturant_app_test/shared/bloc_observer.dart';
import 'package:resturant_app_test/shared/components/constans.dart';
import 'package:resturant_app_test/shared/network/local/cache_helper.dart';
import 'package:resturant_app_test/shared/network/remote/DioHelper.dart';
import 'package:resturant_app_test/shared/styles/thems.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  token = CacheHelper.getData(key: 'token');
  if (token != null)
    widget = RestruantsListScreen();
  else
    widget = LoginScreen();
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resturant Test App',
      theme: lightTheme,
      home: startWidget,
    );
  }
}
