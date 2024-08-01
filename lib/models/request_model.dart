class RequestModel {
  RequestModel({
    required this.requestId,
    required this.requestedBy,
    required this.requestdFor,
    required this.requestType,
    required this.documentName,
    required this.nameOfTheInstitution,
    required this.addressOfTheInstitution,
    required this.status,
    required this.requestedDate,
    required this.date,
    required this.purpose,
    required this.files,
    required this.remarks,
  });
  late final String requestId;
  late final String requestedBy;
  late final String requestdFor;
  late final String requestType;
  late final String documentName;
  late final String nameOfTheInstitution;
  late final String addressOfTheInstitution;
  late final String status;
  late final RequestedDate requestedDate;
  late final Date date;
  late final String purpose;
  late final List<dynamic> files;
  late final String remarks;

  RequestModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    requestedBy = json['requestedBy'];
    requestdFor = json['requestdFor'];
    requestType = json['requestType'];
    documentName = json['documentName'];
    nameOfTheInstitution = json['nameOfTheInstitution'];
    addressOfTheInstitution = json['addressOfTheInstitution'];
    status = json['status'];
    requestedDate = RequestedDate.fromJson(json['requestedDate']);
    date = Date.fromJson(json['date']);
    purpose = json['purpose'];
    files = List.castFrom<dynamic, dynamic>(json['files']);
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['requestId'] = requestId;
    _data['requestedBy'] = requestedBy;
    _data['requestdFor'] = requestdFor;
    _data['requestType'] = requestType;
    _data['documentName'] = documentName;
    _data['nameOfTheInstitution'] = nameOfTheInstitution;
    _data['addressOfTheInstitution'] = addressOfTheInstitution;
    _data['status'] = status;
    _data['requestedDate'] = requestedDate.toJson();
    _data['date'] = date.toJson();
    _data['purpose'] = purpose;
    _data['files'] = files;
    _data['remarks'] = remarks;
    return _data;
  }
}

class RequestedDate {
  RequestedDate({
    required this.day,
    required this.month,
    required this.year,
  });
  late final String day;
  late final String month;
  late final String year;

  RequestedDate.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}

class Date {
  Date({
    required this.day,
    required this.month,
    required this.year,
  });
  late final String day;
  late final String month;
  late final String year;

  Date.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}


// class RequestModel {
//   RequestModel({
//     required this.requestId,
//     required this.requestedBy,
//     required this.requestdFor,
//     required this.requestType,
//     required this.documentName,
//     required this.nameOfTheInstitution,
//     required this.addressOfTheInstitution,
//     required this.date,
//     required this.purpose,
//     required this.files,
//     required this.remarks,
//   });
//   late final String requestId;
//   late final String requestedBy;
//   late final String requestdFor;
//   late final String requestType;
//   late final String documentName;
//   late final String nameOfTheInstitution;
//   late final String addressOfTheInstitution;
//   late final Date date;
//   late final String purpose;
//   late final List<dynamic> files;
//   late final String remarks;

//   RequestModel.fromJson(Map<String, dynamic> json) {
//     requestId = json['requestId'];
//     requestedBy = json['requestedBy'];
//     requestdFor = json['requestdFor'];
//     requestType = json['requestType'];
//     documentName = json['documentName'];
//     nameOfTheInstitution = json['nameOfTheInstitution'];
//     addressOfTheInstitution = json['addressOfTheInstitution'];
//     date = Date.fromJson(json['date']);
//     purpose = json['purpose'];
//     files = List.castFrom<dynamic, dynamic>(json['files']);
//     remarks = json['remarks'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['requestId'] = requestId;
//     _data['requestedBy'] = requestedBy;
//     _data['requestdFor'] = requestdFor;
//     _data['requestType'] = requestType;
//     _data['documentName'] = documentName;
//     _data['nameOfTheInstitution'] = nameOfTheInstitution;
//     _data['addressOfTheInstitution'] = addressOfTheInstitution;
//     _data['date'] = date.toJson();
//     _data['purpose'] = purpose;
//     _data['files'] = files;
//     _data['remarks'] = remarks;
//     return _data;
//   }
// }

// class Date {
//   Date({
//     required this.day,
//     required this.month,
//     required this.year,
//   });
//   late final String day;
//   late final String month;
//   late final String year;

//   Date.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     month = json['month'];
//     year = json['year'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['day'] = day;
//     _data['month'] = month;
//     _data['year'] = year;
//     return _data;
//   }
// }
