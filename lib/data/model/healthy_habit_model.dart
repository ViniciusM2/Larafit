class HealthyHabitModel {
  int idHabito;
  String nomehabito;
  String descricaoTEXT;
  int autorhabitoINT;
  String url;

  HealthyHabitModel(
      {this.idHabito,
      this.nomehabito,
      this.descricaoTEXT,
      this.autorhabitoINT,
      this.url});

  HealthyHabitModel.fromJson(Map<String, dynamic> json) {
    try{
    idHabito = json['idHabito'];
    nomehabito = json['nomeHabito'];
    descricaoTEXT = json['descricao'];
    autorhabitoINT = json['idUser'];
    url = json['url'];
    }
    catch(e){
      print('ERRO HABITO FROM JSON $e');
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_habito'] = this.idHabito;
    data['nomeHabito'] = this.nomehabito;
    data['descricao TEXT'] = this.descricaoTEXT;
    data['autorhabito INT'] = this.autorhabitoINT;
    data['URL'] = this.url;
    return data;
  }

  @override
  String toString() {
    return 'id: $idHabito,nome: $nomehabito, descricaoTEXT: $descricaoTEXT, autorhabitoINT: $autorhabitoINT, url: $url';
  }
}
