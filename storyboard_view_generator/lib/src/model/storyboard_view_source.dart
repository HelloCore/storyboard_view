class StoryboardViewSource {
  String path;
  String name;

  StoryboardViewSource({this.path, this.name});

  StoryboardViewSource.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['name'] = this.name;
    return data;
  }
}