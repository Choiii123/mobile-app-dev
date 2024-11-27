import controlP5.*;

ControlP5 cp5;

PImage iphonebgimg;
//PImage w1background;
PImage campingwg;
PImage w1_food;

// mouse scroll
boolean isLocked = false;
float pos, npos;

// 위젯1 안전/위험 상황
Boolean isPlay = false;


void setup() {
  size(402, 874);
  
  cp5 = new ControlP5(this);
  
  //버튼1 혈당그래프 변경
  cp5.addButton("playBtn")
     .setPosition(34,88)
     .setImage(loadImage("위젯1 안전상황.png"))
     .updateSize();
  
  iphonebgimg = loadImage("Wallpaper.png");

  campingwg = loadImage("캠핑위젯.png");
  w1_food = loadImage("식단 위젯.png");
}

void draw() {
  background(255);
  image(iphonebgimg, 0, 0);
  npos = constrain(npos, -100, 0);
  pos += (npos - pos) * 0.1;
  
  pushMatrix();
  translate(0, int(pos));
  
  // 위젯 이미지 그리기
  
  //image(w1_food, 34, 288); // 위젯1 식단추천
  image(campingwg, 34, 580);  // 위젯5 캠핑 위치

  
  cp5.getController("playBtn").setPosition(34,88 + pos);
  
  popMatrix();
}


// Mouse Scroll
void mousePressed() {
  isLocked = true;
}

void mouseDragged(MouseEvent event) {
  if (isLocked) {
    npos += (mouseY - pmouseY) * 1.5;
  }
}

void mouseReleased() {
  isLocked = false;
}

// 당그래프 클릭시 다른 당그래프로 이미지 교체
public void playBtn() {
  println("위젯1 클릭");
  
  if (isPlay) {
    cp5.getController("playBtn").setImage(loadImage("위젯1 안전상황.png"));
    cp5.getController("playBtn").updateSize();
  } else {
    cp5.getController("playBtn").setImage(loadImage("위젯1 위험상황.png"));
    cp5.getController("playBtn").updateSize();
  }
  
  isPlay = !isPlay;
}
