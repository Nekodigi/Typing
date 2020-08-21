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
