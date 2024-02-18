import '../backend_com/backendSim.dart';
import '../models/dataHelper.dart';

class RequestHolder {
  String request;
  List<String> ids = [];
  bool fetching = false;
  bool fetched = false;

  Future<List<String>> fetch() async {
    print('In Fetch');
    fetching = true;
    dynamic data = await backendRequest(request);
    LocalDataStore.digestData(data, this);
    fetching = false;
    fetched = true;
    print('Finished Fetch');
    return ids;
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
