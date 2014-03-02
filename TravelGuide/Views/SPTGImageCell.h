//
//  SPTGImageCell.h
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTGImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

+(NSString*)cellReuseId;

@end
