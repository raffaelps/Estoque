//
//  ListaProdutosViewController.h
//  Sistoque
//
//  Created by Leonardo on 21/09/13.
//  Copyright (c) 2013 Leonardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaProdutosViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,retain)IBOutlet UITableView *tabela;

@end
