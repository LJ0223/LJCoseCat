//
//  DropDownView.m
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "DropDownView.h"

#define BASETAG 999
#define BWIDTH (SCREENWIDTH-60)/4

@implementation DropDownView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.whiteBackView = [[UIView alloc] init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteBackView];
        
        self.refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-16, 45, 32, 32)];
        [_refreshBtn setImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(refreshBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_refreshBtn];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 122, SCREENWIDTH, 45)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        
        self.line = [[UILabel alloc] initWithFrame:CGRectMake(0, 122, SCREENWIDTH, 0.5)];
        self.line.backgroundColor = CLColor(221.0f, 221.0f, 221.0f);
        [self addSubview:_line];
        
        self.backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backView];
        
        self.closeBtn = [[UIButton alloc] init];
        self.closeBtn.frame = CGRectMake(SCREENWIDTH/2-15, SCREENHEIGHT-80, 30, 30);
        [_closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeBtn];
        
        for (int i = 0; i < 4; i++) {
            UIButton *bottomBtn = [[UIButton alloc] init];
            bottomBtn.frame = CGRectMake(15+i*(BWIDTH+10), 10, BWIDTH, 25);
            bottomBtn.tag = (i+1) * BWIDTH;
            [_bottomView addSubview:bottomBtn];
            [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d", (i+1)]] forState:UIControlStateNormal];;
        }
    }
    return self;
}

- (void)refreshBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownViewrefreshBtnClick:)]) {
        [self.delegate dropDownViewrefreshBtnClick:sender];
    }
}

- (void)bottomBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownViewBottomBtnClick:)]) {
        [self.delegate dropDownViewBottomBtnClick:sender];
    }
}

- (void)closeBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownViewCloseBtnClick:)]) {
        [self.delegate dropDownViewCloseBtnClick:sender];
    }
}

@end
