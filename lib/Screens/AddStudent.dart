import 'package:attendenceappusingfirebase/Components/MyTextField.dart';
import 'package:attendenceappusingfirebase/services/Database.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  @override
  Widget build(BuildContext context) {
    DatabaseMethodService databaseMethodService = DatabaseMethodService();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController agecontroller = TextEditingController();
    TextEditingController rollnocontroller = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Icon(Icons.arrow_back_ios_new)),
                ),
                Row(
                  children: [
                    Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Student",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    "Student Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Mytextfield(
                controller: namecontroller,
                hintText: "Enter Student Name",
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    "Student Age",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Mytextfield(
                controller: agecontroller,
                hintText: "Enter Student Age",
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    "Student RollNo",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Mytextfield(
                controller: rollnocontroller,
                hintText: "Enter Student RollNo",
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {

                    if(namecontroller.text!=""&&agecontroller.text!=""&&rollnocontroller.text!=""){
                      String addid = randomAlphaNumeric(10);
                      Map<String,dynamic> studentinfomap = {
                      "Name" : namecontroller.text,
                      "Age" : agecontroller.text,
                      "RollNo": rollnocontroller.text,
                      "Absent" : false,
                      "Present" : false
                      };
                      await databaseMethodService.addStudentData(studentinfomap,addid).then((value) {
                         namecontroller.text = "";
                         agecontroller.text = "" ;
                         rollnocontroller.text = "";
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploaded.."),backgroundColor: Colors.green,));
                      },);
                  

                    }

                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        
                        SnackBar(content: Text("Fill All field",),backgroundColor: Colors.red,),);
                    }
          
                  

              
                    
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(40)),
                    alignment: Alignment.center,
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
