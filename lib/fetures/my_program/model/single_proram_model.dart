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
  dynamic eventId;
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

  String? get id => sId;

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? json['id'];
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
    id = json['id'] ?? json['_id'];
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
  String? id;
  BlockAnimation? animation;
  Layout? layout;
  String? module;
  String? type;
  BlockData? data;

  Blocks({
    this.id,
    this.animation,
    this.layout,
    this.module,
    this.type,
    this.data,
  });

  Blocks.fromJson(Map<String, dynamic> json) {
    animation = json['animation'] != null
        ? BlockAnimation.fromJson(Map<String, dynamic>.from(json['animation']))
        : null;
    layout = json['layout'] != null ? Layout.fromJson(json['layout']) : null;
    module = json['module'];
    type = json['type'];

    // Support both nested `data` and flattened React-style blocks.
    if (json['data'] != null && json['data'] is Map) {
      data = BlockData.fromJson(Map<String, dynamic>.from(json['data']));
    } else {
      final reserved = {
        'id',
        '_id',
        'type',
        'module',
        'animation',
        'layout',
        'data',
      };
      final flat = <String, dynamic>{};
      json.forEach((k, v) {
        if (!reserved.contains(k)) flat[k] = v;
      });
      if (flat.isNotEmpty) {
        data = BlockData.fromJson(flat);
      }
    }

    id = json['id'] ??
        json['_id'] ??
        data?.id ??
        'blk_${DateTime.now().microsecondsSinceEpoch}';
    data?.id ??= id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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

/// Programme block reveal config (not Flutter's [Animation]).
class BlockAnimation {
  String? type;
  int? delayMs;
  int? durationMs;

  BlockAnimation({this.type, this.delayMs, this.durationMs});

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  BlockAnimation.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    delayMs = _asInt(json['delay_ms'] ?? json['delayMs']);
    durationMs = _asInt(json['duration_ms'] ?? json['durationMs']);
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
  String? backgroundCustom;
  String? textColor;
  String? titleColor;
  String? eyebrowColor;
  String? cardBackground;
  String? cardTextColor;

  Layout({
    this.align,
    this.paddingTop,
    this.paddingBottom,
    this.paddingX,
    this.background,
    this.backgroundCustom,
    this.textColor,
    this.titleColor,
    this.eyebrowColor,
    this.cardBackground,
    this.cardTextColor,
  });

  Layout.fromJson(Map<String, dynamic> json) {
    align = json['align'];
    paddingTop = json['padding_top'];
    paddingBottom = json['padding_bottom'];
    paddingX = json['padding_x'];
    background = json['background'];
    backgroundCustom = json['background_custom'];
    textColor = json['text_color'];
    titleColor = json['title_color'];
    eyebrowColor = json['eyebrow_color'];
    cardBackground = json['card_background'];
    cardTextColor = json['card_text_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['align'] = align;
    data['padding_top'] = paddingTop;
    data['padding_bottom'] = paddingBottom;
    data['padding_x'] = paddingX;
    data['background'] = background;
    data['background_custom'] = backgroundCustom;
    data['text_color'] = textColor;
    data['title_color'] = titleColor;
    data['eyebrow_color'] = eyebrowColor;
    data['card_background'] = cardBackground;
    data['card_text_color'] = cardTextColor;
    return data;
  }
}

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

  // schedule / accessibility / behind_scenes / sponsors / refreshments
  List<ScheduleItem>? items;
  List<FeatureItem>? features;
  List<String>? images;
  List<SponsorItem>? sponsors;
  String? ctaUrl;
  String? ctaLabel;

  // cast spotlight / narrative / image story
  String? name;
  String? role;
  String? bio;
  String? image;
  String? linkUrl;
  String? linkLabel;
  String? eyebrow;
  String? imagePosition;
  String? caption;

  // review / memory
  String? prompt;
  String? placeholder;
  int? maxChars;
  String? submitLabel;
  bool? allowImage;
  bool? allowText;
  String? privacyNote;
  String? successMessage;

  // merchandise / future shows / donation / offers
  List<MerchItem>? merchItems;
  List<ShowItem>? shows;
  List<int>? presetAmounts;
  List<OfferItem>? offers;

  // ads / recommendations / recap / push
  List<String>? selectedItems;
  bool? showRating;
  bool? showDistance;
  int? releaseAfterHours;
  List<String>? pollIdsToInclude;
  String? resultsApiUrl;
  String? trigger;
  String? scheduledAt;
  int? offsetMinutes;
  String? eventDate;
  String? message;

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
    this.items,
    this.features,
    this.images,
    this.sponsors,
    this.ctaUrl,
    this.ctaLabel,
    this.name,
    this.role,
    this.bio,
    this.image,
    this.linkUrl,
    this.linkLabel,
    this.eyebrow,
    this.imagePosition,
    this.caption,
    this.prompt,
    this.placeholder,
    this.maxChars,
    this.submitLabel,
    this.allowImage,
    this.allowText,
    this.privacyNote,
    this.successMessage,
    this.merchItems,
    this.shows,
    this.presetAmounts,
    this.offers,
    this.selectedItems,
    this.showRating,
    this.showDistance,
    this.releaseAfterHours,
    this.pollIdsToInclude,
    this.resultsApiUrl,
    this.trigger,
    this.scheduledAt,
    this.offsetMinutes,
    this.eventDate,
    this.message,
  });

  BlockData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    coverImage = json['cover_image'];
    height = json['height'];
    overlay = json['overlay'];
    parallax = json['parallax'];
    id = json['id'] ?? json['_id'];
    heading = json['heading'];
    body = json['body'];
    signature = json['signature'];
    description = json['description'];
    columns = json['columns'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    question = json['question'];
    variant = json['variant'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(Map<String, dynamic>.from(v)));
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

    if (json['items'] != null) {
      items = <ScheduleItem>[];
      merchItems = <MerchItem>[];
      for (final v in json['items']) {
        if (v is! Map) continue;
        final m = Map<String, dynamic>.from(v);
        final isMerch = m.containsKey('price') ||
            m.containsKey('url') ||
            (m.containsKey('name') && !m.containsKey('time'));
        final isSchedule =
            m.containsKey('time') || (m.containsKey('label') && !isMerch);
        if (isMerch) {
          merchItems!.add(MerchItem.fromJson(m));
        } else if (isSchedule) {
          items!.add(ScheduleItem.fromJson(m));
        }
      }
      if (items!.isEmpty) items = null;
      if (merchItems!.isEmpty) merchItems = null;
    }
    if (json['features'] != null) {
      features = <FeatureItem>[];
      for (final v in json['features']) {
        if (v is Map) {
          features!.add(FeatureItem.fromJson(Map<String, dynamic>.from(v)));
        }
      }
    }
    if (json['images'] != null) {
      images = (json['images'] as List).map((e) => e.toString()).toList();
    }
    if (json['sponsors'] != null) {
      sponsors = <SponsorItem>[];
      for (final v in json['sponsors']) {
        if (v is Map) {
          sponsors!.add(SponsorItem.fromJson(Map<String, dynamic>.from(v)));
        }
      }
    }
    ctaUrl = json['cta_url'];
    ctaLabel = json['cta_label'];
    name = json['name'];
    role = json['role'];
    bio = json['bio'];
    image = json['image'];
    linkUrl = json['link_url'];
    linkLabel = json['link_label'];
    eyebrow = json['eyebrow'];
    imagePosition = json['image_position'];
    caption = json['caption'];
    prompt = json['prompt'];
    placeholder = json['placeholder'];
    maxChars = json['max_chars'];
    submitLabel = json['submit_label'];
    allowImage = json['allow_image'];
    allowText = json['allow_text'];
    privacyNote = json['privacy_note'];
    successMessage = json['success_message'];

    if (json['shows'] != null) {
      shows = <ShowItem>[];
      for (final v in json['shows']) {
        if (v is Map) {
          shows!.add(ShowItem.fromJson(Map<String, dynamic>.from(v)));
        }
      }
    }
    if (json['preset_amounts'] != null) {
      presetAmounts =
          (json['preset_amounts'] as List).map((e) => (e as num).toInt()).toList();
    }
    if (json['offers'] != null) {
      offers = <OfferItem>[];
      for (final v in json['offers']) {
        if (v is Map) {
          offers!.add(OfferItem.fromJson(Map<String, dynamic>.from(v)));
        }
      }
    }
    if (json['selected_items'] != null) {
      selectedItems =
          (json['selected_items'] as List).map((e) => e.toString()).toList();
    }
    showRating = json['show_rating'];
    showDistance = json['show_distance'];
    releaseAfterHours = json['release_after_hours'];
    if (json['poll_ids_to_include'] != null) {
      pollIdsToInclude = (json['poll_ids_to_include'] as List)
          .map((e) => e.toString())
          .toList();
    }
    resultsApiUrl = json['results_api_url'];
    trigger = json['trigger'];
    scheduledAt = json['scheduled_at'];
    offsetMinutes = json['offset_minutes'];
    eventDate = json['event_date'];
    message = json['message'];
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
  String? linkUrl;
  String? linkLabel;

  Members({
    this.id,
    this.name,
    this.role,
    this.image,
    this.bio,
    this.linkUrl,
    this.linkLabel,
  });

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    image = json['image'];
    bio = json['bio'];
    linkUrl = json['link_url'];
    linkLabel = json['link_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['image'] = image;
    data['bio'] = bio;
    data['link_url'] = linkUrl;
    data['link_label'] = linkLabel;
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

class ScheduleItem {
  String? id;
  String? time;
  String? label;
  String? note;

  ScheduleItem({this.id, this.time, this.label, this.note});

  ScheduleItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    label = json['label'];
    note = json['note'];
  }
}

class FeatureItem {
  String? id;
  String? label;
  String? description;

  FeatureItem({this.id, this.label, this.description});

  FeatureItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
  }
}

class SponsorItem {
  String? id;
  String? name;
  String? logo;
  String? url;

  SponsorItem({this.id, this.name, this.logo, this.url});

  SponsorItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    url = json['url'];
  }
}

class MerchItem {
  String? id;
  String? name;
  String? price;
  String? image;
  String? url;

  MerchItem({this.id, this.name, this.price, this.image, this.url});

  MerchItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price']?.toString();
    image = json['image'];
    url = json['url'];
  }
}

class ShowItem {
  String? id;
  String? name;
  String? date;
  String? image;
  String? url;

  ShowItem({this.id, this.name, this.date, this.image, this.url});

  ShowItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    image = json['image'];
    url = json['url'];
  }
}

class OfferItem {
  String? id;
  String? title;
  String? description;
  String? code;

  OfferItem({this.id, this.title, this.description, this.code});

  OfferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    code = json['code'];
  }
}

