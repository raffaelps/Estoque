//
//  MesesRelatorio.h
//  Sistoque
//
//  Created by Raffael Patrício de Souza on 07/11/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MesesRelatorio : NSObject

@property(nonatomic)NSInteger mes;
@property(nonatomic)NSInteger ano;

@property(nonatomic,retain)NSMutableArray *produtos;

@end
