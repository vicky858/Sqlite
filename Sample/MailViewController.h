//
//  MailViewController.h
//  Sample
//
//  Created by vignesh on 8/24/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)loginBtn:(id)sender;

@end
