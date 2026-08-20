class single_programm_model {
  bool? success;
  String? message;
  Data? data;

  single_programm_model({this.success, this.message, this.data});

  single_programm_model.fromJson(Map<String, dynamic> json) {
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
  String? owner;
  Null? eventId;
  String? title;
  List<Pages>? pages;
  String? status;
  bool? isFree;
  int? pricePence;
  int? clicks;
  int? views;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? publishedAt;
  String? category;
  String? coverImage;

  Data({
    this.sId,
    this.owner,
    this.eventId,
    this.title,
    this.pages,
    this.status,
    this.isFree,
    this.pricePence,
    this.clicks,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.publishedAt,
    this.category,
    this.coverImage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    eventId = json['event_id'];
    title = json['title'];
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(Pages.fromJson(v));
      });
    }
    status = json['status'];
    isFree = json['is_free'];
    pricePence = json['price_pence'];
    clicks = json['clicks'];
    views = json['views'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    publishedAt = json['published_at'];
    category = json['category'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['owner'] = owner;
    data['event_id'] = eventId;
    data['title'] = title;
    if (pages != null) {
      data['pages'] = pages!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['is_free'] = isFree;
    data['price_pence'] = pricePence;
    data['clicks'] = clicks;
    data['views'] = views;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['published_at'] = publishedAt;
    data['category'] = category;
    data['cover_image'] = coverImage;
    return data;
  }
}

class Pages {
  String? id;
  String? title;
  List<Blocks>? blocks;

  Pages({this.id, this.title, this.blocks});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['blocks'] != null) {
      blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        blocks!.add(Blocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (blocks != null) {
      data['blocks'] = blocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blocks {
  Animation? animation;
  Layout? layout;
  String? module;
  String? type;
  BlockData? data; // 这里 নাম পরিবর্তন করা হয়েছে BlockData

  Blocks({this.animation, this.layout, this.module, this.type, this.data});

  Blocks.fromJson(Map<String, dynamic> json) {
    animation = json['animation'] != null
        ? Animation.fromJson(json['animation'])
        : null;
    layout =
    json['layout'] != null ? Layout.fromJson(json['layout']) : null;
    module = json['module'];
    type = json['type'];
    data = json['data'] != null ? BlockData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (animation != null) {
      data['animation'] = animation!.toJson();
    }
    if (layout != null) {
      data['layout'] = layout!.toJson();
    }
    data['module'] = module;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Animation {
  String? type;
  int? delayMs;
  int? durationMs;

  Animation({this.type, this.delayMs, this.durationMs});

  Animation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    delayMs = json['delay_ms'];
    durationMs = json['duration_ms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['delay_ms'] = delayMs;
    data['duration_ms'] = durationMs;
    return data;
  }
}

class Layout {
  String? align;
  int? paddingTop;
  int? paddingBottom;
  int? paddingX;
  String? background;

  Layout({
    this.align,
    this.paddingTop,
    this.paddingBottom,
    this.paddingX,
    this.background,
  });

  Layout.fromJson(Map<String, dynamic> json) {
    align = json['align'];
    paddingTop = json['padding_top'];
    paddingBottom = json['padding_bottom'];
    paddingX = json['padding_x'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['align'] = align;
    data['padding_top'] = paddingTop;
    data['padding_bottom'] = paddingBottom;
    data['padding_x'] = paddingX;
    data['background'] = background;
    return data;
  }
}

// Data এর জায়গায় BlockData নাম দেওয়া হয়েছে
class BlockData {
  String? title;
  String? subtitle;
  String? coverImage;
  String? height;
  bool? overlay;
  bool? parallax;
  String? id;
  String? heading;
  String? body;
  String? signature;
  String? description;
  int? columns;
  List<Members>? members;
  String? question;
  String? variant;
  List<Options>? options;
  List<Results>? results;
  String? thankYouMessage;
  bool? showResultsLive;
  String? voteSubmitUrl;
  String? address;
  double? lat;
  double? lng;
  bool? showParking;
  bool? showAccessibilityRoute;
  String? byCar;
  String? byTrain;
  String? byBus;
  String? parkingInfo;

  BlockData({
    this.title,
    this.subtitle,
    this.coverImage,
    this.height,
    this.overlay,
    this.parallax,
    this.id,
    this.heading,
    this.body,
    this.signature,
    this.description,
    this.columns,
    this.members,
    this.question,
    this.variant,
    this.options,
    this.results,
    this.thankYouMessage,
    this.showResultsLive,
    this.voteSubmitUrl,
    this.address,
    this.lat,
    this.lng,
    this.showParking,
    this.showAccessibilityRoute,
    this.byCar,
    this.byTrain,
    this.byBus,
    this.parkingInfo,
  });

  BlockData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    coverImage = json['cover_image'];
    height = json['height'];
    overlay = json['overlay'];
    parallax = json['parallax'];
    id = json['id'];
    heading = json['heading'];
    body = json['body'];
    signature = json['signature'];
    description = json['description'];
    columns = json['columns'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    question = json['question'];
    variant = json['variant'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    thankYouMessage = json['thank_you_message'];
    showResultsLive = json['show_results_live'];
    voteSubmitUrl = json['vote_submit_url'];
    address = json['address'];
    lat = json['lat'] != null ? (json['lat'] as num).toDouble() : null;
    lng = json['lng'] != null ? (json['lng'] as num).toDouble() : null;
    showParking = json['show_parking'];
    showAccessibilityRoute = json['show_accessibility_route'];
    byCar = json['by_car'];
    byTrain = json['by_train'];
    byBus = json['by_bus'];
    parkingInfo = json['parking_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['cover_image'] = coverImage;
    data['height'] = height;
    data['overlay'] = overlay;
    data['parallax'] = parallax;
    data['id'] = id;
    data['heading'] = heading;
    data['body'] = body;
    data['signature'] = signature;
    data['description'] = description;
    data['columns'] = columns;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['question'] = question;
    data['variant'] = variant;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['thank_you_message'] = thankYouMessage;
    data['show_results_live'] = showResultsLive;
    data['vote_submit_url'] = voteSubmitUrl;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['show_parking'] = showParking;
    data['show_accessibility_route'] = showAccessibilityRoute;
    data['by_car'] = byCar;
    data['by_train'] = byTrain;
    data['by_bus'] = byBus;
    data['parking_info'] = parkingInfo;
    return data;
  }
}

class Members {
  String? id;
  String? name;
  String? role;
  String? image;
  String? bio;

  Members({this.id, this.name, this.role, this.image, this.bio});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    image = json['image'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['image'] = image;
    data['bio'] = bio;
    return data;
  }
}

class Options {
  String? id;
  String? label;
  String? emoji;

  Options({this.id, this.label, this.emoji});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    emoji = json['emoji'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['emoji'] = emoji;
    return data;
  }
}

class Results {
  String? optionId;
  int? count;

  Results({this.optionId, this.count});

  Results.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['count'] = count;
    return data;
  }
}