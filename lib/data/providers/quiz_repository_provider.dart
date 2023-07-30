

import 'package:flutter_architecture/data/providers/remote_api_provider.dart';
import 'package:flutter_architecture/data/repository/quizz_repository_impl.dart';
import 'package:flutter_architecture/domain/repository/quizz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizRepositoryProvider = Provider<QuizzRepository>((ref) => QuizzRepositoryImpl(ref.read(remoteApiProvider)));