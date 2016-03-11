//
//  SecondViewController.m
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationBar+Background.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *backImg; // 返回时显示的ImageView

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation SecondViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] initWithObjects:@"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", @"000", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"第二个视图";
    [self setTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar cnReset];
    
    UIColor *color = NavigationBackColor;
    [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:1]];

    self.backImg.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    self.backImg.image = [self screenView:self.view];
    self.backImg.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.backImg.hidden = YES;
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
    
    cell.textLabel.text = @"呵呵哒";
    cell.selectionStyle = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath===%@", indexPath);
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

- (UIImageView *)backImg
{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImg.hidden = YES;
        _backImg.alpha = 1;
        [self.view addSubview:_backImg];
    }
    return _backImg;
}


// 截屏图
- (UIImage*)screenView:(UIView *)view{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 不要导航栏
    //    [view.layer renderInContext:context];
    
    // 要导航栏
    [self.navigationController.view.layer renderInContext:context];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
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
