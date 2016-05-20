//
//  JavaScriptViewController.m
//  JSAndOC交互
//
//  Created by liulianqi on 16/5/20.
//  Copyright © 2016年 sunxianglong. All rights reserved.
//

#import "JavaScriptViewController.h"
#import <JavaScriptCore/JavaScriptCore.h> //引入头文件
#import "ObjCModel.h"
@interface JavaScriptViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation JavaScriptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.xiaomabao.com/testapp.html"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
   
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView*)webView{
    
    /**
     *  通过自己定义遵循JSExport协议的交互类 来实现js和oc交互  http://www.jianshu.com/p/fad8c7844d3参考
     */
    //    当网页视图结束加载一个请求之后，得到通知。
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    ObjCModel *model  = [[ObjCModel alloc] init];
    context[@"xmbapp"] = model;
    model.jsContext = context;
    model.webView = self.webView;
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
}

@end
