
class MyProfileModel {
  MyProfileModel({
      bool? success, 
      num? status, 
      String? message,
    MyProfileData? data,}){
    _success = success;
    _status = status;
    _message = message;
    _data = data;
}

  MyProfileModel.fromJson(dynamic json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? MyProfileData.fromJson(json['data']) : null;
  }
  bool? _success;
  num? _status;
  String? _message;
  MyProfileData? _data;
MyProfileModel copyWith({  bool? success,
  num? status,
  String? message,
  MyProfileData? data,
}) => MyProfileModel(  success: success ?? _success,
  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  num? get status => _status;
  String? get message => _message;
  MyProfileData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class MyProfileData {
  MyProfileData({
      num? id, 
      dynamic firebaseUserId, 
      String? fullName, 
      String? userName, 
      String? email, 
      String? dob, 
      String? phone, 
      String? password, 
      String? address, 
      String? city, 
      String? postalCode, 
      String? language, 
      String? bio, 
      String? prImage, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _firebaseUserId = firebaseUserId;
    _fullName = fullName;
    _userName = userName;
    _email = email;
    _dob = dob;
    _phone = phone;
    _password = password;
    _address = address;
    _city = city;
    _postalCode = postalCode;
    _language = language;
    _bio = bio;
    _prImage = prImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  MyProfileData.fromJson(dynamic json) {
    _id = json['id'];
    _firebaseUserId = json['firebaseUserId'];
    _fullName = json['full_name'];
    _userName = json['user_name'];
    _email = json['email'];
    _dob = json['dob'];
    _phone = json['phone'];
    _password = json['password'];
    _address = json['address'];
    _city = json['city'];
    _postalCode = json['postal_code'];
    _language = json['language'];
    _bio = json['bio'];
    _prImage = json['pr_image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  dynamic _firebaseUserId;
  String? _fullName;
  String? _userName;
  String? _email;
  String? _dob;
  String? _phone;
  String? _password;
  String? _address;
  String? _city;
  String? _postalCode;
  String? _language;
  String? _bio;
  String? _prImage;
  String? _createdAt;
  String? _updatedAt;
  MyProfileData copyWith({  num? id,
  dynamic firebaseUserId,
  String? fullName,
  String? userName,
  String? email,
  String? dob,
  String? phone,
  String? password,
  String? address,
  String? city,
  String? postalCode,
  String? language,
  String? bio,
  String? prImage,
  String? createdAt,
  String? updatedAt,
}) => MyProfileData(  id: id ?? _id,
  firebaseUserId: firebaseUserId ?? _firebaseUserId,
  fullName: fullName ?? _fullName,
  userName: userName ?? _userName,
  email: email ?? _email,
  dob: dob ?? _dob,
  phone: phone ?? _phone,
  password: password ?? _password,
  address: address ?? _address,
  city: city ?? _city,
  postalCode: postalCode ?? _postalCode,
  language: language ?? _language,
  bio: bio ?? _bio,
  prImage: prImage ?? _prImage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  dynamic get firebaseUserId => _firebaseUserId;
  String? get fullName => _fullName;
  String? get userName => _userName;
  String? get email => _email;
  String? get dob => _dob;
  String? get phone => _phone;
  String? get password => _password;
  String? get address => _address;
  String? get city => _city;
  String? get postalCode => _postalCode;
  String? get language => _language;
  String? get bio => _bio;
  String? get prImage => _prImage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firebaseUserId'] = _firebaseUserId;
    map['full_name'] = _fullName;
    map['user_name'] = _userName;
    map['email'] = _email;
    map['dob'] = _dob;
    map['phone'] = _phone;
    map['password'] = _password;
    map['address'] = _address;
    map['city'] = _city;
    map['postal_code'] = _postalCode;
    map['language'] = _language;
    map['bio'] = _bio;
    map['pr_image'] = _prImage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}