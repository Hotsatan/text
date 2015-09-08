//
//  Model.m
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "Model.h"
#import <objc/message.h>
#import <objc/runtime.h>

const char * getPropertyType(objc_property_t property) {
    const char * ret = "";
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            ret = (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
            break;
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            ret = "id";
            break;
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            ret = (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
            break;
        }
    }
    return ret;
}

NSString *getType(objc_property_t property)
{
    NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    if ([propertyType hasPrefix:@"T@"]) {
        return [propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location - 4)];
    }
    else if ([propertyType hasPrefix:@"Ti"])
    {
        return @"int";
    }
    else if ([propertyType hasPrefix:@"TF"])
    {
        return @"float";
    }
    else if([propertyType hasPrefix:@"Td"]) {
        return @"double";
    }
    else if([propertyType hasPrefix:@"Tl"])
    {
        return @"long";
    }
    else if ([propertyType hasPrefix:@"Tc"]) {
        return @"char";
    }
    else if([propertyType hasPrefix:@"Ts"])
    {
        return @"short";
    }
    return nil;
}


@implementation Model

- (id)initWithDictionaryParams:(NSDictionary *)param {
    
    self = [super init];
    if (self) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
        for ( int i=0; i < propertyCount; i++ )
        {
            objc_property_t *thisProperty = propertyList + i;
            NSString *propertyType = getType(*thisProperty);
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
            [dict setValue:propertyType forKey:propertyName];
        }
        
        for (NSString *key in [param allKeys]) {
            
            
            NSString *name = key;
            NSString *value = param[key];
            NSObject *object = dict[name];
            
            if ([value isKindOfClass:[NSNull class]]) {
                [self setValue:nil forKey:name];
                continue;
            }
            if(object != nil)
            {
                NSString *type = (NSString*)object;
                if([type isEqual:@"NSNumber"])
                {
                    NSNumber *num = nil;
                    if( [value isEqual:@"true"] || [value isEqual:@"flase"] )
                    {
                        num = [NSNumber numberWithInteger:[value boolValue]];
                    }
                    else if( [value rangeOfString:@"."].location != NSNotFound )
                    {
                        num = [NSNumber numberWithFloat:[value floatValue]];
                    }
                    else
                    {
                        num = [NSNumber numberWithLongLong:[value longLongValue]];
                    }
                    [self setValue:num forKey:name];
                    
                }
                else if([type isEqual:@"NSString"])
                {
                    [self setValue:value forKey:name];
                }
                //            else if([type isEqual:@"NSURL"])
                //            {
                //                NSURL *url = nil;
                //                NSRange range = [value rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
                //                if(range.location == NSNotFound)
                //                {
                //                    url =[Unity resourceUrlByResourceName:value];
                //                }
                //                else
                //                {
                //                    url = [NSURL URLWithString:value];
                //                }
                //                [self setValue:url forKey:name];
                //
                //            }
                else if([type isEqual:@"NSDate"])
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    //dateFormatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    //设定时间格式,这里可以设置成自己需要的格式
                    //[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:sszzzz"]; // @"1981-10-10T12:22:33+0800"
                    [dateFormatter setDateFormat:@"yyyy-MM-dd' 'HH:mm:ss"]; // @"1981-10-10 12:22:33"
                    NSDate *date = [dateFormatter dateFromString:value];
                    [self setValue:date forKey:name];
                }
                else {
                    [self setValue:value forKey:name];
                }
            }
            
            
        }
    }
    
    return self;
}


- (id)initWithDicitonary:(NSDictionary *)dictionary {
    
    //dictionary setValue:<#(id)#> forKey:<#(NSString *)#>
    if (self = [super init]) {
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSNull class]] || obj == nil) {
                obj = @"";
            }
            if ([key isEqualToString:@"id"]) {
                key = @"ID";
            }
            
            [self setValue:obj forKey:key];//
        }];
    }
    
    return self;
}

- (NSDictionary *)serverNeededDictionary {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [self properties];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        id value = [self valueForKey:obj];
        if ([obj isEqualToString:@"ID"]) {
            obj = @"id";
        }
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            value = @"";
        }
        
        [dict setObject:value forKey:obj];
        
    }];
    
    return dict;
}

- (BOOL)isEqual:(id)object {
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    NSMutableArray *propertyArray = [self properties];
    __block BOOL euqal = YES;
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        euqal = [[self valueForKey:obj] isEqual:[object valueForKey:obj]];
        if (!euqal) {
            *stop = YES;
        }
    }];
    
    return euqal;
}

- (NSUInteger)hash {
    
    NSMutableArray *propertyArray = [self properties];
    __block NSUInteger hashCode = [self hash];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hashCode ^= [[self valueForKey:obj] hash];
    }];
    
    return hashCode;
}

#pragma mark - runtime

- (NSMutableArray *)properties {
    
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    return propertyArray;
}

+ (NSMutableArray *)properties {
    
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    return propertyArray;
}

#pragma mark - 判断自身对象完整度

- (float)integrity {
    
    // 需要排除两个界面没有用到的id属性
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [self properties];
    __block float count = 0;
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = [self valueForKey:obj];
        if (![value isKindOfClass:[NSNull class]] && [value length]) {
            count++;
        };
    }];
    return (count - 2.0) / ((float)propertyArray.count - 2.0);
}

#pragma mark - 返回自身对象所有数据的数组集合

- (NSMutableArray *)valueForProperties {
    
    NSMutableArray *propertyArray = [self properties];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [values addObject:[self valueForKey:obj]];
    }];
    
    // 去掉最后两个id元素
    [values removeLastObject];
    [values removeLastObject];
    
    return values;
}


@end


#pragma mark - NewsLiveListTop

@implementation NewsLiveListTop



@end

#pragma mark - HomeMessageDetailModel

@implementation HomeMessageDetailModel



@end

#pragma mark - FeedBackCellModel

@implementation FeedBackCellModel

@end

#pragma mark - SectionData

@implementation SectionData

- (instancetype)initWithName:(NSString *)name {
    
    if (self = [super init]) {
        self.name = name;
        
    }
    return self;
}


@end

#pragma mark - GuideOfServiceTableViewCellModel
@implementation GuideOfServiceTableViewCellModel



@end




#pragma mark - NotificationAndAnnouncementModel
@implementation NotificationAndAnnouncementModel



@end