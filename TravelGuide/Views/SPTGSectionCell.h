//
//  SPTGSectionCell.h
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTGSectionCell : UICollectionViewCell

@property (nonatomic, strong) NSAttributedString *sectionText;

+(NSString*)cellReuseId;

@end
