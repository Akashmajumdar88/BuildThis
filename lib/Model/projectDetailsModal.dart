
class ProjectDetailsModal {
  ProjectDetailsModal({
      bool? success, 
      num? status, 
      String? message,
    DataProject? data,}){
    _success = success;
    _status = status;
    _message = message;
    _data = data;
}

  ProjectDetailsModal.fromJson(dynamic json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? DataProject.fromJson(json['data']) : null;
  }
  bool? _success;
  num? _status;
  String? _message;
  DataProject? _data;
ProjectDetailsModal copyWith({  bool? success,
  num? status,
  String? message,
  DataProject? data,
}) => ProjectDetailsModal(  success: success ?? _success,
  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  num? get status => _status;
  String? get message => _message;
  DataProject? get data => _data;

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

class DataProject {
  DataProject({
      num? id, 
      String? projectName, 
      String? startDate, 
      String? endDate, 
      String? category, 
      dynamic skillsName, 
      String? tagBy, 
      String? description, 
      dynamic rejectionReason, 
      String? logo, 
      dynamic createDate, 
      String? status, 
      num? createdBy, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _projectName = projectName;
    _startDate = startDate;
    _endDate = endDate;
    _category = category;
    _skillsName = skillsName;
    _tagBy = tagBy;
    _description = description;
    _rejectionReason = rejectionReason;
    _logo = logo;
    _createDate = createDate;
    _status = status;
    _createdBy = createdBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  DataProject.fromJson(dynamic json) {
    _id = json['id'];
    _projectName = json['project_name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _category = json['category'];
    _skillsName = json['skills_name'];
    _tagBy = json['tag_by'];
    _description = json['description'];
    _rejectionReason = json['rejection_reason'];
    _logo = json['logo'];
    _createDate = json['createDate'];
    _status = json['status'];
    _createdBy = json['created__by'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  String? _projectName;
  String? _startDate;
  String? _endDate;
  String? _category;
  dynamic _skillsName;
  String? _tagBy;
  String? _description;
  dynamic _rejectionReason;
  String? _logo;
  dynamic _createDate;
  String? _status;
  num? _createdBy;
  String? _createdAt;
  String? _updatedAt;
  DataProject copyWith({  num? id,
  String? projectName,
  String? startDate,
  String? endDate,
  String? category,
  dynamic skillsName,
  String? tagBy,
  String? description,
  dynamic rejectionReason,
  String? logo,
  dynamic createDate,
  String? status,
  num? createdBy,
  String? createdAt,
  String? updatedAt,
}) => DataProject(  id: id ?? _id,
  projectName: projectName ?? _projectName,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  category: category ?? _category,
  skillsName: skillsName ?? _skillsName,
  tagBy: tagBy ?? _tagBy,
  description: description ?? _description,
  rejectionReason: rejectionReason ?? _rejectionReason,
  logo: logo ?? _logo,
  createDate: createDate ?? _createDate,
  status: status ?? _status,
  createdBy: createdBy ?? _createdBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get projectName => _projectName;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get category => _category;
  dynamic get skillsName => _skillsName;
  String? get tagBy => _tagBy;
  String? get description => _description;
  dynamic get rejectionReason => _rejectionReason;
  String? get logo => _logo;
  dynamic get createDate => _createDate;
  String? get status => _status;
  num? get createdBy => _createdBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['project_name'] = _projectName;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['category'] = _category;
    map['skills_name'] = _skillsName;
    map['tag_by'] = _tagBy;
    map['description'] = _description;
    map['rejection_reason'] = _rejectionReason;
    map['logo'] = _logo;
    map['createDate'] = _createDate;
    map['status'] = _status;
    map['created__by'] = _createdBy;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}