//
//  RootViewController.m
//  TJRPopoverViewDemo
//
//  Created by rimi on 14-8-4.
//  Copyright (c) 2014年 brighttj. All rights reserved.
//

#import "RootViewController.h"
#import "TJRPopoverView.h"

@interface RootViewController () <TJRPopoverViewDelegate> {
    
    TJRPopoverView *_popoverView;
    NSArray *_dataSource;
}

- (void)buttonPressed:(UIButton *)sender;

@end

@implementation RootViewController

- (void)dealloc {
    
    [_popoverView release];
    [_dataSource release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化列表显示数据
    _dataSource = [[NSArray arrayWithObjects:@"1111", @"2222", @"3333", nil] retain];
    
    // 初始化按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.bounds = CGRectMake(0, 0, 60, 40);
    button.center = CGPointMake(1024 / 2, 768 / 2);
    [button setTitle:@"popover" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 初始化弹出框
    _popoverView = [[TJRPopoverView alloc] init];
    _popoverView.popoverFromRect = button.bounds; // 系统可以根据该参数，将弹出框显示到正确的位置（即触发控件的下方）
    _popoverView.inView = button; // 触发弹出框的控件
    _popoverView.dataSource = _dataSource; // 弹出框中列表的数据
    _popoverView.arrowDiretion = UIPopoverArrowDirectionUp; // 弹出框箭头方向
    _popoverView.delegate = self; // 设置代理
    
    // 注意：不要这样设置：inView = self ,因为没有处理循环引用
}

/**
 *  按钮响应事件
 *
 *  @param sender 触发该事件的按钮
 */
- (void)buttonPressed:(UIButton *)sender {
    
    // 推出弹出框
    [_popoverView presentPopover];
}

#pragma mark - TJRPopoverViewDelegate methods

- (void)popoverView:(TJRPopoverView *)popoverView didSelectAtIndex:(NSInteger)index {
    
    NSLog(@"选中第%d行，这一行的数据是：%@", index, popoverView.dataSource[index]);
}

@end