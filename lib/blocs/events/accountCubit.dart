import 'package:bloc/bloc.dart';
import 'package:profiles_app/blocs/states/accountStates.dart';
import 'package:profiles_app/classes/profileClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCubit extends Cubit<AccountStates>{
  AccountCubit():super(AccountInitialState());

  ProfileData? profileData;
  bool isHidePassword = true;
  late SharedPreferences saveLoginOnSharedPreferences;

  setProfileDate(ProfileData data){
    profileData = data;
    emit(SetProfileDataState());
  }

  ProfileData? getProfileDate(){
    return profileData;
  }

  void hidePassword(){
    isHidePassword = !isHidePassword;
    emit(HidePasswordState());
  }

  Future<void> saveLoginOnMyDevice(bool saveLogin)async{
    saveLoginOnSharedPreferences = await SharedPreferences.getInstance();
    saveLoginOnSharedPreferences.setBool('saveLogin',saveLogin);
    emit(SaveLoginState());
  }

  Future<bool?> isLoginSaved()async{
    saveLoginOnSharedPreferences = await SharedPreferences.getInstance();
    emit(SaveLoginState());
    return saveLoginOnSharedPreferences.getBool('saveLogin');
  }

}