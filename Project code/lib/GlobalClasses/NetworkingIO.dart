import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class SocketService {
  // Singleton pattern to ensure only one instance of SocketService exists
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();
  Future<String> sendMessage(
      String ip, int port, String message, int packetType, {required String msg}) async {
    String receivedMessage = '';
    // port = 4447;
    try {
      // Create a socket connection to the given IP and port
      Socket socket = await Socket.connect(ip, port);
      print(
          'Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

      // Prepare the packet
      Uint8List buffer =
          Uint8List(8 + message.length); // 8 bytes for header + message length

      // Write packet type (4 bytes)
      ByteData.view(buffer.buffer).setInt32(0, packetType, Endian.little);

      // Write message length (4 bytes)
      ByteData.view(buffer.buffer).setInt32(4, message.length, Endian.little);

      // Write the message (String to bytes)
      buffer.setRange(8, buffer.lengthInBytes, utf8.encode(message));

      // Send the buffer to the socket
      socket.add(buffer);
      await socket.flush();

      // Receive response
      List<int> responseBuffer = [];
      int responseLength = 0;

      await for (var data in socket) {
        responseBuffer.addAll(data);
        print("Received Data:${responseBuffer.length}");

        // Check if we have at least 8 bytes (type + length)
        if (responseBuffer.length >= 8 && responseLength == 0) {
          // Read the type (first 4 bytes)
          int responseType =
              ByteData.view(Uint8List.fromList(responseBuffer).buffer)
                  .getInt32(0, Endian.little);
          print("responseType: $responseType");

          // Read the length (next 4 bytes)
          responseLength =
              ByteData.view(Uint8List.fromList(responseBuffer).buffer)
                  .getInt32(4, Endian.little);
          print("responseLength: $responseLength");
        }

        // If we have enough data for the full response, break
        if (responseBuffer.length >= responseLength) {
          receivedMessage =
              utf8.decode(responseBuffer.sublist(8, responseLength));
          print("Received Message: $receivedMessage");
          break;
        }
      }

      // Close the socket after receiving the message
      await socket.close();
    } catch (e) {
      print('Error in Socket Service: $e');
      return "Err: Network Error, No internet or Server is down";
    }
    return receivedMessage;
  }

  Map<String, List<String>> processData(String input) {
    // Split the input by records
    List<String> records =
        input.split('record#').where((record) => record.isNotEmpty).toList();

    // Initialize a map to hold the results
    Map<String, List<String>> resultMap = {};

    for (var record in records) {
      // Split the record by '&' to get the individual items
      List<String> items = record.split('&');

      for (var item in items) {
        // Further split each item by '#' to separate the key and value
        List<String> parts = item.split('#');

        if (parts.length == 2) {
          String key = parts[0];
          String value = parts[1];

          // Use the key to store the values in the result map
          if (!resultMap.containsKey(key)) {
            resultMap[key] = [];
          }
          resultMap[key]!.add(value);
        }
      }
    }

    return resultMap;
  }
}
