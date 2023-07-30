import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/remote_api.dart';

final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());