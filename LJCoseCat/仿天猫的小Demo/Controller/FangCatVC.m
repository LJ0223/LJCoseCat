//
//  FangCatVC.m
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "FangCatVC.h"
#import "DropDownView.h"

@interface FangCatVC ()<UITableViewDataSource, UITableViewDelegate, DropDownViewDelegate, UIScrollViewDelegate>
{
    /*
     * 用来判断TableView上滑还是下滑
     */
    CGFloat _oldOffsetY;

}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) DropDownView *bView;

@property (nonatomic) BOOL fixed;

@end

@implementation FangCatVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] initWithObjects:@"11", @"22", @"33", @"44", @"55", @"66", @"77", @"88", @"99", @"00", @"12", @"34", @"45", @"56", @"67", @"78", @"89", @"90", nil];
        
        self.fixed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"仿天猫的小Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000000000000000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify"];
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell上显示内容%@", _dataSource[indexPath.row]);
}

#pragma mark - DropDownViewDelegate
- (void)dropDownViewrefreshBtnClick:(UIButton *)sender
{
    NSLog(@"刷新TableView");
    self.fixed = NO;
    
    self.bView.hidden = YES;
}

- (void)dropDownViewCloseBtnClick:(UIButton *)closeBtn
{
    self.fixed = NO;
    
    self.tableView.contentOffset = CGPointMake(0, 64);
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.bView.hidden = YES;
}

- (void)dropDownViewBottomBtnClick:(UIButton *)sender
{
    NSLog(@"底部按钮的下标为%ld", sender.tag);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    NSLog(@"yOffset====%.2f", yOffset);
    if (!_fixed) {
        
        if (yOffset < -64) {
            NSLog(@"隐藏导航栏啦啦啦。。。");
            self.bView.hidden = NO;
            self.bView.closeBtn.hidden = YES;
            self.navigationController.navigationBar.hidden = YES;
            
            if (-yOffset < CGRectGetMaxY(_bView.bottomView.frame)) {
                _bView.backView.frame = CGRectMake(0, -yOffset, SCREENWIDTH, SCREENHEIGHT);
                _bView.whiteBackView.frame = CGRectMake(0, 0, SCREENWIDTH, -yOffset);
                
            } else {
                _bView.bottomView.hidden = NO;
                _bView.backView.frame = CGRectMake(0, -yOffset, SCREENWIDTH, SCREENHEIGHT);
                _bView.whiteBackView.frame = CGRectMake(0, 0, SCREENWIDTH, _bView.bottomView.frame.origin.y);
            }
            
        } else {
            _bView.hidden = YES;
            self.navigationController.navigationBar.hidden = NO;
        }
        
        CGFloat alpha = yOffset/CGRectGetMaxY(_bView.bottomView.frame);
        alpha=fabs(alpha);
        alpha=alpha<0.2? 0:alpha-0.2;
        _bView.backView.alpha = alpha;
//        CGFloat colorF = 255*alpha;
//        _bView.backView.backgroundColor = CLColor(colorF/255, colorF/255, colorF/255);
        _bView.bottomView.alpha = alpha;
        _bView.line.alpha = alpha;
        NSLog(@"alpha===%f", alpha);
        
//        CGFloat height = [[NSString stringWithFormat:@"%.2f", CGRectGetMaxY(_bView.bottomView.frame)] floatValue];
        // 当Y轴的偏移量
        if (-yOffset >= 167.00) {
            self.fixed = YES;
        } else if (yOffset > _oldOffsetY) { //如果当前位移大于缓存位移，说明scrollView向上滑动
            
            // 当TableView返回到顶端的时候刷新TableView
            if (yOffset == -64) {
                NSLog(@"刷新TableView");
            }
            
        }
    } else {
        
        self.bView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.bView.hidden = NO;
        self.bView.closeBtn.hidden = NO;
        self.tableView.contentOffset = CGPointMake(0, CGRectGetMaxY(_bView.bottomView.frame));
        _bView.backView.frame = CGRectMake(0, CGRectGetMaxY(_bView.bottomView.frame), SCREENWIDTH, SCREENHEIGHT);
    }
    
    _oldOffsetY = yOffset; //将当前位移变成缓存位移
}

#pragma LayoutUI
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    _tableView.tableFooterView = [[UIView alloc] init];
}

- (UIView *)bView
{
    if (!_bView) {
        self.bView = [[DropDownView alloc] init];
        self.bView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
         _bView.backgroundColor = [UIColor clearColor];
        _bView.delegate = self;
        _bView.userInteractionEnabled = YES;
        [self.view addSubview:self.bView];
    }
    return _bView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
