//
//  SisUtil.h
//  Sistoque
//
//  Created by Humberto Mendes on 27/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SisUtil : NSObject

+(BOOL)verificaTextoVazioOuNulo:(NSString*)texto;
+(NSString *)dateToString:(NSDate *)date withMask:(NSString*) dateMask;
+(NSDate *)stringToDate:(NSString*)date withMask:(NSString*) dateMask;
+(NSNumber*)stringToInt:(NSString*)value;
+(BOOL)isGreaterThanZero:(NSNumber*)value;

@end
