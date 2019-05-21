//
//  Util.m
//  TracePlatform
//
//  Created by lym on 2017/5/2.
//  Copyright © 2017年 ehsureTec. All rights reserved.
//

#import "Util.h"

@interface Util()

@end

@implementation Util

#pragma mark 字符串 转Unicode
+ (NSString *)utf8ToUnicode:(NSString *)string{
    
    NSUInteger length = [string length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
        unichar _char = [string characterAtIndex:i];
        // 判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else{
            // 中文和字符
            [s appendFormat:@"\\u%x", [string characterAtIndex:i]];
            // 不足位数补0 否则解码不成功
            if(s.length == 4) {
                [s insertString:@"00" atIndex:2];
            } else if (s.length == 5) {
                [s insertString:@"0" atIndex:2];
            }
        }
        [str appendFormat:@"%@", s];
    }
    return str;
    
    
}


#pragma mark Unicode 转字符串
+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"'"withString:@"\""];
    NSString *tempStr3 = [[@"'" stringByAppendingString:tempStr2] stringByAppendingString:@"'"];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\r\n"withString:@"\n"];
}


#pragma mark 对一个字符串进行base64编码，并返回
+ (NSString *)base64EncodeString:(NSString *)string {
    //1、先转换成二进制数据
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

#pragma mark 对一个字符串进行base64解码，并返回
+ (NSString *)base64DecodeString:(NSString *)string {
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data=[[NSData alloc]initWithBase64EncodedString:string options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark 字典转json字符串
+ (NSString *)dictToJSONString:(NSDictionary *)dict {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        MYLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

#pragma mark json字符串转字典
+ (NSDictionary *)dictWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        MYLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark json字符串转数组
+ (NSArray *)getArrayWithJsonString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSASCIIStringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

#pragma mark 数组转json字符串
+ (NSString *)getJsonStringWithArray:(NSArray *)array{
    if (array.count > 0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        return jsonStr;
        
    }
    return @"";
}


/**
 获取当前屏幕显示的viewcontroller
 
 @return 当前正在显示的viewcontroller
 */
+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    // 获取默认的window
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    // 获取window的rootViewController
    result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}


#pragma mark - token过期
+ (void)reLogin:(UIViewController *)controller
{
    
    //删除登录状态
    [Util removeInfoObjectForKey:@"loginState"];
    //删除登录人类型
    [Util removeInfoObjectForKey:@"userType"];
    //删除loginName
    [Util removeInfoObjectForKey:@"loginName"];
    //删除password
    [Util removeInfoObjectForKey:@"password"];
    //删除token
    [Util removeInfoObjectForKey:@"token"];
    //删除userId
    [Util removeInfoObjectForKey:@"userId"];
  
}


//根据字符串长度获取对应的宽度或者高度
+ (CGFloat)stringText:(NSString *)text font:(CGFloat)font isHeightFixed:(BOOL)isHeightFixed fixedValue:(CGFloat)fixedValue
{
    CGSize size;
    if (isHeightFixed) {
        size = CGSizeMake(MAXFLOAT, fixedValue);
    } else {
        size = CGSizeMake(fixedValue, MAXFLOAT);
    }
    
    CGSize resultSize;
    //返回计算出的size
    resultSize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil].size;
    
    if (isHeightFixed) {
        return resultSize.width;
    } else {
        return resultSize.height;
    }
}


/**
 *  日期格式处理方法
 */
+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

#pragma mark - NSUserDefaults 存储、获取、删除
+ (void)saveInfoObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}


+ (id)getInfoObjectForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)removeInfoObjectForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}


//创建提示弹框并展示
+ (void)showMessageWithView:(UIView *)view Title:(NSString *)title Image:(NSString *)image HideAfter:(NSTimeInterval)time {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    hud.label.text = title;
    [hud hideAnimated:YES afterDelay:time];

}


//字典转json格式字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//邮箱验证
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
//    /**
//     * 移动号段正则表达式
//     */
//    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//    /**
//     * 联通号段正则表达式
//     */
//    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//    /**
//     * 电信号段正则表达式
//     */
//    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//
//    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//    BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//    BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//    BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//
//    if (isMatch1 || isMatch2 || isMatch3) {
//        return YES;
//    }else{
//        return NO;
//    }
    
    
    //不做号段校验，暂时判断是否为11位数字
    if (mobile.length != 11) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:mobile]) {
        return YES;
    }
    return NO;
    
}



//可以删除NSString中的数字、符号，或者修改其中的字符
+ (NSString *)stringDeleteString:(NSString *)str {
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '"' || c == '.' || c == ',' || c == '(' || c == ')' || c == '-') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}


//判断字符串是否为空
+ (BOOL)isNullWithStr:(NSString *)str {
    if ( str == nil
        || str == NULL
        || [str isKindOfClass:[NSNull class]]
        || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]== 0) {
        return YES;
    }else {
        return NO;
    }
}

