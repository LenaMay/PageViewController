//
//  LNFingerLineView.h
//  PageVC
//
//  Created by Lina on 2018/7/2.
//  Copyright © 2018年 Lina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNFingerLineModel.h"

@interface LNFingerLineView : UIView
//所有的线条信息，包含了颜色，坐标和粗细信息 @see DrawPaletteLineInfo
@property(nonatomic,strong) NSMutableArray  *allMyDrawPaletteLineInfos;
//从外部传递的 笔刷长度和宽度，在包含画板的VC中 要是颜色、粗细有所改变 都应该将对应的值传进来
@property (nonatomic,strong)UIColor *currentPaintBrushColor;//颜色
@property (nonatomic)float currentPaintBrushWidth;//笔刷的宽度
//清空所有绘制
- (void)cleanAllDraw;
//清空上一条
- (void)cleanFinallyDraw;
@end
