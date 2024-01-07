import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';
import 'foodEstablishment.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  String searchNameInput = "";
  int budgetMin = 80;
  int budgetMax = 0;

  @override
  Widget build(BuildContext context) {
    final CollectionReference kaonCollection =
        FirebaseFirestore.instance.collection("kaon");

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                ),
                onChanged: (val) {
                  setState(() {
                    searchNameInput = val;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Input Minimum Budget',
                ),
                onChanged: (val) {
                  setState(() {
                    budgetMin = int.tryParse(val) ?? 0;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Input Maximum Budget',
                ),
                onChanged: (val) {
                  setState(() {
                    budgetMax = int.tryParse(val) ?? 0;
                  });
                },
              ),
            ),
            Container(
              height: 500,
              child: StreamBuilder(
                stream: createQuery(kaonCollection).snapshots(),
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

                        if (searchNameInput.isEmpty ||
                            (records["name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchNameInput.toLowerCase()) &&
                                records["min_spend"] as int >= budgetMin &&
                                records["min_spend"] as int <= budgetMax)) {
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
                                    builder: (context) => foodEstablishmentPage(
                                      records: records,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }

                        return Container();
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
    );
  }

  Query createQuery(CollectionReference collectionReference) {
    Query query = collectionReference;

    if (budgetMin > 0) {
      query = query.where('min_spend', isGreaterThanOrEqualTo: budgetMin);
    }

    if (budgetMax > 0) {
      query = query.where('min_spend', isLessThanOrEqualTo: budgetMax);
    }

    // Add more conditions if needed...

    return query;
  }
}
