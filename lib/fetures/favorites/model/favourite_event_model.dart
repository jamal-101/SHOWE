class Favourite_event_model {
  bool? success;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  Favourite_event_model(
      {this.success, this.message, this.pagination, this.data});

  Favourite_event_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        // 💡 স্টেপ ১: ব্যাকএন্ড থেকে আসা নাল অবজেক্ট ফিল্টার করার চেক
        if (v != null) {
          data!.add(new Data.fromJson(v));
        }
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
  Host? host;
  Social? social;
  Location? location;
  String? sId;
  String? title;
  String? category;
  bool? isFeatured;
  List<String>? tags;
  String? author;
  String? coverImage;
  List<String>? gallery;
  String? descriptionHtml;
  List<String>? highlights;
  String? getTicketsUrl;
  List<Performances>? performances;
  int? price;
  String? eventDate;
  String? vanue;
  String? programme;
  List<String>? nearbyRestaurants;
  List<String>? nearbyHotels;
  List<String>? nearbyBars;
  String? status;
  int? qrScanCount;
  int? interestCount;
  int? downloadsCount;
  int? revingeCount;
  String? createdAt;
  String? updatedAt;
  String? address;
  int? iV;

  Data(
      {this.host,
        this.social,
        this.location,
        this.sId,
        this.title,
        this.category,
        this.isFeatured,
        this.tags,
        this.author,
        this.coverImage,
        this.gallery,
        this.descriptionHtml,
        this.highlights,
        this.getTicketsUrl,
        this.performances,
        this.price,
        this.eventDate,
        this.vanue,
        this.programme,
        this.nearbyRestaurants,
        this.nearbyHotels,
        this.nearbyBars,
        this.status,
        this.qrScanCount,
        this.interestCount,
        this.downloadsCount,
        this.revingeCount,
        this.createdAt,
        this.updatedAt,
        this.address,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    social = json['social'] != null ? new Social.fromJson(json['social']) : null;
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    sId = json['_id'];
    title = json['title'];
    category = json['category'];
    isFeatured = json['is_featured'];

    // 💡 স্টেপ ২: .cast<String>() এর বদলে নাল এবং টাইপ সেইফ কনভার্সন
    tags = json['tags'] != null ? List<String>.from(json['tags'].map((x) => x.toString())) : [];
    author = json['author'];
    coverImage = json['cover_image'];
    gallery = json['gallery'] != null ? List<String>.from(json['gallery'].map((x) => x.toString())) : [];
    descriptionHtml = json['description_html'];
    highlights = json['highlights'] != null ? List<String>.from(json['highlights'].map((x) => x.toString())) : [];
    getTicketsUrl = json['get_tickets_url'];

    if (json['performances'] != null) {
      performances = <Performances>[];
      json['performances'].forEach((v) {
        if (v != null) {
          performances!.add(new Performances.fromJson(v));
        }
      });
    }
    price = json['price'];
    eventDate = json['event_date'];
    vanue = json['vanue'];
    programme = json['programme'];

    nearbyRestaurants = json['nearby_restaurants'] != null ? List<String>.from(json['nearby_restaurants'].map((x) => x.toString())) : [];
    nearbyHotels = json['nearby_hotels'] != null ? List<String>.from(json['nearby_hotels'].map((x) => x.toString())) : [];
    nearbyBars = json['nearby_bars'] != null ? List<String>.from(json['nearby_bars'].map((x) => x.toString())) : [];

    status = json['status'];
    qrScanCount = json['qr_scan_count'];
    interestCount = json['interest_count'];
    downloadsCount = json['downloads_count'];
    revingeCount = json['revinge_count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['category'] = this.category;
    data['is_featured'] = this.isFeatured;
    data['tags'] = this.tags;
    data['author'] = this.author;
    data['cover_image'] = this.coverImage;
    data['gallery'] = this.gallery;
    data['description_html'] = this.descriptionHtml;
    data['highlights'] = this.highlights;
    data['get_tickets_url'] = this.getTicketsUrl;
    if (this.performances != null) {
      data['performances'] = this.performances!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['event_date'] = this.eventDate;
    data['vanue'] = this.vanue;
    data['programme'] = this.programme;
    data['nearby_restaurants'] = this.nearbyRestaurants;
    data['nearby_hotels'] = this.nearbyHotels;
    data['nearby_bars'] = this.nearbyBars;
    data['status'] = this.status;
    data['qr_scan_count'] = this.qrScanCount;
    data['interest_count'] = this.interestCount;
    data['downloads_count'] = this.downloadsCount;
    data['revinge_count'] = this.revingeCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['address'] = this.address;
    data['__v'] = this.iV;
    return data;
  }
}

class Host {
  String? name;
  bool? isVerified;

  Host({this.name, this.isVerified});

  Host.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['is_verified'] = this.isVerified;
    return data;
  }
}

class Social {
  String? shareUrl;
  String? shareText;
  int? viewsCount;

  Social({this.shareUrl, this.shareText, this.viewsCount});

  Social.fromJson(Map<String, dynamic> json) {
    shareUrl = json['share_url'];
    shareText = json['share_text'];
    viewsCount = json['views_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['share_url'] = this.shareUrl;
    data['share_text'] = this.shareText;
    data['views_count'] = this.viewsCount;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    // 💡 স্টেপ ৩: double কাস্টিং এর সময় টাইপ মিসম্যাচ এরর হ্যান্ডেল করা হলো
    if (json['coordinates'] != null) {
      coordinates = List<double>.from(json['coordinates'].map((x) => num.parse(x.toString()).toDouble()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Performances {
  String? date;
  String? startTime;
  String? endTime;
  String? type;
  String? sId;

  Performances({this.date, this.startTime, this.endTime, this.type, this.sId});

  Performances.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    type = json['type'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['type'] = this.type;
    data['_id'] = this.sId;
    return data;
  }
}