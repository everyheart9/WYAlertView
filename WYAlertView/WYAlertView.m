//
//  WYAlertView.m
//  HS_Consumer_HE
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenheight [UIScreen mainScreen].bounds.size.height
#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define cancleBtnTitle kLocalized(@"GYHS_Base_cancel")
#define confirmBtnTitle kLocalized(@"GYHS_Base_ok")
#define cancleBtnColor kBtnBackViewGrayColor
#define confirmBtnColor kBtnBackViewRedColor

#define alertViewWidth ((screenWidth == 320) ? screenWidth * 0.91 :screenWidth * 0.85)
#define alertViewHeight screenWidth * 0.5
#define leftMargin ((screenWidth == 320) ? 15.0f : 20.0f)
#define topMargin 15.0f
#define btnBottommargin 15.0f

#define WYAlertView_Tag 1999

#import "WYAlertView.h"

@interface WYAlertView ()

@property (nonatomic, copy) dispatch_block_t cancleBlock;
@property (nonatomic, copy) dispatch_block_t confirmBlock;

@property (nonatomic, strong) UIView* backgroundView;
@property (nonatomic, strong) UILabel* messageLabel;
@property (nonatomic, strong) UIButton* cancleButton;
@property (nonatomic, strong) UIButton* confirmButton;

@end

@implementation WYAlertView

+ (WYAlertView*)showMessage:(NSString*)message
{
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message cancleButtonTitle:nil confirmButtonTitle:confirmBtnTitle cancleBlock:nil confirmBlock:nil color:confirmBtnColor];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showMessage:(NSString*)message confirmBlock:(dispatch_block_t)confirmBlock
{
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message cancleButtonTitle:nil confirmButtonTitle:confirmBtnTitle cancleBlock:nil confirmBlock:confirmBlock color:confirmBtnColor];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showMessage:(NSString*)message cancleBlock:(dispatch_block_t)cancleBlock confirmBlock:(dispatch_block_t)confirmBlock
{
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message cancleButtonTitle:cancleBtnTitle confirmButtonTitle:confirmBtnTitle cancleBlock:cancleBlock confirmBlock:confirmBlock color:confirmBtnColor];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showMessage:(NSString*)message
          cancleButtonTitle:(NSString*)cancleTitle
         confirmButtonTitle:(NSString*)confirmTitle
                cancleBlock:(dispatch_block_t)cancleBlock
               confirmBlock:(dispatch_block_t)confirmBlock
{
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message
                                                cancleButtonTitle:cancleTitle
                                               confirmButtonTitle:confirmTitle
                                                      cancleBlock:cancleBlock
                                                     confirmBlock:confirmBlock
                                                            color:confirmBtnColor];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showAttributedMessage:(NSAttributedString*)message confirmBlock:(dispatch_block_t)confirmBlock
{
    WYAlertView* alertView = [[WYAlertView alloc] initWithAttributedMessage:message cancleButtonTitle:nil confirmButtonTitle:confirmBtnTitle cancleBlock:nil confirmBlock:confirmBlock color:confirmBtnColor];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showAttributedMessageWithLeft:(NSAttributedString*)message confirmBlock:(dispatch_block_t)confirmBlock {
    WYAlertView* alertView = [[WYAlertView alloc] initWithAttributedMessage:message cancleButtonTitle:nil confirmButtonTitle:confirmBtnTitle cancleBlock:nil confirmBlock:confirmBlock color:confirmBtnColor];
    alertView.messageLabel.textAlignment = NSTextAlignmentLeft;
    [alertView show];
    
    return alertView;
}

+ (WYAlertView*)showAttributedMessage:(NSAttributedString*)message cancleButtonTitle:(NSString*)cancleTitle
                   confirmButtonTitle:(NSString*)confirmTitle
                          cancleBlock:(dispatch_block_t)cancleBlock
                         confirmBlock:(dispatch_block_t)confirmBlock {
    
    WYAlertView* alertView = [[WYAlertView alloc] initWithAttributedMessage:message cancleButtonTitle:cancleTitle confirmButtonTitle:confirmTitle cancleBlock:cancleBlock confirmBlock:confirmBlock color:confirmBtnColor];
    [alertView show];
    return alertView;

}

//自定义颜色方法
+ (WYAlertView*)showMessage:(NSString*)message withColor:(UIColor*)color {
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message cancleButtonTitle:nil confirmButtonTitle:confirmBtnTitle cancleBlock:nil confirmBlock:nil color:color];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showMessage:(NSString*)message confirmBlock:(dispatch_block_t)confirmBlock withColor:(UIColor*)color {
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message cancleButtonTitle:nil confirmButtonTitle:confirmBtnTitle cancleBlock:nil confirmBlock:confirmBlock color:color];
    [alertView show];
    return alertView;
}

