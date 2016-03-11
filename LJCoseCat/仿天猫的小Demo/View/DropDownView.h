//
//  DropDownView.h
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownViewDelegate <NSObject>

- (void)dropDownViewCloseBtnClick:(UIButton *)closeBtn;
- (void)dropDownViewBottomBtnClick:(UIButton *)sender;
- (void)dropDownViewrefreshBtnClick:(UIButton *)sender;

@end

@interface DropDownView : UIView

@property (nonatomic, weak) id<DropDownViewDelegate> delegate;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *whiteBackView;     // 白色背景视图
@property (nonatomic, strong) UIButton *refreshBtn; // 刷新按钮
@property (nonatomic, strong) UILabel *line;        // 分割线

@property (nonatomic, strong) UIView *bottomView;   // 底部视图
@property (nonatomic, strong) UIButton *closeBtn;   // 关闭按钮

@end
