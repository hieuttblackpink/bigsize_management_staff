// ignore_for_file: unnecessary_getters_setters

class ProductChosenData {
  String? _chosenProductID;
  String? _chosenProductDetailID;

  ProductChosenData({String? chosenProductID, String? chosenProductDetailID}) {
    if (chosenProductID != null) {
      _chosenProductID = chosenProductID;
    }
    if (chosenProductDetailID != null) {
      _chosenProductDetailID = chosenProductDetailID;
    }
  }

  String? get chosenProductID => _chosenProductID;
  set chosenProductID(String? chosenProductID) =>
      _chosenProductID = chosenProductID;
  String? get chosenProductDetailID => _chosenProductDetailID;
  set chosenProductDetailID(String? chosenProductDetailID) =>
      _chosenProductDetailID = chosenProductDetailID;
}
