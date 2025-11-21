import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/features/settings/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await apiClient.get('/user/profile');
    return ProfileModel.fromJson(response.data);
  }
}
