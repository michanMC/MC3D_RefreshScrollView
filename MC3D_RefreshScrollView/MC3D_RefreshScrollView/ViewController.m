//
//  ViewController.m
//  MC3D_RefreshScrollView
//
//  Created by MC on 16/1/26.
//  Copyright © 2016年 MC. All rights reserved.
//
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
#import "ViewController.h"
#import "UIViewController+HUD.h"
#import "MC3D_RefreshScrollView.h"
@interface ViewController ()<UIScrollViewDelegate>
{
     NSInteger indexnum;//假数据页数
    CGFloat _scrollViewSizeW;
    NSMutableArray *_arrayView;
    BOOL _isRefresh;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor =     UIColorFromRGB(0x29477d);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _arrayView = [NSMutableArray array];
    indexnum = 3;
    
    [self prepareUI2];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)prepareUI2{
    
    [self.view addSubview:self.scrollView];
    _scrollView.viewCount = indexnum;
    for (int i = 0; i < indexnum; i ++) {
        [self createCardWithColor:i];
    }
    _scrollView.contentOffset = CGPointMake(_contentPage * (Main_Screen_Width - 40), 0);
    
    if (_contentPage==0) {
        self.title = @"1";
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    }
}

- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _arrayView.count * width;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
    if (index%2)
        imgView.image = [UIImage imageNamed:@"img"];
    else
        imgView.image = [UIImage imageNamed:@"img1"];
   ViewRadius(imgView, 10);
    // contr.view.backgroundColor = [UIColor yellowColor];//
    [_scrollView addSubview:imgView];
    [_arrayView addObject:imgView];
    
    _scrollView.contentSize = CGSizeMake(x + width, height);
   _scrollViewSizeW =x + width;
    
}
-(void)setContentPage:(NSInteger)contentPage
{
    self.title = [NSString stringWithFormat:@"%zd",contentPage + 1];
    NSLog(@"当前第%d页",contentPage);
  
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indepage = (scrollView.contentOffset.x  )/(Main_Screen_Width - 40);
    self.contentPage = indepage;

}

//实现滚动视图的didScroll这个协议方法，来判断是否在刷新数据
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    
    if (_isRefresh) {
        return;
    }
    //x轴的坐标变化来控制是否刷新的
    if ((scrollView.contentOffset.x + Main_Screen_Width - _scrollViewSizeW) > 100) {
        
       _scrollView.McFooter.state = MCBannerFooterStateTrigger;
        
        if (scrollView.isDragging) {
            
            NSLog(@"不刷新1");
            
        } else {
            _isRefresh = YES;
            _contentPage =indexnum;//每次刷新前都把之前的最后的index记下来
            indexnum += 2;//加两条假数据
            [self showHudInView:self.view hint:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.50 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                for (UIImageView * view in _arrayView) {
                    [view removeFromSuperview];
                }
                [_arrayView removeAllObjects];
                [self prepareUI2];
                 self.contentPage = _contentPage;

                _isRefresh = NO;
                [self hideHud];
                NSLog(@"刷新");
                
            });
            
        }
    }
    else
    {
         NSLog(@"不刷新2");
        _scrollView.McFooter.state = MCBannerFooterStateIdle;
    }
    
}

- (MC3D_RefreshScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[MC3D_RefreshScrollView alloc]initWithFrame:CGRectMake(20, 70, Main_Screen_Width - 40, Main_Screen_Height - 78 - 44)];
        _scrollView.state = MC3DScrollViewStateDepth;
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
