import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:perguntando/src/shared/models/event/event_model.dart';
import 'repository/home_repository.dart';

class HomeBloc extends BlocBase {
  final HomeRepository _repository;

  HomeBloc(this._repository) {
    events = _repository.getEvents();
  }

 Future<List<EventModel>> events;

  @override
  void dispose() {
    super.dispose();
  }
}
