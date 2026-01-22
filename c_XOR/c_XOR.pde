/**
 * 2026/1/22
 * 
 * 棋盘格的本质是异或？
 * 
 * 或者说按位异或？还是奇偶？
 * 
 * 把棋盘格看作网格填格子
 * 则每个格子 x、y 坐标的二进制表示
 * 最后一位（按位）异或的结果恰好是棋盘格的结构
 * 
 * Processing 里面，boolean 类型与 int 类型有本质区别不能混用
 * 从而用了按位异或计算
 * 只有一位的情况下计算规则与异或类似
 * 不同得 1 相同得 0
 * 奇数个 1 得 1 偶数个 1 得 0
 * 
 * 最大的区别是这里左上角格子涂黑
 * 原因是从 checkerboard_1.pde 以来的判断方式是看坐标之和奇偶，奇数（1）涂黑，偶数（0）留白：
 * if ((dx+dy)%2==0) {fill(255);} else {fill(0);}
 * 这里是把 0 涂黑 1 留白了恰好相反 color1 = x_s.charAt(31) ^ y_s.charAt(31);fill(255 * (color1 % 2));
 * 
 * c_XOR.pde 是简写，c 代表 checkerboard，为了偷点懒少打字母
 */
int w = 4;
int h = 4;
void setup() {
  size(128,128);
  noStroke();
}
void draw() {
  int color1;
  int x1;
  int y1;
  for (int x = 0; x < width/w; x++) {
    for (int y = 0; y < height/h; y++) {
      x1 = x & 1;  // 受DeepSeek启发加上之前写的详细的按位与按位或按位异或文档（文档已公开，详见 https://github.com/qp91mn64/sketches_black_white/blob/main/docs/bitwise_AND_OR_XOR_detailed.md）
      y1 = y & 1;  // 取最低位直接用按位与就够了
      color1 = x1 ^ y1;  // 然后按位异或
      fill(255 * color1);  // 最左上角代表0，黑色
      rect(x*w, y*h, w, h);
    }
  }
}
