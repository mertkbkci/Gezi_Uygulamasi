import 'package:city_guide_app/items_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(
      {Key? key,
      required this.category,
      required this.username,
      required this.myJsonData})
      : super(key: key);

  final String category;
  final String username;
  final String myJsonData;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonList = jsonDecode(myJsonData);

    return Scaffold(
      appBar: ItemsAppBar(context),
      body: Container(
        color: Colors.teal[50],
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
            bottom: MediaQuery.of(context).size.width * 0.02),
        child: ListView.builder(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02),
          itemCount: jsonList[category].length,
          itemBuilder: (context, index) {
            for (var comment in jsonList[category][index]['comments']) {
              if (int.parse(comment['rating']) >= 4 &&
                  comment['commentatorName'] == username) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jsonList[category][index]['name'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                          ),
                          Divider(
                            color: Colors.teal,
                            thickness: 1,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Image.asset(
                              'assets/' + jsonList[category][index]['imageUrl'],
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                          ),
                          Text(
                            jsonList[category][index]['information'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                          ),
                          Divider(
                            color: Colors.teal,
                          ),
                          Text(
                            'Open Hours: ' +
                                jsonList[category][index]['openHours']
                                    .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                          ),
                          Text(
                            'Price: ' +
                                jsonList[category][index]['price'].toString() +
                                ' TL',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                          ),
                          Divider(
                            color: Colors.teal,
                          ),
                          Center(
                            child: Text(
                              "Comments",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                              child: jsonList[category][index]['comments']
                                      .isEmpty
                                  ? Text("No comment yet...")
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: returnItemCount(
                                          jsonList, category, index),
                                      itemBuilder: (context, findex) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(jsonList[category][index]
                                                    ['comments'][findex]
                                                ['commentatorName']),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(jsonList[category][index]
                                                        ['comments'][findex]
                                                    ['review']),
                                                Row(
                                                  children: [
                                                    Text(jsonList[category]
                                                            [index]['comments']
                                                        [findex]['rating']),
                                                    Icon(
                                                        Icons.star_rate_rounded)
                                                  ],
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              indent: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              endIndent: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            )
                                          ],
                                        );
                                      },
                                    )),
                        ]),
                  ),
                );
              }
            }
            return Text('');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => new ItemsScreen(
                      category: category,
                      myJsonData: myJsonData,
                      username: username,
                    )),
          );
        },
        child: Icon(Icons.arrow_back_rounded),
        backgroundColor: Colors.teal,
      ),
    );
  }

  AppBar ItemsAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Favorite ${category} of $username",
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      actions: [
        IconButton(
            onPressed: () {
              // items with scored more than 4 stars by the user, will be shown
            },
            icon: Icon(Icons.favorite))
      ],
      backgroundColor: Colors.teal,
    );
  }

  int returnItemCount(
      Map<String, dynamic> jsonList, String category, int index) {
    int a = jsonList[category][index]['comments'].length;
    print("findme $a");

    return a;
  }
}
