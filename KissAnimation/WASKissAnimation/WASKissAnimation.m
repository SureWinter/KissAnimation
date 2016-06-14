//
//  WASKissAnimation.m
//  facebook-pop-try
//
//  Created by wangshuo on 16/6/14.
//  Copyright © 2016年 wangshuo. All rights reserved.
//

#import "WASKissAnimation.h"

@interface WASKissAnimation()

@property (nonatomic,strong) NSArray  *frames;

@property (nonatomic,strong) NSMutableArray  *array;

@property (nonatomic,strong) NSMutableArray  *titleArray;

@property (nonatomic,assign) BOOL  isAnimaiting;

@property (copy) void(^complete)(void);

@end

@implementation WASKissAnimation


+ (WASKissAnimation*)shareKissAnimation {
    static WASKissAnimation * kiss;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kiss = [[WASKissAnimation alloc] init];
        kiss.isAnimaiting = NO;
    });
    return kiss;
}




+ (void)kissAnimationShowUpInCALayer:(CALayer*)layer
                            userIcon:(UIImage*)userIcon
                            bannerText:(NSString*)bannerText
                           landscape:(BOOL)landscapeOrPortrait
                            complete:(void (^)())complete
{
  
    WASKissAnimation *kiss = [WASKissAnimation shareKissAnimation];

    if (kiss.isAnimaiting == YES) {
        return;
    }
    
    kiss.complete = complete;
    
    kiss.isAnimaiting = YES;
    
    CALayer *richMan = [CALayer layer];
    UIImage *newIcon = [kiss imageWithBorderWidth:13 borderColor:[UIColor whiteColor] image:userIcon];
    richMan.contents = (id)(newIcon.CGImage);
    richMan.frame = CGRectMake(20, 100, 35, 35);
    richMan.contentsScale = 2.0;
    [layer addSublayer:richMan];
    
    CATextLayer *text = [CATextLayer layer];
    text.frame = CGRectMake(60, 100, 300, 40);
    text.string = bannerText;
    UIFont *font = [UIFont systemFontOfSize:25];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    text.font = fontRef;
    text.wrapped = YES;
    text.contentsScale = 2.0;
    text.fontSize = font.pointSize;
    CGFontRelease(fontRef);

    
    [layer addSublayer:text];
    [kiss.titleArray addObject:richMan];
    [kiss.titleArray addObject:text];

    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;


    CABasicAnimation *showUpAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showUpAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    showUpAnimation.toValue = [NSNumber numberWithFloat:1.0];
    showUpAnimation.duration = 0.0;
    showUpAnimation.removedOnCompletion = NO;
    showUpAnimation.fillMode = kCAFillModeForwards;

    for (int i = 0;i<6; i++) {
        CALayer *subLayer = kiss.array[i];
        NSValue *frameValue = kiss.frames[i];
        subLayer.frame = [frameValue CGRectValue];
        [layer addSublayer:subLayer];
        opacityAnimation.beginTime = Hide_BeginTime;
        showUpAnimation.beginTime = Show_BeginTime;
        opacityAnimation.duration = Hide_Duration;
        if (i==5) {
            opacityAnimation.delegate = kiss;
        }
        [subLayer addAnimation:opacityAnimation forKey:nil];
        [subLayer addAnimation:showUpAnimation forKey:nil];
    }
    
}




- (UIImage *)imageWithBorderWidth:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image{
    
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    [path addClip];
    
    [image drawInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.array makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.titleArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.titleArray removeAllObjects];
    self.isAnimaiting = NO;
    self.complete();
    
}


-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
        for (int i = 0; i <6; i++) {
            CALayer *layer = [CALayer layer];
            layer.contents = (id)[UIImage imageNamed:[NSString stringWithFormat:@"kiss%d",i+1]].CGImage;
            layer.opacity = 0.0;
            [_array addObject:layer];
        }
    }
    return _array;
}

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
        
    }
    return _titleArray;
}


- (NSArray *)frames
{
    if (_frames == nil) {
        
        CGFloat LCDW = [[UIScreen mainScreen] bounds].size.width;
        CGFloat LCDH = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat X1 = 0;
        CGFloat Y1 = LCDH/3.5;
        CGFloat W1 = 202;
        CGFloat H1 = 115;
        
        NSValue *value1 = [NSValue valueWithCGRect:CGRectMake(X1,Y1,W1, H1)];
        
        CGFloat X2 = LCDW/2 - 30;
        CGFloat Y2 = LCDH/3 + 50;
        CGFloat W2 = 220;
        CGFloat H2 = 185;
        
        NSValue *value2 = [NSValue valueWithCGRect:CGRectMake(X2, Y2,W2 ,H2)];
        
        CGFloat X3 = 20;
        CGFloat Y3 = LCDH/1.6;
        CGFloat W3 = 163;
        CGFloat H3 = 123;
        
        NSValue *value3 = [NSValue valueWithCGRect:CGRectMake(X3, Y3, W3, H3)];
        
        CGFloat X4 = LCDW -171 ;
        CGFloat Y4 = LCDH/1.4;
        CGFloat W4 = 171;
        CGFloat H4 = 143;
        
        NSValue *value4 = [NSValue valueWithCGRect:CGRectMake(X4, Y4, W4, H4)];
        
        CGFloat X5 = 40;
        CGFloat Y5 = LCDH/7;
        CGFloat W5 = 155;
        CGFloat H5 = 88;
        
        NSValue *value5 = [NSValue valueWithCGRect:CGRectMake(X5, Y5, W5, H5)];
        
        CGFloat X6 = LCDW-150;
        CGFloat Y6 = LCDH/7.5;
        CGFloat W6 = 150;
        CGFloat H6 = 121;
        
        NSValue *value6 = [NSValue valueWithCGRect:CGRectMake(X6, Y6, W6, H6)];
        
        _frames = @[value1,value2,value3,value4,value5,value6];
    }
    return _frames;
}

@end
