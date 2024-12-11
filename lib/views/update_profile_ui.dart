// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously, prefer_is_empty, annotate_overrides

import 'package:flutter/material.dart';
import 'package:my_diaryfood_project/models/member.dart';
import 'package:my_diaryfood_project/services/call_api.dart';



class UpdateProfileUi extends StatefulWidget {
  Member? member;
  UpdateProfileUi({super.key, this.member});

  @override
  State<UpdateProfileUi> createState() => _UpdateProfileUiState();
}

class _UpdateProfileUiState extends State<UpdateProfileUi> {
  //TextField Controller
  TextEditingController memFullNameCtrl = TextEditingController(text: '');
  TextEditingController memEmailCtrl = TextEditingController(text: '');
  TextEditingController memUsernameCtrl = TextEditingController(text: '');
  TextEditingController memPasswordCtrl = TextEditingController(text: '');
  TextEditingController memAgeCtrl = TextEditingController(text: '');

  //Boolean variable
  bool passStatus = true;
//Method showWaringDialog
  showWaringDialog(context, msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'คำเตือน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//Method showCompleteDialog
  Future showCompleteDialog(context, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'ผลการทำงาน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    //เอาค่าที่ส่งมากำหนดให้แต่ละ TextEditingController
    memFullNameCtrl.text = widget.member!.memFullName!;
    memEmailCtrl.text = widget.member!.memEmail!;
    memUsernameCtrl.text = widget.member!.memUsername!;
    memPasswordCtrl.text = widget.member!.memPassword!;
    memAgeCtrl.text = widget.member!.memAge!;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
//AppBar
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'แก้ไขข้อมูลส่วนตัว',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
//Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://cdn.pixabay.com/photo/2020/02/02/03/39/man-4811935_1280.png",
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.45,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
//Text Fullname
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ชื่อ-สกุล :',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
          ),
//textfield Fullname
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: TextField(
              enabled: false,
              controller: memFullNameCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_3_rounded,
                ),
                hintText: 'ป้อนชื่อ-สกุล',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
//Text Email
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'อีเมล :',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
          ),
//textfield Email
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: TextField(
              controller: memEmailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: 'ป้อนอีเมล',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
//Text Username
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ชื่อผู้ใช้ :',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
          ),
//textfield Username
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: TextField(
              controller: memUsernameCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_add,
                ),
                hintText: 'ป้อนชื่อผู้ใช้',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
//Text Password
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'รหัสผ่าน :',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
          ),
//textfield Password
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: TextField(
              controller: memPasswordCtrl,
              obscureText: passStatus,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passStatus = !passStatus;
                    });
                  },
                  icon: Icon(
                    passStatus == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                hintText: 'ป้อนรหัสผ่าน',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
//Text Age
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'อายุ :',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
          ),
//textfield Age
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            child: TextField(
              controller: memAgeCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_month,
                ),
                hintText: 'ป้อนอายุ',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
//save button
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.03,
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
            child: ElevatedButton(
              onPressed: () {
                //Validate
                if (memEmailCtrl.text.trim().length == 0) {
                  showWaringDialog(context, 'ป้อนอีเมลด้วย');
                } else if (memUsernameCtrl.text.trim().length == 0) {
                  showWaringDialog(context, 'ป้อนชื่อผู้ใช้ด้วย');
                } else if (memPasswordCtrl.text.trim().length == 0) {
                  showWaringDialog(context, 'ป้อนรหัสผ่านด้วย');
                } else if (memAgeCtrl.text.trim().length == 0) {
                  showWaringDialog(context, 'ป้อนอายุด้วย');
                } else {
                    //validate username and password from DB through API
                    //Create a variable to store data to be sent with the API
                  Member member = Member(
                        memId: widget.member!.memId!,
                        memEmail: memEmailCtrl.text.trim(),
                        memUsername: memUsernameCtrl.text.trim(),
                        memPassword: memPasswordCtrl.text.trim(),
                        memAge: memAgeCtrl.text.trim(),
                      );
                    //call API
                    CallAPI.callUpdateMemberAPI(member).then((value) {
                        if (value.message == '1') {
                          showCompleteDialog(context, 'แก้ไขสําเร็จOvO').then((value) => Navigator.pop(context, member));
                        } else {
                          showCompleteDialog(context, 'แก้ไขไม่สําเร็จ โปรดลองอีกครั้งTwT');
                        }
                      });
                }
              },
              child: Text(
                'บันทึกการแก้ไขข้อมูลส่วนตัว', 
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.07,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ])))
    );
  }
}