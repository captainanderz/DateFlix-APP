import 'package:scoped_model/scoped_model.dart';


import './connected_models.dart';
// 5.2.1
class MainModel extends Model with ConnectedModels, UsersModel, LocalUserModel {

}