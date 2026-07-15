class Favourite_venue_model {
  bool? success;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  Favourite_venue_model(
      {this.success, this.message, this.pagination, this.data});

  Favourite_venue_model.fromJson(Map<String, dynamic> json) {
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
  Location? location;
  String? sId;
  String? owner;
  String? name;
  String? status;
  String? coverImage;
  String? logo;
  String? description;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? contactEmail;
  String? contactPhone;
  String? website;
  String? brandColor;
  int? programmesCount;
  int? eventsCount;
  int? totalDownloads;
  int? totalRevenue;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.location,
        this.sId,
        this.owner,
        this.name,
        this.status,
        this.coverImage,
        this.logo,
        this.description,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.contactEmail,
        this.contactPhone,
        this.website,
        this.brandColor,
        this.programmesCount,
        this.eventsCount,
        this.totalDownloads,
        this.totalRevenue,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    owner = json['owner'];
    name = json['name'];
    status = json['status'];
    coverImage = json['cover_image'];
    logo = json['logo'];
    description = json['description'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zip_code'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    website = json['website'];
    brandColor = json['brand_color'];
    programmesCount = json['programmes_count'];
    eventsCount = json['events_count'];
    totalDownloads = json['total_downloads'];
    totalRevenue = json['total_revenue'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['owner'] = this.owner;
    data['name'] = this.name;
    data['status'] = this.status;
    data['cover_image'] = this.coverImage;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip_code'] = this.zipCode;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['website'] = this.website;
    data['brand_color'] = this.brandColor;
    data['programmes_count'] = this.programmesCount;
    data['events_count'] = this.eventsCount;
    data['total_downloads'] = this.totalDownloads;
    data['total_revenue'] = this.totalRevenue;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? type;
  List<int>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}