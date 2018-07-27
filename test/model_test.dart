// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';

import 'package:voxxedapp/models/enums.dart';
import 'package:voxxedapp/models/serializers.dart';
import 'package:voxxedapp/models/voxxed_day.dart';

const String voxxedDayJson = '''
  {
    "id": 32,
    "name": "Voxxed Days Ticino 2018",
    "eventType": "VOXXED",
    "fromDate": "2018-10-20",
    "endDate": "2018-10-20",
    "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/d8f534e3-7018-457c-83cf-379e40cd783b.jpg",
    "website": "https://ticino.voxxeddays.com"
  }
''';

const String listOfVoxxedDaysJson = '''
  [
    {
      "id": 32,
      "name": "Voxxed Days Ticino 2018",
      "eventType": "VOXXED",
      "fromDate": "2018-10-20",
      "endDate": "2018-10-20",
      "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/d8f534e3-7018-457c-83cf-379e40cd783b.jpg",
      "website": "https://ticino.voxxeddays.com"
    },
    {
      "id": 38,
      "name": "Voxxed Days Bristol 2018",
      "eventType": "VOXXED",
      "fromDate": "2018-10-25",
      "endDate": "2018-10-25",
      "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/8399a59c-3c08-430e-82ca-fef82ca57ff6.jpg",
      "website": "https://voxxeddays.com/bristol"
    },
    {
      "id": 39,
      "name": "Voxxed Days Banff 2018",
      "eventType": "VOXXED",
      "fromDate": "2018-10-26",
      "endDate": "2018-10-27",
      "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/6b33dc41-5056-4ad2-aa45-155b98be25ab.jpg",
      "website": "https://voxxeddays.com/banff"
    },
    {
      "id": 35,
      "name": "VoxxedDays Microservices 2018",
      "eventType": "VOXXED",
      "fromDate": "2018-10-29",
      "endDate": "2018-10-31",
      "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/8e450c86-8f51-4f9a-8b9e-06306886e975.jpg",
      "website": "https://voxxeddays.com/microservices/"
    },
    {
      "id": 24,
      "name": "Voxxed Days Thessaloniki 2018",
      "eventType": "VOXXED",
      "fromDate": "2018-11-19",
      "endDate": "2018-11-20",
      "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/4956ba81-9826-4601-84aa-95b2637d3f9a.jpg",
      "website": "https://voxxeddays.com/thessaloniki"
    },
    {
      "id": 23,
      "name": "Voxxed Days Cluj-Napoca 2018",
      "eventType": "VOXXED",
      "fromDate": "2018-11-22",
      "endDate": "2018-11-22",
      "imageURL": "https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/6c07a8b5-f44f-4cfb-882c-438970be0cf0.jpg",
      "website": "https://romania.voxxeddays.com/cluj-napoca/2018-11-22/"
    }
  ]
''';

void main() {
  group('VoxxedDay serialization', () {

    test('Correctly deserialize a typical VoxxedDay', () {
      final voxxedDay = serializers.deserializeWith(VoxxedDay.serializer, json.decode(voxxedDayJson));
      expect(voxxedDay.id, 32);
      expect(voxxedDay.name, 'Voxxed Days Ticino 2018');
      expect(voxxedDay.eventType, EventType.VOXXED);
      expect(voxxedDay.fromDate, '2018-10-20');
      expect(voxxedDay.endDate, '2018-10-20');
      expect(voxxedDay.imageURL, 'https://s3-eu-west-1.amazonaws.com/voxxeddays/webapp/images/d8f534e3-7018-457c-83cf-379e40cd783b.jpg');
      expect(voxxedDay.website, 'https://ticino.voxxeddays.com');
    });

    test('Correctly deserialize a list of VoxxedDays', () {
      final list = json
          .decode(listOfVoxxedDaysJson)
          .map((o) => serializers.deserializeWith(VoxxedDay.serializer, o))
          .toList();

      expect(list.length, 6);
    });

  });
}
