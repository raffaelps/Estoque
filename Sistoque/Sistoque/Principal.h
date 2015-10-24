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
    NSString *imagemItemMenu;
}

-(id) initWithMenu:(NSString *)menuInicial addImage:(NSString *) imageName;

@property (nonatomic, retain) NSString *itemMenu;
@property (nonatomic, retain) NSString *imagemItemMenu;


@end
