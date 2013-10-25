//
//  Principal.m
//  Sistoque
//
//  Created by Danilo Oliveira on 24/10/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import "Principal.h"

@implementation Principal
@synthesize itemMenu;

-(id) initWithMenu:(NSString *)menuInicial{
    
    if ((self = [super init])) {
        self.itemMenu = menuInicial;
    }
    return self;
}

-(void) dealloc {

}

@end
