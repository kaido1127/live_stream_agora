import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:test_agora/app/features/auth/data/data_source/user_profile_remote_data_source.dart';
import 'package:test_agora/app/features/auth/data/repository/auth_repository.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) => AuthRepository.create(
    authRemoteDataSource: AuthRemoteDataSource.create(auth: FirebaseAuth.instance),
    userProfileRemoteDataSource:
        UserProfileRemoteDataSource.create(firestore: FirebaseFirestore.instance)));
