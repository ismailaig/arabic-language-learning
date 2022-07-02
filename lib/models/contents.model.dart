class Contents {
  Contents({
    required this.data,
    required this.meta,
  });
  late final List<Data> data;
  late final Meta meta;

  Contents.fromJson(Map<String, dynamic> json){
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
    required this.imageName,
    required this.imageNameFr,
    required this.nameArFr,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.pageNumber,
    required this.image,
    required this.lesson,
    required this.imageSong
  });
  late final String imageName;
  late final String nameArFr;
  late final String imageNameFr;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final int pageNumber;
  late final Image image;
  late final Lesson lesson;
  late final ImageSong imageSong;

  Attributes.fromJson(Map<String, dynamic> json){
    imageName = json['imageName'];
    nameArFr = json['nameArFr'];
    imageNameFr = json['imageNameFr'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    pageNumber = json['pageNumber'];
    image = Image.fromJson(json['image']);
    lesson = Lesson.fromJson(json['lesson']);
    imageSong = ImageSong.fromJson(json['imageSong']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageName'] = imageName;
    _data['nameArFr'] = nameArFr;
    _data['imageNameFr'] = imageNameFr;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['pageNumber'] = pageNumber;
    _data['image'] = image.toJson();
    _data['lesson'] = lesson.toJson();
    _data['imageSong'] = imageSong.toJson();
    return _data;
  }
}

class Image {
  Image({
    required this.data,
  });
  late final List<DataImage> data;

  Image.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>DataImage.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DataImage {
  DataImage({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesImage attributes;

  DataImage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    attributes = AttributesImage.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesImage {
  AttributesImage({
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

  AttributesImage.fromJson(Map<String, dynamic> json){
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
    required this.thumbnail,
  });
  late final Thumbnail thumbnail;

  Formats.fromJson(Map<String, dynamic> json){
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['thumbnail'] = thumbnail.toJson();
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

class Lesson {
  Lesson({
    required this.data,
  });
  late final DataLesson data;

  Lesson.fromJson(Map<String, dynamic> json){
    data = DataLesson.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class DataLesson {
  DataLesson({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesLesson attributes;

  DataLesson.fromJson(Map<String, dynamic> json){
    id = json['id'];
    attributes = AttributesLesson.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesLesson {
  AttributesLesson({
    required this.title,
    required this.started,
    required this.locked,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.king,
  });
  late final String title;
  late final bool started;
  late final bool locked;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final int king;

  AttributesLesson.fromJson(Map<String, dynamic> json){
    title = json['title'];
    started = json['started'];
    locked = json['locked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    king = json['king'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['started'] = started;
    _data['locked'] = locked;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['king'] = king;
    return _data;
  }
}



class ImageSong {
  ImageSong({
    required this.data,
  });
  late final List<DataSong> data;

  ImageSong.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>DataSong.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DataSong {
  DataSong({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesSong attributes;

  DataSong.fromJson(Map<String, dynamic> json){
    id = json['id'];
    attributes = AttributesSong.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesSong {
  AttributesSong({
    required this.name,
    required this.alternativeText,
    required this.caption,
    this.width,
    this.height,
    this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String name;
  late final String alternativeText;
  late final String caption;
  late final Null width;
  late final Null height;
  late final Null formats;
  late final String hash;
  late final String ext;
  late final String mime;
  late final double size;
  late final String url;
  late final String previewUrl;
  late final String provider;
  late final ProviderMetadata providerMetadata;
  late final String createdAt;
  late final String updatedAt;

  AttributesSong.fromJson(Map<String, dynamic> json){
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = null;
    height = null;
    formats = null;
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'].toDouble();
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    providerMetadata = ProviderMetadata.fromJson(json['provider_metadata']);
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
    _data['formats'] = formats;
    _data['hash'] = hash;
    _data['ext'] = ext;
    _data['mime'] = mime;
    _data['size'] = size;
    _data['url'] = url;
    _data['previewUrl'] = previewUrl;
    _data['provider'] = provider;
    _data['provider_metadata'] = providerMetadata.toJson();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class ProviderMetadata {
  ProviderMetadata({
    required this.publicId,
    required this.resourceType,
  });
  late final String publicId;
  late final String resourceType;

  ProviderMetadata.fromJson(Map<String, dynamic> json){
    publicId = json['public_id'];
    resourceType = json['resource_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['public_id'] = publicId;
    _data['resource_type'] = resourceType;
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