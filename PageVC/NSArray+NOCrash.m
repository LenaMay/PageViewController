//
//  NSArray+NOCrash.m
//  PageVC
//
//  Created by Lina on 2019/1/3.
//  Copyright © 2019 Lina. All rights reserved.
//

#import "NSArray+NOCrash.h"
#import <objc/runtime.h>

@implementation NSArray (NOCrash)

+(void)load{
    //可变数组添加
    Method mufromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(addObject:));
    Method mutoMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(em_addObject:));
    method_exchangeImplementations(mufromMethod, mutoMethod);
    
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(initWithObjects:count:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(em_initWithObjects:count:));
    method_exchangeImplementations(fromMethod, toMethod);
    
    
    //不可变数组
    Method   oldfromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndex:));
    method_exchangeImplementations(oldfromMethod, newObjectAtIndex);

    
    //替换可变数组方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtSafeIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);

}

- (void)em_addObject:(id)emObject{
    if (emObject) {
        [self em_addObject:emObject];
    }
}

- (instancetype)em_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt
{
    id newObjects[cnt];
    NSInteger index = 0;
    for (int i=0; i<cnt; i++) {
        id object = objects[i];
        if (object) {
            newObjects[index] = object;
            index++;
        }
    }
    cnt = index;
    return [self em_initWithObjects:newObjects count:cnt];
}

- (id)objectAtSafeIndex:(NSUInteger)index{
    if (self.count - 1>= index) {
        return [self objectAtSafeIndex:index];
    }
    return nil;
}

- (id)mutableObjectAtSafeIndex:(NSUInteger)index{
    if (self.count - 1>= index) {
        return [self mutableObjectAtSafeIndex:index];
    }
    return nil;
}



@end
