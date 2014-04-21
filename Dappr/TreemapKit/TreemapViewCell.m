#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TreemapViewCell

@synthesize valueLabel;
@synthesize textLabel;
@synthesize backgroundImage;
@synthesize index;
@synthesize delegate;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];

        
        self.backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.backgroundImage setImage:[UIImage imageNamed:@"zerog.jpg"]];
        [self addSubview:backgroundImage];
        
        UIFont *avenir = [UIFont fontWithName:@"Avenir Medium" size:17.0];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)];
        textLabel.font = avenir;
        textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        textLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:textLabel];

        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)];
        valueLabel.font = avenir;
        valueLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.lineBreakMode = NSLineBreakByCharWrapping;
        valueLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:valueLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20);
    valueLabel.frame = CGRectMake(0, self.frame.size.height / 2 + 10, self.frame.size.width, 20);
    backgroundImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    if (delegate && [delegate respondsToSelector:@selector(treemapViewCell:tapped:)]) {
        [delegate treemapViewCell:self tapped:index];
    }
}

@end
