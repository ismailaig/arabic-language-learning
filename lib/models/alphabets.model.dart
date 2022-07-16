class Alphabets {
  Alphabets({
    required this.data,
    required this.meta,
  });

  late final List<Data> data;
  late final Meta meta;

  Alphabets.fromJson(Map<String, dynamic> json) {
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
  Attributes({
    required this.arabe,
    required this.french,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.song,
  });

  late final String arabe;
  late final String french;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final Song song;

  Attributes.fromJson(Map<String, dynamic> json) {
    arabe = json['arabe'];
    french = json['french'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    song = Song.fromJson(json['song']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['arabe'] = arabe;
    _data['french'] = french;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['song'] = song.toJson();
    return _data;
  }
}

class Song {
  Song({
    required this.data,
  });

  late final List<DataSong> data;

  Song.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataSong.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
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

  DataSong.fromJson(Map<String, dynamic> json) {
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

  AttributesSong.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
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

  ProviderMetadata.fromJson(Map<String, dynamic> json) {
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
