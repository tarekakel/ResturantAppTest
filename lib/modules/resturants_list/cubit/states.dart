import 'package:resturant_app_test/models/resturants_list_model.dart';

abstract class ResturantListStates {}

class ResturantListInitialState extends ResturantListStates {}

class ResturantListLoadingState extends ResturantListStates {}

class ResturantListSuccessState extends ResturantListStates {
  final List<ResturantModel> resturnatModel;
  ResturantListSuccessState(this.resturnatModel);
}

class ResturantListErrorState extends ResturantListStates {
  final dynamic error;

  ResturantListErrorState(this.error);
}
