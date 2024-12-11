// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_field, use_build_context_synchronously, unnecessary_import, prefer_final_fields, sort_child_properties_last, unrelated_type_equality_checks, unnecessary_null_comparison, prefer_is_empty, prefer_interpolation_to_compose_strings, must_be_immutable, annotate_overrides
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_diaryfood_project/models/diaryfood.dart';
import 'package:my_diaryfood_project/services/call_api.dart';

class InsertDiaryfoodUI extends StatefulWidget {
  String memId;
  InsertDiaryfoodUI({super.key, required this.memId});
  @override
  State<InsertDiaryfoodUI> createState() => _InsertDiaryfoodUIState();
}

class _InsertDiaryfoodUIState extends State<InsertDiaryfoodUI> {
//======================================================================================================
//-------------------------------Variable-------------------------------------------------

//Textfield Controller
//image variable
  TextEditingController foodShopnameCtrl = TextEditingController();
  TextEditingController foodPayCtrl = TextEditingController();
  TextEditingController foodDateCtrl = TextEditingController();

//Variable store camera/gallery
  File? _imageSelected;

//Variable store camera/gallery convert to Base64 for sent to api
  String _image64Selected = '';

//variable meal
  int? meal = 1;

//variable date
  String? _foodDateSelected;

//variable province
  String? _foodProvinceSelected = 'กรุงเทพมหานคร';

//--------------------------------------------------------------------------------------
//ประกาศ/สร้างตัวแปรเพื่อเก็บข้อมูลรายการที่จะเอาไปใช้กับ DropdownButton
  List<DropdownMenuItem<String>> provinceItems = [
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พะเยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี'
  ]
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

//variable lat lng ที่ดึงมา
  String? _foodLat, _foodLng;

//ตัวแปรเก็บตําแหน่งที่ Latitude, Longitude
  Position? currentPosition;
//method ดึงตําแหน่งปัจจุบัน
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      currentPosition = position;
      _foodLat = position.latitude.toString();
      _foodLng = position.longitude.toString();
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

//open camera method
  Future<void> _openCamera() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _image64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

//open gallery method
  Future<void> _openGallery() async {
    final XFile? _picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (_picker != null) {
      setState(() {
        _imageSelected = File(_picker.path);
        _image64Selected = base64Encode(_imageSelected!.readAsBytesSync());
      });
    }
  }

//----------------------Method open calendar------------------------
  Future<void> _openCalendar() async {
    final DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (_picker != null) {
      setState(() {
        foodDateCtrl.text = convertToThaiDate(_picker);
        _foodDateSelected = _picker.toString().substring(0, 10);
      });
    }
  }

//เมธอดแปลงวันที่แบบสากล (ปี ค.ศ.-เดือน ตัวเลข-วัน ตัวเลข) ให้เป็นวันที่แบบไทย (วัน เดือน ปี)
  //                             2023-11-25
  convertToThaiDate(date) {
    String day = date.toString().substring(8, 10);
    String year = (int.parse(date.toString().substring(0, 4)) + 543).toString();
    String month = '';
    int monthTemp = int.parse(date.toString().substring(5, 7));
    switch (monthTemp) {
      case 1:
        month = 'มกราคม';
        break;
      case 2:
        month = 'กุมภาพันธ์';
        break;
      case 3:
        month = 'มีนาคม';
        break;
      case 4:
        month = 'เมษายน';
        break;
      case 5:
        month = 'พฤษภาคม';
        break;
      case 6:
        month = 'มิถุนายน';
        break;
      case 7:
        month = 'กรกฎาคม';
        break;
      case 8:
        month = 'สิงหาคม';
        break;
      case 9:
        month = 'กันยายน';
        break;
      case 10:
        month = 'ตุลาคม';
        break;
      case 11:
        month = 'พฤศจิกายน';
        break;
      default:
        month = 'ธันวาคม';
    }

    return int.parse(day).toString() + ' ' + month + ' ' + year;
  }
//-------------------------------------------------------------------

//-------------------------------Show Dialog ------------------------
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
//-------------------------------------------------------------------

//======================================================================================================

  @override
  void initState() {
    _getCurrentLocation();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//AppBar
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'เพิ่มบันทึกการกิน',
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
      ), //body
//Body
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
              ),
//Avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.green),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: _imageSelected == null
                            ? AssetImage(
                                'assets/images/banner.jpg',
                              )
                            : FileImage(_imageSelected!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
//Icon camera
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //open camera
                            ListTile(
                              onTap: () {
                                _openCamera().then(
                                  (value) => Navigator.pop(context),
                                );
                              },
                              leading: Icon(
                                Icons.camera_alt,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Open Camera...',
                              ),
                            ),

                            Divider(
                              color: Colors.grey,
                              height: 5.0,
                            ),

                            //open gallery
                            ListTile(
                              onTap: () {
                                _openGallery().then(
                                  (value) => Navigator.pop(context),
                                );
                              },
                              leading: Icon(
                                Icons.browse_gallery,
                                color: Colors.blue,
                              ),
                              title: Text(
                                'Open Gallery...',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              //Text foodshopName
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ร้านอาหาร',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              //TextField foodshopName
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  controller: foodShopnameCtrl,
                  decoration: InputDecoration(
                    hintText: 'ป้อนชื่อร้านอาหาร',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              //Text cost
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ค่าใช้จ่าย',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              //TextField cost
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: foodPayCtrl,
                  decoration: InputDecoration(
                    hintText: 'ป้อนค่าใช้จ่าย',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              //Text meal
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'อาหารมื้อ',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              //Radio meal
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Breakfast
                  Radio(
                    onChanged: (int? value) {
                      setState(() {
                        meal = value;
                      });
                    },
                    value: 1,
                    groupValue: meal,
                    activeColor: Colors.green,
                  ),
                  Text(
                    'เช้า',
                  ),
                  //Lunch
                  Radio(
                    onChanged: (int? value) {
                      setState(() {
                        meal = value;
                      });
                    },
                    value: 2,
                    groupValue: meal,
                    activeColor: Colors.green,
                  ),
                  Text(
                    'กลางวัน',
                  ),
                  //Dinner
                  Radio(
                    onChanged: (int? value) {
                      setState(() {
                        meal = value;
                      });
                    },
                    value: 3,
                    groupValue: meal,
                    activeColor: Colors.green,
                  ),
                  Text(
                    'เย็น',
                  ),
                  //Free time
                  Radio(
                    onChanged: (int? value) {
                      setState(() {
                        meal = value;
                      });
                    },
                    value: 4,
                    groupValue: meal,
                    activeColor: Colors.green,
                  ),
                  Text(
                    'ว่าง',
                  ),
                ],
              ),
              //Date eat
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'วันที่กิน',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              //TextField date
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: foodDateCtrl,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'เลือกวันที่',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _openCalendar();
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              //Text Province
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จังหวัด',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
              ),
              //Dropdown province
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.015,
                ),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  //dropdown button
                  child: DropdownButton(
                    isExpanded: true,
                    items: provinceItems,
                    onChanged: (String? value) {
                      setState(() {
                        _foodProvinceSelected = value!;
                      });
                    },
                    value: _foodProvinceSelected,
                    underline: SizedBox(),
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
//save button
              ElevatedButton(
                onPressed: () {
                  //Validate
                  if (_image64Selected == '' || _image64Selected == null) {
                    showWaringDialog(context, 'กรุณาถ่ายภาพ/เลือกรูปภาพด้วย');
                  } else if (foodShopnameCtrl.text.trim().length == '') {
                    showWaringDialog(context, 'กรุณาป้อนชื่อร้านอาหารด้วย');
                  } else if (foodPayCtrl.text.trim().length == 0) {
                    showWaringDialog(context, 'กรุณาป้อนค่าใช้จ่ายด้วย');
                  } else if (_foodDateSelected == '' ||
                      _foodDateSelected == null) {
                    showWaringDialog(context, 'กรุณาป้อนวันที่กินด้วย');
                  } else {
                    //ส่งข้อมูลที่ผู้ใช้ป้อน/เลือกไปให้ API เพื่อบันทึกการกินลงฐานข้อมูล
                    //แพ็กข้อมูลที่จะส่งรวมกัน
                    Diaryfood diaryfood = Diaryfood(
                      foodShopname: foodShopnameCtrl.text.trim(),
                      foodMeal: meal.toString(),
                      foodImage: _image64Selected,
                      foodPay: foodPayCtrl.text.trim(),
                      foodDate: foodDateCtrl.text.trim(),
                      foodProvince: _foodProvinceSelected,
                      foodLat: _foodLat,
                      foodLng: _foodLng,
                      memId: widget.memId,
                    );
                    //ส่งข้อมูลที่แพ็กไว้ไปให้ API เพื่อบันทึกการกินลงฐานข้อมูล
                    //call api
                    CallAPI.callInsertDiaryFoodAPI(diaryfood).then((value) {
                      //ถ้าส่งข้อมูลสําเร็จ
                      if (value.message == '1') {
                        showCompleteDialog(context, 'บันทึกการกินสําเร็จOvO');
                      } else {
                        showWaringDialog(context,
                            'บันทึกการกินไม่สําเร็จ โปรดลองใหม่อีกครั้งTwT');
                      }
                    });
                  }
                },
                child: Text(
                  'บันทึกการกิน',
                  style: TextStyle(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.07,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
//cancel button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _imageSelected = null;
                    _image64Selected = '';
                    foodShopnameCtrl.clear(); // .clear(); same as .text = ''
                    foodPayCtrl.text = '';
                    meal = 1;
                    foodDateCtrl.text = '';
                    _foodProvinceSelected = 'กรุงเทพมหานคร';
                    _foodLat = '';
                    _foodLng = '';
                  });
                },
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.07,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}