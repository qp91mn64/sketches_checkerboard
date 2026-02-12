class XORPattern extends Pattern {
  /* 
  c_XOR_2 风格，按位异或，棋盘格推广图案
  两种图案的结构相似，颜色上黑白互补
  */
  void display(int x0, int y0, int areaWidth, int areaHeight, int a){
    int colorZero = 0;  // 0 对应黑色
    int colorOne = 255;  // 1 对应白色
    int cellWidth = 1;
    int cellHeight = 1;
    int W = (areaWidth - 1) / cellWidth + 1;
    int H = (areaHeight - 1) / cellHeight + 1;
    int color1;
    int dx;
    int dy;
    int dx1;
    int dy1;
    int result;
    for (int i = 0; i < W * H; i++) {
      dx = i % W;
      dy = i / W;
      result = (dx ^ dy) & a;  // 按位异或，然后取出特定位
      if (result != 0) {  // result 等于 0 等价于其每一位都是 0
        color1 = colorOne;
      } else {
        color1 = colorZero;
      }
      // 不用矩形而是填充像素点
      for (int j = 0; j < cellWidth * cellHeight; j++) {
        dx1 = j % cellWidth;
        dy1 = j / cellWidth;
        pixels[(y0 + min(dy * cellHeight + dy1, areaHeight - 1)) * width + x0 + min(dx * cellWidth + dx1, areaWidth - 1)] = color(color1);
      };
    }
  }
}
