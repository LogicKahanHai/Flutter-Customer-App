// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String phone;
  const UserModel({
    required this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> map) : phone = map['phone'] as String;

  Map<String, dynamic> toJson() => {
        'phone': phone,
      };
}

//[ ]: phone and addresses and cust id