+ (WYAlertView*)showMessage:(NSString*)message cancleBlock:(dispatch_block_t)cancleBlock confirmBlock:(dispatch_block_t)confirmBlock withColor:(UIColor*)color {
    WYAlertView* alertView = [[WYAlertView alloc] initWithMessage:message cancleButtonTitle:cancleBtnTitle confirmButtonTitle:confirmBtnTitle cancleBlock:cancleBlock confirmBlock:confirmBlock color:color];
    [alertView show];
    return alertView;
}

//公共方法
- (instancetype)initWithMessage:(NSString*)message
              cancleButtonTitle:(NSString*)cancleTitle
             confirmButtonTitle:(NSString*)confirmTitle
                    cancleBlock:(dispatch_block_t)cancleBlock
                   confirmBlock:(dispatch_block_t)confirmBlock
                          color:(UIColor*)color
{
    self = [super init];
    if (self) {
        [self cancleButtonTitle:cancleTitle confirmButtonTitle:confirmTitle cancleBlock:cancleBlock confirmBlock:confirmBlock color:color];
        self.messageLabel.text = message;
    }
    return self;
}

//富文本初始化
- (instancetype)initWithAttributedMessage:(NSAttributedString*)message
                        cancleButtonTitle:(NSString*)cancleTitle
                       confirmButtonTitle:(NSString*)confirmTitle
                              cancleBlock:(dispatch_block_t)cancleBlock
                             confirmBlock:(dispatch_block_t)confirmBlock
                                    color:(UIColor*)color
{
    self = [super init];
    if (self) {
        [self cancleButtonTitle:cancleTitle confirmButtonTitle:confirmTitle cancleBlock:cancleBlock confirmBlock:confirmBlock color:color];
        self.messageLabel.attributedText = message;
    }
    return self;
}

- (void)cancleButtonTitle:(NSString*)cancleTitle confirmButtonTitle:(NSString*)confirmTitle cancleBlock:(dispatch_block_t)cancleBlock confirmBlock:(dispatch_block_t)confirmBlock color:(UIColor*)color
{
    self.cancleBlock = cancleBlock;
    self.confirmBlock = confirmBlock;

    self.bounds = CGRectMake(0, 0, alertViewWidth, alertViewHeight);
    self.center = kKeyWindow.center;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = YES;

    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, topMargin, alertViewWidth - leftMargin * 2, alertViewHeight * 0.7 - topMargin * 2)];
    self.messageLabel.font = [UIFont systemFontOfSize:17.0f];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = kBlackTextColor;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.adjustsFontSizeToFitWidth = YES;

    [self addSubview:self.messageLabel];

//    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, alertViewHeight * 0.6, alertViewWidth, 1.0f)];
//    lineView.backgroundColor = kDefaultViewBorderColor;
//    [self addSubview:lineView];

