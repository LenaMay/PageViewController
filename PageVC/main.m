//
//  main.m
//  PageVC
//
//  Created by Lina on 16/4/28.
//  Copyright © 2016年 Lina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    NSString * str= @"hahahah";
    void  (^blk)(void) = ^{
        NSLog(@"5354%@",str);
    };
    str = @"4543545";
    blk();
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
