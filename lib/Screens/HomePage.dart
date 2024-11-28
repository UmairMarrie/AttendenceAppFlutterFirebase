import 'package:attendenceappusingfirebase/Screens/AddStudent.dart';
import 'package:attendenceappusingfirebase/services/Database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Stream? studentstream;

  DatabaseMethodService databaseMethodService = DatabaseMethodService();

  getontheload() async {
    studentstream = await databaseMethodService.getStudentData();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget showStudentList() {
    return StreamBuilder(
        stream: studentstream,
        builder: (context, AsyncSnapshot snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Material(
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Student Name:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ds['Name'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        Get.defaultDialog(
                                          title: "Delete",
                                          onCancel: () {
                                            Get.back();
                                          },
                                          onConfirm: () async {

                                            await databaseMethodService.deketeStudentData(ds.id);
                                            Get.back();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Deleted${ds['Name']}"),backgroundColor: Colors.green,));
                                            
                                          },
                                            content: Text(
                                                "Are you sure you want to delete"));
                                                
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "RollNo",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ds['RollNo'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Age:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ds['Age'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Attendence:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ds["Present"] == false
                                      ? GestureDetector(
                                          onTap: () async {
                                            await databaseMethodService
                                                .updateStudentData(
                                                    "Present", ds.id);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 7),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1)),
                                            child: Text(
                                              "P",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 7),
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          child: Text(
                                            "P",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ds["Absent"] == false
                                      ? GestureDetector(
                                          onTap: () async {
                                            await databaseMethodService
                                                .updateStudentData(
                                                    "Absent", ds.id);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 7),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1)),
                                            child: Text(
                                              "A",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 7),
                                          decoration:
                                              BoxDecoration(color: Colors.red),
                                          child: Text(
                                            "A",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Get.to(Addstudent(), transition: Transition.downToUp);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Student",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  " Attendence",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          showStudentList(),
        ],
      ),
    );
  }
}
