class PostModel {
  String? thumbnail;
  dynamic noMedia;
  String? link;
  String? description;
  dynamic video;
  String? id;
  String? userId;
  String? username;
  int? timestamp;

  PostModel(
      {this.thumbnail,
      this.noMedia,
      this.link,
      this.description,
      this.video,
      this.id,
      this.userId,
      this.username,
      this.timestamp});

  PostModel.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    noMedia = json['no_media'];
    link = json['link'];
    description = json['description'];
    video = anyToBool(json['video']);
    id = json['id'];
    userId = json['userId'];
    username = json['username'];
    timestamp = json['timestamp'];
  }

  bool anyToBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      String lowerValue = value.toLowerCase();
      if (lowerValue == 'true') {
        return true;
      } else if (lowerValue == 'false') {
        return false;
      } else {
        throw ArgumentError('Invalid boolean string: $value');
      }
    } else if (value is int) {
      return value != 0;
    } else if (value is double) {
      return value != 0.0;
    } else if (value == null) {
      return false;
    } else {
      throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;
    data['no_media'] = noMedia;
    data['link'] = link;
    data['description'] = description;
    data['video'] = video;
    data['id'] = id;
    data['userId'] = userId;
    data['username'] = username;
    data['timestamp'] = timestamp;
    return data;
  }
}
