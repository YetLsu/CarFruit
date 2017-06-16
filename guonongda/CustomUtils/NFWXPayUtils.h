//
//  NFWXPayUtils.h
//  guonongda
//
//  Created by guest on 16/10/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>

//微信appid
#define WXAppId @"wx7bd9538ff704a12c"
//商户id
#define WXMch_id @"1395642302"
//总金额
#define WXTotal_fee @"1"
//交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
#define WXNotify_url @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//交易类型
#define WXTrade_type @"APP"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
//#define WX_PartnerKey @"qwertyuiopasdfghjklzxcvbnm123456"


@interface NFWXPayUtils : NSObject

#pragma mark - 产生随机字符串，用于产生订单号
+ (NSString *)generateTradeNo;

#pragma mark - 获取设备ip地址 / 貌似该方法获取ip地址只能在wifi状态下进行
+ (NSString *)fetchIPAddress;


+ (void)jumpToWXPay;


@end
