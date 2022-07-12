import 'package:grpc/grpc.dart';


/// Utils related to grpc communication
abstract class GrpcUtils {

  ///Private constructor to prevent extending
  GrpcUtils._();

  /// Returns a [ClientChannel] for grpc communication
  static ClientChannel getChannel(
    {
      String host = '10.0.2.2', 
      int port = 5154, 
      ChannelOptions options = const ChannelOptions(credentials: ChannelCredentials.insecure())
    }) {
    ClientChannel channel = ClientChannel(
      host,
      port: port,
      options: options
    );
    return channel;
  }
}