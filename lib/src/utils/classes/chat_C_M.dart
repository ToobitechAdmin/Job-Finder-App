// ignore_for_file: file_names

class ChatModel {
  String? id;
  String? message;
  String? status;
  String? time;
  String? imgurl;
  ChatModel({this.id, this.message, this.imgurl, this.status, this.time});
}

List<ChatModel> chatlist = [
  ChatModel(
      id: 'receiver',
      message:
          'The point of using Lorem Ipsum is that it has a more or less normal distribution of letters.',
      status: 'seen',
      time: '12:46 am',
      imgurl: 'assets/images/receiver.png'),
  ChatModel(
      id: 'sender',
      message:
          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. .',
      status: 'seen',
      time: '12:46 am',
      imgurl: 'assets/images/personimg.png'),
  ChatModel(
      id: 'receiver',
      message: 'oky.',
      status: 'seen',
      time: '12:47 am',
      imgurl: 'assets/images/receiver.png'),
  ChatModel(
      id: 'receiver',
      message: 'hey.',
      status: 'delivered',
      time: '12:49 am',
      imgurl: 'assets/images/receiver.png'),
  ChatModel(
      id: 'receiver',
      message: 'Listen.',
      status: 'sent',
      time: '12:55 am',
      imgurl: 'assets/images/receiver.png'),
];
