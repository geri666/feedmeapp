import 'package:feedmeapp/jsonaccess.dart';

class Entry {
  late DateTime timeStamp;
  late List<String> activities;
  late String message;

  Entry(List<String> a, String m) {
    timeStamp = DateTime.now();
    activities = a;
    message = m;
  }

  Entry.fromJson(rec) {
    timeStamp = DateTime.parse(rec['timestamp']);
    activities = List.from(rec['activities']);
    message = rec['message'];
  }

  Map<String, dynamic> toJson() => {
        'timestamp': timeStamp.toString(),
        'activities': activities,
        'message': message
      };
}
