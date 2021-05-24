abstract class DetailsListStates {}

class DetailsListInitialState extends DetailsListStates {}

class DetailsListLoadingState extends DetailsListStates {}

class DetailsListSuccessState extends DetailsListStates {
  DetailsListSuccessState();
}

class DetailsListErrorState extends DetailsListStates {
  final String error;

  DetailsListErrorState(this.error);
}
