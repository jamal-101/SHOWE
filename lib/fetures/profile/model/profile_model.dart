// class Profile_model {
//   bool? success;
//   String? message;
//   Data? data;
//
//   Profile_model({this.success, this.message, this.data});
//
//   Profile_model.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? sId;
//   String? name;
//   String? role;
//   String? email;
//   String? image;
//   String? status;
//   String? contact;
//   Null? location;
//   bool? verified;
//   // Null? subscription;
//   Subscription? subscription;
//   bool? isSuspended;
//   Null? suspendedAt;
//   Null? suspendedReason;
//   Null? suspendedDays;
//   Null? suspendedUntil;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   Data(
//       {this.sId,
//         this.name,
//         this.role,
//         this.email,
//         this.image,
//         this.status,
//         this.contact,
//         this.location,
//         this.verified,
//         this.subscription,
//         this.isSuspended,
//         this.suspendedAt,
//         this.suspendedReason,
//         this.suspendedDays,
//         this.suspendedUntil,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     role = json['role'];
//     email = json['email'];
//     image = json['image'];
//     status = json['status'];
//     contact = json['contact'];
//     location = json['location'];
//     verified = json['verified'];
//     subscription = json['subscription'];
//     isSuspended = json['isSuspended'];
//     suspendedAt = json['suspendedAt'];
//     suspendedReason = json['suspendedReason'];
//     suspendedDays = json['suspendedDays'];
//     suspendedUntil = json['suspendedUntil'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['role'] = this.role;
//     data['email'] = this.email;
//     data['image'] = this.image;
//     data['status'] = this.status;
//     data['contact'] = this.contact;
//     data['location'] = this.location;
//     data['verified'] = this.verified;
//     data['subscription'] = this.subscription;
//     data['isSuspended'] = this.isSuspended;
//     data['suspendedAt'] = this.suspendedAt;
//     data['suspendedReason'] = this.suspendedReason;
//     data['suspendedDays'] = this.suspendedDays;
//     data['suspendedUntil'] = this.suspendedUntil;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }


class Profile_model {
  bool? success;
  String? message;
  Data? data;

  Profile_model({this.success, this.message, this.data});

  Profile_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
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
  dynamic location;
  bool? verified;
  Subscription? subscription; // 🔹 Null? থেকে Subscription? করা হয়েছে
  bool? isSuspended;
  String? suspendedAt;
  String? suspendedReason;
  int? suspendedDays;
  String? suspendedUntil;
  String? stripeAccountId;
  String? stripeLoginLink;
  List<dynamic>? permissions;
  String? organizationName;
  String? website;
  String? contactName;
  String? country;
  String? phone;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
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
    this.stripeAccountId,
    this.stripeLoginLink,
    this.permissions,
    this.organizationName,
    this.website,
    this.contactName,
    this.country,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

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
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    isSuspended = json['isSuspended'];
    suspendedAt = json['suspendedAt'];
    suspendedReason = json['suspendedReason'];
    suspendedDays = json['suspendedDays'];
    suspendedUntil = json['suspendedUntil'];
    stripeAccountId = json['stripe_account_id'];
    stripeLoginLink = json['stripe_login_link'];
    permissions = json['permissions'] != null ? List<dynamic>.from(json['permissions']) : [];
    organizationName = json['organization_name'];
    website = json['website'];
    contactName = json['contact_name'];
    country = json['country'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['role'] = role;
    data['email'] = email;
    data['image'] = image;
    data['status'] = status;
    data['contact'] = contact;
    data['location'] = location;
    data['verified'] = verified;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    data['isSuspended'] = isSuspended;
    data['suspendedAt'] = suspendedAt;
    data['suspendedReason'] = suspendedReason;
    data['suspendedDays'] = suspendedDays;
    data['suspendedUntil'] = suspendedUntil;
    data['stripe_account_id'] = stripeAccountId;
    data['stripe_login_link'] = stripeLoginLink;
    data['permissions'] = permissions;
    data['organization_name'] = organizationName;
    data['website'] = website;
    data['contact_name'] = contactName;
    data['country'] = country;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

// 🔹 Subscription Class
class Subscription {
  String? sId;
  String? name;
  String? endDate;
  List<int>? modules;
  bool? isProggrammeSell;
  int? minimumProgrammePrice;
  int? downloadFeePrice;

  Subscription({
    this.sId,
    this.name,
    this.endDate,
    this.modules,
    this.isProggrammeSell,
    this.minimumProgrammePrice,
    this.downloadFeePrice,
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    endDate = json['endDate'];
    modules = json['modules'] != null ? List<int>.from(json['modules']) : [];
    isProggrammeSell = json['is_proggramme_sell'];
    minimumProgrammePrice = json['minimum_programme_price'];
    downloadFeePrice = json['download_fee_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['endDate'] = endDate;
    data['modules'] = modules;
    data['is_proggramme_sell'] = isProggrammeSell;
    data['minimum_programme_price'] = minimumProgrammePrice;
    data['download_fee_price'] = downloadFeePrice;
    return data;
  }
}