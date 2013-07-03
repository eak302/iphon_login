//
//  LoginInfoViewController.h
//  loginUsernamePassword
//
//  Created by Weerachai on 12/10/55 BE.
//  Copyright (c) 2555 Weerachai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInfoViewController : UIViewController
{
        
    IBOutlet UILabel *lblMemberID;
    
    IBOutlet UILabel *lblUsername;
    
    IBOutlet UILabel *lblPassword;
    
    IBOutlet UILabel *lblName;
    
    IBOutlet UILabel *lblTel;
    
    IBOutlet UILabel *lblEmail;
    
}

@property (strong, nonatomic) id sMemberID;

@property(nonatomic,assign) NSMutableData *receivedData;

@end
