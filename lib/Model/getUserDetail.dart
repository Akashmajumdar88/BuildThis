
class GetUserDetail {
  GetUserDetail({
      bool? success, 
      num? status, 
      String? message,
    UserData? data,}){
    _success = success;
    _status = status;
    _message = message;
    _data = data;
}

  GetUserDetail.fromJson(dynamic json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  bool? _success;
  num? _status;
  String? _message;
  UserData? _data;
GetUserDetail copyWith({  bool? success,
  num? status,
  String? message,
  UserData? data,
}) => GetUserDetail(  success: success ?? _success,
  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  num? get status => _status;
  String? get message => _message;
  UserData? get data => _data;

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

class UserData {
  UserData({
      num? id, 
      String? firebaseUserId, 
      String? fullName, 
      String? userName, 
      dynamic firstName, 
      dynamic lastName, 
      String? email, 
      String? dob, 
      String? phone, 
      String? profileComplete, 
      String? role, 
      String? password, 
      String? address, 
      String? city, 
      String? postalCode, 
      String? language, 
      String? bio, 
      dynamic otp, 
      String? prImage, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _firebaseUserId = firebaseUserId;
    _fullName = fullName;
    _userName = userName;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _dob = dob;
    _phone = phone;
    _profileComplete = profileComplete;
    _role = role;
    _password = password;
    _address = address;
    _city = city;
    _postalCode = postalCode;
    _language = language;
    _bio = bio;
    _otp = otp;
    _prImage = prImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  UserData.fromJson(dynamic json) {
    _id = json['id'];
    _firebaseUserId = json['firebaseUserId'];
    _fullName = json['full_name'];
    _userName = json['user_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _dob = json['dob'];
    _phone = json['phone'];
    _profileComplete = json['profile_Complete'];
    _role = json['role'];
    _password = json['password'];
    _address = json['address'];
    _city = json['city'];
    _postalCode = json['postal_code'];
    _language = json['language'];
    _bio = json['bio'];
    _otp = json['otp'];
    _prImage = json['pr_image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  String? _firebaseUserId;
  String? _fullName;
  String? _userName;
  dynamic _firstName;
  dynamic _lastName;
  String? _email;
  String? _dob;
  String? _phone;
  String? _profileComplete;
  String? _role;
  String? _password;
  String? _address;
  String? _city;
  String? _postalCode;
  String? _language;
  String? _bio;
  dynamic _otp;
  String? _prImage;
  String? _createdAt;
  String? _updatedAt;
  UserData copyWith({  num? id,
  String? firebaseUserId,
  String? fullName,
  String? userName,
  dynamic firstName,
  dynamic lastName,
  String? email,
  String? dob,
  String? phone,
  String? profileComplete,
  String? role,
  String? password,
  String? address,
  String? city,
  String? postalCode,
  String? language,
  String? bio,
  dynamic otp,
  String? prImage,
  String? createdAt,
  String? updatedAt,
}) => UserData(  id: id ?? _id,
  firebaseUserId: firebaseUserId ?? _firebaseUserId,
  fullName: fullName ?? _fullName,
  userName: userName ?? _userName,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  dob: dob ?? _dob,
  phone: phone ?? _phone,
  profileComplete: profileComplete ?? _profileComplete,
  role: role ?? _role,
  password: password ?? _password,
  address: address ?? _address,
  city: city ?? _city,
  postalCode: postalCode ?? _postalCode,
  language: language ?? _language,
  bio: bio ?? _bio,
  otp: otp ?? _otp,
  prImage: prImage ?? _prImage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get firebaseUserId => _firebaseUserId;
  String? get fullName => _fullName;
  String? get userName => _userName;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  String? get email => _email;
  String? get dob => _dob;
  String? get phone => _phone;
  String? get profileComplete => _profileComplete;
  String? get role => _role;
  String? get password => _password;
  String? get address => _address;
  String? get city => _city;
  String? get postalCode => _postalCode;
  String? get language => _language;
  String? get bio => _bio;
  dynamic get otp => _otp;
  String? get prImage => _prImage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firebaseUserId'] = _firebaseUserId;
    map['full_name'] = _fullName;
    map['user_name'] = _userName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['dob'] = _dob;
    map['phone'] = _phone;
    map['profile_Complete'] = _profileComplete;
    map['role'] = _role;
    map['password'] = _password;
    map['address'] = _address;
    map['city'] = _city;
    map['postal_code'] = _postalCode;
    map['language'] = _language;
    map['bio'] = _bio;
    map['otp'] = _otp;
    map['pr_image'] = _prImage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}