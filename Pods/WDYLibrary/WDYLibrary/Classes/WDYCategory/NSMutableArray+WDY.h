//
//  NSMutableArray+WDY.h
//  Pods
//
//  Created by wangdongyang on 16/7/5.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (WDY)

/**
 *  获取在安全模式下给定索引的对象（如果自身是空的则无）
 */
- (id)safeObjectAtIndex:(NSUInteger)index; // 设定的索引

/**
 *  移动对象从一个索引到另一个索引
 */
- (void)moveObjectFromIndex:(NSUInteger)from // 源索引
                    toIndex:(NSUInteger)to; // 目标索引

/**
 *  创建反向数组
 */
- (NSMutableArray *)reversedArray;

/**
 *  获取给定的键值和排序的数组
 */
+ (NSMutableArray *)sortArrayByKey:(NSString *)key // 键值
                             array:(NSMutableArray *)array // 指定的集合
                         ascending:(BOOL)ascending; // YES为升序，NO为降序
@end
