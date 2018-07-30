// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:test/test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/data/conference_repository.dart';

import 'package:voxxedapp/data/local_storage.dart';
import 'package:voxxedapp/models/enums.dart';
import 'package:voxxedapp/models/conference.dart';

// This file is meant to be run from the command line like this:
//
// flutter run on_device_test/conference_repository_test.dart
//
// This is necessary because the tests here require access to a working form of
// local storage, which is only available on a device or emulator.
void main() {
  group('Conference repository integration tests', () {
    test('Correctly retrieve a list of conferences from the cache', () async {
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
      final repository = const ConferenceRepository();
      final loadedConferences = await repository.loadCachedConferences();
      print('Read.');

      expect(loadedConferences.length, 1);
      expect(loadedConferences[0].id, 12);
      expect(loadedConferences[0].name, 'This is the name');
      expect(loadedConferences[0].fromDate, '2018-01-01');
      expect(loadedConferences[0].endDate, '2018-01-02');
      expect(loadedConferences[0].eventType, EventType.VOXXED);
      expect(loadedConferences[0].imageURL, 'https://images.google.com');
      expect(loadedConferences[0].website, 'https://www.google.com');
    });
  });
}
