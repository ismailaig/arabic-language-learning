class ListUsers {
  ListUsers({
    required this.data,
    required this.meta,
  });
  late final List<Data> data;
  late final Meta meta;

  ListUsers.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
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

  Data.fromJson(Map<String, dynamic> json){
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
  Attributes({
    required this.email,
    required this.fullname,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.photo,
    required this.king
  });
  late final String email;
  late final String fullname;
  late final String password;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final Photo photo;
  late final int king;

  Attributes.fromJson(Map<String, dynamic> json){
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
  late final DataPhoto data;

  Photo.fromJson(Map<String, dynamic> json){
    data = DataPhoto.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
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

  DataPhoto.fromJson(Map<String, dynamic> json){
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
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String name;
  late final String alternativeText;
  late final String caption;
  late final int width;
  late final int height;
  late final Formats formats;
  late final String hash;
  late final String ext;
  late final String mime;
  late final double size;
  late final String url;
  late final Null previewUrl;
  late final String provider;
  late final Null providerMetadata;
  late final String createdAt;
  late final String updatedAt;

  AttributesPhoto.fromJson(Map<String, dynamic> json){
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats = Formats.fromJson(json['formats']);
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    previewUrl = null;
    provider = json['provider'];
    providerMetadata = null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['alternativeText'] = alternativeText;
    _data['caption'] = caption;
    _data['width'] = width;
    _data['height'] = height;
    _data['formats'] = formats.toJson();
    _data['hash'] = hash;
    _data['ext'] = ext;
    _data['mime'] = mime;
    _data['size'] = size;
    _data['url'] = url;
    _data['previewUrl'] = previewUrl;
    _data['provider'] = provider;
    _data['provider_metadata'] = providerMetadata;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Formats {
  Formats({
    required this.large,
    required this.small,
    required this.medium,
    required this.thumbnail,
  });
  late final Large large;
  late final Small small;
  late final Medium medium;
  late final Thumbnail thumbnail;

  Formats.fromJson(Map<String, dynamic> json){
    large = Large.fromJson(json['large']);
    small = Small.fromJson(json['small']);
    medium = Medium.fromJson(json['medium']);
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['large'] = large.toJson();
    _data['small'] = small.toJson();
    _data['medium'] = medium.toJson();
    _data['thumbnail'] = thumbnail.toJson();
    return _data;
  }
}

class Large {
  Large({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    this.path,
    required this.size,
    required this.width,
    required this.height,
  });
  late final String ext;
  late final String url;
  late final String hash;
  late final String mime;
  late final String name;
  late final Null path;
  late final double size;
  late final int width;
  late final int height;

  Large.fromJson(Map<String, dynamic> json){
    ext = json['ext'];
    url = json['url'];
    hash = json['hash'];
    mime = json['mime'];
    name = json['name'];
    path = null;
    size = json['size'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ext'] = ext;
    _data['url'] = url;
    _data['hash'] = hash;
    _data['mime'] = mime;
    _data['name'] = name;
    _data['path'] = path;
    _data['size'] = size;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Small {
  Small({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    this.path,
    required this.size,
    required this.width,
    required this.height,
  });
  late final String ext;
  late final String url;
  late final String hash;
  late final String mime;
  late final String name;
  late final Null path;
  late final double size;
  late final int width;
  late final int height;

  Small.fromJson(Map<String, dynamic> json){
    ext = json['ext'];
    url = json['url'];
    hash = json['hash'];
    mime = json['mime'];
    name = json['name'];
    path = null;
    size = json['size'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ext'] = ext;
    _data['url'] = url;
    _data['hash'] = hash;
    _data['mime'] = mime;
    _data['name'] = name;
    _data['path'] = path;
    _data['size'] = size;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Medium {
  Medium({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    this.path,
    required this.size,
    required this.width,
    required this.height,
  });
  late final String ext;
  late final String url;
  late final String hash;
  late final String mime;
  late final String name;
  late final Null path;
  late final double size;
  late final int width;
  late final int height;

  Medium.fromJson(Map<String, dynamic> json){
    ext = json['ext'];
    url = json['url'];
    hash = json['hash'];
    mime = json['mime'];
    name = json['name'];
    path = null;
    size = json['size'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ext'] = ext;
    _data['url'] = url;
    _data['hash'] = hash;
    _data['mime'] = mime;
    _data['name'] = name;
    _data['path'] = path;
    _data['size'] = size;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Thumbnail {
  Thumbnail({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    this.path,
    required this.size,
    required this.width,
    required this.height,
  });
  late final String ext;
  late final String url;
  late final String hash;
  late final String mime;
  late final String name;
  late final Null path;
  late final double size;
  late final int width;
  late final int height;

  Thumbnail.fromJson(Map<String, dynamic> json){
    ext = json['ext'];
    url = json['url'];
    hash = json['hash'];
    mime = json['mime'];
    name = json['name'];
    path = null;
    size = json['size'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ext'] = ext;
    _data['url'] = url;
    _data['hash'] = hash;
    _data['mime'] = mime;
    _data['name'] = name;
    _data['path'] = path;
    _data['size'] = size;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Meta {
  Meta({
    required this.pagination,
  });
  late final Pagination pagination;

  Meta.fromJson(Map<String, dynamic> json){
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

  Pagination.fromJson(Map<String, dynamic> json){
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