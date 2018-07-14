//
//  ViewController.m
//  halgram
//
//  Created by Halima Monds on 7/9/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "ViewController.h"
#import "Parse/Parse.h"
@interface ViewController ()
- (IBAction)SignIn:(id)sender;
- (IBAction)SignUp:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [self backgroundGradient];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backgroundGradient{
    UIColor *firstColor = [UIColor colorWithRed:81.0/255.0 green:91.0/255.0 blue:212.0/255.0 alpha:1.0];
    UIColor *secondColor = [UIColor colorWithRed:129.0/255.0 green:52.0/255.0 blue:175.0/255.0 alpha:1.0];
    UIColor *thirdColor = [UIColor colorWithRed:221.0/255.0 green:42.0/255.0 blue:123.0/255.0 alpha:1.0];
    UIColor *fourthColor = [UIColor colorWithRed:254.0/255.0 green:218.0/255.0 blue:119.0/255.0 alpha:1.0];
    UIColor *fifthColor = [UIColor colorWithRed:245.0/255.0 green:133.0/255.0 blue:41.0/255.0 alpha:1.0];
    
    // Create the gradient
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)firstColor.CGColor, (id)secondColor.CGColor,(id)thirdColor.CGColor,
        (id)fourthColor.CGColor,
        (id)fifthColor.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    //theViewGradient.startPoint = CGPointMake(0.0, 0.5);
    //theViewGradient.endPoint = CGPointMake(1.0, 0.5);
    //Add gradient to view
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.Username.text;
    //newUser.email = self.emailField.text;
    newUser.password = self.Password.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.Username.text;
    NSString *password = self.Password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)errorAlert{
    
    if ([self.Username.text isEqual:@""]) {
        UIAlertController *usernamealert = [UIAlertController alertControllerWithTitle:@"No username"
                                                                               message:@"Something went wrong, Try Again "
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle cancel response here. Doing nothing will dismiss the view.
                                                             }];
        // add the cancel action to the alertController
        [usernamealert addAction:cancelAction];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [usernamealert addAction:okAction];
        [self presentViewController:usernamealert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    if ([self.Password.text isEqual:@""]) {
        UIAlertController *passwordalert = [UIAlertController alertControllerWithTitle:@"No password"
                                                                               message:@"Something went wrong, Try Again "
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle cancel response here. Doing nothing will dismiss the view.
                                                             }];
        // add the cancel action to the alertController
        [passwordalert addAction:cancelAction];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [passwordalert addAction:okAction];
        [self presentViewController:passwordalert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
}
- (IBAction)SignIn:(id)sender {
    [self errorAlert];
    [self loginUser];
}

- (IBAction)SignUp:(id)sender {
    [self errorAlert];
    [self registerUser];


}
@end
