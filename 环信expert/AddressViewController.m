//
//  AddressViewController.m
//  环信expert
//
//  Created by INTCO 王伟 on 2016/1/13.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "AddressViewController.h"
#import <HyphenateLite/EMClient.h>
#import "AddViewController.h"
#import "ConversitionViewController.h"

#define ADDRESS_CELL @"addressCell"
@interface AddressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TFRightSpace;

@property (nonatomic,strong) NSArray * friendList;
@end

@implementation AddressViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setSubViews];
    
}
- (void) loadData{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取 环信好友
        [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
            if (aError) {
                NSLog(@"%@",aError);
            }else{
                NSLog(@"%@",aList);
                self.friendList = aList;
                NSLog(@"%@",self.friendList);
                [self.tableView reloadData];
                
            }
        }];
        
    });
}
- (void) setSubViews{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ADDRESS_CELL];

}
- (IBAction)backAction:(UIButton *)sender {

    
    
}

//  tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSLog(@"%ld",self.friendList.count);
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ADDRESS_CELL];
    cell.textLabel.text = self.friendList[indexPath.row];
  
    return cell;
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ConversitionViewController * conversitionVC = [[ConversitionViewController alloc] init];
    
     conversitionVC.chatTo = self.friendList[indexPath.row];
    
    [self.navigationController pushViewController:conversitionVC animated:YES];
    
   
    
}


    


#pragma mark - 添加联系人事件
- (IBAction)addContact:(UIButton *)sender {
    
    AddViewController * addVC = [[AddViewController alloc] init];
    
    [self presentViewController:addVC animated:YES completion:nil];
}


@end
