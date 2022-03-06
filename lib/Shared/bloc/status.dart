abstract class NewsState {}

class initalState extends NewsState {}

class changeCurrentIndexState extends NewsState {}

class changeMessageState extends NewsState {}

class LoadBusinessNewsState extends NewsState {}

class SucessBusinessNewsState extends NewsState {}

class ErrorBusinessNewsState extends NewsState {
  var error;
  ErrorBusinessNewsState(this.error);
}

class LoadSportsNewsState extends NewsState {}

class SucessSportsNewsState extends NewsState {}

class ErrorSportsNewsState extends NewsState {
  var error;
  ErrorSportsNewsState(this.error);
}

class LoadScienceNewsState extends NewsState {}

class SucessScienceNewsState extends NewsState {}

class ErrorScienceNewsState extends NewsState {
  var error;
  ErrorScienceNewsState(this.error);
}

class LoadSearchState extends NewsState {}

class SucessSearchState extends NewsState {}

class ErrorSearchState extends NewsState {
  var error;
  ErrorSearchState(this.error);
}

class onChangeModeState extends NewsState {}
