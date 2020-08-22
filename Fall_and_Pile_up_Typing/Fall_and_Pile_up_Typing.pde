import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

float textS = 50;//text size 100
int lifeTime = 100;
String[] sentences;
int sentIX = 0;//sentence index
float dropS = 0.05;//drop down speed
float g = 20;//40 gravity

Box2DProcessing box2d;

Sentence sentence;

void setup(){
  //fullScreen();
  size(2000, 1000);//             please set alpha range 100
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -g);
  PolygonShape sd = new PolygonShape();
  float box2dW = box2d.scalarPixelsToWorld(width/2);//origin center?
  float box2dH = box2d.scalarPixelsToWorld(10/2);
  sd.setAsBox(box2dW, box2dH);
  
  BodyDef bd = new BodyDef();
  bd.type = BodyType.STATIC;
  bd.position.set(box2d.coordPixelsToWorld(width/2, height+10/2));
  Body b = box2d.createBody(bd);
  b.createFixture(sd, 1);
  
  sentences = loadStrings("THE CHEMICAL HISTORY OF A CANDLE.txt");
  colorMode(HSB, 360, 100, 100, 100);
  sentence = new Sentence(sentences[sentIX], width/2, height/2, textS, lifeTime);
  sentIX++;
}

void draw(){
  textAlign(LEFT, TOP);//need this
  background(0);
  box2d.step();
  fill(360);
  sentence.update();
  sentence.show();
  if(sentence.end()){
    sentence.destory();
    sentence = new Sentence(sentences[sentIX], width/2, height/2, textS, lifeTime);
    sentIX++;
  }
}

void keyPressed(){
  sentence.onType(key);
}
