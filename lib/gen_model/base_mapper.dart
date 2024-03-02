//"dart run build_runner build --delete-conflicting-outputs" run this to build model
library mapper;

// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_mapper.g.dart';
part 'package:clean_arch_movie_app/features/auth/data/models/test_model.dart';
part 'package:clean_arch_movie_app/features/auth/data/models/login_model.dart';
part 'package:clean_arch_movie_app/features/auth/domain/entities/login.dart';
