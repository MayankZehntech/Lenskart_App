part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends ProfileEvent {
  final String uid;

  const FetchUserProfile(this.uid);

  @override
  List<Object> get props => [uid];
}

class UpdateUserProfile extends ProfileEvent {
  final String uid;
  final Map<String, dynamic> updatedInfo;

  const UpdateUserProfile(this.uid, this.updatedInfo);

  @override
  List<Object> get props => [uid, updatedInfo];
}

class GenderSelected extends ProfileEvent {
  final String gender;

  const GenderSelected(this.gender);
}

class LoadProfile extends ProfileEvent {
  final String userId;
  const LoadProfile(this.userId);
}

class UpdateProfilePicture extends ProfileEvent {
  final String userId;
  const UpdateProfilePicture(this.userId);
}
