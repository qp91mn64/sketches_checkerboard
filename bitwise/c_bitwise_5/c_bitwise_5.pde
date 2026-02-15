/**
 * Author: qp91mn64
 * License: the MIT License
 * Created: 2026-02-12
 * 
 * Modefied from c_bitwise_3
 * 
 * Bitwise operation, square, & a to extract bits, result used as color
 * Pretty complex patterns
 *
 * Click to see the approximate current value of `a` in the console
 * the change of `a` by 1 can be ignored as `a` keeps changing in the draw() loop
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
int whichBitwiseOperator = 3;  // 1:& 2:| 3:^
String bitwiseString;
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
  println(bitwiseString, a, binary(a));
  frameRate(64);
}
void draw() {
  a--;  // As the change of `a` a bit doesn't change the screen too much, you may use something like `a+=2;` to make it change faster
  int b = 0;
  int color1 = 0;
  loadPixels();
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      if (whichBitwiseOperator == 1) {
        b = x & y;
      } else if (whichBitwiseOperator == 2) {
        b = x | y;
      } else if (whichBitwiseOperator == 3) {
        b = x ^ y;
      }
      color1 = a & b*b;  // Bitmask, and use the result as the color of pixels
      // So that the result between 256 and 16777215 draws something opaque. As a result we can see blue and other colors
      if (color1 > 255) {color1 = color1%16777216-16777216;}
      // Use pixels[] instead of rect() for seppd
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          pixels[min(y * cellHeight + dy, height - 1) * width + min(x * cellWidth + dx, width - 1)] = color(color1);
        }
      }
    }
  }
  updatePixels();
}
void mousePressed() {
  if (mouseButton == LEFT) {
    a++;
    println(bitwiseString, a, binary(a));
  } else if (mouseButton == RIGHT) {
    a--;
    println(bitwiseString, a, binary(a));
  }
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
        String s = String.format("your_output/c_bitwise_5_%s_a_%d_s%s.png", bitwiseString, a, stamp());  // For distinction a stamp is used
        save(s);
        println(String.format("Saved: %s", s));
      break;
  }
}
String stamp() {
  String stamp1 = year() + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);  // Timestamp to the second
  stamp1 += String.format("_%d_%d", millis(), frameCount);  // Better distinction
  return stamp1;
}
