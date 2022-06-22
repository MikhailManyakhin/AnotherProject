class NasaPhotos {
  Collection? collection;

  NasaPhotos({this.collection});

  NasaPhotos.fromJson(Map<String, dynamic> json) {
    collection = json['collection'] != null
        ? Collection.fromJson(json['collection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collection != null) {
      data['collection'] = collection!.toJson();
    }
    return data;
  }
}

class Collection {
  String? version;
  String? href;
  List<Item>? items;
  Metadata? metadata;
  List<Links>? links;

  Collection({this.version, this.href, this.items, this.metadata, this.links});

  Collection.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    href = json['href'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['href'] = href;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? href;
  List<Data>? data;
  List<Links>? links;

  Item({this.href, this.data, this.links});

  Item.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? center;
  String? title;
  List<String>? keywords;
  String? nasaId;
  String? dateCreated;
  String? mediaType;
  String? description;
  String? description508;
  String? secondaryCreator;
  String? location;
  String? photographer;
  List<String>? album;

  Data(
      {this.center,
        this.title,
        this.keywords,
        this.nasaId,
        this.dateCreated,
        this.mediaType,
        this.description,
        this.description508,
        this.secondaryCreator,
        this.location,
        this.photographer,
        this.album});

  Data.fromJson(Map<String, dynamic> json) {
    center = json['center'];
    title = json['title'];
    keywords = json['keywords'].cast<String>();
    nasaId = json['nasa_id'];
    dateCreated = json['date_created'];
    mediaType = json['media_type'];
    description = json['description'];
    description508 = json['description_508'];
    secondaryCreator = json['secondary_creator'];
    location = json['location'];
    photographer = json['photographer'];
    album = json['album'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['center'] = center;
    data['title'] = title;
    data['keywords'] = keywords;
    data['nasa_id'] = nasaId;
    data['date_created'] = dateCreated;
    data['media_type'] = mediaType;
    data['description'] = description;
    data['description_508'] = description508;
    data['secondary_creator'] = secondaryCreator;
    data['location'] = location;
    data['photographer'] = photographer;
    data['album'] = album;
    return data;
  }
}

class Links {
  String? href;
  String? rel;
  String? render;
  String? prompt;

  Links({this.href, this.rel, this.render, this.prompt});

  Links.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    rel = json['rel'];
    render = json['render'];
    prompt = json['prompt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['rel'] = rel;
    data['render'] = render;
    data['prompt'] = prompt;
    return data;
  }
}

class Metadata {
  int? totalHits;

  Metadata({this.totalHits});

  Metadata.fromJson(Map<String, dynamic> json) {
    totalHits = json['total_hits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_hits'] = totalHits;
    return data;
  }
}

// class Links {
//   String? rel;
//   String? prompt;
//   String? href;
//
//   Links({this.rel, this.prompt, this.href});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     rel = json['rel'];
//     prompt = json['prompt'];
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['rel'] = rel;
//     data['prompt'] = prompt;
//     data['href'] = href;
//     return data;
//   }
// }