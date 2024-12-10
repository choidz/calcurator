class Record {
  String record1;
  String record2;

  Record({
    required this.record1,
    required this.record2,
  });

  Map<String, dynamic> toJson() => {
        'record1': record1,
        'record2': record2,
      };

  factory Record.fromJson(Map<String, dynamic> json) =>
      Record(record1: json['record1'], record2: json['record2']);
}
