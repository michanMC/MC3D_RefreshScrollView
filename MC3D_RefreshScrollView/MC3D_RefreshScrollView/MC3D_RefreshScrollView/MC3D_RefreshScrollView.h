//
//  MC3D_RefreshScrollView.h
//  MC3D_RefreshScrollView
//
//  Created by MC on 16/1/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBannerFooter.h"
typedef NS_ENUM(NSUInteger, MC3DScrollViewState) {
    MC3DScrollViewStateNone,
    MC3DScrollViewStateTranslation,
    MC3DScrollViewStateDepth,
    MC3DScrollViewStateCarousel,
    MC3DScrollViewStateCards
};
@interface MC3D_RefreshScrollView : UIScrollView
@property (nonatomic,assign) MC3DScrollViewState state;

@property (nonatomic,assign) CGFloat angleRatio;
@property (nonatomic,assign) CGFloat rotationX;
@property (nonatomic,assign) CGFloat rotationY;
@property (nonatomic,assign) CGFloat rotationZ;
@property (nonatomic,assign) CGFloat translateX;
@property (nonatomic,assign) CGFloat translateY;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MCBannerFooter *McFooter;
@property (nonatomic,assign)NSInteger viewCount;
- (NSUInteger)currentPage;

- (void)loadNextPage:(BOOL)animated;
- (void)loadPreviousPage:(BOOL)animated;
- (void)loadPageIndex:(NSUInteger)index animated:(BOOL)animated;


@end
