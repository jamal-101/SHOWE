class Profile_model {
  bool? success;
  String? message;
  Data? data;

  Profile_model({this.success, this.message, this.data});

  Profile_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? role;
  String? email;
  String? image;
  String? status;
  String? contact;
  Null? location;
  bool? verified;
  Null? subscription;
  bool? isSuspended;
  Null? suspendedAt;
  Null? suspendedReason;
  Null? suspendedDays;
  Null? suspendedUntil;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.name,
        this.role,
        this.email,
        this.image,
        this.status,
        this.contact,
        this.location,
        this.verified,
        this.subscription,
        this.isSuspended,
        this.suspendedAt,
        this.suspendedReason,
        this.suspendedDays,
        this.suspendedUntil,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    image = json['image'];
    status = json['status'];
    contact = json['contact'];
    location = json['location'];
    verified = json['verified'];
    subscription = json['subscription'];
    isSuspended = json['isSuspended'];
    suspendedAt = json['suspendedAt'];
    suspendedReason = json['suspendedReason'];
    suspendedDays = json['suspendedDays'];
    suspendedUntil = json['suspendedUntil'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['role'] = this.role;
    data['email'] = this.email;
    data['image'] = this.image;
    data['status'] = this.status;
    data['contact'] = this.contact;
    data['location'] = this.location;
    data['verified'] = this.verified;
    data['subscription'] = this.subscription;
    data['isSuspended'] = this.isSuspended;
    data['suspendedAt'] = this.suspendedAt;
    data['suspendedReason'] = this.suspendedReason;
    data['suspendedDays'] = this.suspendedDays;
    data['suspendedUntil'] = this.suspendedUntil;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}