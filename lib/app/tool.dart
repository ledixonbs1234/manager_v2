import 'package:manager_v2/app/modules/comic/model/comics_model.dart';

extension ListUpdate<T> on List {
  List update(int pos, T t) {
    List<T> list = new List();
    list.add(t);
    replaceRange(pos, pos + 1, list);
    return this;
  }
}

class Glob {
  static Glob _instance;
  factory Glob() => _instance ??= new Glob._();
  Glob._();
  ComicsModel _comicsModel;
  setComicsFile(ComicsModel comics){
    _comicsModel = comics;
  }
  ComicsModel getComicsFile(){
    return _comicsModel;
  }
}
