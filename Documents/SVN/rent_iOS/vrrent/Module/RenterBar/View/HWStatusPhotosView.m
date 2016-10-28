//
//  HWStatusPhotosView.m
//  黑马微博2期
//
//  Created by apple on 14-10-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"
#import "HWStatusPhotoView.h"


#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

#define HWStatusPhotoWH(count) (SCREEN_WIDTH -20- (((count >= HWStatusPhotoMaxCol(count))? HWStatusPhotoMaxCol(count) : count)-1)*HWStatusPhotoMargin)/((count >= HWStatusPhotoMaxCol(count))? HWStatusPhotoMaxCol(count) : count)


@implementation HWStatusPhotosView // 9

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        HWStatusPhotoView *photoView = [[HWStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.mj_x = col*(HWStatusPhotoWH(photosCount)+HWStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.mj_y = row * (HWStatusPhotoWH(photosCount) + HWStatusPhotoMargin);
        photoView.mj_w = HWStatusPhotoWH(photosCount);
        photoView.mj_h = HWStatusPhotoWH(photosCount);
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = HWStatusPhotoMaxCol(count);
    
    ///Users/apple/Desktop/课堂共享/05-iPhone项目/1018/代码/黑马微博2期35-相册/黑马微博2期/Classes/Home(首页)/View/HWStatusPhotosView.m 列数
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = SCREEN_WIDTH - 20;
    
//    (SCREEN_WIDTH - HWStatusPhotoMaxCol(count)*HWStatusPhotoMargin)/((count >= HWStatusPhotoMaxCol(count))? HWStatusPhotoMaxCol(count) : count);
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH(count) + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end