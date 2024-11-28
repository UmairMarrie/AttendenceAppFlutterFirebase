import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethodService {

Future addStudentData (Map<String,dynamic> studentInfoMap,String id) async{

  return await FirebaseFirestore.instance.collection("Students").doc(id).set(studentInfoMap);

}
//read or get data from firebase
Future <Stream<QuerySnapshot>> getStudentData() async{
  return await FirebaseFirestore.instance.collection("Students").snapshots(); 
}

updateStudentData(String attcase,String id)  async{

  return await FirebaseFirestore.instance.collection("Students").doc(id).update({attcase: true});

}
 deketeStudentData(String id) async {

  await FirebaseFirestore.instance.collection("Students").doc(id).delete();
 }
}