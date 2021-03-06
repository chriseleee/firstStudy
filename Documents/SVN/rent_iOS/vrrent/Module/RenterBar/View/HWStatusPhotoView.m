//
//  HWStatusPhotoView.m
//  黑马微博2期
//
//  Created by apple on 14-10-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWStatusPhotoView.h"
#import "HWPhoto.h"
#import "UIImageView+WebCache.h"

@interface HWStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation HWStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(NSString *)photo
{
    _photo = photo;
    
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo]];
//    [self setImage:[UIImage imageNamed:@"back"]];
    // 显示\隐藏gif控件
    // 判断是够以gif或者GIF结尾
    self.gifView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.mj_x = self.mj_w - self.gifView.mj_w;
    self.gifView.mj_y = self.mj_h - self.gifView.mj_h;
}

@end
