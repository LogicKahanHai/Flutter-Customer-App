import 'package:pk_customer_app/models/models.dart';

class UserRepo {
  static final UserModel _user = UserModel(
    id: '1',
    phone: '1234567890',
    addresses: [
      AddressModel(
        id: '1',
        addressType: 'Home',
        address: '123, ABC Street, XYZ City',
        lat: '12.345678',
        lon: '98.765432',
        userId: '1',
        pincode: '400701',
      ),
      AddressModel(
        id: '2',
        addressType: 'Office',
        address: '123, DEF Street, YAZ City',
        lat: '12.345678',
        lon: '98.765432',
        userId: '1',
        pincode: '400701',
      ),
    ],
    token: '1234',
  );

  static UserModel get user => _user;

  static void addAddress(String address, String addressType, String lat,
      String lon, String pincode) {
    //[ ]: Every new address can have a new phone number..
    _user.addresses.add(
      AddressModel(
        id: {_user.addresses.length + 1}.toString(),
        addressType: addressType,
        address: address,
        lat: lat,
        lon: lon,
        pincode: pincode,
        userId: _user.id,
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
