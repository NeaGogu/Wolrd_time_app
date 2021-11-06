import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  late String location;
  late String time; // time in location
  late String flag; // url to asset flag icon
  late String url; // location for api endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get data propr
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print('$datetime, $offset');

      // create datetime obj
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught err');
      time = 'could not get time data';
    }
  }
}
