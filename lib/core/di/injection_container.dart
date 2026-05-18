import 'package:get_it/get_it.dart';

import '../../bloc/countdown_bloc.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  sl.registerFactory<CountdownBloc>(() => CountdownBloc());
}
