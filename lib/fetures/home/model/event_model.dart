class Event_model {
  bool? success;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  Event_model({this.success, this.message, this.pagination, this.data});

  Event_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? category;
  String? coverImage;
  // int? price;
  num? price;
  String? eventDate;
  int? interestCount;
  String? address;
  bool? isFavorited;
  List<SomeInterestPeopsle>? someInterestPeopsle;

  Data(
      {this.sId,
        this.title,
        this.category,
        this.coverImage,
        this.price,
        this.eventDate,
        this.interestCount,
        this.address,
        this.isFavorited,
        this.someInterestPeopsle});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    category = json['category'];
    coverImage = json['cover_image'];
    price = json['price'];
    eventDate = json['event_date'];
    interestCount = json['interest_count'];
    address = json['address'];
    isFavorited = json['isFavorited'];
    if (json['someInterestPeopsle'] != null) {
      someInterestPeopsle = <SomeInterestPeopsle>[];
      json['someInterestPeopsle'].forEach((v) {
        if (v != null && v is Map<String, dynamic>) {
          someInterestPeopsle!.add(SomeInterestPeopsle.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['category'] = this.category;
    data['cover_image'] = this.coverImage;
    data['price'] = this.price;
    data['event_date'] = this.eventDate;
    data['interest_count'] = this.interestCount;
    data['address'] = this.address;
    data['isFavorited'] = this.isFavorited;
    if (someInterestPeopsle != null) {
      data['someInterestPeopsle'] =
          someInterestPeopsle!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SomeInterestPeopsle {
  String? sId;
  String? name;
  String? image;

  SomeInterestPeopsle({this.sId, this.name, this.image});

  SomeInterestPeopsle.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}