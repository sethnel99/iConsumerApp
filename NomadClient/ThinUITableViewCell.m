//
//  ThinUITableViewCell.m
//  NomadClient
//
//  Created by Farley User on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThinUITableViewCell.h"

@implementation ThinUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    int inset = 30;
    frame.origin.x += inset;
    frame.size.width -= 2 * inset;
    [super setFrame:frame];
}

@end
