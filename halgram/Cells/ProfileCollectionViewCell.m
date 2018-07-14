//
//  ProfileCollectionViewCell.m
//  halgram
//
//  Created by Halima Monds on 7/13/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import "ProfileCollectionViewCell.h"
#import "Post.h"
#import "ParseUI.h"

@implementation ProfileCollectionViewCell

- (void)configureCell: (Post *) post {
    self.post = post;
   
    self.postsView.image = nil;
    self.postsView.file = self.post[@"image"]; 
    [self.postsView loadInBackground];
    //[sender setTitle:self.post.author forState:UIControlStateNormal];
}
@end
