class ListUsers {
  ListUsers({
    required this.data,
    required this.meta,
  });

  late final List<Data> data;
  late final Meta meta;

  ListUsers.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.attributes,
  });

  late final int id;
  late final Attributes attributes;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = Attributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class Attributes {
  Attributes(
      {required this.email,
      required this.fullname,
      required this.password,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt,
      required this.photo,
      required this.king});

  late final String email;
  late final String fullname;
  late final String password;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final Photo photo;
  late final int king;

  Attributes.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullname = json['fullname'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    photo = Photo.fromJson(json['photo']);
    king = json['king'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['fullname'] = fullname;
    _data['password'] = password;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['photo'] = photo.toJson();
    _data['king'] = king;
    return _data;
  }
}

class Photo {
  Photo({
    required this.data,
  });

  DataPhoto? data;

  Photo.fromJson(Map<String, dynamic> json) {
    data = json['data'] == null ? null : DataPhoto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data == null ? null : data!.toJson();
    return _data;
  }
}

class DataPhoto {
  DataPhoto({
    required this.id,
    required this.attributes,
  });

  late final int id;
  late final AttributesPhoto attributes;

  DataPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesPhoto.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesPhoto {
  AttributesPhoto({
    required this.name,
    required this.width,
    required this.height,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  late final String name;
  late final int width;
  late final int height;
  late final String hash;
  late final String ext;
  late final String mime;
  late final double size;
  late final String url;
  late final String provider;
  late final String createdAt;
  late final String updatedAt;

  AttributesPhoto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    width = json['width'];
    height = json['height'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'].toDouble();
    url = json['url'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['width'] = width;
    _data['height'] = height;
    _data['hash'] = hash;
    _data['ext'] = ext;
    _data['mime'] = mime;
    _data['size'] = size;
    _data['url'] = url;
    _data['provider'] = provider;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Meta {
  Meta({
    required this.pagination,
  });

  late final Pagination pagination;

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = Pagination.fromJson(json['pagination']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagination'] = pagination.toJson();
    return _data;
  }
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  late final int page;
  late final int pageSize;
  late final int pageCount;
  late final int total;

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['pageSize'] = pageSize;
    _data['pageCount'] = pageCount;
    _data['total'] = total;
    return _data;
  }
}
