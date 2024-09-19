part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userInfo;

  const ProfileLoaded(this.userInfo);

  @override
  List<Object> get props => [userInfo];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileUpdated extends ProfileState {}

// user profile image
class ProfilePictureUpdateInProgress extends ProfileState {}

class ProfilePictureUpdateSuccess extends ProfileState {
  final String photoUrl;
  const ProfilePictureUpdateSuccess(this.photoUrl);
}

class ProfilePictureUpdateFailure extends ProfileState {
  final String error;
  const ProfilePictureUpdateFailure(this.error);
}
