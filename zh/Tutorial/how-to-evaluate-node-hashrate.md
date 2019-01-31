# 如何估算自己的出块概率

## 粗略估算`全网的算力`

- 看最新的两个块之间的时间间隔，比如156994块和156993块之间相差19s。

![image.png](https://upload-images.jianshu.io/upload_images/277023-881a98d6a51553fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- 看最新的块的难度，比如最新的156994块是132亿

![image.png](https://upload-images.jianshu.io/upload_images/277023-b1cc6a48408e206d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

- 用`难度`除以`时间间隔`，可以得出`全网的算力(HashRate)`，$13206204507/19=695,063,395 (H/S)​$ 也就是每秒全网所有节点一共计算6.95亿次Hash值。
- 当然这是初略估计，精确的话需要截取一段时间的数据，估算平均值。

## 获取自己节点的算力值

- 这是最新的0.1.4版本的钱包程序提供的功能，需要这个功能，请下载最新的钱包程序。
- 找到并点击钱包的菜单项
- 算力统计窗口

![image.png](https://upload-images.jianshu.io/upload_images/277023-106a62e4b73d8a6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

- 算力统计窗口会显示出本节点算力，表示一秒钟进行多少次Hash运算。
  - 需要运行一段时间，等数值稳定后才是正确的算力值。
  - 经验上，一个物理线程粗略估计是34000H/S
- 算力统计会轻微的影响挖矿效率，统计完成后建议点击关闭按钮。