//
//  ConversitionViewController.m
//  环信expert
//
//  Created by INTCO 王伟 on 2016/1/13.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "ConversitionViewController.h"
#import <HyphenateLite/EMClient.h>
#import "SendTableViewCell.h"
#import "ReceiveCell.h"
#import "CurrentUser.h"
#import "LogedViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ConversitionViewController ()<EMChatManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sendTF;

@property (weak, nonatomic) IBOutlet UILabel *receiveMessage;

@property (nonatomic,strong) LogedViewController * logedVC;

@end

@implementation ConversitionViewController

// lazy
-(LogedViewController *)logedVC{

    if (_logedVC ==nil) {
        _logedVC = [[LogedViewController alloc] init];
    }
    return _logedVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setDelegate];
    [self setSubViews];
}
- (void) setDelegate{
    // 监听接收消息
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
/// 发送消息
- (IBAction)sendAction:(UIButton *)sender {
    
    // >构建文字信息
    EMTextMessageBody * body = [[EMTextMessageBody alloc] initWithText:self.sendTF.text];
    //> message
    NSString * conID = [NSString stringWithFormat:@"firstMessage"];
    EMMessage * message = [[EMMessage alloc] initWithConversationID:conID from:[CurrentUser defaultUser].userName to:self.chatTo body:body ext:nil];
    
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"发送成功！");
        }
    }];
    
}
/// 监听接受到的消息
- (void) messagesDidReceive:(NSArray *)aMessages{

    // > 接受到的消息
    EMMessage * message = [aMessages firstObject];
    NSLog(@"%@\n",message);
    EMMessageBody * mBody    = message.body;
    EMTextMessageBody * body = (EMTextMessageBody *)mBody;
    NSLog(@"%@",body.text);
    self.receiveMessage.text = body.text;
    
    
}
- (void) loadData{
    

}

- (void) setSubViews{
    
    //创建会话
    [[EMClient sharedClient].chatManager getConversation:self.chatTo type:EMConversationTypeChat createIfNotExist:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
