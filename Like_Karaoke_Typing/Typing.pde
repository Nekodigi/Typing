class Sentence{
  PVector pos;
  int lifeTime;
  float textS;
  String text;
  ArrayList<CharObj> chars = new ArrayList<CharObj>();
  int charIX = 0;//typing char index
  
  Sentence(String text, float x, float y, float textS, int lifeTime){
    this.text = text;
    this.textS = textS;
    this.lifeTime = lifeTime;
    textSize(textS);
    pos = new PVector(x-textWidth(text)/2, y-textS/2);//origin center, center by myself to make thing easier
    targetHX = x-textWidth(text)/2;
    hideX = targetHX;
    splitText();
  }
  
  void splitText(){
    chars = new ArrayList<CharObj>();
    float xoff = 0;
    textSize(textS);
    for(int i=0; i<text.length(); i++){
      char c = text.charAt(i);
      chars.add(new CharObj(pos.x + xoff, pos.y, c, textS, lifeTime));
      xoff += textWidth(c);
    }
  }
  
  boolean end(){
    return charIX >= text.length();
  }
  
  void onType(char target){
    char c = text.charAt(charIX);
    if(c == target){
      targetHX += textWidth(c);
      //chars.get(charIX).dissolve();
      charIX++;
    }
  }
  
  void update(){
    hideX = lerp(hideX, targetHX, hideS);
    //for(CharObj cha : chars)cha.update();
  }
  
  void show(){
    //textSize(textS);
    //text(text, pos.x, pos.y);
    for(CharObj cha : chars){
      cha.show();
    }
  }
}

class CharObj{
  PVector pos;
  float textS;
  char cha;
  int lifeTime;
  float t = 0;
  boolean typed = false;
  
  CharObj(float x, float y, char cha, float textS, int lifeTime){
    this.pos = new PVector(x, y);
    this.cha = cha;
    this.textS = textS;
    this.lifeTime = lifeTime;
  }
  
  //void dissolve(){
  //  typed = true;
  //}
  
  //void update(){
  //  if(typed)t += dropS;
  //}
  
  void show(){
    text(cha, pos.x, EaseInCubic(pos.y, pos.y+textS, t));
  }
}
