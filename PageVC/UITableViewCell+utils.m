//
//  UITableViewCell+utils.m
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-10-17.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "UITableViewCell+utils.h"

@implementation UITableViewCell (utils)

- (void)getLayer
{
    /*
    CGFloat cornerRadius = 2.f;
    self.backgroundColor = UIColor.clearColor;
    
    //设置cell显示风格 圆角和描边
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(self.bounds, 5, 0);
    
    BOOL addLine = NO;
    
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    } else if (indexPath.row == 0) {
        
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        addLine = YES;
        
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        
    } else {
        
        CGPathAddRect(pathRef, nil, bounds);
        addLine = YES;
    }
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    
    layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
    //            layer.strokeColor = [UIColor blackColor].CGColor;
    //            layer.borderWidth = 1;
    
    if (addLine == YES) {
        
        CALayer *lineLayer = [[CALayer alloc] init];
        
        CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
        
        lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-20, lineHeight);
        
        lineLayer.backgroundColor = tableView.separatorColor.CGColor;
        
        [layer addSublayer:lineLayer];
    }
    
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    
    [testView.layer insertSublayer:layer atIndex:0];
    
    testView.backgroundColor = UIColor.clearColor;
    
    cell.backgroundView = testView;
     */
}

@end
