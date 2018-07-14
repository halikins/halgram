//
//  FeedCell.m
//  halgram
//
//  Created by Halima Monds on 7/10/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "FeedCell.h"
#import "ViewController.h"

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureCell: (Post *) post rowNumber:(int)row {
    self.post = post;
    NSString *buttonTitle = self.post.author.username;
    self.postAuthor.tag = row;
    self.postText.text = self.post.caption;
    self.postImage.image = nil;
    self.postImage.file = self.post[@"image"];
    [self.postImage loadInBackground];
    [self.postAuthor setTitle:buttonTitle forState:UIControlStateNormal];
    //[sender setTitle:self.post.author forState:UIControlStateNormal];
}

//- (IBAction)postImage:(id)sender {}
@end
