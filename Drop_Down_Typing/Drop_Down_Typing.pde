float textS = 50;//text size 100
int lifeTime = 100;
String[] sentences;
int sentIX = 0;//sentence index
float dropS = 0.05;//drop down speed

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
  fill(360);
  sentence.update();
  sentence.show();
  if(sentence.end()){
    sentence = new Sentence(sentences[sentIX], width/2, height/2, textS, lifeTime);
    sentIX++;
  }
  fill(0);
  rect(0, height/2+textS/2, width, height);
}

void keyPressed(){
  sentence.onType(key);
}
