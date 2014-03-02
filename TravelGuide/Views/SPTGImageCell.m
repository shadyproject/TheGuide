//
//  SPTGImageCell.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "SPTGImageCell.h"

@interface SPTGImageCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation SPTGImageCell

+(NSString*)cellReuseId{
    return @"SPTGImageCell";
}

-(void)prepareForReuse{
    self.image = nil;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = self.image;
}
@end
