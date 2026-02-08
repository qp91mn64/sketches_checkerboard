class Pattern1 extends Pattern {
  /* 
  继承抽象类 Pattern
  重写 display 方法
  画出想要的棋盘格推广图案
  */
  void display(int x0, int y0, int areaWidth, int areaHeight, int a){
    int color1;
    int cellWidth = 1;
    int cellHeight = 1;
    int W = (areaWidth - 1) / cellWidth + 1;
    int H = (areaHeight - 1) / cellHeight + 1;
    int dx;
    int dy;
    int dx1;
    int dy1;
    for (int i = 0; i < W * H; i++) {
      dx = i % W;
      dy = i / W;
      color1 = (dx ^ dy) & a;  // 先把坐标x、y按位异或再和变量 a 按位与，保留相应位的值。
      if (color1 != 0) {
        color1 = 1;  // 只要有一位是 1，就把颜色取 1，相当于对计算结果所有位取或运算
      }
      // 不用矩形而是填充像素点
      for (int j = 0; j < cellWidth * cellHeight; j++) {
        dx1 = j % cellWidth;
        dy1 = j / cellWidth;
        pixels[(y0 + min(dy * cellHeight + dy1, areaHeight - 1)) * width + x0 + min(dx * cellWidth + dx1, areaWidth - 1)] = color(color1 * 255);
      }
    }
  }
}
