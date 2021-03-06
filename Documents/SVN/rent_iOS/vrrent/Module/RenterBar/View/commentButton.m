//
//  commentButton.m
//  vrrent
//
//  Created by 龚俊平 on 16/5/5.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "commentButton.h"
#define HWMargin 12
@implementation commentButton

- (id)initWithFrame:(CGRect)frame withImageName:(NSString*)normalImage selectedImage:(NSString*)selectedImage
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
        
    }
    return self;
}

// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width += HWMargin;
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    
    WS(ws)
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AdjustW(25), AdjustH(25)));
        make.left.equalTo(ws.left);
        make.centerY.mas_equalTo(ws.centerY);
    }];
    
    self.titleLabel.mj_x = CGRectGetMaxX(self.imageView.frame) + HWMargin;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}


@end
