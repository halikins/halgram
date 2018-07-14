//
//  FeedCell.h
//  halgram
//
//  Created by Halima Monds on 7/10/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"
#import "ViewController.h"
@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (strong,nonatomic) Post *post;
@property (strong, nonatomic) NSString *postName;
@property(strong, nonatomic) ViewController *user;
@property (weak, nonatomic) IBOutlet UIButton *postAuthor;

-(void)configureCell:(Post *) post rowNumber:(int)row;
@end
