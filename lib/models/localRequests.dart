import '../backend_com/backendSim.dart';
import '../models/dataHelper.dart';

class RequestHolder {
  String request;
  List<String> ids = [];
  bool fetching = false;
  bool fetched = false;

  Future<void> fetch() async {
    fetching = true;
    Map<String, dynamic> data = await backendRequest(request);
    LocalDataStore.digestData(data, this);
    fetching = false;
    fetched = true;
  }

  void addNewIds(List<String> ids_) {
    for (int i = 0; i < ids_.length; i++) {
      if (!ids.contains(ids_[i])) {
        ids.add(ids_[i]);
      }
    }
  }

  List<DataItem> getDataItems() {
    List<DataItem> ret = [];
    for (int i = 0; i < ids.length; i++) {
      DataItem? di = LocalDataStore.dataItems[ids[i]];
      if (di != null) {
        ret.add(di);
      }
    }
    return ret;
  }

  RequestHolder(this.request);
}
