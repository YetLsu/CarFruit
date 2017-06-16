//
//  NFDataMD5.m
//  guonongda
//
//  Created by guest on 16/10/6.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFDataMD5.h"
#import <CommonCrypto/CommonDigest.h>
@interface NFDataMD5 ()
@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *mch_id;
@property (nonatomic,strong) NSString *nonce_str;
@property (nonatomic,strong) NSString *partnerkey;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *out_trade_no;
@property (nonatomic,strong) NSString *total_fee;
@property (nonatomic,strong) NSString *spbill_create_ip;
@property (nonatomic,strong) NSString *notify_url;
@property (nonatomic,strong) NSString *trade_type;
@end

@implementation NFDataMD5

- (NSMutableDictionary *)dict{
    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (instancetype)initWithAppid:(NSString *)appid
                       mch_id:(NSString *)mch_id
                    nonce_str:(NSString *)nonce_str
                   partner_id:(NSString *)partner_id
                         body:(NSString *)body
                 out_trade_no:(NSString *)out_trade_no
                    total_fee:(NSString *)total_fee
             spbill_create_ip:(NSString *)spbill_create_ip
                   notify_url:(NSString *)notify_url
                   trade_type:(NSString *)trade_type{

    self = [super init];
    if (self) {
        _appid = appid;
        _mch_id = mch_id;
        _nonce_str = nonce_str;
        _body = body;
        _out_trade_no = out_trade_no;
        _total_fee = total_fee;
        _spbill_create_ip = spbill_create_ip;
        _notify_url = notify_url;
        _trade_type = trade_type;
        
        [self.dict setObject:_appid forKey:@"appid"];
        [self.dict setObject:_mch_id forKey:@"mch_id"];
        [self.dict setObject:_nonce_str forKey:@"nonce_str"];
        [self.dict setObject:_body forKey:@"body"];
        [self.dict setObject:_out_trade_no forKey:@"out_trade_no"];
        [self.dict setObject:_total_fee forKey:@"total_fee"];
        [self.dict setObject:_spbill_create_ip forKey:@"spbill_create_ip"];
        [self.dict setObject:_notify_url forKey:@"notify_url"];
        [self.dict setObject:_trade_type forKey:@"trade_type"];
        
        [self createMd5Sign:self.dict];
        
        
    }
    return self;
}

//创建发起支付时的SIGN签名(二次签名)
- (NSString *)createMD5SingForPay:(NSString *)appid_key
                        partnerid:(NSString *)partnerid_key
                         prepayid:(NSString *)prepayid_key
                          package:(NSString *)package_key
                         noncestr:(NSString *)noncestr_key
                        timestamp:(UInt32)timestamp_key{

    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];
    [signParams setObject:partnerid_key forKey:@"partnerid"];
    [signParams setObject:prepayid_key forKey:@"prepayid"];
    [signParams setObject:package_key forKey:@"package"];
    [signParams setObject:noncestr_key forKey:@"noncestr"];
    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)timestamp_key] forKey:@"timestamp"];
    
    NSMutableString *contentString = [NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for(NSString *categoryId in sortedArray){
        if (![[signParams objectForKey:categoryId] isEqualToString:@""] && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"] && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]) {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    
    }
    //添加商户密钥key字段
    [contentString appendFormat:@"key=%@",WX_PartnerKey];
    NSString *result = [self md5:contentString];
    
    return result;
}

-(void)createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![[dict objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    
    //添加商户密钥key字段
    [contentString appendFormat:@"key=%@",WX_PartnerKey];
    
    //MD5 获取Sign签名
    NSString *md5Sign =[self md5:contentString];
    //
    [self.dict setValue:md5Sign forKey:@"sign"];
}







//md5加密算法
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
