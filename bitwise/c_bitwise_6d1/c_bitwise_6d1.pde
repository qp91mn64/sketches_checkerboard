/**
 * Author: qp91mn64
 * License: the MIT License
 * Created: 2026-02-23
 * 
 * Modefied from c_bitwise_6d
 * 
 * Bitwise operation, square, & a to extract bits, result used as color
 * Pretty complex patterns
 * 
 * You can drag to explore different parts
 *
 * Smaller canvas, 512x512 pixels 
 *
 * Side effert: old patterns remain with dragging or switching
 * Use the pattern as brush?
 * Blurred effects with transparency
 * 
 * Left click: a + 1
 * Right click: a - 1
 * Press 's' to save an image
 * 
 * See different bitwise patterns:
 * Press '1': bitwise AND &
 * Press '2': bitwise OR |
 * Press '3': bitwise XOR ^ (default)
 */
int cellWidth = 1;
int cellHeight = 1;
int a = 1;  // A bitmask, also an index of patterns
int xMax;
int yMax;
int xOffset = 3840;
int yOffset = 3840;
int whichBitwiseOperator = 3;  // 1:& 2:| 3:^
int x1 = 0;
int y1 = 0;
int x2 = 0;
int y2 = 0;
String bitwiseString;
PImage image1;
void setup() {
  size(512, 512);
  noStroke();
  xMax = (width - 1) / cellWidth + 1;  // Avoid grey egdes when `width` cannot be divided by `cellWidth`
  yMax = (height - 1) / cellHeight + 1;  // Avoid grey egdes when `height` cannot be divided by `cellHeight`
  if (whichBitwiseOperator == 1) {
    bitwiseString = "AND";
  } else if (whichBitwiseOperator == 2) {
    bitwiseString = "OR";
  } else if (whichBitwiseOperator == 3) {
    bitwiseString = "XOR";
  }
  image1 = createImage(width, height, ARGB);
  println(bitwiseString, a, binary(a));
  frameRate(64);
}
void draw() {
  a--;  // As the change of `a` a bit doesn't change the screen too much, you may use something like `a-=2;` to make it change faster
  int b = 0;
  int color1 = 0;
  int x1;
  int y1;
  image1.loadPixels();
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      // Calculate values near 4096
      x1 = x + xOffset - x2;
      y1 = y + yOffset - y2;
      if (whichBitwiseOperator == 1) {
        b = x1 & y1;
      } else if (whichBitwiseOperator == 2) {
        b = x1 | y1;
      } else if (whichBitwiseOperator == 3) {
        b = x1 ^ y1;
      }
      color1 = a & b*b;  // Bitmask, and use the result as the color of pixels
      // Use pixels[] instead of rect() for speed
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          image1.pixels[min(y * cellHeight + dy, height - 1) * width + min(x * cellWidth + dx, width - 1)] = color(color1);
        }
      }
    }
  }
  image1.updatePixels();
  image(image1, 0, 0);
}
void mousePressed() {
  if (x1 == 0) {x1 = mouseX;}
  if (y1 == 0) {y1 = mouseY;}
  if (mouseButton == LEFT) {
    a++;
    println(bitwiseString, a, binary(a));
  } else if (mouseButton == RIGHT) {
    a--;
    println(bitwiseString, a, binary(a));
  }
}
void mouseDragged() {
  x2 = mouseX - x1;
  y2 = mouseY - y1;
}
void mouseReleased() {
  xOffset -= x2;
  yOffset -= y2;
  x2 = 0;
  y2 = 0;
  println(String.format("xOffset:%d yOffset:%d", xOffset, yOffset));
  x1 = 0;
  y1 = 0;
}
void keyPressed() {
  switch (key) {
    case '1':
      if (whichBitwiseOperator != 1) {
        whichBitwiseOperator = 1;
        bitwiseString = "AND";
        println(bitwiseString, a, binary(a));
      }
      break;
    case '2':
      if (whichBitwiseOperator != 2) {
        whichBitwiseOperator = 2;
        bitwiseString = "OR";
        println(bitwiseString, a, binary(a));
      }
      break;
    case '3':
      if (whichBitwiseOperator != 3) {
        whichBitwiseOperator = 3;
        bitwiseString = "XOR";
        println(bitwiseString, a, binary(a));
      }
      break;
    case 's':
        String s = String.format("your_output/c_bitwise_6d1_%s_a_%d_xOffset_%d_yOffset_%d_s%s.png", bitwiseString, a, xOffset, yOffset, stamp());  // For distinction a stamp is used
        save(s);  // Save what on the canvas directly. 
        println(String.format("Saved: %s", s));
      break;
  }
}
String stamp() {
  String stamp1 = year() + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);  // Timestamp to the second
  stamp1 += String.format("_%d_%d", millis(), frameCount);  // Better distinction
  return stamp1;
}
