
class MyProjectModel {
  int id;
  String projectName;
  String status;


  MyProjectModel({
    required this.id,
    required this.projectName,
    required this.status,
  });
}

class MySkillModel {
  int id;
  String skillName;


  MySkillModel({
    required this.id,
    required this.skillName,
  });
}

class MyCertificateModel {
  int id;
  String certificateName;


  MyCertificateModel({
    required this.id,
    required this.certificateName,
  });
}

class MyInviteModel {
  int id;
  String senderId;
  String projectName;
  String status;
  String invitedDate;
  String projectOwnerName;


  MyInviteModel({
    required this.id,
    required this.senderId,
    required this.projectName,
    required this.status,
    required this.invitedDate,
    required this.projectOwnerName,
  });
}

class MyInviteSendModel {
  int id;
  String senderId;
  String projectName;
  String status;
  String invitedDate;
  String projectOwnerName;


  MyInviteSendModel({
    required this.id,
    required this.senderId,
    required this.projectName,
    required this.status,
    required this.invitedDate,
    required this.projectOwnerName,
  });
}

class MyInterestModel {
  int id;
  String senderId;
  String fullName;
  String email;
  String phone;
  String projectName;
  String status;


  MyInterestModel({
    required this.id,
    required this.senderId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.projectName,
    required this.status,
  });
}

class MyInterestSendModel {
  int id;
  String senderId;
  String fullName;
  String email;
  String phone;
  String projectName;
  String status;


  MyInterestSendModel({
    required this.id,
    required this.senderId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.projectName,
    required this.status,
  });
}
