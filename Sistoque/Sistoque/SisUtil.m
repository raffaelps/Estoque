//
//  SisUtil.m
//  Sistoque
//
//  Created by Humberto Mendes on 27/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "SisUtil.h"

@implementation SisUtil

+(BOOL)verificaTextoVazioOuNulo:(NSString*)texto{
    return ([texto stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0);
}

+(NSDateFormatter *)dateFormatWithMask:(NSString*) dateMask{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateMask];    
    return dateFormatter;
}

+(NSString *)dateToString:(NSDate *)date withMask:(NSString*) dateMask{    
    NSDateFormatter *dateFormatter = [self dateFormatWithMask :dateMask];
    return [dateFormatter stringFromDate:date];
}

+(NSDate *)stringToDate:(NSString*)date withMask:(NSString*) dateMask{    
    NSDateFormatter *dateFormatter = [self dateFormatWithMask:dateMask];
    return [dateFormatter dateFromString:date];    
}

+(NSNumber*)stringToInt:(NSString*)value{
    return [[NSNumber alloc] initWithUnsignedInt:[value intValue]];
}

+(BOOL)isGreaterThanZero:(NSNumber*)value{
    int result = [value integerValue];
    return (result > 0);
}

@end
