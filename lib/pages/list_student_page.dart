import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrud/pages/update_student_page.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              // scrollDirection: Axis.vertical,
              /*  child: Container(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                   itemCount: storedocs.length,
                  itemBuilder: (context, index) {
                    return  InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => detailsscreen(data: storedocs[index])));
                      },
                      child: Card(
                        elevation: 7,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: [
                            // for (var i = 0; i < storedocs.length; i++)
                              Text(
                                storedocs[index]['name'],
                                // storedocs[i]['name'],
                              ),
                            // for (var i = 0; i < storedocs.length; i++)
                              Text(
                                // storedocs[i]['email'],
                                   storedocs[index]['email'],

                              ),
                            // for (var i = 0; i < storedocs.length; i++)
                              Text(
                                storedocs[index]['password'],
                                // storedocs[i]['password'],
                              ),
                            // for (var i = 0; i < storedocs.length; i++)
                              Text(
                                storedocs[index]['number'],
                                // storedocs[i]['number'],
                              ),
                            // IconButton(
                            //   onPressed: () => {
                            //     for (var i = 0; i < storedocs.length; i++)
                            //       deleteUser(storedocs[i]['id']),
                            //   },
                            //   icon: Icon(
                            //     Icons.delete,
                            //     color: Colors.red,
                            //   ),
                            // ),
                            // IconButton(
                            //   onPressed: () => {
                            //     for (var i = 0; i < storedocs.length; i++)
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //
                            //               UpdateStudentPage(id: storedocs[i]['id']),
                            //         ),
                            //       )
                            //   },
                            //   icon: Icon(
                            //     Icons.edit,
                            //     color: Colors.orange,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),*/
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['name'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(storedocs[i]['email'],
                                style: TextStyle(fontSize: 18.0)),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateStudentPage(
                                          id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
