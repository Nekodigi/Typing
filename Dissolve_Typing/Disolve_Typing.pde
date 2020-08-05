float noiseS = 100;//noise size 200
float noiseP = 0.01;//noise power 0.02
float textS = 50;//text size 100
int lifeTime = 100;
int sampItv = 1;//sampling interval
String[] sentences;
int sentIX = 0;//sentence index

Sentence sentence;

void setup(){
  sentences = loadStrings("THE CHEMICAL HISTORY OF A CANDLE.txt");
  //fullScreen();
  size(2000, 1000);//             please set alpha range 100
  colorMode(HSB, 360, 100, 100, 100);
  sentence = new Sentence(sentences[sentIX], width/2, height/2, textS, lifeTime);
  sentIX++;
}

void draw(){
  textAlign(LEFT, TOP);//need this
  background(0);
  sentence.update();
  sentence.show();
  if(sentence.end()){
    sentence = new Sentence(sentences[sentIX], width/2, height/2, textS, lifeTime);
    sentIX++;
  }
}

void keyPressed(){
  sentence.onType(key);
}

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
      chars.get(charIX).disolve();
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
  DisolveImg disImg = null;
  
  CharObj(float x, float y, char cha, float textS, int lifeTime){
    this.pos = new PVector(x, y);
    this.cha = cha;
    this.textS = textS;
    this.lifeTime = lifeTime;
  }
  
  void disolve(){
    textSize(textS);//                                           please set proper value to font
    PGraphics pg = createGraphics((int)textWidth(cha), int(textS*1.5));
    pg.beginDraw();
    pg.background(0);
    pg.textSize(textS);
    pg.textAlign(LEFT, TOP);
    pg.text(cha, 0, 0);
    pg.endDraw();
    disImg = new DisolveImg(new PVector(pos.x, pos.y), pg, lifeTime, noiseS, noiseP, sampItv, true);
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
