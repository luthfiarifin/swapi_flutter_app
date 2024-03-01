import 'package:google_directions_api/google_directions_api.dart';
import 'package:injectable/injectable.dart';

import '../../core/data/network/api_client.dart';

@module
abstract class CoreInjectionModule {
  @lazySingleton
  ApiClient get apiClient => ApiClient();

  @lazySingleton
  DirectionsService get directionService {
    DirectionsService.init('AIzaSyASkT0Ogkq6BSbcJM5IrrUybO4mOiB7o8g');
    return DirectionsService();
  }
}
