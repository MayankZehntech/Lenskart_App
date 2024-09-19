import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lenskart_clone/services/user_info_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserInfoService userInfoService;

  ProfileBloc(this.userInfoService) : super(ProfileInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<GenderSelected>(_onGenderSelected);
    on<UpdateProfilePicture>(_onUpdateProfilePicture);
  }

  // Fetching user profile
  Future<void> _onFetchUserProfile(
      FetchUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final userInfo = await userInfoService.getUserInfo(event.uid);
      if (userInfo != null) {
        emit(ProfileLoaded(userInfo));
      } else {
        emit(const ProfileError("User info not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Updating user profile
  Future<void> _onUpdateUserProfile(
      UpdateUserProfile event, Emitter<ProfileState> emit) async {
    try {
      await userInfoService.updateUserInfo(event.uid, event.updatedInfo);
      emit(ProfileUpdated());
      add(FetchUserProfile(event.uid)); // Re-fetch the updated data
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onGenderSelected(GenderSelected event, Emitter<ProfileState> emit) {
    // Update gender locally and emit a new state with the updated gender
    if (state is ProfileLoaded) {
      final currentUser = (state as ProfileLoaded).userInfo;
      emit(ProfileLoaded({
        ...currentUser,
        'gender': event.gender,
      }));
    }
  }

  // Handling profile picture update
  Future<void> _onUpdateProfilePicture(
      UpdateProfilePicture event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfilePictureUpdateInProgress());

      // Call the service to pick image and upload
      String? newPhotoUrl =
          await userInfoService.pickImageAndUpload(event.userId);

      if (newPhotoUrl != null) {
        emit(ProfilePictureUpdateSuccess(newPhotoUrl));
        add(FetchUserProfile(event.userId)); // Re-fetch the updated data
      } else {
        emit(const ProfilePictureUpdateFailure(
            'Failed to update profile picture'));
      }
    } catch (e) {
      print('mayank : Error updating profile picture: $e');
      emit(const ProfilePictureUpdateFailure('Error updating profile picture'));
    }
  }
}
