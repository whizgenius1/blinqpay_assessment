class UserModel {
  String? name;
  String? bio;
  String? photo;
  String? userId;
  String? username;

  UserModel({this.name, this.bio, this.photo, this.userId, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    photo = json['photo'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['bio'] = bio;
    data['photo'] = photo;
    data['userId'] = userId;
    data['username'] = username;
    return data;
  }
}
