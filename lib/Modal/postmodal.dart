class MyPostModal{


    String mmtitle;
    String engtitle;
    String author;
    String source;
    String timeStamp;
    String mmcontent;
    String engcontent;
    String image;

    MyPostModal(

      {
        
    required this.mmtitle,
        required this.engtitle,
        required this.author,
        required this.source,
        required this.timeStamp,
        required this.mmcontent,
        required this.engcontent,
        required this.image,
      }
    );

     factory MyPostModal.fromJson(dynamic data){

    return MyPostModal(

        mmtitle: data["mmtitle"],
        engtitle: data["engtitle"],
        author: data["author"],
        source: data["source"],
        timeStamp: data["timeStamp"],
        mmcontent: data["mmcontent"],
        engcontent: data["engcontent"],
        image: data["image"],

    );
  }
    Map<String, dynamic> toJson() {
        return {
            "mmtitle": mmtitle,
            "engtitle": engtitle,
            "author": author,
            "source": source,
            "timeStamp": timeStamp,
            "mmcontent": mmcontent,
            "engcontent": engcontent,
            "image": image,
        };
    }


}




