//
//  SecondTableVC.m
//  LJCoseCat
//
//  Created by 罗金 on 16/3/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "SecondTableVC.h"
#import "SecondViewController.h"

#define topImageViewH 208

@interface SecondTableVC ()<UITableViewDataSource, UITableViewDelegate, UIBarPositioningDelegate>
{
    NSDictionary *_diction;
    CGFloat _alpha;

}
@property (strong, nonatomic)UIImageView *topImageView;
@property (strong ,nonatomic) UIView *backView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SecondTableVC

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
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"表示头拉伸";
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + topImageViewH)/2;
    
    if (yOffset < -topImageViewH) {
        
        CGRect rect = self.topImageView.frame;
        NSLog(@"old   %@",NSStringFromCGRect(_topImageView.frame));
        
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.size.width = SCREENWIDTH;
        
        rect.origin.x = xOffset;
        rect.size.width =  SCREENWIDTH + fabs(xOffset)*2;
        
        self.topImageView.frame = rect;
    }
    
    CGFloat alpha = (yOffset+topImageViewH)/topImageViewH;
    alpha=fabs(alpha);
    alpha=fabs(1-alpha);
    alpha=alpha<0.2? 0:alpha-0.2;
    
    NSLog(@"透明度%f",alpha);
    _backView.alpha = alpha;
}

#pragma LayoutUI
- (void)setTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:BOUNDS];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _tableView.contentInset = UIEdgeInsetsMake(topImageViewH, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(0, -topImageViewH);
    
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.backgroundColor =[UIColor clearColor];
    self.topImageView.image = [UIImage imageNamed:@"center"];
    self.topImageView.frame = CGRectMake(0, -topImageViewH, SCREENWIDTH, topImageViewH);
//    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview:_topImageView];
    //创建一块UIview
    
    _backView=[[UIView alloc]init];
    _backView.backgroundColor=[UIColor clearColor];
    _backView.frame=CGRectMake(0, -topImageViewH, SCREENWIDTH, topImageViewH);
    [_tableView addSubview:_backView];

    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 32, 30, 20)];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:leftBtn];
}

- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
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
