//
//  Movimento.h
//  ControleEstoque
//
//  Created by Pedro Farias Barbosa on 17/09/13.
//  Copyright (c) 2013 raffaelps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movimento : NSManagedObject

@property (nonatomic, retain) NSNumber * idMovimento;
@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * quantidade;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSNumber * valor;
@property (nonatomic, retain) NSNumber * idProduto;
@property (nonatomic, retain) NSNumber * idMovimentoRef;

@end
