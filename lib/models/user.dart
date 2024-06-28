/// Represents a user model.
class UserModel {
  final String status;
  final int balance;
  final String token;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final bool isVerified;
  final String role;
  final String ownerId;
  final String walletAddress;
  final bool hasWallet;
  final String lastLogin;
  final String profilePictureUrl;

  /// Constructs a [UserModel] instance.
  UserModel({
    required this.status,
    required this.balance,
    required this.token,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.role,
    required this.ownerId,
    required this.walletAddress,
    required this.hasWallet,
    required this.lastLogin,
    required this.profilePictureUrl,
  });

  /// Constructs a [UserModel] instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      balance: json['balance'],
      token: json['token'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      isVerified: json['isVerified'],
      role: json['role'],
      ownerId: json['owner_id'],
      walletAddress: json['wallet_address'],
      hasWallet: json['has_wallet'],
      lastLogin: json['last_login'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }
}
