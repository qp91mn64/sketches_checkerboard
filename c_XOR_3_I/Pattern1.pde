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
    int W = areaWidth / cellWidth + 1;
    int H = areaHeight / cellHeight + 1;
    int dx;
    int dy;
    for (int i = 0; i < W * H; i++) {
      dx = i % W;
      dy = i / W;
      color1 = (dx ^ dy) & a;  // 先把坐标x、y按位异或再和变量 a 按位与，保留相应位的值。
      if (color1 != 0) {
        color1 = 1;  // 只要有一位是 1，就把颜色取 1，相当于对计算结果所有位取或运算
      }
      fill(255 * color1);  // 最左上角代表0，黑色。填充的颜色（灰度）值大于最大值就不画？
      rectMode(CORNERS);
      rect(x0 + dx * cellWidth, y0 + dy * cellHeight, min(x0 + (dx+1) * cellWidth, x0+areaWidth), min(y0 + (dy + 1) * cellHeight, y0 + areaHeight));
    }
  }
}
