import 'dart:collection';
import 'package:city_guide_app/categories_screen.dart';
import 'package:city_guide_app/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen(
      {Key? key,
      required this.category,
      required this.myJsonData,
      required this.username})
      : super(key: key);

  final String category;
  final String myJsonData;
  final String username;

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final commentController = TextEditingController();

  String _selectedValue = 'Please choose a rating';

  Future<void> saveJsonToSP(String newJsonData) async {
    var sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('myJsonData', newJsonData);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonList = jsonDecode(widget.myJsonData);

    void updateComments(String newJsonData) {
      setState(() {
        jsonList = jsonDecode(newJsonData);
      });
    }

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
          itemCount: jsonList[widget.category].length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("${jsonList[widget.category][index]} clicked");
              },
              child: ItemCard(jsonList, index, context),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => new CategoriesScreen(
                      username: widget.username,
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
        "İzmir Tour Guide - ${widget.category}",
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      actions: [
        IconButton(
            onPressed: () {
              // items with scored more than 4 stars by the user, will be shown
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => new FavoritesScreen(
                          category: widget.category,
                          myJsonData: widget.myJsonData,
                          username: widget.username,
                        )),
              );
            },
            icon: Icon(Icons.favorite))
      ],
      backgroundColor: Colors.teal,
    );
  }

  Card ItemCard(
      Map<String, dynamic> jsonList, int index, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            jsonList[widget.category][index]['name'].toString(),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          Divider(
            color: Colors.teal,
            thickness: 1,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            child: Image.asset(
              'assets/' + jsonList[widget.category][index]['imageUrl'],
              fit: BoxFit.cover,
              width: 1000,
            ),
          ),
          Text(
            jsonList[widget.category][index]['information'].toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          Divider(
            color: Colors.teal,
          ),
          Text(
            'Open Hours: ' +
                jsonList[widget.category][index]['openHours'].toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          Text(
            'Price: ' +
                jsonList[widget.category][index]['price'].toString() +
                ' TL',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
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
              child: jsonList[widget.category][index]['comments'].isEmpty
                  ? Text("No comment yet...")
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          returnItemCount(jsonList, widget.category, index),
                      itemBuilder: (context, findex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(jsonList[widget.category][index]['comments']
                                [findex]['commentatorName']),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(jsonList[widget.category][index]
                                    ['comments'][findex]['review']),
                                Row(
                                  children: [
                                    Text(jsonList[widget.category][index]
                                        ['comments'][findex]['rating']),
                                    Icon(Icons.star_rate_rounded)
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              indent: MediaQuery.of(context).size.width * 0.05,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.05,
                            )
                          ],
                        );
                      },
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                content: Form(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4),
                                      child: TextFormField(
                                          controller: commentController,
                                          decoration: new InputDecoration(
                                              hintText: 'Your comment...'),
                                          keyboardType: TextInputType.name),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(4),
                                        child: DropdownButton(
                                            items: <String>[
                                              '1',
                                              '2',
                                              '3',
                                              '4',
                                              '5'
                                            ].map((String value) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            hint: Text(_selectedValue),
                                            onChanged: (val) {
                                              setState(() {
                                                _selectedValue = val.toString();
                                              });
                                            })),
                                  ],
                                )),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        // rating: _selectedValue
                                        // comment: commentController.text
                                        // name: widget.username
                                        print(
                                            "name: ${widget.username} comment: ${commentController.text} rating: ${_selectedValue}");

                                        List<dynamic> data =
                                            jsonList[widget.category][index]
                                                ['comments'];

                                        HashMap<String, dynamic> newComment =
                                            HashMap();
                                        newComment.addAll({
                                          'commentatorName': widget.username,
                                          'review': commentController.text,
                                          'rating': _selectedValue
                                        });

                                        data.add(newComment);
                                        jsonList[widget.category][index]
                                            ['comments'] = data;

                                        String newJsonData =
                                            jsonEncode(jsonList);
                                        saveJsonToSP(newJsonData);

                                        Navigator.of(context).pop();

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new ItemsScreen(
                                                    category: widget.category,
                                                    myJsonData: newJsonData,
                                                    username: widget.username,
                                                  )),
                                        );
                                      },
                                      child: Icon(Icons.send_rounded))
                                ],
                              );
                            },
                          );
                        });
                  },
                  child: Text('Make a comment'))
            ],
          ),
        ]),
      ),
    );
  }

  int returnItemCount(
      Map<String, dynamic> jsonList, String category, int index) {
    int a = jsonList[category][index]['comments'].length;
    print("findme $a");

    return a;
  }
}
