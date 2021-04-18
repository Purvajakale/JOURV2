import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:paginate_firestore/paginate_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView, // listview and gridview

        itemBuilder: (index, context, documentSnapshot) => Column(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.blueGrey.shade100.withOpacity(0.4),
                  //       spreadRadius: 3,
                  //       blurRadius: 0.2,
                  //       //offset: Offset(0, 3), // changes position of shadow
                  //     ),
                  //   ],
                  // ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CachedNetworkImage(
                          imageUrl: documentSnapshot.data()['image'],
                          height: 150,
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(),
                            height: 150,
                            width: 100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                documentSnapshot.data()['description'] ??
                                    "No Description",
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18.0),
                                // textDirection: TextDirection.ltr,
                              ),
                            ),
                            Text(
                              documentSnapshot.data()['date'],
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Text(
                              documentSnapshot.data()['time'],
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.blueGrey,
                  height: 5.0,
                )
              ],
            ),

        // orderBy is compulsary to enable pagination
        itemsPerPage: 10,
        padding: const EdgeInsets.all(10),
        query: FirebaseFirestore.instance
            .collection('Posts')
            .doc('${auth.currentUser.uid}')
            .collection("UsersPosts")
            .orderBy('time'),
        isLive: true // to fetch real-time data

        );
    // Scaffold(
    //   appBar: AppBar(
    //     title: new Text('Jour Blog'),
    //   ),
    //   body: PaginateFirestore(
    //       itemBuilderType:
    //           PaginateBuilderType.listView, // listview and gridview

    //       itemBuilder: (index, context, documentSnapshot) => Column(
    //             children: [
    //               Container(
    //                 // decoration: BoxDecoration(
    //                 //   boxShadow: [
    //                 //     BoxShadow(
    //                 //       color: Colors.blueGrey.shade100.withOpacity(0.4),
    //                 //       spreadRadius: 3,
    //                 //       blurRadius: 0.2,
    //                 //       //offset: Offset(0, 3), // changes position of shadow
    //                 //     ),
    //                 //   ],
    //                 // ),
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: CachedNetworkImage(
    //                         imageUrl: documentSnapshot.data()['image'],
    //                         height: 150,
    //                         fit: BoxFit.fitHeight,
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.only(bottom: 20.0),
    //                             child: Text(
    //                               documentSnapshot.data()['description'],
    //                               // overflow: TextOverflow.ellipsis,
    //                               style: TextStyle(fontSize: 18.0),
    //                               // textDirection: TextDirection.ltr,
    //                             ),
    //                           ),
    //                           Text(
    //                             documentSnapshot.data()['date'],
    //                             style: TextStyle(fontSize: 10.0),
    //                           ),
    //                           Text(
    //                             documentSnapshot.data()['time'],
    //                             style: TextStyle(fontSize: 10.0),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Divider(
    //                 color: Colors.blueGrey,
    //                 height: 5.0,
    //               )
    //             ],
    //           ),

    //       // orderBy is compulsary to enable pagination
    //       itemsPerPage: 10,
    //       padding: const EdgeInsets.all(10),
    //       query: FirebaseFirestore.instance
    //           .collection('Posts')
    //           .doc('${auth.currentUser.uid}')
    //           .collection("UsersPosts")
    //           .orderBy('time'),
    //       isLive: true // to fetch real-time data

    //       ),
    // );
  }
}
