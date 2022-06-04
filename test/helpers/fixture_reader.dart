import 'dart:io';

String fixture(String path, String name) =>
    File('test/fixtures/$path/$name').readAsStringSync();
