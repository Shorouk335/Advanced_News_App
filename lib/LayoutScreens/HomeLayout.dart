import 'package:advanced_news_app/LayoutScreens/SearchLayout.dart';
import 'package:advanced_news_app/Shared/bloc/cubit.dart';
import 'package:advanced_news_app/Shared/bloc/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    NewsCubit.get(context).subscription = NewsCubit.get(context)
        .simpleConnectionChecker
        .onConnectionChange
        .listen((connected) {
      if (connected)
        NewsCubit.get(context).ChangeMessage("Connected");
      else
        NewsCubit.get(context).ChangeMessage("Not connected");
    });
  }

  void dispose() {
    NewsCubit.get(context).subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("${cubit.titleAppBar[cubit.CurrentIndex]}"),
            titleSpacing: 20,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SearchLayout();
                    }));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.ChangeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: (NewsCubit.get(context).message == "Not connected")
              ? Center(
                  child: Text(
                    "Check your Internet Connection",
                    style: TextStyle(color: Colors.red, fontSize: 15.0),
                  ),
                )
              : cubit.Body[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: cubit.CurrentIndex,
            onTap: (index) {
              cubit.change(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text("Business")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports), title: Text("Sports")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science), title: Text("Science")),
            ],
          ),
        );
      },
    );
  }
}
