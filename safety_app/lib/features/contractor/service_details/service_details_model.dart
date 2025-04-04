class SubAct {
  final int id;
  final String subActivityName;

  SubAct({
    required this.id,
    required this.subActivityName,
  });

  factory SubAct.fromJson(Map<String, dynamic> json) {
    return SubAct(
      id: json['id'] as int,
      subActivityName: json['sub_activity_name'] as String,
    );
  }
}
