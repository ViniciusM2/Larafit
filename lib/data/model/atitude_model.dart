class AtitudeModel {
  int idAtitude;
  String atitudeName;
  int atitudeDuration;
  int idHabito;

  AtitudeModel(
      {this.idAtitude, this.atitudeName, this.atitudeDuration, this.idHabito});

  AtitudeModel.fromJson(Map<String, dynamic> json) {
    idAtitude = json['idAtitude'];
    atitudeName = json['atitudeName'];
    atitudeDuration = json['atitudeDuration'];
    idHabito = json['idHabito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAtitude'] = this.idAtitude;
    data['atitudeName'] = this.atitudeName;
    data['atitudeDuration'] = this.atitudeDuration;
    data['idHabito'] = this.idHabito;
    return data;
  }
}
