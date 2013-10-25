//
//  Principal.h
//  Sistoque
//
//  Created by Danilo Oliveira on 24/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Principal : NSObject {
    NSString *itemMenu;
}

-(id) initWithMenu:(NSString *) menuInicial;

@property (nonatomic, retain) NSString *itemMenu;

@end
