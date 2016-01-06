//
//  MyButton.m
//  AFN
//
//  Created by Fankai on 16/1/6.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "MyButton.h"
//#import "ViewController.h"
@implementation MyButton

+ (UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title action:(SEL)action target:(UIViewController *)viewController
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    //    [button setTitle:otherTitle forState:UIControlStateDisabled];
    //    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    //    [button setBackgroundImage:disabledButtonBackgroundImage forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    //    button.enabled = NO;
    
    return button;
}



@end
