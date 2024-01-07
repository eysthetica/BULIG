import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';
import 'foodEstablishment.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  String search_name_input = "";
  int budget_min = 0;

  double _slider_minimum_budget = 100;
  bool _slider_minimum_budget_toggled = false;

  double _slider_minimum_review = 5;
  bool is_changing_menu = false;
  bool is_changing_menu_is_switched = false;

  bool has_pork = false;
  bool has_pork_is_switched = false;

  bool has_beef = false;
  bool has_beef_is_switched = false;

  bool has_chicken = false;
  bool has_chicken_is_switched = false;

  bool has_vegies = false;
  bool has_vegies_is_switched = false;

  @override
  Widget build(BuildContext context) {
    final CollectionReference _kaon =
        FirebaseFirestore.instance.collection("kaon");

    // Create a query against the collection.
    // final query = _kaon.where("min_spend", isEqualTo: 80);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search...'),
                      onChanged: (val) {
                        setState(() {
                          search_name_input = val;
                        });
                      })),
              // --- NOT NEEDED -----

              // Container(
              //     margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              //     child: TextField(
              //         decoration: InputDecoration(
              //             prefixIcon: Icon(Icons.search),
              //             hintText: 'Input Minimum Budget'),
              //         onChanged: (val) {
              //           setState(() {
              //             budget_min = int.tryParse(val) ?? 0;
              //           });
              //         })),

              // Container(
              //     margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              //     child: TextField(
              //         decoration: InputDecoration(
              //             prefixIcon: Icon(Icons.search),
              //             hintText: 'Input Minimum Review Value'),
              //         onChanged: (val) {
              //           setState(() {
              //             minimum_review = int.tryParse(val) ?? 0;
              //           });
              //         })),
              //Slider for minimum review
              // --- NOT NEEDED -----

              //Todo #1 This needs a corresponding query condition
              Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        'Select Minimum Budget Value for one meal: Php $_slider_minimum_budget'),
                    SizedBox(height: 10),
                    Slider(
                      value: _slider_minimum_budget,
                      max: 300,
                      divisions: 10,
                      label: _slider_minimum_review.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _slider_minimum_budget = value;
                          _slider_minimum_budget_toggled = true;
                        });
                      },
                    ),
                    Text(
                        'Select Minimum Review Value: $_slider_minimum_review Stars'),
                    SizedBox(height: 10),
                    Slider(
                      value: _slider_minimum_review,
                      max: 5,
                      divisions: 5,
                      label: _slider_minimum_review.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _slider_minimum_review = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text('Changing Menu'),
                        Switch(
                          // This bool value toggles the switch.
                          value: is_changing_menu,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              is_changing_menu = value;
                              is_changing_menu_is_switched = true;
                            });
                          },
                        ),
                      ],
                    ),
                    Text('Food Types: '),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Text('has_pork'),
                              Switch(
                                // This bool value toggles the switch.
                                value: has_pork,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    has_pork = value;
                                    has_pork_is_switched = true;
                                  });
                                },
                              ),
                              Text('has_beef'),
                              Switch(
                                // This bool value toggles the switch.
                                value: has_beef,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    has_beef = value;
                                    has_beef_is_switched = true;
                                  });
                                },
                              ),
                              Text('has_chicken'),
                              Switch(
                                // This bool value toggles the switch.
                                value: has_chicken,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    has_chicken = value;
                                    has_chicken_is_switched = true;
                                  });
                                },
                              ),
                              Text('has_vegies'),
                              Switch(
                                // This bool value toggles the switch.
                                value: has_vegies,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    has_vegies = value;
                                    has_vegies_is_switched = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 500,
                child: StreamBuilder(
                  //stream: query.snapshots(),
                  stream: createQuery(_kaon).snapshots(),
                  builder: (context, AsyncSnapshot snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }
                    if (snapshots.hasData) {
                      return ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot records =
                              snapshots.data!.docs[index];
                          if (search_name_input.isEmpty) {
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    // SlidableAction(
                                    //   onPressed: (context) {
                                    //     navigateToNewPage(context);
                                    //   },
                                    //   icon: Icons.phone,
                                    //   backgroundColor: Colors.blue,
                                    // )
                                  ]),
                              child: ListTile(
                                  title: Text(records["name"]),
                                  subtitle: Text(records["owner"] +
                                      '\n' +
                                      (records["fb link"]) +
                                      '\n' +
                                      (records["location"])),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                foodEstablishmentPage(
                                                    records: records)));
                                  }),
                            );
                          }

                          if (records["name"]
                              .toString()
                              .toLowerCase()
                              .contains(search_name_input.toLowerCase())) {
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: StretchMotion(), children: []),
                              child: ListTile(
                                  title: Text(records["name"]),
                                  subtitle: Text(records["owner"] +
                                      '\n' +
                                      (records["fb link"]) +
                                      '\n' +
                                      (records["location"])),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                foodEstablishmentPage(
                                                    records: records)));
                                  }),
                            );
                          }
                        },
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   body: Co
      //   title: Text('Add Sensor',
      //       style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
    );
  }

  Query createQuery(Query queryReference) {
    Query query = queryReference;

    // if (budget_min != 0 && search_name_input.isNotEmpty) {
    //   query = query.where(Filter.and(
    //       Filter('min_spend', isLessThanOrEqualTo: budget_min),
    //       Filter('name', arrayContains: search_name_input.toLowerCase()))
    //       );
    // }

    // if (search_name_input.isNotEmpty) {
    //   query =
    //       query.where('name', arrayContains: search_name_input.toLowerCase());
    // }

    // if (search_name_input.isNotEmpty) {
    //   query = query.where('name', arrayContains: search_name_input);
    // }

    // WORKS
    // if (_slider_minimum_budget_toggled == true) {
    //   query =
    //       query.where('min_spend', isLessThanOrEqualTo: _slider_minimum_budget);
    // }

    // When minimum review slider is moved
    // WORKS
    // if (_slider_minimum_review <= 0) {
    //   query = query.where('averageRating',
    //       isGreaterThanOrEqualTo: _slider_minimum_review);
    // }

    // When minimum review slider is moved
    // WORKS
    // if (is_changing_menu_is_switched == true) {
    //   query = query.where('changing menu', isEqualTo: is_changing_menu);
    // }

    // if (has_pork_is_switched == true) {
    //   query = query.where('pork', isEqualTo: has_pork);
    // }

    // if (has_beef_is_switched == true) {
    //   query = query.where('beef', isEqualTo: has_beef);
    // }

    // if (has_chicken_is_switched == true) {
    //   query = query.where('chicken', isEqualTo: has_chicken);
    // }

    // if (has_vegies_is_switched == true) {
    //   query = query.where('vegies', isEqualTo: has_vegies);
    // }

    //Add clear all filter

    return query;
  }
}


              // bool has_pork = false;
              // bool has_pork_is_switched = false;

              // bool has_beef = false;
              // bool has_beef_is_switched = false;

              // bool has_chicken = false;
              // bool has_chicken_is_switched = false;

              // bool has_vegies = false;
              // bool has_vegies_is_switched = false;
