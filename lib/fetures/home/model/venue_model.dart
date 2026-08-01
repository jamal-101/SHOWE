class Venue_model {
  bool? success;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  Venue_model({this.success, this.message, this.pagination, this.data});

  Venue_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['success'] = success;
    dataMap['message'] = message;
    if (pagination != null) {
      dataMap['pagination'] = pagination!.toJson();
    }
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
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
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['total'] = total;
    dataMap['limit'] = limit;
    dataMap['page'] = page;
    dataMap['totalPage'] = totalPage;
    return dataMap;
  }
}

class Data {
  Coordinates? coordinates;
  Location? location;
  String? sId;
  Owner? owner;
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
  bool? isFavorited;

  Data({
    this.coordinates,
    this.location,
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
    this.iV,
    this.isFavorited = false,
  });

  Data.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
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
    isFavorited = json['isFavorited'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    if (coordinates != null) {
      dataMap['coordinates'] = coordinates!.toJson();
    }
    if (location != null) {
      dataMap['location'] = location!.toJson();
    }
    dataMap['_id'] = sId;
    if (owner != null) {
      dataMap['owner'] = owner!.toJson();
    }
    dataMap['name'] = name;
    dataMap['status'] = status;
    dataMap['cover_image'] = coverImage;
    dataMap['logo'] = logo;
    dataMap['description'] = description;
    dataMap['address_line1'] = addressLine1;
    dataMap['address_line2'] = addressLine2;
    dataMap['city'] = city;
    dataMap['state'] = state;
    dataMap['country'] = country;
    dataMap['zip_code'] = zipCode;
    dataMap['contact_email'] = contactEmail;
    dataMap['contact_phone'] = contactPhone;
    dataMap['website'] = website;
    dataMap['brand_color'] = brandColor;
    dataMap['programmes_count'] = programmesCount;
    dataMap['events_count'] = eventsCount;
    dataMap['total_downloads'] = totalDownloads;
    dataMap['total_revenue'] = totalRevenue;
    dataMap['createdAt'] = createdAt;
    dataMap['updatedAt'] = updatedAt;
    dataMap['__v'] = iV;
    dataMap['isFavorited'] = isFavorited;
    return dataMap;
  }
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['latitude'] = latitude;
    dataMap['longitude'] = longitude;
    return dataMap;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['type'] = type;
    dataMap['coordinates'] = coordinates;
    return dataMap;
  }
}

class Owner {
  String? sId;
  String? name;
  String? email;
  String? image;

  Owner({this.sId, this.name, this.email, this.image});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['_id'] = sId;
    dataMap['name'] = name;
    dataMap['email'] = email;
    dataMap['image'] = image;
    return dataMap;
  }
}