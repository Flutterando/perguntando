import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:perguntando/src/app_module.dart';

class ProfileBloc extends BlocBase {
  final ProfileRepository _profileRepository;
  ProfileBloc(this._profileRepository);

  @override
  void dispose() {
    super.dispose();
  }
}



class ProfileRepository{
  final _connection = AppModule.to.getDependency<CustomHasura>();

}