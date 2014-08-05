//
//  TJRPopoverView.h
//  内蒙中行
//
//  Created by rimi on 14-8-2.
//  Copyright (c) 2014年 brighttj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJRPopoverView;

@protocol TJRPopoverViewDelegate <NSObject>

// 选中列表行后的回调方法
- (void)popoverView:(TJRPopoverView *)popoverView didSelectAtIndex:(NSInteger)index;

@end

@interface TJRPopoverView : UIView

@property (nonatomic, assign) CGRect popoverFromRect; // 弹出框显示大小
@property (nonatomic, assign) UIPopoverArrowDirection arrowDiretion; // 弹出框箭头方向
@property (nonatomic, retain) NSArray *dataSource; // 弹出框中列表显示数据
@property (nonatomic, retain) UIView *inView; // 弹出框的父容器（由哪一个触发）
@property (nonatomic, assign) id<TJRPopoverViewDelegate> delegate; // 代理

- (void)reloadPopover; // 重置弹出框中列表数据
- (void)presentPopover; // 推出弹出框

@end