import 'package:pk_customer_app/models/models.dart';

class UserRepo {
  static late UserModel _user;

  UserRepo(UserModel user) {
    _user = user;
  }

  static UserModel get user => _user;

  static set user(UserModel newUser) {
    _user = newUser;
  }

  static void addAddress({
    required String address1,
    required String addressType,
    required String lat,
    required String lon,
    String? pincode,
    String? address2,
    String? city,
    String? state,
    String? country,
  }) {
    //[ ]: Every new address can have a new phone number..
    _user.addresses.add(
      AddressModel(
        id: {_user.addresses.length + 1}.toString(),
        addressType: addressType,
        addressLine1: address1,
        addressLine2: address2,
        lat: lat,
        lon: lon,
        pincode: pincode,
        userId: _user.id,
        city: city,
        state: state,
        country: country,
      ),
    );
  }

  static void removeAddress(String id) {
    _user.addresses.removeWhere((element) => element.id == id);
  }

  static int get addressesLength => _user.addresses.length;

  static List<AddressModel>? get addresses {
    try {
      return _user.addresses;
    } catch (_) {
      return null;
    }
  }

  static AddressModel? get currentAddress {
    try {
      return _user.addresses[_user.currentAddressIndex];
    } catch (_) {
      return null;
    }
  }

  static void setCurrentAddressIndex(int index) {
    _user.currentAddressIndex = index;
  }
}
