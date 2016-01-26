//
//  MC3D_RefreshScrollView.m
//  MC3D_RefreshScrollView
//
//  Created by MC on 16/1/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MC3D_RefreshScrollView.h"
// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface MC3D_RefreshScrollView (){

}

@end


@implementation MC3D_RefreshScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        
        return nil;
    }
    
    [self prepareInit];
    
    
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self prepareInit];
    
    return self;
}

- (void)prepareInit
{
    self.pagingEnabled = YES;
    self.clipsToBounds = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.state = MC3DScrollViewStateNone;

}
- (void)setState:(MC3DScrollViewState)state
{
    _state= state;
    
    switch (state) {
        case MC3DScrollViewStateTranslation:
            self.angleRatio = 0.;
            
            self.rotationX = 0.;
            self.rotationY = 0.;
            self.rotationZ = 0.;
            
            self.translateX = .25;
            self.translateY = .25;
            break;
        case MC3DScrollViewStateDepth:
            self.angleRatio = .5;
            
            self.rotationX = -1.;
            self.rotationY = 0.;
            self.rotationZ = 0.;
            
            self.translateX = .25;
            self.translateY = 0.;
            break;
        case MC3DScrollViewStateCarousel:
            self.angleRatio = .5;
            
            self.rotationX = -1.;
            self.rotationY = 0.;
            self.rotationZ = 0.;
            
            self.translateX = .25;
            self.translateY = .25;
            break;
        case MC3DScrollViewStateCards:
            self.angleRatio = .5;
            
            self.rotationX = -1.;
            self.rotationY = -1.;
            self.rotationZ = 0.;
            
            self.translateX = .25;
            self.translateY = .25;
            break;
        case MC3DScrollViewStateNone:
            self.angleRatio = 0.;
            
            self.rotationX = 0.;
            self.rotationY = 0.;
            self.rotationZ = 0.;
            
            self.translateX = .25;
            self.translateY = 0.;
            break;

        default:
            break;
    }
    
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentOffsetX = self.contentOffset.x;
    CGFloat contentOffsetY = self.contentOffset.y;
    
    for(UIView *view in self.subviews){
        
        CATransform3D t1 = view.layer.transform;
        view.layer.transform = CATransform3DIdentity;
        
        CGFloat distanceFromCenterX = view.frame.origin.x - contentOffsetX;

        
        view.layer.transform = t1;
        
        distanceFromCenterX = distanceFromCenterX * 40. / CGRectGetWidth(self.frame);
        
        
        //        distanceFromCenterY = distanceFromCenterY * 100. / CGRectGetHeight(self.frame);
        
        CGFloat angle = distanceFromCenterX * self.angleRatio;
        
        CGFloat offset = distanceFromCenterX;
        CGFloat translateX = (CGRectGetWidth(self.frame) * self.translateX) * offset / Main_Screen_Width;
        CGFloat translateY = (CGRectGetWidth(self.frame) * self.translateY) * abs(offset) / 40.;
        
        CATransform3D t = CATransform3DMakeTranslation(translateX, translateY, 0.);
        
        view.layer.transform = CATransform3DRotate(t, DEGREES_TO_RADIANS(angle), self.rotationX, self.rotationY, self.rotationZ);
    }
}
- (NSUInteger)currentPage
{
    CGFloat pageWidth = self.frame.size.width;
    float fractionalPage = self.contentOffset.x / pageWidth;
    return lround(fractionalPage);
}

- (void)loadNextPage:(BOOL)animated
{
    [self loadPageIndex:self.currentPage + 1 animated:animated];
}

- (void)loadPreviousPage:(BOOL)animated
{
    [self loadPageIndex:self.currentPage - 1 animated:animated];
}

- (void)loadPageIndex:(NSUInteger)index animated:(BOOL)animated
{
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    
    [self scrollRectToVisible:frame animated:animated];
}
-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
      [self addSubview:self.McFooter];
    

}

- (MCBannerFooter *)McFooter
{
    if (!_McFooter) {
        _McFooter = [[MCBannerFooter alloc]initWithFrame:CGRectMake(0,0 , 100,0 )];
        _McFooter.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _McFooter.state = MCBannerFooterStateIdle;
        
    }
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    _McFooter.frame = CGRectMake(_viewCount * width+20,0 , 100,height) ;
    
    return _McFooter;
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
