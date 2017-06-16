//
//  NFDataMD5.h
//  guonongda
//
//  Created by guest on 16/10/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFDataMD5 : NSObject
@property (nonatomic, strong) NSMutableDictionary *dict;

- (instancetype)initWithAppid:(NSString *)appid
                       mch_id:(NSString *)mch_id
                    nonce_str:(NSString *)nonce_str
                   partner_id:(NSString *)partner_id
                         body:(NSString *)body
                 out_trade_no:(NSString *)out_trade_no
                    total_fee:(NSString *)total_fee
             spbill_create_ip:(NSString *)spbill_create_ip
                   notify_url:(NSString *)notify_url
                   trade_type:(NSString *)trade_type;


//创建发起支付时的SIGN签名(二次签名)
- (NSString *)createMD5SingForPay:(NSString *)appid_key
                        partnerid:(NSString *)partnerid_key
                         prepayid:(NSString *)prepayid_key
                          package:(NSString *)package_key
                         noncestr:(NSString *)noncestr_key
                        timestamp:(UInt32)timestamp_key;

@end
