//
//  NSObject+AssociatedObject.h
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author foxsofter, 15-02-23 21:02:44
 *
 *  @brief  添加属性到对象
 */
@interface NSObject (AssociatedObject)

- (id)object:(SEL)key;

- (void)setAssignObject:(id)object withKey:(SEL)key;

- (void)setRetainNonatomicObject:(id)object withKey:(SEL)key;

- (void)setCopyNonatomicObject:(id)object withKey:(SEL)key;

- (void)setRetainObject:(id)object withKey:(SEL)key;

- (void)setCopyObject:(id)object withKey:(SEL)key;

@end
