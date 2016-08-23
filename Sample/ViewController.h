//
//  ViewController.h
//  Sample
//
//  Created by vignesh on 8/11/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "FMDatabase.h"

@interface ViewController : UIViewController

@property (strong, nonatomic)  FMDatabase *db;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnAction:(id)sender;
- (IBAction)xmlRead:(id)sender;
-(void)saveBooks;
@end

