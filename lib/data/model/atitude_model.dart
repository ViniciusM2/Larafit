class AtitudeModel {
  int idAtitude;
  String atitudeName;
  int atitudeDuration;
  int idMeta;
  String url;

  AtitudeModel(
      {this.idAtitude, this.atitudeName, this.atitudeDuration, this.idMeta, this.url});

  AtitudeModel.fromJson(Map<String, dynamic> json) {
    idAtitude = json['idAtitude'];
    atitudeName = json['atitudeName'];
    atitudeDuration = json['atitudeDuration'];
    idMeta = json['idMeta'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAtitude'] = this.idAtitude;
    data['atitudeName'] = this.atitudeName;
    data['atitudeDuration'] = this.atitudeDuration;
    data['idMeta'] = this.idMeta;
    data['Url'] = this.url;
    return data;
  }
}
