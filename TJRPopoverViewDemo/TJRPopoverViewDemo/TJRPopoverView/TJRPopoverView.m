//
//  TJRPopoverView.m
//  内蒙中行
//
//  Created by rimi on 14-8-2.
//  Copyright (c) 2014年 brighttj. All rights reserved.
//

#import "TJRPopoverView.h"

@interface TJRPopoverView () <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UITableView *tableView;

// 初始化用户界面
- (void)initializeUserInterface;

@end

@implementation TJRPopoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeUserInterface];
    }
    return self;
}

- (void)dealloc {
    
    [_inView release];
    [_dataSource release];
    [_tableView release];
    [_popoverController release];
    [super dealloc];
}

- (void)setDataSource:(NSArray *)dataSource {
    
    if (_dataSource != dataSource) {
        
        [_dataSource release];
        _dataSource = [dataSource retain];
        [_tableView reloadData];
    }
}

/**
 *  初始化弹出框的用户界面
 */
- (void)initializeUserInterface {
    
    // 初始化弹出框中的列表视图
    UIViewController *viewController = [[UIViewController alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 180, 220) style:UITableViewStylePlain];
    [viewController.view addSubview:_tableView];
    
    // 设置事件代理以及数据代理
    _tableView.delegate = self;
    _tableView.dataSource = self;

    // 初始化弹出框，弹出框中封装的必须是ViewController对象
    self.popoverController = [[[UIPopoverController alloc] initWithContentViewController:viewController] autorelease];
    // 设置弹出框大小
    self.popoverController.popoverContentSize = _tableView.bounds.size;
    
    [viewController release];
}

/**
 *  推出弹出框
 */
- (void)presentPopover {
    
    // 推出弹出框
    // 参数1：弹出框位置，系统可根据传入的触发控件自行计算
    // 参数2：由哪一个view弹出（注意：这里没有处理循环引用的情况，所以inView最好不要是superView）
    // 参数3：箭头方向
    // 参数4：是否需要动画效果
    // TODO: 处理inView的循环引用
    [self.popoverController presentPopoverFromRect:_popoverFromRect inView:self.inView permittedArrowDirections:_arrowDiretion animated:YES];
}

/**
 *  重新加载弹出框数据
 *  用于弹出框数据的重用
 */
- (void)reloadPopover {
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

#pragma mark - UITableViewDelegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"TJRPopoverViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    // 设置列表文字
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 当选中列表某行以后，触发代理方法，将选中行的下标返回
    [self.delegate popoverView:self didSelectAtIndex:indexPath.row];
}

@end