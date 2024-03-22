class DataProductModel {
  String? name;
  String? path;
  String? des;

  DataProductModel({this.name, this.path,this.des});

  DataProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    des=json['des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['des'] = des;
    return data;
  }
}

