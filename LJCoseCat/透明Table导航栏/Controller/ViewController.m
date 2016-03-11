//
//  ViewController.m
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Background.h"
#import "TableVController.h"

#import "SecondTableVC.h"

#import "FangCatVC.h"

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] initWithObjects:@"第一种方式", @"另一种方式", @"仿天猫的小Demo", nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar cnReset];
    
    UIColor *color = NavigationBackColor;
    [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    self.title = @"透明导航栏";
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify"];
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            TableVController *tableVC = [[TableVController alloc] init];
            [self.navigationController pushViewController:tableVC animated:YES];
        }
            break;
        case 1:
        {
            SecondTableVC *secondVC = [[SecondTableVC alloc] init];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
            break;
        case 2:
        {
            FangCatVC *catVC = [[FangCatVC alloc] init];
            [self.navigationController pushViewController:catVC animated:YES];
        }
            break;
        default:
            break;
    }
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
