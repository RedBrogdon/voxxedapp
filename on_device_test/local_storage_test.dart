// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:test/test.dart';
import 'package:built_collection/built_collection.dart';

import 'package:voxxedapp/data/local_storage.dart';
import 'package:voxxedapp/models/enums.dart';
import 'package:voxxedapp/models/conference.dart';

// This file is meant to be run from the command line like this:
//
// flutter run on_device_test/local_storage_test.dart
//
// This is necessary because the tests here require access to a working form of
// local storage, which is only available on a device or emulator.
void main() {
  group('Conference location storage integration tests', () {
    test('Clears and Loads empty list.', () async {
      print('Beginning test');

      final storage = ConferenceLocalStorage();

      print('About to clear.');
      storage.clear();
      print('About to load.');
      final retrieved = await storage.loadConferences();
      print('Read.');

      expect(retrieved.length, 0);
    });

    test('Correctly store/retrieve a list of conferences.', () async {
      print('Beginning test');

      final conference = Conference((b) => b
        ..id = 12
        ..name = 'This is the name'
        ..fromDate = '2018-01-01'
        ..endDate = '2018-01-02'
        ..eventType = EventType.VOXXED
        ..imageURL = 'https://images.google.com'
        ..website = 'https://www.google.com');

      final storage = ConferenceLocalStorage();

      print('About to write.');
      await storage.saveConferences(BuiltList([conference]));
      print('Written.');
      final retrieved = await storage.loadConferences();
      print('Read.');

      expect(retrieved.length, 1);
      expect(retrieved[0].id, 12);
      expect(retrieved[0].name, 'This is the name');
      expect(retrieved[0].fromDate, '2018-01-01');
      expect(retrieved[0].endDate, '2018-01-02');
      expect(retrieved[0].eventType, EventType.VOXXED);
      expect(retrieved[0].imageURL, 'https://images.google.com');
      expect(retrieved[0].website, 'https://www.google.com');
    });
  });
}
