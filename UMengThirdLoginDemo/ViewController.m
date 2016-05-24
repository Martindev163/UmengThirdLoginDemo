//
//  ViewController.m
//  UMengThirdLoginDemo
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UMSocial.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialSnsService.h"

@interface ViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIButton *WBLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *QQLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *WXLoginBtn;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _WBLoginBtn = [self cornerBtns:_WBLoginBtn];
    
    _QQLoginBtn = [self cornerBtns:_QQLoginBtn];
    
    _WXLoginBtn = [self cornerBtns:_WXLoginBtn];
}

//裁剪圆角
-(UIButton *)cornerBtns:(UIButton *)Btn
{
    Btn.layer.cornerRadius = Btn.frame.size.width/2;
    Btn.layer.masksToBounds = YES;
    
    return Btn;
}

//新浪微博登录
- (IBAction)wbLogin:(UIButton *)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

//QQ登录
- (IBAction)QQLogin:(UIButton *)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

//微信登录
- (IBAction)WXLogin:(UIButton *)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }
        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
