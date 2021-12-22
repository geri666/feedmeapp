import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'entry.dart';

class JsonAccess {
  List<Entry> entries = [];
  String url = "https://api.jsonbin.io/b/61bf447278cc9429607c12c5/latest";
  String url2 = "https://api.jsonbin.io/b/61bf447278cc9429607c12c5";
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'secret-key':
        "\$2b\$10\$Tl/Qx8Og4rbm0JqQkxxUY.FnWlWCtXwKscyCUhMcKrtMNqmKXY85m"
  };

  Future<List<Entry>> readEntries() async {
    var response = await http.read(Uri.parse(url), headers: h);
    Iterable l = json.decode(response);
    entries = List<Entry>.from(l.map((m) => Entry.fromJson(m)));
    return entries;
  }

  Future<void> updateEntries() async {
    String b = "[";
    int i = 0;
    for (var e in entries) {
      if (i > 0) {
        b += ",";
      }
      b += jsonEncode(e.toJson());
      i++;
    }
    b += "]";

    http.put(Uri.parse(url2), headers: h, body: b).then((response) {
      if (response.statusCode == 200) {
        print("update successful.");
      } else {
        print("update failed.");
      }
    }).catchError(() {
      print("error!");
    }).whenComplete(() {
      print("update complete.");
    });
  }

  void addEntry(Entry e) {
    entries.add(e);
  }

  List<Entry> getEntries() {
    return entries;
  }
}
