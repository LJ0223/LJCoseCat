//
//  TableVController.m
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "TableVController.h"
#import "UINavigationBar+Background.h"
#import "DescriptionView.h"

#import "SecondViewController.h"

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)


@interface TableVController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic) CGFloat halfHeight;
@property (nonatomic, strong) DescriptionView *descriptionView;

@end

@implementation TableVController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] initWithObjects:@"11", @"22", @"33", @"44", @"55", @"66", @"77", @"88", @"99", @"00", @"12", @"34", @"45", @"56", @"67", @"78", @"89", @"90", nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [_tableView setContentOffset:CGPointMake(0, -_halfHeight)];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tableView.delegate = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    self.title = @"第一种实现方式";
    [self setTableView];
    [self descriptionView];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tableView.delegate = self;
    UIColor *color = NavigationBackColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > - _halfHeight-64) {
        CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:20],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        _descriptionView.alpha = 1 - alpha;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:20],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
        
         [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify"];
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma LayoutUI
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _halfHeight = (kScreenHeight) * 0.5 - 64;
    [_tableView setContentInset:UIEdgeInsetsMake(_halfHeight, 0, 0, 0)];
}

- (DescriptionView *)descriptionView{
    if (!_descriptionView) {
        
        _descriptionView = [[NSBundle mainBundle] loadNibNamed:@"DescriptionView" owner:nil options:nil][0];
        _descriptionView.frame = CGRectMake(0, 80, CGRectGetWidth([UIScreen mainScreen].bounds), 42);
        [self.view addSubview:_descriptionView];
    }
    return _descriptionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
