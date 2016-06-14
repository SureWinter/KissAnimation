//
//  WASKissAnimation.h
//  facebook-pop-try
//
//  Created by wangshuo on 16/6/14.
//  Copyright © 2016年 wangshuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//动画出现、动画隐藏 的开始时间，利用i产生时间差
#define Show_BeginTime CACurrentMediaTime() + 0.2*i
#define Hide_BeginTime CACurrentMediaTime() + 1.5 + 0.1*i

//动画显示后，消失的duration时长
#define Hide_Duration 1.0 - 0.05*i

@interface WASKissAnimation : NSObject

+ (WASKissAnimation*)shareKissAnimation;
/**
 *  显示嘴唇动画 传入要显示view的layer就可以额
 *
 *  @param layer 动画将要显示的layer
 */
+ (void)kissAnimationShowUpInCALayer:(CALayer*)layer
                            userIcon:(UIImage*)userIcon
                            bannerText:(NSString*)bannerText
                           landscape:(BOOL)landscapeOrPortrait
                            complete:(void (^)())complete;



@end
