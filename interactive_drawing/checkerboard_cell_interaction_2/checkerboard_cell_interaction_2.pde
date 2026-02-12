/**
 * 2026/1/15 - 2026/2/9
 *
 * 棋盘格可视化数值演示
 * 点击鼠标左键、右键试一试
 * 看一看能不能用棋盘格画出什么东西
 *
 * 把数据部分的代码拆分到 Grid 类里面
 * 
 * 受DeepSeek启发，使用抽象类来抽象出图案部分
 * 然后继承这个抽象类，实现具体图案绘制
 *
 * 我打算拆分代码
 * 从而便于复用
 * 画不同类型的图案
 * 如果你想画一种不同于示例的图案
 * 修改 `CheckerboardPattern` 中的 `display` 方法即可
 * 如果想扩展原有代码
 * 同时画多种不同图案
 * 新建标签
 * 模仿 `CheckerboardPattern` 写一个新类
 * 继承 `Pattern` 抽象类
 * 重写 `display` 方法
 * 即可在主文件或者任何画图的地方调用
 * 
 * 看起来灰蒙蒙的一片实际上是细密的棋盘格
 * 而且分了不同区域
 * 每个区域对应一个数值，这个数值决定了棋盘格的格子边长 a
 *
 * 按下 s 键保存数据和当前画布
 * 按下 r 键重置
 *
 * 注意不能撤回操作，而且可能会看起来有点眼花缭乱
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
String[] dataStrings;
String fileName;
boolean r = false;
boolean isSaved = false;  // 防止重复保存
Grid grid;
CheckerboardPattern pattern = new CheckerboardPattern();  // 然后实例化这个子类
void setup() {
  size(512, 512);  // 调这个试一试，例如 256，1024
  W = width / w;  // 每个矩形区域宽度
  H = height / h;  // 每个矩形区域高度
  noStroke();
  int i = dataMin;
  while (int(pow(2, i)) < max(W, H)) {
    i++;
  }
  dataMax = i;
  grid = new Grid(w, h, dataMax, dataMin);
  loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      pattern.display(x * W, y * H, W, H, int(pow(2, grid.data[y][x])));  // 调用子类里面的 display 方法即可
    }
  }
  updatePixels();
}
void draw() {
  if (r) {
    loadPixels();
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        pattern.display(x * W, y * H, W, H, int(pow(2, grid.data[y][x])));  // 调用子类里面的 display 方法即可
      }
    }
    updatePixels();
    r = !r;
  }
}
void mousePressed() {
  x = mouseX / W;  // 矩形区域 x 坐标
  y = mouseY / H;  // 矩形区域 y 坐标
  if (x >= w || x < 0 || y >= h || y < 0) {  // 限制坐标范围
    return;                                  // 超出画图区域的部分，点不动即可
  }
  if (mouseButton == LEFT) {
    grid.updateValue(x, y, '+');
    loadPixels();
    pattern.display(x * W, y * H, W, H, int(pow(2, grid.data[y][x])));  // 调用子类里面的 display 方法即可
    updatePixels();
    isSaved = false;
  } else if (mouseButton == RIGHT) {
    grid.updateValue(x, y, '-');
    loadPixels();
    pattern.display(x * W, y * H, W, H, int(pow(2, grid.data[y][x])));  // 调用子类里面的 display 方法即可
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
        grid.saveData(fileName);
        image1.save(s + ".png");
        println(String.format("已保存：%s", s));
        isSaved = true;
      }
      break;
  }
}
void myReset() {
  int[][] data1 = new int[grid.h][grid.w];
  for (int i = 0; i < grid.h; i++) {
    for (int j = 0; j < grid.w; j++) {
      data1[i][j] = grid.data[i][j];
    }
  }
  grid.reset();
  // 防止交替按下 r、s 键重复保存
  for (int i = 0; i < grid.h; i++) {
    for (int j = 0; j < grid.w; j++) {
      if (!isSaved) {
        break;
      }
      if (data1[i][j] != grid.data[i][j]) {
        isSaved = false;
        break;
      }
    }
    if (!isSaved) {
      break;
    }
  }
}
