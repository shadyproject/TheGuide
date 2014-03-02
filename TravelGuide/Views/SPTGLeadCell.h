//
//  SPTGLeadCell.h
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTGLeadCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSAttributedString *bodyText;
@property (nonatomic, strong) UIImage *backgroundImage;

+(NSString*)cellReuseId;

@end
