//
//  UITableView+Common.h
//  Youka
//
//  Created by wangfang on 15/12/21.
//  Copyright © 2015年 LeSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDYCategoryHeader.h"

typedef void (^LoadNewDataOperation)();

typedef void (^LoadMoreDataOperation)();

@interface UITableView (WDYSepLine)

#pragma mark - 添加分割线
- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath  withLeftSpace:(CGFloat)leftSpace;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

- (void)addLineforMessageCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;

#pragma mark - UITableView的刷新、删除操作
/** 刷新某一行 */ 
- (void)reloadDataAtIndexPath:(NSIndexPath *)indexPath;

/** 删除某一行 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;


/** 隐藏多余的UITableViewCell */
- (void)hiddenExtraCellLine;

/** ios7之后，设置列表分割线从左边开始绘制 */
- (void)setSeparatorStartLeft;
@end
