float noiseS = 100;
float noiseP = 1;
float textS = 25;
String[] sentences;
int sentIX = 0;//sentence index

Sentence sentence;

void setup(){
  size(1000, 500);
  sentences = loadStrings("THE CHEMICAL HISTORY OF A CANDLE.txt");
  sentence = new Sentence(sentences[sentIX], width/2, height/2, textS);
  sentIX++;
}

void draw(){
  background(0);
  sentence.update();
  sentence.show();
  if(sentence.end()){
    sentence = new Sentence(sentences[sentIX], width/2, height/2, textS);
    sentIX++;
  }
}

void keyPressed(){
  sentence.onType(key);
}

class Sentence{
  PVector pos;
  float textS;
  String text;
  ArrayList<CharObj> chars = new ArrayList<CharObj>();
  int charIX = 0;//typing char index
  
  Sentence(String text, float x, float y, float textS){//origin center, center by myself to make thing easier
    this.text = text;
    this.textS = textS;
    textSize(textS);
    pos = new PVector(x-textWidth(text)/2, y+textS/2);
    splitText();
  }
  
  void splitText(){
    chars = new ArrayList<CharObj>();
    float xoff = 0;
    textSize(textS);
    for(int i=0; i<text.length(); i++){
      char c = text.charAt(i);
      chars.add(new CharObj(pos.x + xoff, pos.y, c));
      xoff += textWidth(c);
    }
  }
  
  void onType(char target){
    char c = text.charAt(charIX);
    if(c == target){
      chars.get(charIX).broken = true;
      charIX++;
    }
  }
  
  boolean end(){
    return charIX >= text.length();
  }
  
  void update(){
    
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
  char cha;
  boolean broken = false;
  
  CharObj(float x, float y, char cha){
    this.pos = new PVector(x, y);
    this.cha = cha;
  }
  
  void show(){
    if(!broken)text(cha, pos.x, pos.y);
  }
}
