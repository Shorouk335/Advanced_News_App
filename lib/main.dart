import 'package:advanced_news_app/LayoutScreens/HomeLayout.dart';
import 'package:advanced_news_app/Shared/CachHelper.dart';
import 'package:advanced_news_app/Shared/DioHelper.dart';
import 'package:advanced_news_app/Shared/bloc/cubit.dart';
import 'package:advanced_news_app/Shared/bloc/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  bool? isDark = CachHelper.getData(key: "isDark");
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  MyApp({required this.isDark});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          NewsCubit()..ChangeMode(DataSave: isDark),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 23.0,
                ),
                iconTheme: IconThemeData(color: Colors.red),
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                bodyText2: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20.0,
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.grey,
              ),
              backgroundColor: Colors.grey.shade100,
              focusColor: Colors.black,
            ),
            darkTheme: ThemeData(
                focusColor: Colors.white,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 23.0,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.black,
                ),
                scaffoldBackgroundColor: Colors.black,
                backgroundColor: Colors.grey.shade900,
                canvasColor: Colors.black,
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyText2: TextStyle(
                    color: Colors.white54,
                    fontSize: 15,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  elevation: 20.0,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                )),
            themeMode: (NewsCubit.get(context).isDark)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
