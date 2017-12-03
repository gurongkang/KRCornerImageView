//
//  UIImage+KR.h
//  KRCornerImageView
//
//  Created by RK on 2017/12/3.
//  Copyright © 2017年 KR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KR)

- (UIImage *)kr_imageByResizeToSize:(CGSize)size;

- (UIImage *)kr_imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

- (void)kr_drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips;

- (UIImage *)kr_imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)kr_imageByRoundCornerRadius:(CGFloat)radius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor;

- (UIImage *)kr_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor
                          borderLineJoin:(CGLineJoin)borderLineJoin;
@end
