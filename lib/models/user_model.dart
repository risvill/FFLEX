class UserModel {
  String? firstName;
  String? lastName;
  String? gender;
  String? birthday;
  double? weight;
  double? height;
  UserModel({this.firstName,this.lastName,this.gender,this.birthday,this.weight,this.height});
  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first name'];
    lastName = json['last name'];
    gender = json['gender'];
    birthday = json['birthday'];
    weight = json['weight'];
    height = json['height'];
  }
}
