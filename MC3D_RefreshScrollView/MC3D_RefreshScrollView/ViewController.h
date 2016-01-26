//
//  ViewController.h
//  MC3D_RefreshScrollView
//
//  Created by MC on 16/1/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MC3D_RefreshScrollView;
@interface ViewController : UIViewController
@property (nonatomic,strong)MC3D_RefreshScrollView *scrollView;
//@property(nonatomic,assign)NSInteger index;
@property (nonatomic,assign)NSInteger contentPage;
@end

