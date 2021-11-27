import 'base_path.dart';

class BooksListPath extends BaseRoutePath {}

class BooksSettingsPath extends BaseRoutePath {}

class BooksDetailsPath extends BaseRoutePath {
  final int id;

  BooksDetailsPath(this.id);
}
