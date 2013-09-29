//
//  Produto.h
//  Sistoque
//
//  Created by Fabio Marinho on 28/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Produto : NSManagedObject

@property (nonatomic, retain) NSNumber * ativo;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * idCategoria;
@property (nonatomic, retain) NSNumber * qtdeMaxima;
@property (nonatomic, retain) NSNumber * qtdeMinima;
@property (nonatomic, retain) NSNumber * valorEntrada;
@property (nonatomic, retain) NSNumber * valorSaida;

@end
