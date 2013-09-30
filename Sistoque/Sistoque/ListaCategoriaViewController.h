//
//  ListaCategoriaViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaCategoriaViewController : UIViewController<UITableViewDelegate,
UITableViewDataSource> {
    NSArray *categorias;
}
@property (retain, nonatomic) IBOutlet UITableView *tableviewCategorias;

@end
