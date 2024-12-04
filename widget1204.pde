import controlP5.*;

ControlP5 cp5;

PImage iphonebgimg;
PImage campingwg;
PImage w1_food;  // 식단 위젯 이미지

// 인디케이터 이미지
PImage dots1;
PImage dots2;

// mouse scroll
boolean isLocked = false;
float pos, npos;

// 위젯1 안전/위험 상황
boolean isPlay = false;

// dots 상태를 추적하는 변수
boolean isDots1Active = true;  // true: dots1, false: dots2

// 이미지 변수
PImage safeImage;  // 안전 상황 이미지
PImage riskImage;  // 위험 상황 이미지

void setup() {
  size(402, 874);
  
  cp5 = new ControlP5(this);
  
  // 버튼1 혈당그래프 변경
  safeImage = loadImage("위젯1 안전상황.png");
  riskImage = loadImage("위젯1 위험상황.png");
  
  cp5.addButton("playBtn")
     .setPosition(34, 88)
     .setImage(safeImage)  // 기본 이미지 설정
     .updateSize();
  
  // dots 버튼 (클릭시 이미지 변경)
  cp5.addButton("dotsBtn")
     .setPosition(377, 154)
     .setImage(dots1)  // 기본 dots1 이미지
     .updateSize();
  
  iphonebgimg = loadImage("Wallpaper.png");
  campingwg = loadImage("캠핑위젯.png");
  w1_food = loadImage("식단 위젯.png");  // 식단 이미지 로드
  dots1 = loadImage("인디케이터1면.png");
  dots2 = loadImage("인디케이터2면.png");
}

void draw() {
  // 배경을 흰색으로 지웁니다.
  background(255);  
  
  // 배경 이미지 그리기
  image(iphonebgimg, 0, 0);
  
  npos = constrain(npos, -100, 0);
  pos += (npos - pos) * 0.1;
  
  pushMatrix();
  translate(0, int(pos));
  
  // 위젯 이미지 그리기
  image(campingwg, 34, 580);  // 위젯5 캠핑 위치

  
  // dots 버튼 이미지 (현재 dots1 또는 dots2)
  cp5.getController("dotsBtn").setImage(isDots1Active ? dots1 : dots2);
  
  // 버튼 위치 업데이트
  cp5.getController("playBtn").setPosition(34, 88 + pos);
  cp5.getController("dotsBtn").setPosition(377, 154 + pos);
  
  popMatrix();
}

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

// dots1 또는 dots2 버튼을 클릭했을 때
public void dotsBtn() {
  // dots 버튼이 클릭되었을 때
  isDots1Active = !isDots1Active;  // 상태 전환

  // 상태에 따라 playBtn 이미지 설정
  if (isDots1Active) {
    cp5.getController("playBtn").setImage(safeImage);  // 안전 이미지로 설정
  } else {
    cp5.getController("playBtn").setImage(w1_food);  // 식단 위젯 이미지로 설정
  }

  // 버튼 이미지 상태를 반영
  cp5.getController("dotsBtn").setImage(isDots1Active ? dots1 : dots2);
}

// 당그래프 클릭시 이미지 교체
public void playBtn() {
  println("위젯1 클릭");
  
  isPlay = !isPlay;  // 상태 전환
  
  // 위험 또는 안전 이미지로 설정
  if (isPlay) {
    cp5.getController("playBtn").setImage(riskImage);  // 위험 상황 이미지로 변경
  } else {
    cp5.getController("playBtn").setImage(safeImage);  // 안전 상황 이미지로 변경
  }
}
