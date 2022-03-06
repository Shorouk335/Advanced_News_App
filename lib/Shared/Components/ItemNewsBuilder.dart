import 'package:advanced_news_app/LayoutScreens/WebViewLayout.dart';
import 'package:flutter/material.dart';

Widget ItemNewsBuilder(List<dynamic> model, context) {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: model.length,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebViewLayout(url: model[index]["url"]);
          }));
        },
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(30.0)),
                      image: DecorationImage(
                        image: NetworkImage("${model[index]["urlToImage"]}"),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${model[index]["title"]}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                      Text("${model[index]["publishedAt"]}",
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
