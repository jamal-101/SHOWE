class NotificationModel {
  bool? success;
  String? message;
  Pagination? pagination;
  NotificationData? data;

  NotificationModel({
    this.success,
    this.message,
    this.pagination,
    this.data,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    data = json['data'] != null
        ? NotificationData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Pagination {
  int? total;
  int? limit;
  int? page;
  int? totalPage;

  Pagination({this.total, this.limit, this.page, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    page = json['page'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['limit'] = limit;
    map['page'] = page;
    map['totalPage'] = totalPage;
    return map;
  }
}

class NotificationData {
  int? unreadCount;
  List<NotificationItem>? notifications;

  NotificationData({this.unreadCount, this.notifications});

  NotificationData.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unreadCount'];
    if (json['data'] != null) {
      notifications = <NotificationItem>[];
      json['data'].forEach((v) {
        notifications!.add(NotificationItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['unreadCount'] = unreadCount;
    if (notifications != null) {
      map['data'] = notifications!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

// class NotificationItem {
//   String? sId;
//   String? title;
//   List<String>? receiver;
//   String? message;
//   String? filePath;
//   bool? isRead;
//   List<dynamic>? readers;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   NotificationItem({
//     this.sId,
//     this.title,
//     this.receiver,
//     this.message,
//     this.filePath,
//     this.isRead,
//     this.readers,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//   });
//
//   NotificationItem.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     if (json['receiver'] != null) {
//       receiver = List<String>.from(json['receiver']);
//     }
//     message = json['message'];
//     filePath = json['filePath'];
//     isRead = json['isRead'];
//     readers = json['readers'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = {};
//     map['_id'] = sId;
//     map['title'] = title;
//     map['receiver'] = receiver;
//     map['message'] = message;
//     map['filePath'] = filePath;
//     map['isRead'] = isRead;
//     map['readers'] = readers;
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     map['__v'] = iV;
//     return map;
//   }
// }


class NotificationItem {
  String? sId;
  String? title;
  List<String>? receiver;
  String? message;
  String? filePath;
  bool? isRead;
  List<dynamic>? readers;
  String? extraPath; // ✅ নতুন extraPath ফিল্ড যুক্ত করা হলো
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationItem({
    this.sId,
    this.title,
    this.receiver,
    this.message,
    this.filePath,
    this.isRead,
    this.readers,
    this.extraPath,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  NotificationItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    if (json['receiver'] != null) {
      receiver = List<String>.from(json['receiver']);
    }
    message = json['message'];
    filePath = json['filePath'];
    isRead = json['isRead'];
    readers = json['readers'];
    extraPath = json['extraPath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['_id'] = sId;
    map['title'] = title;
    map['receiver'] = receiver;
    map['message'] = message;
    map['filePath'] = filePath;
    map['isRead'] = isRead;
    map['readers'] = readers;
    map['extraPath'] = extraPath;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = iV;
    return map;
  }
}