//    if (!cancleTitle) {
//        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.confirmButton.frame = CGRectMake(leftMargin, alertViewHeight * 0.6 + topMargin, alertViewWidth - leftMargin * 2, alertViewHeight * 0.4 - btnBottommargin * 2);
//    }
//    else {
//        if (!confirmTitle) {
//            self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.cancleButton.frame = CGRectMake(leftMargin, alertViewHeight * 0.6 + topMargin, alertViewWidth - leftMargin * 2, alertViewHeight * 0.4 - btnBottommargin * 2);
//            self.cancleButton.layer.cornerRadius = 2.0f;
//            self.cancleButton.backgroundColor = buttonColor;
//            [self.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }
//        else {
//            self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.cancleButton.frame = CGRectMake(leftMargin, alertViewHeight * 0.6 + btnBottommargin, (alertViewWidth - leftMargin * 3) * 0.5, alertViewHeight * 0.4 - btnBottommargin * 2);
//            self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.confirmButton.frame = CGRectMake(alertViewWidth * 0.5 + leftMargin * 0.5, alertViewHeight * 0.6 + btnBottommargin, (alertViewWidth - leftMargin * 3) * 0.5, alertViewHeight * 0.4 - btnBottommargin * 2);
//
//            self.cancleButton.layer.borderWidth = 1.0f;
//            self.cancleButton.layer.cornerRadius = 2.0f;
//            self.cancleButton.layer.borderColor = kDefaultViewBorderColor.CGColor;
//            [self.cancleButton setTitleColor:kCellItemTextColor forState:UIControlStateNormal];
//        }
//    }

    if (!cancleTitle) {
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton.frame = CGRectMake(0, alertViewHeight * 0.7, alertViewWidth, alertViewHeight * 0.3);
    }
    else {
        if (!confirmTitle) {
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancleButton.frame = CGRectMake(0, alertViewHeight * 0.7, alertViewWidth, alertViewHeight * 0.3);
            if (!color) {
                self.cancleButton.backgroundColor = confirmBtnColor;
            } else {
                self.cancleButton.backgroundColor = color;
            }
            
            [self.cancleButton setTitleColor:kBtnWriteTextColor forState:UIControlStateNormal];
        }
        else {
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancleButton.frame = CGRectMake(0, alertViewHeight * 0.7, alertViewWidth * 0.5, alertViewHeight * 0.3);
            self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.confirmButton.frame = CGRectMake(alertViewWidth * 0.5, alertViewHeight * 0.7, alertViewWidth * 0.5, alertViewHeight * 0.3);
            
            self.cancleButton.backgroundColor = cancleBtnColor;
            [self.cancleButton setTitleColor:kBtnGrayTextColor forState:UIControlStateNormal];
        }
    }

    [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self addSubview:self.cancleButton];
    
    if (!color) {
        self.confirmButton.backgroundColor = confirmBtnColor;
    } else {
        self.confirmButton.backgroundColor = color;
    }
    //self.confirmButton.layer.cornerRadius = 2.0f;
    [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kBtnWriteTextColor forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self addSubview:self.confirmButton];
}

- (void)cancleButtonClicked:(id)sender
{

    if (self.cancleBlock) {
        self.cancleBlock();
        self.cancleBlock = nil;
    }
    [self dismissAlert];
}

- (void)confirmButtonClicked:(id)sender
{
    if (self.confirmBlock) {
        self.confirmBlock();
        self.confirmBlock = nil;
    }

    [self dismissAlert];
}

- (void)dismissAlert
{
    [self.backgroundView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)show
{
    [kKeyWindow endEditing:YES];

    WYAlertView* oldView = [kKeyWindow viewWithTag:WYAlertView_Tag];
    if (oldView) {
        [oldView dismissAlert];
    }

    [kKeyWindow addSubview:self];
    self.tag = WYAlertView_Tag;
}

- (UIView*)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }

    return _backgroundView;
}

//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    
    //    加载背景背景图,防止重复点击
    [kKeyWindow addSubview:self.backgroundView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.01), @(1), @(1), @(1)];
    animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.3;
    [self.layer addAnimation:animation forKey:@"bouce"];
    
    [super willMoveToSuperview:newSuperview];
}


@end
