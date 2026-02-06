class XORPattern_C extends Pattern {
  /* 
  c_XOR_2 风格，按位异或，棋盘格推广图案
  两种图案的结构相似，颜色上黑白互补
  */
  void display(int x0, int y0, int areaWidth, int areaHeight, int a){
    int colorZero = 255;  // 0 对应白色
    int colorOne = 0;  // 1 对应的黑色
    int cellWidth = 1;
    int cellHeight = 1;
    int W = areaWidth / cellWidth + 1;
    int H = areaHeight / cellHeight + 1;
    int dx;
    int dy;
    int result;
    for (int i = 0; i < W * H; i++) {
      dx = i % W;
      dy = i / W;
      result = (dx ^ dy) & a;  // 按位异或，然后取出特定位
      if (result != 0) {  // result 等于 0 等价于其每一位都是 0
        fill(colorOne);
      } else {
        fill(colorZero);
      }
      rectMode(CORNERS);
      rect(x0 + dx * cellWidth, y0 + dy * cellHeight, min(x0 + (dx+1) * cellWidth, x0+areaWidth), min(y0 + (dy + 1) * cellHeight, y0 + areaHeight));
    }
  }
}
