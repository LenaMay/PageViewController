//
//  MessageforWardVC.m
//  PageVC
//
//  Created by Lina on 2019/3/20.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "MessageforWardVC.h"
#import <objc/runtime.h>
#import "UIResponder+messageforward.h"
#import "TestCornerViewController.h"


@implementation MessageforWardVC
@dynamic name;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setName:@"llllllllll"];
    NSLog(@"--------------%@",self.name);
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    TestCornerViewController *vc = [[TestCornerViewController alloc]init];
    return vc;
}




//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    SEL aSel = NSSelectorFromString(@"nameSetMethod:");
//    Method aMethod = class_getInstanceMethod(self, aSel);
//    class_addMethod(self, sel, method_getImplementation(aMethod), "v@:");
//    return YES;
//}
//
//- (void)nameSetMethod:(NSString*)str{
//    NSLog(@"哈哈%@",str);
//}



@end
