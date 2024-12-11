// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class Member {
  String? message;
  String? memId;
  String? memFullName;
  String? memEmail;
  String? memUsername;
  String? memPassword;
  String? memAge;

  Member({this.message, this.memId, this.memFullName, this.memEmail, this.memUsername, this.memPassword, this.memAge});

  //Convert JSON file to App data
  Member.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    memId = json['memId'];
    memFullName = json['memFullName'];
    memEmail = json['memEmail'];
    memUsername = json['memUsername'];
    memPassword = json['memPassword'];
    memAge = json['memAge'];
  }

  //Convert App data to JSON file
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['memId'] = this.memId;
    data['memFullName'] = this.memFullName;
    data['memEmail'] = this.memEmail;
    data['memUsername'] = this.memUsername;
    data['memPassword'] = this.memPassword;
    data['memAge'] = this.memAge;
    return data;
  }
}
