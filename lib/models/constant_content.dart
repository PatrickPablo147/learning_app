class Content {
  String? text;

  Content({
    this.text,
  });

  static List<Content> getStaticContent() {
    return [
      Content(
        text: ""
      ),

    ];
  }
}