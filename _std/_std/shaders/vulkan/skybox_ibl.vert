#version 450 core

//— Vertex inputs
layout(location = 0) in vec3  inPos;
layout(location = 1) in vec3  inNormal;
layout(location = 2) in vec2  inUV;
layout(location = 3) in vec4  inColor;
layout(location = 4) in vec4  inJoint0;
layout(location = 5) in vec4  inWeight0;
layout(location = 6) in vec4  inTangent;

//— Scene UBO (set 0)
struct PointLight {
    vec4 position;
    vec4 color;
};


layout(set = 0, binding = 0) uniform GlobalUbo {
    mat4 projection;
    mat4 view;
    vec4 ambientLightColor;
    vec4 viewPos;         
    PointLight pointLights[10];
    int numLights;
} ubo;


layout(location = 0) out vec3 vDirection;

void main() {
    // remove translation:
    mat4 rotView = mat4(mat3(ubo.view));
    
    vec4 clipPos = ubo.projection * rotView * vec4(inPos, 1.0);
    gl_Position = clipPos.xyww; // Depth = 1.0 (far plane)
    
    vDirection = inPos; 
}
