//
//  UIButton+MyFont.h
//  Youka
//
//  Created by wangfang on 16/1/25.
//  Copyright © 2016年 LeSheng. All rights reserved.
//

#import "UIButton+MyFont.h"

@implementation UIButton (MyFont)

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self)
    {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.titleLabel.tag != 333)
        {
            CGFloat h = [UIScreen mainScreen].bounds.size.height;
            CGFloat scale = ((h > 568) ? h/568 : 1);
            
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize*scale];
        }
    }
    return self;
}

@end
