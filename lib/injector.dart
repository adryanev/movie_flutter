import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_flutter/injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(generateForDir: ['lib', 'test'])
void configureDependencies() => $initGetIt(getIt);
