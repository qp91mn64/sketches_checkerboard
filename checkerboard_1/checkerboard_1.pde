/**
 * 2026/1/15 - 2026/1/16
 *
 * 在屏幕上画棋盘格的函数
 */
void setup() {
  size(512, 512);
  noStroke();
}
void draw() {
  Checkerboard(0, 0, width/2, height/2, 16);
  Checkerboard(width/2, 0, width/2, height/2, 40);
  Checkerboard2(0, height/2, width/2, height/2, 16);
  Checkerboard2(width/2, height/2, width/2, height/2, 40);
}
void Checkerboard(int x0, int y0, int checkerboardWidth, int checkerboardHeight, int a) {
  // 矩形区域里面画棋盘格。
  // 只画完整的小格子，最右边和最下边可能没有格子。
  // 参数：
  // int x0: 起始横坐标
  // int y0: 起始纵坐标
  // int checkerboardWidth: 区域宽度
  // int checkerboardHeight: 区域高度
  // int a: 每个小格子边长
  // 返回值: 无
  int W = checkerboardWidth / a;
  int H = checkerboardHeight / a;
  int dx;
  int dy;
  for (int i = 0; i < W * H; i++) {
    dx = i % W;
    dy = i / W;
    if ((dx+dy)%2==0) {fill(255);} else {fill(0);}
    rect(x0 + dx * a, y0 + dy * a, a, a);
  }
}
void Checkerboard2(int x0, int y0, int checkerboardWidth, int checkerboardHeight, int a) {
  // 矩形区域里面画棋盘格。
  // 画满整个区域，最右边和最下边可能有不完整的格子。
  // 参数：
  // int x0: 起始横坐标
  // int y0: 起始纵坐标
  // int checkerboardWidth: 区域宽度
  // int checkerboardHeight: 区域高度
  // int a: 每个小格子边长
  // 返回值: 无
  int W = checkerboardWidth / a + 1;
  int H = checkerboardHeight / a + 1;
  int dx;
  int dy;
  for (int i = 0; i < W * H; i++) {
    dx = i % W;
    dy = i / W;
    if ((dx+dy)%2==0) {fill(255);} else {fill(0);}
    if (dx != W - 1) {
      if (dy != H - 1) {
        rect(x0 + dx * a, y0 + dy * a, a, a);
      } else {
        rect(x0 + dx * a, y0 + dy * a, a, min(a, checkerboardHeight % a));
      }
    } else {
      if (dy != H - 1) {
        rect(x0 + dx * a, y0 + dy * a, min(a, checkerboardWidth % a), a);
      } else {
        rect(x0 + dx * a, y0 + dy * a, min(a, checkerboardWidth % a), min(a, checkerboardHeight % a));
      }
    }
  }
}
