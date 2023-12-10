import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
void initialize() {
  // //لازم اهتم بالترتيب من الاعلي لتحت يعني من ال bloc للاقل
  // sl.registerFactory(() => NumberTriviaBloc(getNumberTriviaUC: sl()));
  // sl.registerLazySingleton(
  //     () => GetNumberTriviaUC(numberTriviaRepository: sl()));
  // //لما اجي اعمل singleton لحاجه ليها impl و abstract لازم احدد ال type
  // sl.registerLazySingleton<NumberTriviaRepository>(
  //     () => NumberTriviaRepositoryImpl(triviaRemoteDs: sl()));
  // sl.registerLazySingleton<TriviaRemoteDs>(() => TriviaRemoteDsImpl());
}