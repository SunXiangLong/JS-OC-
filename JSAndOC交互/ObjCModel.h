//
//  ObjCModel.h
//  XiaoMaBao
//
//  Created by liulianqi on 16/5/12.
//  Copyright © 2016年 HuiBei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h> //引入头文件
@protocol JavaScriptObjectiveCDelegate <JSExport>

// JS调用此方法来调用OC登录
- (void)showLogin;
- (void)showGood:(NSString  *)params;
- (void)showTopic:(NSString *)params;
- (void)showGroup:(NSString *)params;

@end
@interface ObjCModel : NSObject <JavaScriptObjectiveCDelegate>
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@end
