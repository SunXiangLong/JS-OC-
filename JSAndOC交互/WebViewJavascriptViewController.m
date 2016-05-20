//
//  WebViewJavascriptViewController.m
//  JSAndOC交互
//
//  Created by liulianqi on 16/5/20.
//  Copyright © 2016年 sunxianglong. All rights reserved.
//

#import "WebViewJavascriptViewController.h"
#import "WebViewJavascriptBridge.h"
@interface WebViewJavascriptViewController ()
@property WebViewJavascriptBridge* bridge;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewJavascriptViewController
/**
 *  无论是JS调用OC还是OC调用JS，都可以正常传值和返回值；而且在页面加载时只要JS代码被运行就可以进行交互，上面遇到的缺点和坑在这里都被掩埋的，真是良心之作
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.automaticallyAdjustsScrollViewInsets = NO;

    /**
     *  需要前端在js代码面加上才可以实现功能  https://github.com/marcuswestin/WebViewJavascriptBridge参考
     function setupWebViewJavascriptBridge(callback) {
     if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
     if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
     window.WVJBCallbacks = [callback];
     var WVJBIframe = document.createElement('iframe');
     WVJBIframe.style.display = 'none';
     WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
     document.documentElement.appendChild(WVJBIframe);
     setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
     }
     */
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    /**
     *  网页上的 testObjcCallback按钮点击方法
     *  @param data             testObjcCallback按钮点击方法传的值
     *  @param responseCallback 回调
     *
     *  @return nil
     */
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        /**
         *  js里面传到oc的值
         */
        NSLog(@"testObjcCallback called: %@", data);
        /**
         *  oc传值给js
         */
        responseCallback(@"我是oc里面的代码");
    }];
    
    /**
     *  还没加载完成的传值给js
     */
    for (NSInteger i = 0; i<5; i++) {
        
         [_bridge callHandler:@"testJavascriptHandler" data:@{ @"OC":@"oc里传的值" }];
    }
   
    
    
    
    
    
    [_webView loadHTMLString:appHtml baseURL:baseURL];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
