class GoalModel {
  int idGoal;
  String activeTimeGoal;
  double distanceGoal;
  String startDate;
  String finalDate;
  int goalAutor;

  GoalModel(
      {this.idGoal,
      this.activeTimeGoal,
      this.distanceGoal,
      this.startDate,
      this.finalDate,
      this.goalAutor});

  GoalModel.fromJson(Map<String, dynamic> json) {
    idGoal = json['IdGoal'];
    activeTimeGoal = json['ActiveTimeGoal'];
    distanceGoal = json['DistanceGoal'];
    startDate = json['StartDate'];
    finalDate = json['FinalDate'];
    goalAutor = json['GoalAutor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdGoal'] = this.idGoal;
    data['ActiveTimeGoal'] = this.activeTimeGoal;
    data['DistanceGoal'] = this.distanceGoal;
    data['StartDate'] = this.startDate;
    data['FinalDate'] = this.finalDate;
    data['GoalAutor'] = this.goalAutor;
    return data;
  }
}