//判断字符串是否为空(包括空字符串)
+ (BOOL)isNullWithString:(NSString *)str {
    if ( str == nil
        || str == NULL
        || [str isKindOfClass:[NSNull class]]
        || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]== 0
        || [str isEqualToString:@""]) {
        return YES;
    }else {
        return NO;
    }
}

//计算字符串size
+ (CGSize)sizeWithString:(NSString *)string font:(CGFloat)font {
    UIFont *font1 = [UIFont systemFontOfSize:font];
    CGSize sizeWord = [string sizeWithFont:font1 constrainedToSize:CGSizeMake(1000.0, 1000.0) lineBreakMode:UILineBreakModeWordWrap];
    return sizeWord;
}

+ (CGSize)measureSinglelineStringSize:(NSString*)str andFont:(UIFont*)wordFont {
    
    if (str == nil) return CGSizeZero;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return measureSize;
    
}

+ (float)measureMutilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidthSetup:(float)width {
    
    if (str == nil || width <= 0) return 0;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return ceil(measureSize.height);
    
}

// 传一个字符串和字体大小来返回一个字符串所占的宽度

+ (float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont {
    
    if (str == nil) return 0;
    
    CGSize measureSize;
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 7.0){
        
        measureSize = [str sizeWithFont:wordFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }else{
        
        measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
        
    }
    
    return ceil(measureSize.width);
    
}





//获取当前时间字符串
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//比较两个日期的大小
+ (int)compareDate:(NSString *)date01 withDate:(NSString *)date02 {
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    
    switch (result) {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
            
        default: MYLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}


//button点击后的设置
+ (void)setBtnEnabledWithBtn:(UIButton *)btn Time:(int)outTime YesColor:(UIColor *)yesColor NoColor:(UIColor *)noColor {
    
    __block int timeout=outTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [btn setBackgroundColor:yesColor];
                btn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [btn setBackgroundColor:noColor];
                btn.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
        
    });
    dispatch_resume(_timer);
    
}

//正则匹配用户密码,6-18位数字和字母组合
+ (BOOL)validatePSW:(NSString *)psw {
    
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:psw];
    
    return isMatch;
}


//正则匹验证码,6位的数字
+ (BOOL)validateCode:(NSString *)code {
    
    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:code];
    
    return isMatch;
}


+(BOOL)validateUserID:(NSString *)userID {
    //长度不为18的都排除掉
    if (userID.length!=18) { return NO; }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2]; BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) {
        
        return flag; //格式错误
        
    }else { //格式正确在判断是否合法 //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0; for(int i = 0;i < 17;i++) {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue]; NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2) { if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) { return YES; }else { return NO; } }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return YES;
                
            } else {
                return NO;
                
            }
            
        }
        
    }
    
}

