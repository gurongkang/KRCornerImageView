//
//  UIImageView+RKCornerImageView.h
//  KRCornerImageView
//
//  Created by RK on 2017/12/3.
//  Copyright © 2017年 KR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (KRCornerImageView)

/**
 切圆角
 
 @param url 图片地址
 @param placeholder 占位图
 @param size 大小
 @param radius 圆角角度
 */
- (void)kr_setImageUrl:(NSURL *)url
           placeholder:(UIImage *)placeholder
                  size:(CGSize )size
          cornerRadius:(CGFloat)radius;

/**
 切圆角
 
 @param url 图片地址
 @param placeholder placeholder
 @param size 大小
 @param radius 圆角角度
 @param borderWidth 描边线宽
 @param borderColor 描边颜色
 */
- (void)kr_setImageUrl:(NSURL *)url
           placeholder:(UIImage *)placeholder
                  size:(CGSize )size
          cornerRadius:(CGFloat)radius
           borderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *)borderColor;

@end
