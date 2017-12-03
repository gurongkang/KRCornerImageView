//
//  KRCornerTableViewCell.m
//  KRCornerImageView
//
//  Created by RK on 2017/12/3.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "KRCornerTableViewCell.h"
#import "UIImageView+KRCornerImageView.h"

@interface KRCornerTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *cornerImageView;

@end

@implementation KRCornerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
  
    [self.cornerImageView kr_setImageUrl:[NSURL URLWithString:imageUrl]
                             placeholder:nil
                                    size:CGSizeMake(60, 60)
                            cornerRadius:30
                             borderWidth:1
                             borderColor:[UIColor redColor]];
}

@end
