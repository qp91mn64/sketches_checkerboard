/**
 * Author: qp91mn64
 * License: the MIT License
 * Created: 2026-02-21
 * 
 * Modefied from c_bitwise_6a
 * 
 * Bitwise operation, square, & a to extract bits, result used as color
 * Pretty complex patterns
 * 
 * Left click: offset << 1 until offset < 0 (`a` remains unchanged)
 * Right click: offset >> 1 until offset == 1 (`a` remains unchanged)
 * Press 's' to save an image
 * 
 * See different bitwise patterns:
 * Press '1': bitwise AND &
 * Press '2': bitwise OR |
 * Press '3': bitwise XOR ^ (default)
 * 
 * No side effect of old patterns remaining after switching
 */
int cellWidth = 1;
int cellHeight = 1;
int a = 1;  // A bitmask, also an index of patterns
int xMax;
int yMax;
int offset = 1 << 12;
int xOffset;
int yOffset;
int whichBitwiseOperator = 3;  // 1:& 2:| 3:^
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
    xOffset = offset - 256;
    yOffset = offset - 256;
    println(bitwiseString, "a", a, binary(a));
    println("offset", offset, binary(offset));
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
      x1 = x + xOffset;
      y1 = y + yOffset;
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
  if (mouseButton == LEFT) {
    if (offset > 0) {offset = offset << 1;}
    background(0);
    xOffset = offset - 256;
    yOffset = offset - 256;
    println(bitwiseString, "a", a, binary(a));
    println("offset", offset, binary(offset));
  } else if (mouseButton == RIGHT) {
    if (offset >> 1 != 0) {offset = offset >>> 1;}
    background(0);
    xOffset = offset - 256;
    yOffset = offset - 256;
    println(bitwiseString, "a", a, binary(a));
    println("offset", offset, binary(offset));
  }
}
void keyPressed() {
  switch (key) {
    case '1':
      if (whichBitwiseOperator != 1) {
        background(0);
        whichBitwiseOperator = 1;
        bitwiseString = "AND";
        println(bitwiseString, a, binary(a));
      }
      break;
    case '2':
      if (whichBitwiseOperator != 2) {
        background(0);
        whichBitwiseOperator = 2;
        bitwiseString = "OR";
        println(bitwiseString, a, binary(a));
      }
      break;
    case '3':
      if (whichBitwiseOperator != 3) {
        background(0);
        whichBitwiseOperator = 3;
        bitwiseString = "XOR";
        println(bitwiseString, a, binary(a));
      }
      break;
    case 's':
        String s = String.format("your_output/c_bitwise_6b_%s_a_%d_offset_%d_s%s.png", bitwiseString, a, offset, stamp());  // For distinction a stamp is used
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
