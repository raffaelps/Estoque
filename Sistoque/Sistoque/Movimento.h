//
//  Movimento.h
//  Sistoque
//
//  Created by Fabio Marinho on 28/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movimento : NSManagedObject

@property (nonatomic, retain) NSNumber * ativo;
@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * idProduto;
@property (nonatomic, retain) NSNumber * qtde;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSNumber * valor;

@end
