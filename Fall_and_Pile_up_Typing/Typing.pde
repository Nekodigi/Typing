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
  
  void destory(){
    for(CharObj cha : chars)cha.destory();
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
  float textS, textW;
  char cha;
  int lifeTime;
  float t = 0;
  boolean typed = false;
  Body body;
  
  CharObj(float x, float y, char cha, float textS, int lifeTime){
    this.pos = new PVector(x, y);
    this.cha = cha;
    this.textS = textS;
    textSize(textS);
    this.textW = textWidth(cha);
    this.lifeTime = lifeTime;
  }
  
  void dissolve(){
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(textW/2);
    float box2dH = box2d.scalarPixelsToWorld(textS/2);
    sd.setAsBox(box2dW, box2dH);
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(pos.x+textW/2, pos.y+textS/2));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 0), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
    
    typed = true;
  }
  
  void update(){
    if(typed)t += dropS;
  }
  
  void destory(){
    box2d.destroyBody(body);
  }
  
  void show(){
    if(typed){
      pos = box2d.getBodyPixelCoordPVector(body);
      float angle = body.getAngle();
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(-angle);
      textAlign(CENTER, CENTER);
      text(cha, 0, 0);
      popMatrix();
    }else{
      textAlign(LEFT, TOP);
      text(cha, pos.x, pos.y);
    }
  }
}
