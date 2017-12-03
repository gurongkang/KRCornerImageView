//
//  UIImageView+RKCornerImageView.m
//  KRCornerImageView
//
//  Created by RK on 2017/12/3.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "UIImageView+KRCornerImageView.h"
#import "objc/runtime.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "UIImage+KR.h"

static char imageURLKey;

@implementation UIImageView (KRCornerImageView)

- (void)kr_setImageUrl:(NSURL *)url
           placeholder:(UIImage *)placeholder
                  size:(CGSize )size
          cornerRadius:(CGFloat)radius {
    [self kr_setImageUrl:url placeholder:placeholder size:size cornerRadius:radius borderWidth:0 borderColor:nil];
    
}

- (void)kr_setImageUrl:(NSURL *)url
           placeholder:(UIImage *)placeholder
                  size:(CGSize )size
          cornerRadius:(CGFloat)radius
           borderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *)borderColor {
    
    __block UIImage *resutImage;
    
    if(borderColor == nil) {
        borderColor = [UIColor grayColor];
    }
    
    NSString *key = [self keyForCornerImageView:url size:size cornerRadius:radius borderWidth:borderWidth borderColor:borderColor];
    
    objc_setAssociatedObject(self, &imageURLKey, key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [[SDImageCache sharedImageCache]queryCacheOperationForKey:key done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        } else {
            if(placeholder != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = placeholder;
                });
            }
            
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:url options:SDWebImageDownloaderIgnoreCachedResponse progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if(image) {
                    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_async(globalQueue, ^{
                        //修复SDwebImage 3.7变动引起的问题
                        resutImage = image;
                        CGFloat scale = resutImage.scale;
                        if(scale!=[UIScreen mainScreen].scale) {
                            resutImage = [[UIImage alloc]initWithCGImage:resutImage.CGImage scale:[UIScreen mainScreen].scale orientation:resutImage.imageOrientation];
                        }
                        //调整大小 切圆角
                        resutImage = [resutImage kr_imageByResizeToSize:size contentMode:UIViewContentModeScaleAspectFill];
                        resutImage = [resutImage kr_imageByRoundCornerRadius:radius borderWidth:borderWidth borderColor:borderColor];
                        
                        //保存
                        [[SDImageCache sharedImageCache]storeImage:resutImage forKey:key completion:nil];
                       
                        //赋image
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //tableView中防止图片乱掉
                            NSString *tempKey = objc_getAssociatedObject(self, &imageURLKey);
                            if([tempKey isEqualToString:key]) {
                                self.image = resutImage;
                            }
                        });
                    });
                }
            }];
        }
    }];
}

- (NSString *)keyForCornerImageView:(NSURL *)url size:(CGSize )size cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth  borderColor:(UIColor *)borderColor {
    NSString *urlStr = [url absoluteString];
    NSString *sizeStr = NSStringFromCGSize(size);
    NSString *radiusStr = [NSString stringWithFormat:@"%f",radius];
    NSString *borderWidthStr = [NSString stringWithFormat:@"%f",borderWidth];
    NSString *borderColorStr = [self colorStringForColor:borderColor];
    
    NSString *key = [NSString stringWithFormat:@"%@%@%@%@%@",urlStr,sizeStr,radiusStr,borderWidthStr,borderColorStr];
    return key;
}

- (NSString *)colorStringForColor:(UIColor *)color {
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    CGFloat r = cs[0];
    CGFloat g = cs[1];
    CGFloat b = cs[2];
    CGFloat alpha = cs[3];
    
    NSString *colorString = [NSString stringWithFormat:@"%02f%02f%02f%02f", r, g, b, alpha];
    return colorString;
}

@end
