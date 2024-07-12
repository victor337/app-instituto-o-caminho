part of 'edit_profile_page_cubit.dart';

class EditProfilePageState {
  EditProfilePageState({
    this.name,
    this.image,
    this.isUseLocalImage = false,
    this.phone,
    this.isLoading = false,
  });

  EditProfilePageState copyWith({
    String? name,
    String? image,
    bool? isUseLocalImage,
    String? phone,
    bool? isLoading,
  }) {
    return EditProfilePageState(
      name: name ?? this.name,
      image: image ?? this.image,
      isUseLocalImage: isUseLocalImage ?? this.isUseLocalImage,
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final String? name;
  final String? image;
  final bool isUseLocalImage;
  final String? phone;
  final bool isLoading;
}