+ (BOOL)isSocialCredit18Number:(NSString *)socialCreditNum
{
    if(socialCreditNum.length != 18){
        return NO;
    }
    
    NSString *scN = @"^([0-9ABCDEFGHJKLMNPQRTUWXY]{2})([0-9]{6})([0-9ABCDEFGHJKLMNPQRTUWXY]{9})([0-9Y])$";
    NSPredicate *regextestSCNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", scN];
    if (![regextestSCNum evaluateWithObject:socialCreditNum]) {
        return NO;
    }
    
    NSArray *ws = @[@1,@3,@9,@27,@19,@26,@16,@17,@20,@29,@25,@13,@8,@24,@10,@30,@28];
    NSDictionary *zmDic = @{@"A":@10,@"B":@11,@"C":@12,@"D":@13,@"E":@14,@"F":@15,@"G":@16,@"H":@17,@"J":@18,@"K":@19,@"L":@20,@"M":@21,@"N":@22,@"P":@23,@"Q":@24,@"R":@25,@"T":@26,@"U":@27,@"W":@28,@"X":@29,@"Y":@30};
    NSMutableArray *codeArr = [NSMutableArray array];
    NSMutableArray *codeArr2 = [NSMutableArray array];
    
    codeArr[0] = [socialCreditNum substringWithRange:NSMakeRange(0,socialCreditNum.length-1)];
    codeArr[1] = [socialCreditNum substringWithRange:NSMakeRange(socialCreditNum.length-1,1)];
    
    int sum = 0;
    
    for (int i = 0; i < [codeArr[0] length]; i++) {
        
        [codeArr2 addObject:[codeArr[0] substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSScanner* scan;
    int val;
    for (int j = 0; j < codeArr2.count; j++) {
        scan = [NSScanner scannerWithString:codeArr2[j]];
        if (![scan scanInt:&val] && ![scan isAtEnd]) {
            codeArr2[j] = zmDic[codeArr2[j]];
        }
    }
    
    
    for (int x = 0; x < codeArr2.count; x++) {
        sum += [ws[x] intValue]*[codeArr2[x] intValue];
    }
    
    
    int c18 = 31 - (sum % 31);
    
    for (NSString *key in zmDic.allKeys) {
        
        if (zmDic[key]==[NSNumber numberWithInt:c18]) {
            if (![codeArr[1] isEqualToString:key]) {
                return NO;
            }
        }
    }
    
    return YES;
}


+ (NSString*)isOrNoUserNameStyle:(NSString *)userName

{
    
    NSString * message;
    
    if (userName.length<6) {
        
        message=@"账号不能少于6位，请您重新输入";
        
    }
    
    else if (userName.length>20)
        
    {
        
        message=@"最大长度为20位，请您重新输入";
        
    }
    
    else if ([self JudgeTheillegalCharacter:userName])
        
    {
        
        message=@"账号不能包含特殊字符，请您重新输入";
        
        
    }
    
//    else if (![self judgePassWordLegal:userName])
//
//    {
//
//        message=@"密码必须同时包含字母和数字";
//
//    }
    else{
        message=@"right";
    }
    
    return message;
    
    
    
}



+ (NSString*)isOrNoPasswordStyle:(NSString *)passWordName

{
    
    NSString * message;
    
    if (passWordName.length<8) {
        
        message=@"密码不能少于8位，请您重新输入";
        
    }
    
    else if (passWordName.length>20)
        
    {
        
        message=@"密码最大长度为20位，请您重新输入";
        
    }
    
    else if ([self JudgeTheillegalCharacter:passWordName])
        
    {
        
        message=@"密码不能包含特殊字符，请您重新输入";
        
        
        
    }
    
//    else if (![self judgePassWordLegal:passWordName])
//
//    {
//
//        message=@"密码必须同时包含字母和数字";
//
//    }
    
    else{
          message=@"right";
    }
    
    return message;
    
    
    
}

+(BOOL)JudgeTheillegalCharacter:(NSString *)content {
    
    //提示标签不能输入特殊字符
//      NSString *str =@"[~!/@#$%^&#$%^&amp;*()-_=+\\|[{}];:\'\",&#$%^&amp;*()-_=+\\|[{}];:\'\",&lt;.&#$%^&amp;*()-_=+\\|[{}];:\'\",&lt;.&gt;/?]+";
    
    //    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSString *str =@"^[A-Za-z0-9]+$";

    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if (![emailTest evaluateWithObject:content]) {
        
        return YES;
        
    }
    
    return NO;
    
}

+(BOOL)judgePassWordLegal:(NSString *)pass{
    
    BOOL result ;
    
    // 判断长度大于8位后再接着判断是否同时包含数字和大小写字母
    
    NSString * regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$ ";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    result = [pred evaluateWithObject:pass];
    
    return result;
    
}


+ (BOOL)isUserNameWithStr:(NSString *)content {
    
    NSString *str = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if ([predicate evaluateWithObject:content]) {
        return YES;
    }
    
    return NO;
    
}


+ (BOOL)isHaveSpecialCharWithStr:(NSString *)content {
    
    NSString *str = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if ([predicate evaluateWithObject:content]) {
        return false;
    }
    
    return true;
}

/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size {
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1024.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1024.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    
    
    
    MYLog(@"===========333333=====>>>>>:%fkb",(float)[data length]/1024.0f);
    
    return data;
}



+ (UIImage*)imageCompressWithSimple:(UIImage*)image {
    CGSize size = image.size;
    CGFloat scale = 1.0;
    //TODO:KScreenWidth屏幕宽
    if (size.width > kScreen_Width || size.height > kScreen_Height) {
        if (size.width > size.height) {
            scale = kScreen_Width / size.width;
        }else {
            scale = kScreen_Height / size.height;
        }
    }
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    CGSize secSize =CGSizeMake(scaledWidth, scaledHeight);
    //TODO:设置新图片的宽高
    //    UIGraphicsBeginImageContext(secSize); // this will crop
    UIGraphicsBeginImageContextWithOptions(secSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (BOOL)isTelNum:(NSString *)telNum {
    //固话，区号（3-4位）- 号码（7-8位）
    NSString *checkStr = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|14[5|7|9]|15[0-9]|17[0|1|3|5|6|7|8]|18[0-9])\\d{8}$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", checkStr];
    return [predicate evaluateWithObject:telNum];
}


+ (BOOL)isPostcode:(NSString *)postcode {
    //邮编，校验前两位
    NSString *checkStr = @"^(0[1234567]|1[012356]|2[01234567]|3[0123456]|4[01234567]|5[1234567]|6[1234567]|7[012345]|8[013456])\\d{4}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", checkStr];
    return [predicate evaluateWithObject:postcode];
}

@end
