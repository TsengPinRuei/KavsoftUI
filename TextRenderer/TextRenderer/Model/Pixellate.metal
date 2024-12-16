//
//  Pixellate.metal
//  TextRenderer
//
//  Created by 曾品瑞 on 2024/9/20.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[stitchable]] float2 pixellate(float2 position, float size) {
    float2 pixellate=round(position/size)*size;
    return pixellate;
}
