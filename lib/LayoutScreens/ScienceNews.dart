import 'package:advanced_news_app/Shared/Components/ItemNewsBuilder.dart';
import 'package:advanced_news_app/Shared/bloc/cubit.dart';
import 'package:advanced_news_app/Shared/bloc/status.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context)..getDataScience();
        return ConditionalBuilder(
          condition: cubit.ScienceList.isEmpty,
          builder: (context) => Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          )),
          fallback: (context) => ItemNewsBuilder(cubit.ScienceList, context),
        );
      },
    );
  }
}
