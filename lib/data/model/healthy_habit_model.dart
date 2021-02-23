class HealthyHabitModel {
  int idHabito;
  String nomehabito;
  String descricaoTEXT;
  int autorhabitoINT;

  HealthyHabitModel(
      {this.idHabito,
      this.nomehabito,
      this.descricaoTEXT,
      this.autorhabitoINT});

  HealthyHabitModel.fromJson(Map<String, dynamic> json) {
    idHabito = json['id_habito'];
    nomehabito = json['nomehabito'];
    descricaoTEXT = json['descricao TEXT'];
    autorhabitoINT = json['autorhabito INT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_habito'] = this.idHabito;
    data['nomehabito'] = this.nomehabito;
    data['descricao TEXT'] = this.descricaoTEXT;
    data['autorhabito INT'] = this.autorhabitoINT;
    return data;
  }
}
