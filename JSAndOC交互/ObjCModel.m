//
//  ObjCModel.m
//  XiaoMaBao
//
//  Created by liulianqi on 16/5/12.
//  Copyright © 2016年 HuiBei. All rights reserved.
//

#import "ObjCModel.h"
@implementation ObjCModel
- (void)showLogin{
 [self showAlert:@"Js调用了OC的方法" msg:@"没有参数"];

}

// 通过JSON传过来
- (void)showGood:(NSString *)params{

    [self showAlert:@"Js调用了OC的方法" msg:params];
}
- (void)showTopic:(NSString *)params{
 [self showAlert:@"Js调用了OC的方法" msg:params];
}
- (void)showGroup:(NSString *)params{
    [self showAlert:@"Js调用了OC的方法" msg:params];

}
- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
