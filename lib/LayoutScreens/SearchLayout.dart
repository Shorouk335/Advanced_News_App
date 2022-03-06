import 'package:advanced_news_app/Shared/Components/ItemNewsBuilder.dart';
import 'package:advanced_news_app/Shared/bloc/cubit.dart';
import 'package:advanced_news_app/Shared/bloc/status.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: NewsCubit.get(context).SearchController,
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                      cursorColor: Theme.of(context).focusColor,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: 20.0,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).focusColor,
                          size: 25,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).focusColor),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).focusColor),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        labelText: "Search",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: (NewsCubit.get(context).message == 'Not connected')
                        ? Center(
                            child: Text(
                              "Check your Internet Connection",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 15.0),
                            ),
                          )
                        : ConditionalBuilder(
                            condition:
                                NewsCubit.get(context).SearchList.isEmpty,
                            builder: (context) => SizedBox(),
                            fallback: (context) => ItemNewsBuilder(
                                NewsCubit.get(context).SearchList, context),
                          ),
                  ),
                ]),
          );
        });
  }
}
