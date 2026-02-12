/**
 * 2026/1/15 - 2026/2/10
 *
 * 棋盘格可视化数值演示
 * 点击鼠标左键、右键试一试
 * 看一看能不能用棋盘格画出什么东西
 *
 * 看起来灰蒙蒙的一片实际上是细密的棋盘格
 * 而且分了不同区域
 * 每个区域对应一个数值，这个数值决定了棋盘格的格子边长 a
 *
 * 按下 s 键保存数据和当前画布
 * 按下 r 键重置
 *
 * 注意不能撤回操作
 * 屏幕分辨率不够就不用尝试 1024x1024 或者更大的画布尺寸了，以免最后一排点不到。
 * 此外画布尺寸太大，就算画布能全部显示，画到后面也可能有点眼花缭乱
 * 
 * a 的计算公式：a = int(pow(2, data[y][x]))
 */
int w = 8;  // 区域列数，调这个试一试
int h = 8;  // 区域行数，调这个试一试
int W;
int H;
int x;
int y;
int dataMax;  // 不用徒手调
int dataMin = 0;
int[][] data = new int[h][w];
boolean r;
boolean isSaved = false;  // 防止重复保存
String[] dataStrings;
String fileName;
void setup() {
  size(512, 512);  // 调这个试一试，例如256，1024
  W = width / w;  // 每个矩形区域宽度
  H = height / h;  // 每个矩形区域高度
  noStroke();
  int i = dataMin;
  while (int(pow(2, i)) < max(W, H)) {
    i++;
  }
  dataMax = i;
  loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
    }
  }
  updatePixels();
}
void draw() {
  loadPixels();
  if (r) {
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
      }
    }
  r = !r;
  }
  updatePixels();
}
void mousePressed() {
  x = mouseX / W;  // 矩形区域 x 坐标
  y = mouseY / H;  // 矩形区域 y 坐标
  if (x >= w || x < 0 || y >= h || y < 0) {  // 限制坐标范围
    return;                                  // 超出画图区域的部分，点不动即可
  }
  if (mouseButton == LEFT && data[y][x] < dataMax) {
    data[y][x]++;
    loadPixels();
    checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
    updatePixels();
    isSaved = false;
  } else if (mouseButton == RIGHT && data[y][x] > dataMin) {
    data[y][x]--;
    loadPixels();
    checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
    updatePixels();
    isSaved = false;
  }
}
void keyPressed() {
  switch (key) {
    case 'r':
      // 重置
      myReset();
      r = true;
      break;
    case 's':
      // 保存
      if (!isSaved) {
        int w1 = w * W;  // 有效画图区域宽度
        int h1 = h * H;  // 有效画图区域高度
        PImage image1 = createImage(w1, h1, RGB);
        loadPixels();
        for (int i = 0; i < w1 * h1; i++) {
          int indexX = i % w1;
          int indexY = i / w1;
          image1.pixels[i] = pixels[indexY * width + indexX];  // 去除当 width 不能被 w 整除，或者 height 不能被 h 整除时，产生的不美观的灰边
        }
        int a = int(random(10000));
        String s = String.format("your_output/data_%d", a);
        fileName = s + ".txt";
        saveData(fileName, data);
        image1.save(s + ".png");
        println(String.format("已保存：%s", s));
        isSaved = true;
      }
      break;
  }
}
void checkerboard(int x0, int y0, int checkerboardWidth, int checkerboardHeight, int a) {
  // 矩形区域里面画棋盘格。
  // 画满整个区域，最右边和最下边可能有不完整的格子。
  // 参数：
  // int x0: 起始横坐标
  // int y0: 起始纵坐标
  // int checkerboardWidth: 棋盘格区域宽度
  // int checkerboardHeight: 棋盘格区域高度
  // int a: 棋盘格内每个小格子边长
  // 返回值: 无
  int W = (checkerboardWidth - 1) / a + 1;
  int H = (checkerboardHeight - 1) / a + 1;
  int color1;
  int dx;
  int dy;
  int dx1;
  int dy1;
  for (int i = 0; i < W * H; i++) {
    dx = i % W;
    dy = i / W;
    if ((dx + dy) % 2 == 0) {
      color1 = 255;
    } else {
      color1 = 0;
    }
    // 不用矩形而是填充像素点
    for (int j = 0; j < a * a; j++) {
      dx1 = j % a;
      dy1 = j / a;
      pixels[(y0 + min(dy * a + dy1, checkerboardHeight - 1)) * width + x0 + min(dx * a + dx1, checkerboardWidth - 1)] = color(color1);
    }
  }
}
void saveData(String fileName, int[][] data) {
  String[] dataStrings = new String[data.length];
  String s;
  for (int y = 0; y < data.length; y++) {
    s = String.valueOf(data[y][0]);
    for (int x = 1; x < data[0].length; x++) {
      s += String.format(" %d", data[y][x]);
    }
    dataStrings[y] = s;
  }
  saveStrings(fileName, dataStrings);
}
void myReset() {
  int[][] data1 = new int[h][w];
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {
      data1[i][j] = data[i][j];
    }
  }
  data = new int[h][w];
  // 防止交替按下 r、s 键重复保存
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {
      if (!isSaved) {
        break;
      }
      if (data1[i][j] != data[i][j]) {
        isSaved = false;
        break;
      }
    }
    if (!isSaved) {
      break;
    }
  }
}
