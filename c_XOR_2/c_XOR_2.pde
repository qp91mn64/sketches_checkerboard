/**
 * 2026/1/22 - 2026/1/29
 * 
 * 棋盘格的本质是异或？
 * 
 * 或者说按位异或？还是奇偶？
 * 
 * 把棋盘格看作网格填格子
 * 每个格子 x、y 坐标的二进制表示
 * 按位异或
 * 然后取特定位的值
 * 有1，结果是1，全0，结果是0，相当于按位或
 * 取哪些位呢？
 * 引入一个索引值 a，取其补码所有 1 所在位
 *
 * 只取一位则画出的是棋盘格结构
 * 越高位，对应方格越大
 * 直到画不下
 *
 * 现在多取几位
 * 看起来就像
 * 把不同方格尺寸的棋盘格放在一起的结果
 * 索引值 a 的补码出现重复片段、周期的时候
 * 画出的图案就会出现嵌套、层次、分形特征
 * 只是能画的范围很有限
 * 
 * 使用方式
 * 直接运行
 * 点击鼠标更新索引值 a 看不同图形
 * 左键 a 加 1
 * 右键 a 减 1
 * 控制台查看 a 的值以及补码
 * 
 * 按位异或计算规则是
 * 对每一位
 * 用补码运算，得到补码
 * 不同得 1 相同得 0
 * 奇数个 1 得 1 偶数个 1 得 0
 * 
 * 按位与也是补码
 * 有 1 得 1 全 0 得 0
 * 和 1 按位与不变和 0 按位与置 0
 * 故可以用按位与把一些二进制位置 0 或者取相应位的值
 * 
 * 左上角格子对应0，涂黑
 * 
 * c_XOR_2.pde 中的 c 代表 checkerboard
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int a = 1;  // 引入和索引值，取其补码中所有 1 所在位
void setup() {
  size(512,512);
  noStroke();
}
void draw() {
  int color1;
  for (int x = 0; x < width / cellWidth; x++) {
    for (int y = 0; y < height / cellHeight; y++) {
      color1 = (x ^ y) & a;  // 先把坐标x、y按位异或再和变量 a 按位与，保留相应位的值。
      if (color1 != 0) {
        color1 = 1;  // 只要有一位是 1，就把颜色取 1，相当于对计算结果所有位取或运算
      }
      fill(255 * color1);  // 最左上角代表0，黑色。填充的颜色（灰度）值大于最大值就不画？
      rect(x * cellWidth, y * cellHeight, cellWidth, cellHeight);
    }
  }
}
void mousePressed() {
  if (mouseButton == LEFT) {
    a++;
    println(a, binary(a));
  } else if (mouseButton == RIGHT) {
    a--;
    println(a, binary(a));
  }
}
