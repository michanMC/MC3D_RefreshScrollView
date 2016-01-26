//
//  MCBannerFooter.m
//  SocialMall
//
//  Created by MC on 16/1/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCBannerFooter.h"
#define ZY_ARROW_SIDE 15.f

@implementation MCBannerFooter
@synthesize idleTitle = _idleTitle;
@synthesize triggerTitle = _triggerTitle;

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.arrowView];
        [self addSubview:self.label];

        self.arrowView.image = [UIImage imageNamed:@"banner_arrow"];

    }
    return self;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat arrowX =10; //self.bounds.size.width / 2 - ZY_ARROW_SIDE - 2;
    CGFloat arrowY = self.bounds.size.height / 2 - ZY_ARROW_SIDE / 2;
    CGFloat arrowW = ZY_ARROW_SIDE;
    CGFloat arrowH = ZY_ARROW_SIDE;
    self.arrowView.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    
    CGFloat labelX = arrowX + arrowW + 5;//self.bounds.size.width / 2 + 2;
    CGFloat labelY = 0;
    CGFloat labelW = ZY_ARROW_SIDE;
    CGFloat labelH = self.bounds.size.height;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
    }
    return _arrowView;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor darkGrayColor];
        _label.numberOfLines = 0;
    }
    return _label;
}
- (void)setState:(MCBannerFooterState)state
{
    _state = state;
    
    switch (state) {
        case MCBannerFooterStateIdle:
        {
            self.label.text = self.idleTitle;
            [UIView animateWithDuration:0.3 animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0);
            }];
            
        }
            break;
        case MCBannerFooterStateTrigger:
        {
            self.label.text = self.triggerTitle;
            [UIView animateWithDuration:0.3 animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)setIdleTitle:(NSString *)idleTitle
{
    _idleTitle = idleTitle;
    
    if (self.state == MCBannerFooterStateIdle) {
        self.label.text = idleTitle;
    }
}

- (NSString *)idleTitle
{
    if (!_idleTitle) {
        _idleTitle = @"拖动加载更多"; // default
    }
    return _idleTitle;
}

- (void)setTriggerTitle:(NSString *)triggerTitle
{
    _triggerTitle = triggerTitle;
    
    if (self.state == MCBannerFooterStateTrigger) {
        self.label.text = triggerTitle;
    }
}

- (NSString *)triggerTitle
{
    if (!_triggerTitle) {
        _triggerTitle = @"释放加载更多"; // default
    }
    return _triggerTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
