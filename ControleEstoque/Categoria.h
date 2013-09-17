//
//  Categoria.h
//  ControleEstoque
//
//  Created by Pedro Farias Barbosa on 17/09/13.
//  Copyright (c) 2013 raffaelps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSNumber * idCategoria;
@property (nonatomic, retain) NSString * descricao;

@end
