//
//  ViewController.m
//  环信expert
//
//  Created by INTCO 王伟 on 2017/1/12.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "ViewController.h"
#import "HyphenateSDK/HyphenateLite.framework/Headers/EMClient.h"
#import "LogedViewController.h"
#import "AddressViewController.h"
#import "CurrentUser.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNameTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.pswTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    [self test];
    
}

- (void) test{

    self.testBtn.backgroundColor = [UIColor purpleColor];
    
    [self.testBtn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)testAction:(UIButton *)btn {

    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
}
#pragma mark - 登录事件
- (IBAction)loginAction:(UIButton *)sender {
    
    EMError * error = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:self.pswTF.text];
    if (error == nil) {
        NSLog(@"登录成功！");
        //当前的user
        [CurrentUser initWithName:self.userNameTF.text];
        
        LogedViewController * logedVC = [[LogedViewController alloc] init];
        
        AddressViewController * addressVC = [[AddressViewController alloc] init];
        
        UIViewController * tmpVC = [[UIViewController alloc] init];
        UINavigationController * addressNav = [[UINavigationController alloc] initWithRootViewController:addressVC];
        addressNav.navigationBarHidden = YES;
        UITabBarController * tabbarVC = [[UITabBarController alloc] init];
        //>tabbar 设置
        logedVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会话" image:[UIImage imageNamed:@"会话"] selectedImage:[UIImage imageNamed:@"会话"]];
        addressVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[UIImage imageNamed:@"联系人"] tag:1001];
        tmpVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"设置"] tag:1002];
        tmpVC.view.backgroundColor = [UIColor grayColor];
        logedVC.tabBarItem.badgeValue = @"new";
        tabbarVC.viewControllers = @[logedVC,addressNav,tmpVC];
        [self presentViewController:tabbarVC animated:YES completion:nil];
    }
}
#pragma mark - 注册事件
- (IBAction)registerAction:(UIButton *)sender {
    
    EMError * error = [[EMClient sharedClient] registerWithUsername:self.userNameTF.text password:self.pswTF.text];
    if (error == nil) {
        NSLog(@"注册成功！");
    }
}

#pragma mark - 取消编辑
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
