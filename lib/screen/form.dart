import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/model/student.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  Student _mystudent = Student();
  //** */ เตรียม firebase
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();
  CollectionReference _studentCollection = FirebaseFirestore.instance.collection('student');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebase,
        builder: (context, snapshot) {
          /* ----------------------------------ถ้าเชื่อมต่อ ไม่สำเร็จ---------------------------------------- */
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('error'),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          /* ------------------------------------ถ้าเชื่อมต่อ สำเร็จ-------------------------------------- */
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('แบบฟอร์มบันทึกคะแนนสอบ'),
                ),
                body: Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          formFname(),
                          SizedBox(
                            height: 15,
                          ),
                          formLname(),
                          SizedBox(
                            height: 15,
                          ),
                          formEmail(),
                          SizedBox(
                            height: 15,
                          ),
                          formScore(),
                          SizedBox(
                            height: 15,
                          ),
                          methodsubmit()
                        ],
                      ),
                    ),
                  ),
                ));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  TextFormField formFname() {
    return TextFormField(
      validator: RequiredValidator(errorText: "*กรุณากรอกชื่อ"),
      decoration: InputDecoration(labelText: "ชื่อ"),
      onSaved: (newValue) {
        _mystudent.fname = newValue;
      },
    );
  }

  TextFormField formLname() {
    return TextFormField(
      validator: RequiredValidator(errorText: "*กรุณากรอกนามสกุล"),
      decoration: InputDecoration(labelText: "นามสกุล"),
      onSaved: (newValue) {
        _mystudent.lname = newValue;
      },
    );
  }

  TextFormField formEmail() {
    return TextFormField(
      validator: MultiValidator([
        RequiredValidator(errorText: "*กรุณากรอกอีเมล"),
        EmailValidator(errorText: '*รูปแบบอีเมลไม่ถูกต้อง'),
      ]),
      decoration: InputDecoration(
        labelText: "อีเมล",
        hintText: "abc@mail.com",
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        _mystudent.email = newValue;
      },
    );
  }

  TextFormField formScore() {
    return TextFormField(
      validator: RequiredValidator(errorText: "*กรุณากรอกคะแนน"),
      decoration: InputDecoration(labelText: "คะแนน"),
      keyboardType: TextInputType.number,
      onSaved: (String? newValue) {
        _mystudent.score = newValue;
      },
    );
  }

  SizedBox methodsubmit() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: Text('บันทึกข้อมูล'),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            await _studentCollection.add({
              "fname": _mystudent.fname,
              "lname": _mystudent.lname,
              "email": _mystudent.email,
              "score": _mystudent.score,
            });
            _formKey.currentState!.reset();
          }
        },
      ),
    );
  }
// }
}
