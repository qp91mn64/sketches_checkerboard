/**
 * 2026/1/15 - 2026/1/21
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
int dataMax;  // 不用徒手调
int dataMin;  // 不用徒手调
String[] dataStrings;
String fileName;
boolean r = false;
Grid grid;
CheckerboardPattern pattern = new CheckerboardPattern();  // 然后实例化这个子类
CheckerboardPattern2 pattern2 = new CheckerboardPattern2();  // 然后实例化这个子类
void setup() {
  size(512, 512);  // 调这个试一试，例如 256，1024
  W = width / w;
  H = height / h;
  noStroke();
  int i = 0;
  while (int(pow(2, i)) < max(W, H)) {
    i++;
  }
  dataMax = i;
  dataMin = -i-1;
  grid = new Grid(w, h, dataMax, dataMin);
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      drawPattern(x, y);
    }
  }
}
void draw() {
  if (r) {
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
      drawPattern(x, y);
      }
    }
    r = !r;
  }
}
void mousePressed() {
  int x = w * mouseX / width;
  int y = h * mouseY / height;
  if (mouseButton == LEFT) {
    grid.updateValue(x, y, '+');
    drawPattern(x, y);
  } else if (mouseButton == RIGHT) {
    grid.updateValue(x, y, '-');
    drawPattern(x, y);
  }
}
void keyPressed() {
  switch (key) {
    case 'r':
      grid.reset();
      r = true;
      break;
    case 's':
      int a = int(random(10000));
      fileName = String.format("output/data_%d.txt", a);
      grid.saveData(fileName);
      saveFrame(String.format("output/data_%d.png", a));
      println("已保存",String.format("data_%d", a));
      break;
  }
}
void drawPattern(int x, int y) {
  /*
  参数的不同取值范围对应不同类型图案
  这里的参数是 a
  
  而且 dataMin 到 dataMax 之间每个整数值都有对应的棋盘格图案
  而不是只有背景颜色
  
  a >= 0，与之前的草图 checkerboard_cell_interaction_2 无异
  a < 0, 反向画棋盘格，绝对值越大，棋盘格中的小方格就越大
  即： a = -1 与 a = 0 的棋盘格，格子大小相同，颜色黑白互补
  a = -2 的则与 a = 1 的互补
  a = -3 的则与 a = 2 的互补
  以此类推
  即对 a 按位取反 ~a，得到 -a-1
  注意按位取反是按照补码运算，把补码的每一位都取反，结果也是补码
  
  使用 ~a 表示 -a-1 之后规律就明显了
  负数 -- 按位取反 -- 棋盘格黑白互补
  
  正数 -- 补码等于原码 -- 棋盘格图案与原来一致
  负数 -- 补码等于除符号位不动以外按位取反加 1 -- 棋盘格取黑白互补图案
  dataMin 的绝对值恰好比 dataMax 大 1 -- 补码比原码多表示一个负数，且多表示的负数的绝对值比能表示的最大正数大 1
  */
  int a = grid.data[y][x];
  if (a >= 0){
    pattern.display(x * W, y * H, W, H, int(pow(2, a)));  // 调用子类里面的 display 方法即可
  } else {
    pattern2.display(x * W, y * H, W, H, int(pow(2, ~a)));  // 调用子类里面的 display 方法即可
  }
}
