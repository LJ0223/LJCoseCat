//
//  CustomUINavigationViewController.m


#import "CustomUINavigationViewController.h"

@interface CustomUINavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomUINavigationViewController


+ (void) initialize
{
    
    /**
     *  设置导航栏的背景颜色
     */
    UINavigationBar *navBar  = [UINavigationBar appearance];
    
    navBar.barTintColor = NavigationBackColor;
    /**
     *  设置导航栏字体的颜色
     */
    BOOL isIos7  = NO;
    isIos7 = [[[UIDevice currentDevice]systemVersion]floatValue]
    >= 7.0f?  YES:  NO;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    /**
     *  设置字体的颜色，
     */
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    /**
     设置文字的偏移量；
     */
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
//    shadow.shadowOffset = CGSizeMake(0, 1);
//    attrs[NSShadowAttributeName] =   shadow;
//    
    /**
     *  依据当前手机的系统版本号设置title的字体大小
     */
//    attrs[NSFontAttributeName] = isIos7 ? [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0]: [UIFont systemFontOfSize:20.0];
    
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20.0];
    [[UINavigationBar appearance] setTitleTextAttributes:attrs];
    
    
    /**
     *  push 一个界面进入，默认会显示箭头和上一页的title;
     */
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    
    
    
    
    //将返回按钮的文字position设置不在屏幕上显示
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@" 自定义导航控制器:%@",self.interactivePopGestureRecognizer);
    
    
   
    

}
- (void) handleNavigationTransition:(UIGestureRecognizer *) gestureRecongnizer
{
    
    
    
}

- (void)  customLeftPanViewController

{
    /**
     获取系统自带滑动手势的target 对象
     */
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    /**
     *创建全屏滑动手势，调用系统的自带的滑动手势的target 的action方法；
     */
   
    
    
    pan.delegate = self;
    /**
     *  给导航控制器，添加全屏的滑动手势
     */
    [self.view addGestureRecognizer:pan];
    
    /**
     *  禁用掉导航控制器的手势
     */
    self.interactivePopGestureRecognizer.enabled  = NO;
    
    
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    
    CGPoint point = [pan translationInView:pan.view];
    // 限定手势右滑才返回
    if (point.x > 0) {
        /**
         *  只有非根的控制器才能拥有右滑的手势功能
         */
        
        NSString *type2 = @"OrderSuccessViewController";
        Class type3 = NSClassFromString(type2);
        NSString *type4 = @"ReserverOrderDetailVC";
        Class type5 = NSClassFromString(type4);
        
        
        if (self.childViewControllers.count == 1) {
            /**
             *  我们知道导航控制器,push  对应的是压栈的操作，  pop  是对应的的是出栈的操作，那么我们就可以得知，有一个数组存放着我们push进来的页面，即:  导航控制器的childViewControllers 属性；
             
             */
            
            return NO;
        } else {
            
            for (UIViewController *controller in self.childViewControllers) {
                
                if ([controller isKindOfClass:[type3 class]]) {
                    return NO;
                }
                
                /*
                 * 预定订单详情页面若是从核对订单页面进入则关闭左滑手势，若从订单列表活通知中心进入则打开左滑手势
                 */
//                if ([controller isKindOfClass:[type5 class]]) {
//                    UIViewController *vc = controller.navigationController.viewControllers[0];
//                    if ([vc isKindOfClass:[OrderVC class]] || [vc isKindOfClass:[InfoViewController class]]) {
//                        if ([EasyFlowerToolHandle toolHandleShare].buyAgin) {
//                            return NO;
//                        }
//                        return YES;
//                    } else {
//                        return NO;
//                    }
//                }
            }
            
            return YES;
            
            
        }
        
    }
    return NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
