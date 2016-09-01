//
//  RecipeBookViewController.h
//  RecipeBook
//
//  Created by vignesh on 31/08/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeBookViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
