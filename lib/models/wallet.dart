/// Represents a wallet object.
class Wallet {
  final String status;
  final String message;
  final String walletName;
  final String userPin;
  final String network;
  final String publicKey;
  final List<int> secretKey;

  /// Constructs a [Wallet] object.
  ///
  /// The [status], [message], [walletName], [userPin], [network], [publicKey],
  /// and [secretKey] parameters are required.
  Wallet({
    required this.status,
    required this.message,
    required this.walletName,
    required this.userPin,
    required this.network,
    required this.publicKey,
    required this.secretKey,
  });

  /// Constructs a [Wallet] object from a JSON map.
  ///
  /// The [json] parameter is a map representing the JSON data.
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      status: json['status'],
      message: json['message'],
      walletName: json['walletName'],
      userPin: json['userPin'],
      network: json['network'],
      publicKey: json['publicKey'],
      secretKey: List<int>.from(json['secretKey']),
    );
  }
}
