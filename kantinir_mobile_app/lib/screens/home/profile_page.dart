// From gab natividad

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:kantinir_mobile_app/services/my_list_tile.dart';

class profilePage extends StatefulWidget {
  profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                child: Icon(
                  Icons.person,
                  size: 200,
                ),
              ),
              MyListTile(
                icon: Icons.manage_accounts,
                text: 'Username',
                onTap: () {
                  //username tap function
                },
              ),
              MyListTile(
                icon: Icons.manage_accounts,
                text: currentUser.email!,
                onTap: () {
                  //email tap function
                },
              ),
              MyListTile(
                icon: Icons.admin_panel_settings,
                text: 'Change Password',
                onTap: () {
                  //username tap functionality (edit user)
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Container(
              color: Colors.grey,
              child: MyListTile(
                icon: Icons.logout,
                text: 'Log Out',
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}


// From adrine/my-code

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kantinir_mobile_app/services/auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import '../food_page/foodPage.dart';
// import '../housing_page/housingPage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kantinir_mobile_app/services/auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import '../food_page/foodPage.dart';
// import '../housing_page/housingPage.dart';
// import 'home_content.dart';
// import 'profile_page.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final AuthService _auth = AuthService();

//   int _selectedIndex = 0;
//   bool _hidePassword = true;
//   final List<String> details = [
//     'John Doe',
//     'j_dawg2023',
//     'Nov 2023',
//     'johndoe@email.com',
//     'joeisthename',
//   ];
//   // I used list to name the details in this order: name, uname, membership date, email, and password

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => FoodPage()),
//         );
//         break;
//       case 1:
//         // Add Home Page here
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HousingPage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.arrow_forward,
//                 color: Color.fromARGB(255, 6, 97, 76), size: 30.00),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: 50),
//             CircleAvatar(
//               radius: 100,
//               backgroundColor: Color.fromARGB(255, 18, 130, 120),
//               child: Icon(
//                 Icons.person,
//                 color: Colors.white,
//                 size: 200,
//               ),
//             ),
//             Text(
//               details[0],
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               details[1],
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             SizedBox(height: 50),
//             buildStackWithCard(
//               icon: Icons.date_range,
//               text: 'Member since ${details[2]}',
//             ),
//             buildStackWithCard(
//               icon: Icons.email,
//               text: details[3],
//             ),
//             buildStackWithCard(
//               icon: Icons.lock,
//               text: _hidePassword ? '********' : details[4],
//               trailingIcon: IconButton(
//                 icon: Icon(
//                   _hidePassword ? Icons.visibility_off : Icons.visibility,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _hidePassword = !_hidePassword;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 50),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
//                   backgroundColor: Color.fromARGB(255, 180, 178, 178),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   textStyle: TextStyle(fontSize: 24),
//                 ),
//                 onPressed: () async {
//                   await _auth.signOut();
//                   Navigator.pop(context);
//                 },
//                 child: Text('Sign Out'),
//               ),
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.restaurant_menu),
//             label: 'Food',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Housing',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color.fromARGB(255, 76, 187, 80),
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   Widget buildStackWithCard({
//     required IconData icon,
//     required String text,
//     Widget? trailingIcon,
//   }) {
//     return Stack(
//       children: <Widget>[
//         Card(
//           color: Color.fromARGB(255, 156, 197, 194),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           margin: EdgeInsets.fromLTRB(50, 5, 30, 30),
//           child: ListTile(
//             title: Padding(
//               padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
//               child: Text(text, style: TextStyle(fontSize: 22)),
//             ),
//             trailing: trailingIcon,
//           ),
//         ),
//         Positioned(
//           top: 0,
//           left: 20,
//           child: CircleAvatar(
//             radius: 30,
//             backgroundColor: Color.fromARGB(255, 161, 214, 210),
//             child: Icon(icon, size: 30),
//           ),
//         ),
//       ],
//     );
//   }
// }
