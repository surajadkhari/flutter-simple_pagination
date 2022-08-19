// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String userEmail;
  final String userImage;
  final String userName;
  User({
    required this.userEmail,
    required this.userImage,
    required this.userName,
  });

  User copyWith({
    String? userEmail,
    String? userImage,
    String? userName,
  }) {
    return User(
      userEmail: userEmail ?? this.userEmail,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
    );
  }

  @override
  String toString() => 'User(userEmail: $userEmail, userImage: $userImage, userName: $userName)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.userEmail == userEmail &&
      other.userImage == userImage &&
      other.userName == userName;
  }

  @override
  int get hashCode => userEmail.hashCode ^ userImage.hashCode ^ userName.hashCode;
}
