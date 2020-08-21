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
      chars.get(charIX).dissolve();
      charIX++;
    }
  }
  
  void update(){
    for(CharObj cha : chars)cha.update();
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
  DissolveImg disImg = null;
  
  CharObj(float x, float y, char cha, float textS, int lifeTime){
    this.pos = new PVector(x, y);
    this.cha = cha;
    this.textS = textS;
    this.lifeTime = lifeTime;
  }
  
  void dissolve(){
    textSize(textS);//                                           please set proper value to font
    PGraphics pg = createGraphics((int)textWidth(cha), int(textS*1.5));
    pg.beginDraw();
    pg.background(0);
    pg.textSize(textS);
    pg.textAlign(LEFT, TOP);
    pg.text(cha, 0, 0);
    pg.endDraw();
    disImg = new DissolveImg(new PVector(pos.x, pos.y), pg, lifeTime, noiseS, noiseP, sampItv, true);
  }
  
  void update(){
    if(disImg != null)disImg.update();
  }
  
  void show(){
    if(disImg == null)text(cha, pos.x, pos.y);
    else{ disImg.show();
    }
  }
}
