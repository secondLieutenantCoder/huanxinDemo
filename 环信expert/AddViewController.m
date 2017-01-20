//
//  AddViewController.m
//  环信expert
//
//  Created by INTCO 王伟 on 2016/1/13.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "AddViewController.h"
#import <HyphenateLite/EMClient.h>

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactTF;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - 输入要添加的姓名，点击确定事件
- (IBAction)addAction:(UIButton *)sender {
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"请填写验证信息！" message:@"填写验证信息可以增加验证通过率哦" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * actionSure = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 发送验证信息
        EMError * error = [[EMClient sharedClient].contactManager addContact:self.contactTF.text message:alertVC.textFields.firstObject.text];
        if (error == nil) {
            NSLog(@"已发送！");
        }
    }];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertVC addAction:action];
    [alertVC addAction:actionSure];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - disMiss
- (IBAction)dismissAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
