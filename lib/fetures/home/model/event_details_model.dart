class Event_details_model {
  bool? success;
  String? message;
  Data? data;

  Event_details_model({this.success, this.message, this.data});

  Event_details_model.fromJson(Map<String, dynamic> json) {
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
  int? revingeCount;
  String? sId;
  String? title;
  String? category;
  bool? isFeatured;
  List<String>? tags;
  Author? author;
  Artist? artist;
  String? coverImage;
  List<String>? gallery;
  String? descriptionHtml;
  List<String>? highlights;
  String? getTicketsUrl;
  List<Performances>? performances;
  Host? host;
  num? price;
  String? eventDate;
  Vanue? vanue;
  String? programme;
  Social? social;
  List<NearbyRestaurants>? nearbyRestaurants;
  List<NearbyHotels>? nearbyHotels;
  List<NearbyBars>? nearbyBars;
  String? status;
  Location? location;
  int? qrScanCount;
  String? createdAt;
  String? updatedAt;
  String? address;
  int? iV;
  bool? isFavorited;
  List<dynamic>? someInterestPeopsle;
  bool? isAlreadyProgrammePurchased;
  Programme? programmeData;
  num? pricePence;

  Data({
    this.sId,
    this.title,
    this.category,
    this.isFeatured,
    this.tags,
    this.author,
    this.artist,
    this.coverImage,
    this.gallery,
    this.descriptionHtml,
    this.highlights,
    this.getTicketsUrl,
    this.performances,
    this.host,
    this.price,
    this.eventDate,
    this.vanue,
    this.programme,
    this.social,
    this.nearbyRestaurants,
    this.nearbyHotels,
    this.nearbyBars,
    this.status,
    this.location,
    this.qrScanCount,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.iV,
    this.isFavorited,
    this.someInterestPeopsle,
    bool? isAlreadyProgrammePurchased,
    this.programmeData,
    this.pricePence,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    revingeCount = json['revinge_count'];
    category = json['category'];
    isFeatured = json['is_featured'];
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    coverImage = json['cover_image'];
    gallery = json['gallery'] != null ? List<String>.from(json['gallery']) : null;
    descriptionHtml = json['description_html'];
    highlights = json['highlights'] != null ? List<String>.from(json['highlights']) : null;
    getTicketsUrl = json['get_tickets_url'];

    if (json['performances'] != null) {
      performances = <Performances>[];
      json['performances'].forEach((v) {
        performances!.add(Performances.fromJson(v));
      });
    }

    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    price = json['price'];
    eventDate = json['event_date'];
    vanue = json['vanue'] != null ? Vanue.fromJson(json['vanue']) : null;

    if (json['programme'] != null) {
      if (json['programme'] is Map) {
        programmeData = Programme.fromJson(Map<String, dynamic>.from(json['programme']));
        programme = programmeData?.title;
        pricePence = programmeData?.pricePence;
      } else {
        programme = json['programme'].toString();
      }
    }

    social = json['social'] != null ? Social.fromJson(json['social']) : null;

    if (json['nearby_restaurants'] != null) {
      nearbyRestaurants = <NearbyRestaurants>[];
      json['nearby_restaurants'].forEach((v) {
        nearbyRestaurants!.add(NearbyRestaurants.fromJson(v));
      });
    }

    if (json['nearby_hotels'] != null) {
      nearbyHotels = <NearbyHotels>[];
      json['nearby_hotels'].forEach((v) {
        nearbyHotels!.add(NearbyHotels.fromJson(v));
      });
    }

    if (json['nearby_bars'] != null) {
      nearbyBars = <NearbyBars>[];
      json['nearby_bars'].forEach((v) {
        nearbyBars!.add(NearbyBars.fromJson(v));
      });
    }

    status = json['status'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    qrScanCount = json['qr_scan_count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    iV = json['__v'];
    isFavorited = json['isFavorited'];

    if (json['someInterestPeopsle'] != null) {
      someInterestPeopsle = List<dynamic>.from(json['someInterestPeopsle']);
    }
    isAlreadyProgrammePurchased = json['is_already_programme_purchased'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['revinge_count'] = revingeCount;
    data['_id'] = sId;
    data['title'] = title;
    data['category'] = category;
    data['is_featured'] = isFeatured;
    data['tags'] = tags;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (artist != null) {
      data['artist'] = artist!.toJson();
    }
    data['cover_image'] = coverImage;
    data['gallery'] = gallery;
    data['description_html'] = descriptionHtml;
    data['highlights'] = highlights;
    data['get_tickets_url'] = getTicketsUrl;
    if (performances != null) {
      data['performances'] = performances!.map((v) => v.toJson()).toList();
    }
    if (host != null) {
      data['host'] = host!.toJson();
    }
    data['price'] = price;
    data['event_date'] = eventDate;
    if (vanue != null) {
      data['vanue'] = vanue!.toJson();
    }
    data['programme'] = programme;
    if (social != null) {
      data['social'] = social!.toJson();
    }

    if (programmeData != null) {
      data['programme'] = programmeData!.toJson();
    } else {
      data['programme'] = programme;
    }

    if (nearbyRestaurants != null) {
      data['nearby_restaurants'] = nearbyRestaurants!.map((v) => v.toJson()).toList();
    }
    if (nearbyHotels != null) {
      data['nearby_hotels'] = nearbyHotels!.map((v) => v.toJson()).toList();
    }
    if (nearbyBars != null) {
      data['nearby_bars'] = nearbyBars!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['qr_scan_count'] = qrScanCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['address'] = address;
    data['__v'] = iV;
    data['isFavorited'] = isFavorited;
    if (someInterestPeopsle != null) {
      data['someInterestPeopsle'] = someInterestPeopsle;
    }
    data['is_already_programme_purchased'] = isAlreadyProgrammePurchased;
    return data;
  }
}

class Author {
  String? name;
  String? email;
  String? image;
  int? followersCount;
  String? sId;
  bool? following;

  Author({this.name, this.email, this.image, this.followersCount, this.sId, this.following});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    followersCount = json['followers_count'];
    sId = json['_id'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['followers_count'] = followersCount;
    data['_id'] = sId;
    data['following'] = following;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['type'] = type;
    data['_id'] = sId;
    return data;
  }
}

class Host {
  String? name;
  bool? isVerified;

  Host({this.name, this.isVerified});

  Host.fromJson(Map<String, dynamic> json) {
    if (json is Map<String, dynamic>) {
      name = json['name'];
      isVerified = json['is_verified'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['is_verified'] = isVerified;
    return data;
  }
}

class Vanue {
  String? sId;
  String? name;
  String? addressLine1;

  Vanue({this.sId, this.name, this.addressLine1});

  Vanue.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    addressLine1 = json['address_line1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['address_line1'] = addressLine1;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['share_url'] = shareUrl;
    data['share_text'] = shareText;
    data['views_count'] = viewsCount;
    return data;
  }
}

class NearbyRestaurants {
  String? sId;
  String? name;
  String? image;
  String? category;
  num? rating;
  String? distance;
  String? price;
  String? location;
  String? description;
  String? website;
  String? owner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NearbyRestaurants({
    this.sId,
    this.name,
    this.image,
    this.category,
    this.rating,
    this.distance,
    this.price,
    this.location,
    this.description,
    this.website,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  NearbyRestaurants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    category = json['category'];
    rating = json['rating'];
    distance = json['distance'];
    price = json['price']?.toString();
    location = json['location'];
    description = json['description'];
    website = json['website'];
    owner = json['owner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['category'] = category;
    data['rating'] = rating;
    data['distance'] = distance;
    data['price'] = price;
    data['location'] = location;
    data['description'] = description;
    data['website'] = website;
    data['owner'] = owner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class NearbyHotels {
  String? sId;
  String? name;
  String? image;
  String? rating;
  String? distance;
  String? website;

  NearbyHotels({this.sId, this.name, this.image, this.rating, this.distance});

  NearbyHotels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating']?.toString();
    distance = json['distance'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['rating'] = rating;
    data['distance'] = distance;
    data['website'] = website;
    return data;
  }
}

class NearbyBars {
  String? sId;
  String? name;
  String? image;
  String? rating;
  String? distance;
  String? website;

  NearbyBars({this.sId, this.name, this.image, this.rating, this.distance});

  NearbyBars.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating']?.toString();
    distance = json['distance'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['rating'] = rating;
    data['distance'] = distance;
    data['website'] = website;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = (json['coordinates'] as List).map((e) => (e as num).toDouble()).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
class Artist {
  String? sId;
  String? name;
  String? image;
  String? type;

  Artist({this.sId, this.name, this.image, this.type});

  Artist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['type'] = type;
    return data;
  }
}


class Programme {
  String? sId;
  String? title;
  bool? isFree;
  num? pricePence;

  Programme({this.sId, this.title, this.isFree, this.pricePence});

  Programme.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isFree = json['is_free'];
    pricePence = json['price_pence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['is_free'] = isFree;
    data['price_pence'] = pricePence;
    return data;
  }
}