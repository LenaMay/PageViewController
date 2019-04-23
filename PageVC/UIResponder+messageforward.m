//
//  NSObject+messageforward.m
//  PageVC
//
//  Created by Lina on 2019/3/20.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "UIResponder+messageforward.h"
#import <objc/runtime.h>

@implementation UIResponder (messageforward)


//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//
//    NSString *str = NSStringFromSelector(sel);
//    if([str hasPrefix:@"setName"]){
//        SEL aSel = NSSelectorFromString(@"nameSetMethod:");
//        Method aMethod = class_getInstanceMethod(self, aSel);
//        class_addMethod(self, sel, method_getImplementation(aMethod), "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

- (void)nameSetMethod:(NSString*)str{
    NSLog(@"哈哈2222%@",str);
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    NSLog(@"哈哈2222");
}

@end
