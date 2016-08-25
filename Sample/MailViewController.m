//
//  MailViewController.m
//  Sample
//
//  Created by vignesh on 8/24/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "MailViewController.h"

@interface MailViewController ()

@end

@implementation MailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.delegate = self;
    self.pwd.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginBtn:(id)sender {
    
    
    if([_userName.text length]>8){
        
        NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
        
        if ([emailTest evaluateWithObject:self.userName.text] == NO)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"enter the Valid Mail id" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
            [alert show];
            
        }
        else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"enter the Valid Mail id" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
        [alert show];
    }
    
    }
}
@end
