import 'package:bigsize_management_staff/models/user/user.dart';
import 'package:bigsize_management_staff/services/api_provider.dart';

class StaffRepository {
  final ApiProvider _provider = ApiProvider();

  Future<StaffLogin> fetchUser() async {
    final response = await _provider.get("accounts/staff-login");
    return StaffLogin.fromJson(response);
  }

  //Future<StaffLogin>
}
