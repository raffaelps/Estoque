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
@synthesize imagemItemMenu;

-(id) initWithMenu:(NSString *)menuInicial addImage:(NSString *) imageName{
    
    if ((self = [super init])) {
        self.itemMenu = menuInicial;
        self.imagemItemMenu = imageName;
    }
    return self;
}

-(void) dealloc {

}

@end
