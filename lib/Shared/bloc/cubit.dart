import 'dart:async';
import 'package:advanced_news_app/LayoutScreens/BusinessNews.dart';
import 'package:advanced_news_app/LayoutScreens/ScienceNews.dart';
import 'package:advanced_news_app/LayoutScreens/SportsNews.dart';
import 'package:advanced_news_app/Shared/CachHelper.dart';
import 'package:advanced_news_app/Shared/DioHelper.dart';
import 'package:advanced_news_app/Shared/bloc/status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(initalState());

  static NewsCubit get(context) => BlocProvider.of(context);

  //connection of internet
  String message = '';
  void ChangeMessage(value) {
    message = value;
    emit(changeMessageState());
  }

  StreamSubscription? subscription;
  SimpleConnectionChecker simpleConnectionChecker = SimpleConnectionChecker()
    ..setLookUpAddress('pub.dev');

  //List of appbar title
  List<String> titleAppBar = [
    "Business News",
    "Sports News ",
    "Science News",
  ];
  //List of body in homeLayout
  List Body = [
    BusinessNews(),
    SportsNews(),
    ScienceNews(),
  ];
  //currentIndex of bottomNav
  int CurrentIndex = 0;

  //onChange CurrentIndex
  void change(index) {
    CurrentIndex = index;
    emit(changeCurrentIndexState());
  }

  //List of TypeNewsData and get data of them

  List<dynamic> BusinessList = [];

  void getDataBusiness() {
    emit(LoadBusinessNewsState());
    if (BusinessList.isEmpty) {
      DioHelper.getData(path: "v2/top-headlines", query: {
        "country": 'eg',
        "category": 'business',
        "apiKey": '98d680d1804a4655bd85ca85020adee8',
      }).then((value) {
        BusinessList = value.data["articles"];
        emit(SucessBusinessNewsState());
      }).catchError((onError) {
        emit(ErrorBusinessNewsState(this.onError));
        print(this.onError.toString());
      });
    } else {
      emit(SucessBusinessNewsState());
    }
  }

  List<dynamic> SportsList = [];
  void getDataSports() {
    emit(LoadSportsNewsState());
    if (SportsList.isEmpty) {
      DioHelper.getData(path: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "98d680d1804a4655bd85ca85020adee8",
      }).then((value) {
        SportsList = value.data["articles"];
        emit(SucessSportsNewsState());
      }).catchError((onError) {
        emit(ErrorSportsNewsState(this.onError));
      });
    } else {
      emit(SucessSportsNewsState());
    }
  }

  List<dynamic> ScienceList = [];
  void getDataScience() async {
    emit(LoadScienceNewsState());
    if (ScienceList.isEmpty) {
      DioHelper.getData(path: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "98d680d1804a4655bd85ca85020adee8",
      }).then((value) {
        ScienceList = value.data["articles"];
        emit(SucessScienceNewsState());
      }).catchError((onError) {
        print("reeeeeeeeeeeeeeor222222222222");

        emit(ErrorScienceNewsState(this.onError));
      });
    } else {
      emit(SucessScienceNewsState());
    }
  }

  List<dynamic> SearchList = [];
  var SearchController = TextEditingController();
  void getSearch(key) {
    emit(LoadSearchState());
    DioHelper.getData(path: "v2/everything", query: {
      "q": "$key",
      "from": "=2022-02-06",
      "sortBy": "publishedAt",
      "apiKey": "98d680d1804a4655bd85ca85020adee8",
    }).then((value) {
      SearchList = value.data["articles"];
      emit(SucessSearchState());
    }).catchError((onError) {
      emit(ErrorSearchState(this.onError));
    });
  }

  //ThemeMode
  bool isDark = false;

  void ChangeMode({bool? DataSave}) {
    if (DataSave != null) {
      isDark = DataSave;
      emit(onChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(onChangeModeState());
      });
    }
  }
}
