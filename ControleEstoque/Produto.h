//
//  Produto.h
//  ControleEstoque
//
//  Created by Pedro Farias Barbosa on 17/09/13.
//  Copyright (c) 2013 raffaelps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Produto : NSManagedObject

@property (nonatomic, retain) NSNumber * idProduto;
@property (nonatomic, retain) NSNumber * idCategoria;
@property (nonatomic, retain) NSString * nomeProduto;
@property (nonatomic, retain) NSNumber * qtdMinima;
@property (nonatomic, retain) NSNumber * qtdMaxima;
@property (nonatomic, retain) NSNumber * valorCompra;
@property (nonatomic, retain) NSNumber * valorVenda;
@property (nonatomic, retain) NSString * codigoBarras;

@end
