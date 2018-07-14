//
//  ProfileViewController.h
//  halgram
//
//  Created by Halima Monds on 7/12/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) PFUser *user;
-(void)profileUser: (PFUser *)user;
- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;
@end
