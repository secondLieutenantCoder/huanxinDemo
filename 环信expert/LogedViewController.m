//
//  LogedViewController.m
//  环信expert
//
//  Created by INTCO 王伟 on 2017/1/12.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "LogedViewController.h"
#import <HyphenateLite/EMClient.h>

#define conversitionCellID @"conversitionID"
@interface LogedViewController ()<EMChatManagerDelegate,EMContactManagerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *message;

@property (nonatomic,strong) NSArray * conversitionArr;

@end

@implementation LogedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // > 监听好友添加请求
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [self loadData];
    [self setSubViews];
}
- (void) setSubViews{

    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64-120-5) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate   = self;
    
    [self.view addSubview:tableView];
}

- (void) loadData{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * array = [[EMClient sharedClient].chatManager getAllConversations];
        self.conversitionArr = array;
        dispatch_sync(dispatch_get_main_queue()
                      , ^{
                          NSLog(@"%@",array);
                      });
    });
//    NSLog(@"EMConversation:%@",array);
}
#pragma mark - tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.conversitionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:conversitionCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:conversitionCellID];
    }
    cell.imageView.image = [UIImage imageNamed:@"INTCO"];
    cell.textLabel.text  = @"111";
    EMTextMessageBody * body = (EMTextMessageBody*)[self.conversitionArr[indexPath.row] lastReceivedMessage].body;
    cell.detailTextLabel.text = body.text;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - 好友添加监听
#pragma mark *** 收到好友添加请求
- (void) friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{

    NSLog(@"%@想添加你为联系人！==%@==",aUsername,aMessage);
    EMError * error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
    if (error == nil) {
        NSLog(@"同意添加好友已发送！");
    }
    
}
#pragma mark *** 收到对方的同意
- (void) didReceiveAgreedFromUsername:(NSString *)aUsername{

    NSLog(@"%@ 同意了你的添加请求!",aUsername);
}
// 取消badge
- (IBAction)cancelBadgeAction:(UIButton *)sender {
    self.tabBarItem.badgeValue = nil;
}

- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
