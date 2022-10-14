import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final client = PocketBase('http://127.0.0.1:8090');

// // create user
// Future createUser() async {
// final user = await client .users.create(body: {
//     'email': 'test@example.com',
//     'password': '123456',
//     'passwordConfirm': '123456',
// });
//     'name': 'test',
// });
// }

// // set user profile data
// final updatedProfile = await client.records.update('profiles', user.profile.id, body: {

// // send verification email
// await client.users.requestVerification(user.email);
}
