//
//  ProfileCollectionViewCell.h
//  halgram
//
//  Created by Halima Monds on 7/13/18.
//  Copyright © 2018 Halima Monds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@interface ProfileCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postsView;
@property (strong, nonatomic) Post *post;
- (void)configureCell: (Post *) post;
@end
