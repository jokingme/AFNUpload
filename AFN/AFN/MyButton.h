//
//  MyButton.h
//  AFN
//
//  Created by Fankai on 16/1/6.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title action:(SEL)action target:(UIViewController *)viewController;
@end
