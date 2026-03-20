import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pravuxpracticle/services/apiUrls.dart';

class ApiHandler {
  Future<Response> getData({String? url}) async {
    var storedData = await http.get(Uri.parse(url.toString()));
    print(storedData.statusCode);
    print(storedData.body);
    return storedData;
  }

  Future<Response> postData({String? url, var passedData}) async {
    var storedData = await http.post(
      Uri.parse(url.toString()),
      body: passedData,
    );
    print(storedData.statusCode);
    print(storedData.body);

    return storedData;
  }

  Future<Response> removeData({String? url, var id}) async {
    print(id);
    var storedData = await http.delete(Uri.parse(url.toString() + "/" + id));
    print(storedData.statusCode);
    print(storedData.body);

    return storedData;
  }

  Future<Response> updateData({String? url, var id, var passedData}) async {
    print(id);
    var storedData = await http.put(Uri.parse(url.toString() + "/" + id),body: passedData);
    print(storedData.statusCode);
    print(storedData.body);

    return storedData;
  }
}
