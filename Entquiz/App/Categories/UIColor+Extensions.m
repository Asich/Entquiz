//
//  UIColor+Extensions.m
//  Kiwi.kz
//
//  Created by Almas Adilbek on 11/3/12.
//
//

@implementation UIColor (Extensions)

+(UIColor *)fromRGB:(int)rgb {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

- (UIColor *)lighterColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.75
                               alpha:a];
    return nil;
}

+ (UIColor *)orangeACBColor {
    return [UIColor fromRGB:0xFF8300];
}

+ (UIColor *)entquizGrayColor {
    return [UIColor fromRGB:0xC4CED3];
}

+ (UIColor *)entGreenColor {
    return [UIColor fromRGB:0x00A562];
}

+ (UIColor *)entGrayColor {
    return [UIColor fromRGB:0x505356];
}

+ (UIColor *)entRedColor {
    return [UIColor fromRGB:0xC62426];
}


@end
