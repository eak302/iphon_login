//
//  ViewController.h
//  loginUsernamePassword
//
//  Created by Weerachai on 12/10/55 BE.
//  Copyright (c) 2555 Weerachai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    IBOutlet UITextField *txtUsername;
    
    IBOutlet UITextField *txtPassword;
}

- (IBAction)btnLogin:(id)sender;

@property(nonatomic,assign) NSMutableData *receivedData;

@end
