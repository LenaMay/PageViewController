//
//  LNFingerLineView.m
//  PageVC
//
//  Created by Lina on 2018/7/2.
//  Copyright © 2018年 Lina. All rights reserved.
//

#import "LNFingerLineView.h"

@implementation LNFingerLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _allMyDrawPaletteLineInfos = [[NSMutableArray alloc] initWithCapacity:10];
        self.currentPaintBrushColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        self.currentPaintBrushWidth =  4.f;
    }
    return self;

}

//根据现有的线条 绘制相应的图画
- (void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    if(_allMyDrawPaletteLineInfos.count>0){
        for (int i  = 0; i<_allMyDrawPaletteLineInfos.count; i++) {
            LNFingerLineModel *model = _allMyDrawPaletteLineInfos[i];
            CGContextBeginPath(context);
            CGPoint myStartPoint = [[model.linePoints objectAtIndex:0] CGPointValue];
            CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
            if (model.linePoints.count>1) {
                for (int j=0; j<[model.linePoints count]-1; j++) {
                    CGPoint myEndPoint=[[model.linePoints objectAtIndex:j+1] CGPointValue];
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
            }else {
                CGContextAddLineToPoint(context, myStartPoint.x,myStartPoint.y);
            }
            CGContextSetLineWidth(context, model.lineWidth+1);
            CGContextSetStrokeColorWithColor(context, model.lineColor.CGColor);
            CGContextStrokePath(context);
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    //添加一个新的线条
    [self drawPaletteTouchesBeganWithWidth:self.currentPaintBrushWidth andColor:self.currentPaintBrushColor andBeginPoint:[touch locationInView:self]];
    
    
}

//触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* MovePointArray=[touches allObjects];
    [self drawPaletteTouchesMovedWithPonit:[[MovePointArray objectAtIndex:0] locationInView:self]];
    [self setNeedsDisplay];
}


//在触摸开始的时候 添加一条新的线条 并初始化
- (void)drawPaletteTouchesBeganWithWidth:(float)width andColor:(UIColor *)color andBeginPoint:(CGPoint)bPoint {
    
    LNFingerLineModel *info = [LNFingerLineModel new];
    info.lineColor = color;
    info.lineWidth = width;
    [info.linePoints addObject:[NSValue valueWithCGPoint:bPoint]];
    [self.allMyDrawPaletteLineInfos addObject:info];
}

//在触摸移动的时候 将现有的线条的最后一条的 point增加相应的触摸过的坐标
- (void)drawPaletteTouchesMovedWithPonit:(CGPoint)mPoint {
    
    LNFingerLineModel *lastInfo = [self.allMyDrawPaletteLineInfos lastObject];
    [lastInfo.linePoints addObject:[NSValue valueWithCGPoint:mPoint]];

}
//清空所有绘制
- (void)cleanAllDraw{
    if (self.allMyDrawPaletteLineInfos.count>0) {
        [self.allMyDrawPaletteLineInfos removeAllObjects];
        [self setNeedsDisplay];
    }
}
//清空上一条
- (void)cleanFinallyDraw{
    if (self.allMyDrawPaletteLineInfos.count>0) {
        [self.allMyDrawPaletteLineInfos removeLastObject];
        [self setNeedsDisplay];
    }
}
@end
