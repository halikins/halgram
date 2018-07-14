//
//  DetailsViewController.h
//  halgram
//
//  Created by Halima Monds on 7/12/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailCaption;
@property (weak, nonatomic) IBOutlet UILabel *detailTimestamp;
@property (strong, nonatomic) Post *post;
-(void)detailUser: (Post *) post;
@end
