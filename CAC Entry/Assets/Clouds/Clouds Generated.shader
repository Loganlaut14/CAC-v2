Shader "Unlit Master"
{
    Properties
    {
        Vector4_65EABAB("RotateProjection", Vector) = (1,0,0,0)
Vector1_50818A11("NoiseScale ", Float) = 10
Vector1_61C806C0("NoiseSpeed ", Float) = 0.1
Vector1_30AAF593("NoiseHeight ", Float) = 1
Vector4_4751FA07("NoiseRemap", Vector) = (0,1,-1,1)
Color_3E180C9C("ColorPeak", Color) = (1,1,1,0)
Color_8449C32A("ColorValley", Color) = (0,0,0,0)
Vector1_620DD99("NoiseEdge 1 ", Float) = 0
Vector1_D70DF092("NoiseEdge 2 ", Float) = 0
Vector1_450B7EF3("NoisePower ", Float) = 2
Vector1_DF4C36BA("BaseScale ", Float) = 5
Vector1_B4B00342("BaseSpeed ", Float) = 0.2
Vector1_A0B72FA1("BaseStrength ", Float) = 1
Vector1_FD5A3D43("EmissionStrength ", Float) = 1
Vector1_3BD37C41("CurvatureRadius ", Float) = 0
Vector1_561AAF3("FresnelPower ", Float) = 1
Vector1_677CA6D3("FresnelOpacity ", Float) = 1
Vector1_7E803735("FadeDepth ", Float) = 100
[HideInInspector] _EmissionColor("Color", Color) = (1,1,1,1)
[HideInInspector] _RenderQueueType("Vector1 ", Float) = 5
[HideInInspector] _StencilRef("Vector1 ", Int) = 0
[HideInInspector] _StencilWriteMask("Vector1 ", Int) = 3
[HideInInspector] _StencilRefDepth("Vector1 ", Int) = 0
[HideInInspector] _StencilWriteMaskDepth("Vector1 ", Int) = 32
[HideInInspector] _StencilRefMV("Vector1 ", Int) = 128
[HideInInspector] _StencilWriteMaskMV("Vector1 ", Int) = 128
[HideInInspector] _StencilRefDistortionVec("Vector1 ", Int) = 64
[HideInInspector] _StencilWriteMaskDistortionVec("Vector1 ", Int) = 64
[HideInInspector] _StencilWriteMaskGBuffer("Vector1 ", Int) = 3
[HideInInspector] _StencilRefGBuffer("Vector1 ", Int) = 2
[HideInInspector] _ZTestGBuffer("Vector1 ", Int) = 4
[HideInInspector] [ToggleUI] _RequireSplitLighting("Boolean", Float) = 0
[HideInInspector] [ToggleUI] _ReceivesSSR("Boolean", Float) = 0
[HideInInspector] _SurfaceType("Vector1 ", Float) = 1
[HideInInspector] _BlendMode("Vector1 ", Float) = 0
[HideInInspector] _SrcBlend("Vector1 ", Float) = 1
[HideInInspector] _DstBlend("Vector1 ", Float) = 0
[HideInInspector] _AlphaSrcBlend("Vector1 ", Float) = 1
[HideInInspector] _AlphaDstBlend("Vector1 ", Float) = 0
[HideInInspector] [ToggleUI] _ZWrite("Boolean", Float) = 1
[HideInInspector] _CullMode("Vector1 ", Float) = 2
[HideInInspector] _TransparentSortPriority("Vector1 ", Int) = 0
[HideInInspector] _CullModeForward("Vector1 ", Float) = 2
[HideInInspector] [Enum(Front, 1, Back, 2)] _TransparentCullMode("Vector1", Float) = 2
[HideInInspector] _ZTestDepthEqualForOpaque("Vector1 ", Int) = 4
[HideInInspector] [Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("Vector1", Float) = 4
[HideInInspector] [ToggleUI] _TransparentBackfaceEnable("Boolean", Float) = 0
[HideInInspector] [ToggleUI] _AlphaCutoffEnable("Boolean", Float) = 0
[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
[HideInInspector] [ToggleUI] _UseShadowThreshold("Boolean", Float) = 0
[HideInInspector] [ToggleUI] _DoubleSidedEnable("Boolean", Float) = 1
[HideInInspector] [Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Vector1", Float) = 2
[HideInInspector] _DoubleSidedConstants("Vector4", Vector) = (1,1,-1,0)

    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
            "RenderType"="HDUnlitShader"
            "Queue" = "Transparent+0"
        }
        
        Pass
        {
            // based on HDUnlitPass.template
            Name "META"
            Tags { "LightMode" = "META" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull Off
        
            
            
            
            
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            //-------------------------------------------------------------------------------------
            // Variant
            //-------------------------------------------------------------------------------------
            
            // #pragma shader_feature_local _DOUBLESIDED_ON - We have no lighting, so no need to have this combination for shader, the option will just disable backface culling
        
            // Keyword for transparent
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
        
            #define _ENABLE_FOG_ON_TRANSPARENT 1
        
            //enable GPU instancing support
            #pragma multi_compile_instancing
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            #pragma vertex Vert
            #pragma fragment Frag
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
                #define REQUIRE_DEPTH_TEXTURE
                // ACTIVE FIELDS:
                //   AlphaFog
                //   SurfaceDescriptionInputs.ScreenPosition
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.WorldSpaceViewDirection
                //   SurfaceDescriptionInputs.WorldSpacePosition
                //   SurfaceDescriptionInputs.TimeParameters
                //   SurfaceDescription.Color
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   SurfaceDescription.Emission
                //   features.modifyMesh
                //   AttributesMesh.normalOS
                //   AttributesMesh.tangentOS
                //   AttributesMesh.uv0
                //   AttributesMesh.uv1
                //   AttributesMesh.color
                //   AttributesMesh.uv2
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   AttributesMesh.positionOS
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            // #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        // Generated Type: AttributesMesh
        struct AttributesMesh {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL; // optional
            float4 tangentOS : TANGENT; // optional
            float4 uv0 : TEXCOORD0; // optional
            float4 uv1 : TEXCOORD1; // optional
            float4 uv2 : TEXCOORD2; // optional
            float4 color : COLOR; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        
        // Generated Type: VaryingsMeshToPS
        struct VaryingsMeshToPS {
            float4 positionCS : SV_Position;
            float3 positionRWS; // optional
            float3 normalWS; // optional
            float4 tangentWS; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        struct PackedVaryingsMeshToPS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            float4 interp02 : TEXCOORD2; // auto-packed
            float4 positionCS : SV_Position; // unpacked
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            output.interp02.xyzw = input.tangentWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            output.tangentWS = input.interp02.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        
        // Generated Type: VaryingsMeshToDS
        struct VaryingsMeshToDS {
            float3 positionRWS;
            float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        struct PackedVaryingsMeshToDS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
        {
            PackedVaryingsMeshToDS output;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
        {
            VaryingsMeshToDS output;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float4 Vector4_65EABAB;
                    float Vector1_50818A11;
                    float Vector1_61C806C0;
                    float Vector1_30AAF593;
                    float4 Vector4_4751FA07;
                    float4 Color_3E180C9C;
                    float4 Color_8449C32A;
                    float Vector1_620DD99;
                    float Vector1_D70DF092;
                    float Vector1_450B7EF3;
                    float Vector1_DF4C36BA;
                    float Vector1_B4B00342;
                    float Vector1_A0B72FA1;
                    float Vector1_FD5A3D43;
                    float Vector1_3BD37C41;
                    float Vector1_561AAF3;
                    float Vector1_677CA6D3;
                    float Vector1_7E803735;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _AlphaCutoff;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    CBUFFER_END
                
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs {
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs {
                        float3 WorldSpaceNormal; // optional
                        float3 WorldSpaceViewDirection; // optional
                        float3 WorldSpacePosition; // optional
                        float4 ScreenPosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Color;
                        float Alpha;
                        float AlphaClipThreshold;
                        float3 Emission;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
                    {
                        Rotation = radians(Rotation);
                
                        float s = sin(Rotation);
                        float c = cos(Rotation);
                        float one_minus_c = 1.0 - c;
                        
                        Axis = normalize(Axis);
                
                        float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                                  one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                                  one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                                };
                
                        Out = mul(rot_mat,  In);
                    }
                
                    void Unity_Multiply_float (float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
    float2 Unity_GradientNoise_Dir_float(float2 p)
    {
        // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
        p = p % 289;
        float x = (34 * p.x + 1) * p.x % 289 + p.y;
        x = (34 * x + 1) * x % 289;
        x = frac(x / 41) * 2 - 1;
        return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
    }

                    void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                    { 
                        float2 p = UV * Scale;
                        float2 ip = floor(p);
                        float2 fp = frac(p);
                        float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                        float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                        float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                        float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                        fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                        Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                    }
                
                    void Unity_Add_float(float A, float B, out float Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                    {
                        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
                    {
                        Out = smoothstep(Edge1, Edge2, In);
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
                    {
                        Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
                    }
                
                    void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
                    {
                        Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                    }
                
                    void Unity_Subtract_float(float A, float B, out float Out)
                    {
                        Out = A - B;
                    }
                
                    void Unity_Multiply_float (float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_AC8231BD_Out_0 = Color_3E180C9C;
                        float4 _Property_7EA371_Out_0 = Color_8449C32A;
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float4 _Lerp_20BA14D_Out_3;
                        Unity_Lerp_float4(_Property_AC8231BD_Out_0, _Property_7EA371_Out_0, (_Divide_9D8CF743_Out_2.xxxx), _Lerp_20BA14D_Out_3);
                        float _Property_F97B599C_Out_0 = Vector1_561AAF3;
                        float _FresnelEffect_BF67A096_Out_3;
                        Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_F97B599C_Out_0, _FresnelEffect_BF67A096_Out_3);
                        float _Multiply_E5CE35D3_Out_2;
                        Unity_Multiply_float(_Divide_9D8CF743_Out_2, _FresnelEffect_BF67A096_Out_3, _Multiply_E5CE35D3_Out_2);
                        float _Property_44C0C1B9_Out_0 = Vector1_677CA6D3;
                        float _Multiply_5AE6327A_Out_2;
                        Unity_Multiply_float(_Multiply_E5CE35D3_Out_2, _Property_44C0C1B9_Out_0, _Multiply_5AE6327A_Out_2);
                        float4 _Add_F7DC9567_Out_2;
                        Unity_Add_float4(_Lerp_20BA14D_Out_3, (_Multiply_5AE6327A_Out_2.xxxx), _Add_F7DC9567_Out_2);
                        float _SceneDepth_629DAEFE_Out_1;
                        Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_629DAEFE_Out_1);
                        float4 _ScreenPosition_A7683ECB_Out_0 = IN.ScreenPosition;
                        float _Split_5AA1CCB1_R_1 = _ScreenPosition_A7683ECB_Out_0[0];
                        float _Split_5AA1CCB1_G_2 = _ScreenPosition_A7683ECB_Out_0[1];
                        float _Split_5AA1CCB1_B_3 = _ScreenPosition_A7683ECB_Out_0[2];
                        float _Split_5AA1CCB1_A_4 = _ScreenPosition_A7683ECB_Out_0[3];
                        float _Subtract_93D2E4C0_Out_2;
                        Unity_Subtract_float(_Split_5AA1CCB1_A_4, 1, _Subtract_93D2E4C0_Out_2);
                        float _Subtract_26711984_Out_2;
                        Unity_Subtract_float(_SceneDepth_629DAEFE_Out_1, _Subtract_93D2E4C0_Out_2, _Subtract_26711984_Out_2);
                        float _Property_E6C99CE9_Out_0 = Vector1_7E803735;
                        float _Divide_5DC00D5A_Out_2;
                        Unity_Divide_float(_Subtract_26711984_Out_2, _Property_E6C99CE9_Out_0, _Divide_5DC00D5A_Out_2);
                        float _Saturate_3C064589_Out_1;
                        Unity_Saturate_float(_Divide_5DC00D5A_Out_2, _Saturate_3C064589_Out_1);
                        float _Property_D8E1DB68_Out_0 = Vector1_FD5A3D43;
                        float4 _Multiply_81AE3C9A_Out_2;
                        Unity_Multiply_float(_Add_F7DC9567_Out_2, (_Property_D8E1DB68_Out_0.xxxx), _Multiply_81AE3C9A_Out_2);
                        surface.Color = (_Add_F7DC9567_Out_2.xyz);
                        surface.Alpha = _Saturate_3C064589_Out_1;
                        surface.AlphaClipThreshold = 0.5;
                        surface.Emission = (_Multiply_81AE3C9A_Out_2.xyz);
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            // output.ObjectSpaceNormal =           input.normalOS;
            // output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
            // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
            // output.ObjectSpaceTangent =          input.tangentOS;
            // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
            // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
            // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
            // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
            // output.ObjectSpacePosition =         input.positionOS;
            // output.WorldSpacePosition =          GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
            // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
            // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
            // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
            // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
            // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
            // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
            // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
            // output.uv0 =                         input.uv0;
            // output.uv1 =                         input.uv1;
            // output.uv2 =                         input.uv2;
            // output.uv3 =                         input.uv3;
            // output.VertexColor =                 input.color;
        
            return output;
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
            // vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        
            // copy graph output to the results
            // input.positionOS = vertexDescription.Position;
        
            return input;
        }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
            FragInputs BuildFragInputs(VaryingsMeshToPS input)
            {
                FragInputs output;
                ZERO_INITIALIZE(FragInputs, output);
        
                // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                // to compute normals which are then passed on elsewhere to compute other values...
                output.tangentToWorld = k_identity3x3;
                output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
                output.positionRWS = input.positionRWS;
                output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                // output.texCoord0 = input.texCoord0;
                // output.texCoord1 = input.texCoord1;
                // output.texCoord2 = input.texCoord2;
                // output.texCoord3 = input.texCoord3;
                // output.color = input.color;
                #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #elif SHADER_STAGE_FRAGMENT
                // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #endif // SHADER_STAGE_FRAGMENT
        
                return output;
            }
        
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
                output.WorldSpaceNormal =            normalize(input.tangentToWorld[2].xyz);
                // output.ObjectSpaceNormal =           mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M);           // transposed multiplication by inverse matrix to handle normal scale
                // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.WorldSpaceViewDirection =     normalize(viewWS);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                output.WorldSpacePosition =          GetAbsolutePositionWS(input.positionRWS);
                // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                // output.uv0 =                         input.texCoord0;
                // output.uv1 =                         input.texCoord1;
                // output.uv2 =                         input.texCoord2;
                // output.uv3 =                         input.texCoord3;
                // output.VertexColor =                 input.color;
                // output.FaceSign =                    input.isFrontFace;
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        
                return output;
            }
        
            // existing HDRP code uses the combined function to go directly from packed to frag inputs
            FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
            {
                UNITY_SETUP_INSTANCE_ID(input);
                VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                return BuildFragInputs(unpacked);
            }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // copy across graph values, if defined
                surfaceData.color = surfaceDescription.Color;
        
        #if defined(DEBUG_DISPLAY)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO
                }
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                // DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
        
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                // Builtin Data
                ZERO_INITIALIZE(BuiltinData, builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #endif
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassLightTransport.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDUnlitPass.template
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite On
        
            ZClip [_ZClip]
        
            
            ColorMask 0
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            //-------------------------------------------------------------------------------------
            // Variant
            //-------------------------------------------------------------------------------------
            
            // #pragma shader_feature_local _DOUBLESIDED_ON - We have no lighting, so no need to have this combination for shader, the option will just disable backface culling
        
            // Keyword for transparent
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
        
            #define _ENABLE_FOG_ON_TRANSPARENT 1
        
            //enable GPU instancing support
            #pragma multi_compile_instancing
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            #pragma vertex Vert
            #pragma fragment Frag
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_SHADOWS
                #define REQUIRE_DEPTH_TEXTURE
                // ACTIVE FIELDS:
                //   AlphaFog
                //   SurfaceDescriptionInputs.ScreenPosition
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.WorldSpaceNormal
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.WorldSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   VertexDescription.Position
                //   SurfaceDescriptionInputs.WorldSpacePosition
                //   AttributesMesh.normalOS
                //   AttributesMesh.positionOS
                //   FragInputs.positionRWS
                //   VaryingsMeshToPS.positionRWS
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            // #define ATTRIBUTES_NEED_TANGENT
            // #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            // #define VARYINGS_NEED_TANGENT_TO_WORLD
            // #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        // Generated Type: AttributesMesh
        struct AttributesMesh {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        
        // Generated Type: VaryingsMeshToPS
        struct VaryingsMeshToPS {
            float4 positionCS : SV_Position;
            float3 positionRWS; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        struct PackedVaryingsMeshToPS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float4 positionCS : SV_Position; // unpacked
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.interp00.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.positionRWS = input.interp00.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        
        // Generated Type: VaryingsMeshToDS
        struct VaryingsMeshToDS {
            float3 positionRWS;
            float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        struct PackedVaryingsMeshToDS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
        {
            PackedVaryingsMeshToDS output;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
        {
            VaryingsMeshToDS output;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float4 Vector4_65EABAB;
                    float Vector1_50818A11;
                    float Vector1_61C806C0;
                    float Vector1_30AAF593;
                    float4 Vector4_4751FA07;
                    float4 Color_3E180C9C;
                    float4 Color_8449C32A;
                    float Vector1_620DD99;
                    float Vector1_D70DF092;
                    float Vector1_450B7EF3;
                    float Vector1_DF4C36BA;
                    float Vector1_B4B00342;
                    float Vector1_A0B72FA1;
                    float Vector1_FD5A3D43;
                    float Vector1_3BD37C41;
                    float Vector1_561AAF3;
                    float Vector1_677CA6D3;
                    float Vector1_7E803735;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _AlphaCutoff;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    CBUFFER_END
                
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs {
                        float3 ObjectSpaceNormal; // optional
                        float3 WorldSpaceNormal; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 WorldSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 Position;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs {
                        float3 WorldSpacePosition; // optional
                        float4 ScreenPosition; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
                    {
                        Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                    }
                
                    void Unity_Subtract_float(float A, float B, out float Out)
                    {
                        Out = A - B;
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_Distance_float3(float3 A, float3 B, out float Out)
                    {
                        Out = distance(A, B);
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Multiply_float (float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
                    {
                        Rotation = radians(Rotation);
                
                        float s = sin(Rotation);
                        float c = cos(Rotation);
                        float one_minus_c = 1.0 - c;
                        
                        Axis = normalize(Axis);
                
                        float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                                  one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                                  one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                                };
                
                        Out = mul(rot_mat,  In);
                    }
                
                    void Unity_Multiply_float (float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
    float2 Unity_GradientNoise_Dir_float(float2 p)
    {
        // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
        p = p % 289;
        float x = (34 * p.x + 1) * p.x % 289 + p.y;
        x = (34 * x + 1) * x % 289;
        x = frac(x / 41) * 2 - 1;
        return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
    }

                    void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                    { 
                        float2 p = UV * Scale;
                        float2 ip = floor(p);
                        float2 fp = frac(p);
                        float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                        float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                        float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                        float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                        fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                        Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                    }
                
                    void Unity_Add_float(float A, float B, out float Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                    {
                        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
                    {
                        Out = smoothstep(Edge1, Edge2, In);
                    }
                
                    void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                    {
                        Out = A + B;
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        float _Distance_62611F65_Out_2;
                        Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_62611F65_Out_2);
                        float _Property_631B91DC_Out_0 = Vector1_3BD37C41;
                        float _Divide_2A62E038_Out_2;
                        Unity_Divide_float(_Distance_62611F65_Out_2, _Property_631B91DC_Out_0, _Divide_2A62E038_Out_2);
                        float _Power_C69EF6B2_Out_2;
                        Unity_Power_float(_Divide_2A62E038_Out_2, 3, _Power_C69EF6B2_Out_2);
                        float3 _Multiply_70EE69E2_Out_2;
                        Unity_Multiply_float(IN.WorldSpaceNormal, (_Power_C69EF6B2_Out_2.xxx), _Multiply_70EE69E2_Out_2);
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float3 _Multiply_FC816DFD_Out_2;
                        Unity_Multiply_float(IN.ObjectSpaceNormal, (_Divide_9D8CF743_Out_2.xxx), _Multiply_FC816DFD_Out_2);
                        float _Property_5637D767_Out_0 = Vector1_30AAF593;
                        float3 _Multiply_2C756F8_Out_2;
                        Unity_Multiply_float(_Multiply_FC816DFD_Out_2, (_Property_5637D767_Out_0.xxx), _Multiply_2C756F8_Out_2);
                        float3 _Add_E3FAE77D_Out_2;
                        Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_2C756F8_Out_2, _Add_E3FAE77D_Out_2);
                        float3 _Add_785CBEC2_Out_2;
                        Unity_Add_float3(_Multiply_70EE69E2_Out_2, _Add_E3FAE77D_Out_2, _Add_785CBEC2_Out_2);
                        description.Position = _Add_785CBEC2_Out_2;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float _SceneDepth_629DAEFE_Out_1;
                        Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_629DAEFE_Out_1);
                        float4 _ScreenPosition_A7683ECB_Out_0 = IN.ScreenPosition;
                        float _Split_5AA1CCB1_R_1 = _ScreenPosition_A7683ECB_Out_0[0];
                        float _Split_5AA1CCB1_G_2 = _ScreenPosition_A7683ECB_Out_0[1];
                        float _Split_5AA1CCB1_B_3 = _ScreenPosition_A7683ECB_Out_0[2];
                        float _Split_5AA1CCB1_A_4 = _ScreenPosition_A7683ECB_Out_0[3];
                        float _Subtract_93D2E4C0_Out_2;
                        Unity_Subtract_float(_Split_5AA1CCB1_A_4, 1, _Subtract_93D2E4C0_Out_2);
                        float _Subtract_26711984_Out_2;
                        Unity_Subtract_float(_SceneDepth_629DAEFE_Out_1, _Subtract_93D2E4C0_Out_2, _Subtract_26711984_Out_2);
                        float _Property_E6C99CE9_Out_0 = Vector1_7E803735;
                        float _Divide_5DC00D5A_Out_2;
                        Unity_Divide_float(_Subtract_26711984_Out_2, _Property_E6C99CE9_Out_0, _Divide_5DC00D5A_Out_2);
                        float _Saturate_3C064589_Out_1;
                        Unity_Saturate_float(_Divide_5DC00D5A_Out_2, _Saturate_3C064589_Out_1);
                        surface.Alpha = _Saturate_3C064589_Out_1;
                        surface.AlphaClipThreshold = 0.5;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
            // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
            // output.ObjectSpaceTangent =          input.tangentOS;
            // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
            // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
            // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
            // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
            output.ObjectSpacePosition =         input.positionOS;
            output.WorldSpacePosition =          GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
            // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
            // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
            // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
            // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
            // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
            // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
            // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
            // output.uv0 =                         input.uv0;
            // output.uv1 =                         input.uv1;
            // output.uv2 =                         input.uv2;
            // output.uv3 =                         input.uv3;
            // output.VertexColor =                 input.color;
        
            return output;
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
        
            return input;
        }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
            FragInputs BuildFragInputs(VaryingsMeshToPS input)
            {
                FragInputs output;
                ZERO_INITIALIZE(FragInputs, output);
        
                // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                // to compute normals which are then passed on elsewhere to compute other values...
                output.tangentToWorld = k_identity3x3;
                output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
                output.positionRWS = input.positionRWS;
                // output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                // output.texCoord0 = input.texCoord0;
                // output.texCoord1 = input.texCoord1;
                // output.texCoord2 = input.texCoord2;
                // output.texCoord3 = input.texCoord3;
                // output.color = input.color;
                #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #elif SHADER_STAGE_FRAGMENT
                // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #endif // SHADER_STAGE_FRAGMENT
        
                return output;
            }
        
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
                // output.WorldSpaceNormal =            normalize(input.tangentToWorld[2].xyz);
                // output.ObjectSpaceNormal =           mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M);           // transposed multiplication by inverse matrix to handle normal scale
                // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                // output.WorldSpaceViewDirection =     normalize(viewWS);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                output.WorldSpacePosition =          GetAbsolutePositionWS(input.positionRWS);
                // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                // output.uv0 =                         input.texCoord0;
                // output.uv1 =                         input.texCoord1;
                // output.uv2 =                         input.texCoord2;
                // output.uv3 =                         input.texCoord3;
                // output.VertexColor =                 input.color;
                // output.FaceSign =                    input.isFrontFace;
                // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        
                return output;
            }
        
            // existing HDRP code uses the combined function to go directly from packed to frag inputs
            FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
            {
                UNITY_SETUP_INSTANCE_ID(input);
                VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                return BuildFragInputs(unpacked);
            }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // copy across graph values, if defined
                // surfaceData.color = surfaceDescription.Color;
        
        #if defined(DEBUG_DISPLAY)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO
                }
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                // DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
        
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                // Builtin Data
                ZERO_INITIALIZE(BuiltinData, builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #endif
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDUnlitPass.template
            Name "SceneSelectionPass"
            Tags { "LightMode" = "SceneSelectionPass" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite Off
        
            
            
            ColorMask 0
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            //-------------------------------------------------------------------------------------
            // Variant
            //-------------------------------------------------------------------------------------
            
            // #pragma shader_feature_local _DOUBLESIDED_ON - We have no lighting, so no need to have this combination for shader, the option will just disable backface culling
        
            // Keyword for transparent
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
        
            #define _ENABLE_FOG_ON_TRANSPARENT 1
        
            //enable GPU instancing support
            #pragma multi_compile_instancing
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            #pragma vertex Vert
            #pragma fragment Frag
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_DEPTH_ONLY
                #define SCENESELECTIONPASS
                #pragma editor_sync_compilation
                #define REQUIRE_DEPTH_TEXTURE
                // ACTIVE FIELDS:
                //   AlphaFog
                //   SurfaceDescriptionInputs.ScreenPosition
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.WorldSpaceNormal
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.WorldSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   VertexDescription.Position
                //   SurfaceDescriptionInputs.WorldSpacePosition
                //   AttributesMesh.normalOS
                //   AttributesMesh.positionOS
                //   FragInputs.positionRWS
                //   VaryingsMeshToPS.positionRWS
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            // #define ATTRIBUTES_NEED_TANGENT
            // #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            // #define VARYINGS_NEED_TANGENT_TO_WORLD
            // #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        // Generated Type: AttributesMesh
        struct AttributesMesh {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        
        // Generated Type: VaryingsMeshToPS
        struct VaryingsMeshToPS {
            float4 positionCS : SV_Position;
            float3 positionRWS; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        struct PackedVaryingsMeshToPS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float4 positionCS : SV_Position; // unpacked
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.interp00.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.positionRWS = input.interp00.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        
        // Generated Type: VaryingsMeshToDS
        struct VaryingsMeshToDS {
            float3 positionRWS;
            float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        struct PackedVaryingsMeshToDS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
        {
            PackedVaryingsMeshToDS output;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
        {
            VaryingsMeshToDS output;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float4 Vector4_65EABAB;
                    float Vector1_50818A11;
                    float Vector1_61C806C0;
                    float Vector1_30AAF593;
                    float4 Vector4_4751FA07;
                    float4 Color_3E180C9C;
                    float4 Color_8449C32A;
                    float Vector1_620DD99;
                    float Vector1_D70DF092;
                    float Vector1_450B7EF3;
                    float Vector1_DF4C36BA;
                    float Vector1_B4B00342;
                    float Vector1_A0B72FA1;
                    float Vector1_FD5A3D43;
                    float Vector1_3BD37C41;
                    float Vector1_561AAF3;
                    float Vector1_677CA6D3;
                    float Vector1_7E803735;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _AlphaCutoff;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    CBUFFER_END
                
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs {
                        float3 ObjectSpaceNormal; // optional
                        float3 WorldSpaceNormal; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 WorldSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 Position;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs {
                        float3 WorldSpacePosition; // optional
                        float4 ScreenPosition; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
                    {
                        Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                    }
                
                    void Unity_Subtract_float(float A, float B, out float Out)
                    {
                        Out = A - B;
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_Distance_float3(float3 A, float3 B, out float Out)
                    {
                        Out = distance(A, B);
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Multiply_float (float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
                    {
                        Rotation = radians(Rotation);
                
                        float s = sin(Rotation);
                        float c = cos(Rotation);
                        float one_minus_c = 1.0 - c;
                        
                        Axis = normalize(Axis);
                
                        float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                                  one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                                  one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                                };
                
                        Out = mul(rot_mat,  In);
                    }
                
                    void Unity_Multiply_float (float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
    float2 Unity_GradientNoise_Dir_float(float2 p)
    {
        // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
        p = p % 289;
        float x = (34 * p.x + 1) * p.x % 289 + p.y;
        x = (34 * x + 1) * x % 289;
        x = frac(x / 41) * 2 - 1;
        return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
    }

                    void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                    { 
                        float2 p = UV * Scale;
                        float2 ip = floor(p);
                        float2 fp = frac(p);
                        float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                        float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                        float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                        float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                        fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                        Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                    }
                
                    void Unity_Add_float(float A, float B, out float Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                    {
                        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
                    {
                        Out = smoothstep(Edge1, Edge2, In);
                    }
                
                    void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                    {
                        Out = A + B;
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        float _Distance_62611F65_Out_2;
                        Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_62611F65_Out_2);
                        float _Property_631B91DC_Out_0 = Vector1_3BD37C41;
                        float _Divide_2A62E038_Out_2;
                        Unity_Divide_float(_Distance_62611F65_Out_2, _Property_631B91DC_Out_0, _Divide_2A62E038_Out_2);
                        float _Power_C69EF6B2_Out_2;
                        Unity_Power_float(_Divide_2A62E038_Out_2, 3, _Power_C69EF6B2_Out_2);
                        float3 _Multiply_70EE69E2_Out_2;
                        Unity_Multiply_float(IN.WorldSpaceNormal, (_Power_C69EF6B2_Out_2.xxx), _Multiply_70EE69E2_Out_2);
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float3 _Multiply_FC816DFD_Out_2;
                        Unity_Multiply_float(IN.ObjectSpaceNormal, (_Divide_9D8CF743_Out_2.xxx), _Multiply_FC816DFD_Out_2);
                        float _Property_5637D767_Out_0 = Vector1_30AAF593;
                        float3 _Multiply_2C756F8_Out_2;
                        Unity_Multiply_float(_Multiply_FC816DFD_Out_2, (_Property_5637D767_Out_0.xxx), _Multiply_2C756F8_Out_2);
                        float3 _Add_E3FAE77D_Out_2;
                        Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_2C756F8_Out_2, _Add_E3FAE77D_Out_2);
                        float3 _Add_785CBEC2_Out_2;
                        Unity_Add_float3(_Multiply_70EE69E2_Out_2, _Add_E3FAE77D_Out_2, _Add_785CBEC2_Out_2);
                        description.Position = _Add_785CBEC2_Out_2;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float _SceneDepth_629DAEFE_Out_1;
                        Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_629DAEFE_Out_1);
                        float4 _ScreenPosition_A7683ECB_Out_0 = IN.ScreenPosition;
                        float _Split_5AA1CCB1_R_1 = _ScreenPosition_A7683ECB_Out_0[0];
                        float _Split_5AA1CCB1_G_2 = _ScreenPosition_A7683ECB_Out_0[1];
                        float _Split_5AA1CCB1_B_3 = _ScreenPosition_A7683ECB_Out_0[2];
                        float _Split_5AA1CCB1_A_4 = _ScreenPosition_A7683ECB_Out_0[3];
                        float _Subtract_93D2E4C0_Out_2;
                        Unity_Subtract_float(_Split_5AA1CCB1_A_4, 1, _Subtract_93D2E4C0_Out_2);
                        float _Subtract_26711984_Out_2;
                        Unity_Subtract_float(_SceneDepth_629DAEFE_Out_1, _Subtract_93D2E4C0_Out_2, _Subtract_26711984_Out_2);
                        float _Property_E6C99CE9_Out_0 = Vector1_7E803735;
                        float _Divide_5DC00D5A_Out_2;
                        Unity_Divide_float(_Subtract_26711984_Out_2, _Property_E6C99CE9_Out_0, _Divide_5DC00D5A_Out_2);
                        float _Saturate_3C064589_Out_1;
                        Unity_Saturate_float(_Divide_5DC00D5A_Out_2, _Saturate_3C064589_Out_1);
                        surface.Alpha = _Saturate_3C064589_Out_1;
                        surface.AlphaClipThreshold = 0.5;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
            // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
            // output.ObjectSpaceTangent =          input.tangentOS;
            // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
            // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
            // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
            // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
            output.ObjectSpacePosition =         input.positionOS;
            output.WorldSpacePosition =          GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
            // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
            // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
            // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
            // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
            // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
            // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
            // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
            // output.uv0 =                         input.uv0;
            // output.uv1 =                         input.uv1;
            // output.uv2 =                         input.uv2;
            // output.uv3 =                         input.uv3;
            // output.VertexColor =                 input.color;
        
            return output;
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
        
            return input;
        }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
            FragInputs BuildFragInputs(VaryingsMeshToPS input)
            {
                FragInputs output;
                ZERO_INITIALIZE(FragInputs, output);
        
                // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                // to compute normals which are then passed on elsewhere to compute other values...
                output.tangentToWorld = k_identity3x3;
                output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
                output.positionRWS = input.positionRWS;
                // output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                // output.texCoord0 = input.texCoord0;
                // output.texCoord1 = input.texCoord1;
                // output.texCoord2 = input.texCoord2;
                // output.texCoord3 = input.texCoord3;
                // output.color = input.color;
                #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #elif SHADER_STAGE_FRAGMENT
                // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #endif // SHADER_STAGE_FRAGMENT
        
                return output;
            }
        
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
                // output.WorldSpaceNormal =            normalize(input.tangentToWorld[2].xyz);
                // output.ObjectSpaceNormal =           mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M);           // transposed multiplication by inverse matrix to handle normal scale
                // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                // output.WorldSpaceViewDirection =     normalize(viewWS);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                output.WorldSpacePosition =          GetAbsolutePositionWS(input.positionRWS);
                // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                // output.uv0 =                         input.texCoord0;
                // output.uv1 =                         input.texCoord1;
                // output.uv2 =                         input.texCoord2;
                // output.uv3 =                         input.texCoord3;
                // output.VertexColor =                 input.color;
                // output.FaceSign =                    input.isFrontFace;
                // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        
                return output;
            }
        
            // existing HDRP code uses the combined function to go directly from packed to frag inputs
            FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
            {
                UNITY_SETUP_INSTANCE_ID(input);
                VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                return BuildFragInputs(unpacked);
            }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // copy across graph values, if defined
                // surfaceData.color = surfaceDescription.Color;
        
        #if defined(DEBUG_DISPLAY)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO
                }
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                // DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
        
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                // Builtin Data
                ZERO_INITIALIZE(BuiltinData, builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #endif
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDUnlitPass.template
            Name "DepthForwardOnly"
            Tags { "LightMode" = "DepthForwardOnly" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite On
        
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMaskDepth]
           Ref [_StencilRefDepth]
           Comp Always
           Pass Replace
        }
        
            ColorMask 0 0
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            //-------------------------------------------------------------------------------------
            // Variant
            //-------------------------------------------------------------------------------------
            
            // #pragma shader_feature_local _DOUBLESIDED_ON - We have no lighting, so no need to have this combination for shader, the option will just disable backface culling
        
            // Keyword for transparent
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
        
            #define _ENABLE_FOG_ON_TRANSPARENT 1
        
            //enable GPU instancing support
            #pragma multi_compile_instancing
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            #pragma vertex Vert
            #pragma fragment Frag
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_DEPTH_ONLY
                #pragma multi_compile _ WRITE_MSAA_DEPTH
                #define REQUIRE_DEPTH_TEXTURE
                // ACTIVE FIELDS:
                //   AlphaFog
                //   SurfaceDescriptionInputs.ScreenPosition
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.WorldSpaceNormal
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.WorldSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   VertexDescription.Position
                //   SurfaceDescriptionInputs.WorldSpacePosition
                //   AttributesMesh.normalOS
                //   AttributesMesh.positionOS
                //   FragInputs.positionRWS
                //   VaryingsMeshToPS.positionRWS
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            // #define ATTRIBUTES_NEED_TANGENT
            // #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            // #define VARYINGS_NEED_TANGENT_TO_WORLD
            // #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        // Generated Type: AttributesMesh
        struct AttributesMesh {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        
        // Generated Type: VaryingsMeshToPS
        struct VaryingsMeshToPS {
            float4 positionCS : SV_Position;
            float3 positionRWS; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        struct PackedVaryingsMeshToPS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float4 positionCS : SV_Position; // unpacked
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.interp00.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.positionRWS = input.interp00.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        
        // Generated Type: VaryingsMeshToDS
        struct VaryingsMeshToDS {
            float3 positionRWS;
            float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        struct PackedVaryingsMeshToDS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
        {
            PackedVaryingsMeshToDS output;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
        {
            VaryingsMeshToDS output;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float4 Vector4_65EABAB;
                    float Vector1_50818A11;
                    float Vector1_61C806C0;
                    float Vector1_30AAF593;
                    float4 Vector4_4751FA07;
                    float4 Color_3E180C9C;
                    float4 Color_8449C32A;
                    float Vector1_620DD99;
                    float Vector1_D70DF092;
                    float Vector1_450B7EF3;
                    float Vector1_DF4C36BA;
                    float Vector1_B4B00342;
                    float Vector1_A0B72FA1;
                    float Vector1_FD5A3D43;
                    float Vector1_3BD37C41;
                    float Vector1_561AAF3;
                    float Vector1_677CA6D3;
                    float Vector1_7E803735;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _AlphaCutoff;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    CBUFFER_END
                
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs {
                        float3 ObjectSpaceNormal; // optional
                        float3 WorldSpaceNormal; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 WorldSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 Position;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs {
                        float3 WorldSpacePosition; // optional
                        float4 ScreenPosition; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
                    {
                        Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                    }
                
                    void Unity_Subtract_float(float A, float B, out float Out)
                    {
                        Out = A - B;
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_Distance_float3(float3 A, float3 B, out float Out)
                    {
                        Out = distance(A, B);
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Multiply_float (float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
                    {
                        Rotation = radians(Rotation);
                
                        float s = sin(Rotation);
                        float c = cos(Rotation);
                        float one_minus_c = 1.0 - c;
                        
                        Axis = normalize(Axis);
                
                        float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                                  one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                                  one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                                };
                
                        Out = mul(rot_mat,  In);
                    }
                
                    void Unity_Multiply_float (float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
    float2 Unity_GradientNoise_Dir_float(float2 p)
    {
        // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
        p = p % 289;
        float x = (34 * p.x + 1) * p.x % 289 + p.y;
        x = (34 * x + 1) * x % 289;
        x = frac(x / 41) * 2 - 1;
        return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
    }

                    void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                    { 
                        float2 p = UV * Scale;
                        float2 ip = floor(p);
                        float2 fp = frac(p);
                        float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                        float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                        float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                        float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                        fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                        Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                    }
                
                    void Unity_Add_float(float A, float B, out float Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                    {
                        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
                    {
                        Out = smoothstep(Edge1, Edge2, In);
                    }
                
                    void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                    {
                        Out = A + B;
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        float _Distance_62611F65_Out_2;
                        Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_62611F65_Out_2);
                        float _Property_631B91DC_Out_0 = Vector1_3BD37C41;
                        float _Divide_2A62E038_Out_2;
                        Unity_Divide_float(_Distance_62611F65_Out_2, _Property_631B91DC_Out_0, _Divide_2A62E038_Out_2);
                        float _Power_C69EF6B2_Out_2;
                        Unity_Power_float(_Divide_2A62E038_Out_2, 3, _Power_C69EF6B2_Out_2);
                        float3 _Multiply_70EE69E2_Out_2;
                        Unity_Multiply_float(IN.WorldSpaceNormal, (_Power_C69EF6B2_Out_2.xxx), _Multiply_70EE69E2_Out_2);
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float3 _Multiply_FC816DFD_Out_2;
                        Unity_Multiply_float(IN.ObjectSpaceNormal, (_Divide_9D8CF743_Out_2.xxx), _Multiply_FC816DFD_Out_2);
                        float _Property_5637D767_Out_0 = Vector1_30AAF593;
                        float3 _Multiply_2C756F8_Out_2;
                        Unity_Multiply_float(_Multiply_FC816DFD_Out_2, (_Property_5637D767_Out_0.xxx), _Multiply_2C756F8_Out_2);
                        float3 _Add_E3FAE77D_Out_2;
                        Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_2C756F8_Out_2, _Add_E3FAE77D_Out_2);
                        float3 _Add_785CBEC2_Out_2;
                        Unity_Add_float3(_Multiply_70EE69E2_Out_2, _Add_E3FAE77D_Out_2, _Add_785CBEC2_Out_2);
                        description.Position = _Add_785CBEC2_Out_2;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float _SceneDepth_629DAEFE_Out_1;
                        Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_629DAEFE_Out_1);
                        float4 _ScreenPosition_A7683ECB_Out_0 = IN.ScreenPosition;
                        float _Split_5AA1CCB1_R_1 = _ScreenPosition_A7683ECB_Out_0[0];
                        float _Split_5AA1CCB1_G_2 = _ScreenPosition_A7683ECB_Out_0[1];
                        float _Split_5AA1CCB1_B_3 = _ScreenPosition_A7683ECB_Out_0[2];
                        float _Split_5AA1CCB1_A_4 = _ScreenPosition_A7683ECB_Out_0[3];
                        float _Subtract_93D2E4C0_Out_2;
                        Unity_Subtract_float(_Split_5AA1CCB1_A_4, 1, _Subtract_93D2E4C0_Out_2);
                        float _Subtract_26711984_Out_2;
                        Unity_Subtract_float(_SceneDepth_629DAEFE_Out_1, _Subtract_93D2E4C0_Out_2, _Subtract_26711984_Out_2);
                        float _Property_E6C99CE9_Out_0 = Vector1_7E803735;
                        float _Divide_5DC00D5A_Out_2;
                        Unity_Divide_float(_Subtract_26711984_Out_2, _Property_E6C99CE9_Out_0, _Divide_5DC00D5A_Out_2);
                        float _Saturate_3C064589_Out_1;
                        Unity_Saturate_float(_Divide_5DC00D5A_Out_2, _Saturate_3C064589_Out_1);
                        surface.Alpha = _Saturate_3C064589_Out_1;
                        surface.AlphaClipThreshold = 0.5;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
            // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
            // output.ObjectSpaceTangent =          input.tangentOS;
            // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
            // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
            // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
            // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
            output.ObjectSpacePosition =         input.positionOS;
            output.WorldSpacePosition =          GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
            // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
            // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
            // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
            // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
            // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
            // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
            // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
            // output.uv0 =                         input.uv0;
            // output.uv1 =                         input.uv1;
            // output.uv2 =                         input.uv2;
            // output.uv3 =                         input.uv3;
            // output.VertexColor =                 input.color;
        
            return output;
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
        
            return input;
        }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
            FragInputs BuildFragInputs(VaryingsMeshToPS input)
            {
                FragInputs output;
                ZERO_INITIALIZE(FragInputs, output);
        
                // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                // to compute normals which are then passed on elsewhere to compute other values...
                output.tangentToWorld = k_identity3x3;
                output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
                output.positionRWS = input.positionRWS;
                // output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                // output.texCoord0 = input.texCoord0;
                // output.texCoord1 = input.texCoord1;
                // output.texCoord2 = input.texCoord2;
                // output.texCoord3 = input.texCoord3;
                // output.color = input.color;
                #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #elif SHADER_STAGE_FRAGMENT
                // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #endif // SHADER_STAGE_FRAGMENT
        
                return output;
            }
        
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
                // output.WorldSpaceNormal =            normalize(input.tangentToWorld[2].xyz);
                // output.ObjectSpaceNormal =           mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M);           // transposed multiplication by inverse matrix to handle normal scale
                // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                // output.WorldSpaceViewDirection =     normalize(viewWS);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                output.WorldSpacePosition =          GetAbsolutePositionWS(input.positionRWS);
                // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                // output.uv0 =                         input.texCoord0;
                // output.uv1 =                         input.texCoord1;
                // output.uv2 =                         input.texCoord2;
                // output.uv3 =                         input.texCoord3;
                // output.VertexColor =                 input.color;
                // output.FaceSign =                    input.isFrontFace;
                // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        
                return output;
            }
        
            // existing HDRP code uses the combined function to go directly from packed to frag inputs
            FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
            {
                UNITY_SETUP_INSTANCE_ID(input);
                VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                return BuildFragInputs(unpacked);
            }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // copy across graph values, if defined
                // surfaceData.color = surfaceDescription.Color;
        
        #if defined(DEBUG_DISPLAY)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO
                }
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                // DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
        
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                // Builtin Data
                ZERO_INITIALIZE(BuiltinData, builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #endif
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDUnlitPass.template
            Name "MotionVectors"
            Tags { "LightMode" = "MotionVectors" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            
            Cull [_CullMode]
        
            
            ZWrite On
        
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMaskMV]
           Ref [_StencilRefMV]
           Comp Always
           Pass Replace
        }
        
            ColorMask 0 1
        
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            //-------------------------------------------------------------------------------------
            // Variant
            //-------------------------------------------------------------------------------------
            
            // #pragma shader_feature_local _DOUBLESIDED_ON - We have no lighting, so no need to have this combination for shader, the option will just disable backface culling
        
            // Keyword for transparent
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
        
            #define _ENABLE_FOG_ON_TRANSPARENT 1
        
            //enable GPU instancing support
            #pragma multi_compile_instancing
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            #pragma vertex Vert
            #pragma fragment Frag
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_MOTION_VECTORS
                #pragma multi_compile _ WRITE_MSAA_DEPTH
                #define REQUIRE_DEPTH_TEXTURE
                // ACTIVE FIELDS:
                //   AlphaFog
                //   SurfaceDescriptionInputs.ScreenPosition
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   features.modifyMesh
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.WorldSpaceNormal
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.WorldSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   VertexDescription.Position
                //   FragInputs.positionRWS
                //   SurfaceDescriptionInputs.WorldSpacePosition
                //   AttributesMesh.normalOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.positionRWS
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            // #define ATTRIBUTES_NEED_TANGENT
            // #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            // #define VARYINGS_NEED_TANGENT_TO_WORLD
            // #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        // Generated Type: AttributesMesh
        struct AttributesMesh {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        
        // Generated Type: VaryingsMeshToPS
        struct VaryingsMeshToPS {
            float4 positionCS : SV_Position;
            float3 positionRWS; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        struct PackedVaryingsMeshToPS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float4 positionCS : SV_Position; // unpacked
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.interp00.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.positionRWS = input.interp00.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        
        // Generated Type: VaryingsMeshToDS
        struct VaryingsMeshToDS {
            float3 positionRWS;
            float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        struct PackedVaryingsMeshToDS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
        {
            PackedVaryingsMeshToDS output;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
        {
            VaryingsMeshToDS output;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float4 Vector4_65EABAB;
                    float Vector1_50818A11;
                    float Vector1_61C806C0;
                    float Vector1_30AAF593;
                    float4 Vector4_4751FA07;
                    float4 Color_3E180C9C;
                    float4 Color_8449C32A;
                    float Vector1_620DD99;
                    float Vector1_D70DF092;
                    float Vector1_450B7EF3;
                    float Vector1_DF4C36BA;
                    float Vector1_B4B00342;
                    float Vector1_A0B72FA1;
                    float Vector1_FD5A3D43;
                    float Vector1_3BD37C41;
                    float Vector1_561AAF3;
                    float Vector1_677CA6D3;
                    float Vector1_7E803735;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _AlphaCutoff;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    CBUFFER_END
                
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs {
                        float3 ObjectSpaceNormal; // optional
                        float3 WorldSpaceNormal; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 WorldSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 Position;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs {
                        float3 WorldSpacePosition; // optional
                        float4 ScreenPosition; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float Alpha;
                        float AlphaClipThreshold;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
                    {
                        Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                    }
                
                    void Unity_Subtract_float(float A, float B, out float Out)
                    {
                        Out = A - B;
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_Distance_float3(float3 A, float3 B, out float Out)
                    {
                        Out = distance(A, B);
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Multiply_float (float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
                    {
                        Rotation = radians(Rotation);
                
                        float s = sin(Rotation);
                        float c = cos(Rotation);
                        float one_minus_c = 1.0 - c;
                        
                        Axis = normalize(Axis);
                
                        float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                                  one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                                  one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                                };
                
                        Out = mul(rot_mat,  In);
                    }
                
                    void Unity_Multiply_float (float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
    float2 Unity_GradientNoise_Dir_float(float2 p)
    {
        // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
        p = p % 289;
        float x = (34 * p.x + 1) * p.x % 289 + p.y;
        x = (34 * x + 1) * x % 289;
        x = frac(x / 41) * 2 - 1;
        return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
    }

                    void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                    { 
                        float2 p = UV * Scale;
                        float2 ip = floor(p);
                        float2 fp = frac(p);
                        float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                        float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                        float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                        float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                        fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                        Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                    }
                
                    void Unity_Add_float(float A, float B, out float Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                    {
                        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
                    {
                        Out = smoothstep(Edge1, Edge2, In);
                    }
                
                    void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                    {
                        Out = A + B;
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        float _Distance_62611F65_Out_2;
                        Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_62611F65_Out_2);
                        float _Property_631B91DC_Out_0 = Vector1_3BD37C41;
                        float _Divide_2A62E038_Out_2;
                        Unity_Divide_float(_Distance_62611F65_Out_2, _Property_631B91DC_Out_0, _Divide_2A62E038_Out_2);
                        float _Power_C69EF6B2_Out_2;
                        Unity_Power_float(_Divide_2A62E038_Out_2, 3, _Power_C69EF6B2_Out_2);
                        float3 _Multiply_70EE69E2_Out_2;
                        Unity_Multiply_float(IN.WorldSpaceNormal, (_Power_C69EF6B2_Out_2.xxx), _Multiply_70EE69E2_Out_2);
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float3 _Multiply_FC816DFD_Out_2;
                        Unity_Multiply_float(IN.ObjectSpaceNormal, (_Divide_9D8CF743_Out_2.xxx), _Multiply_FC816DFD_Out_2);
                        float _Property_5637D767_Out_0 = Vector1_30AAF593;
                        float3 _Multiply_2C756F8_Out_2;
                        Unity_Multiply_float(_Multiply_FC816DFD_Out_2, (_Property_5637D767_Out_0.xxx), _Multiply_2C756F8_Out_2);
                        float3 _Add_E3FAE77D_Out_2;
                        Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_2C756F8_Out_2, _Add_E3FAE77D_Out_2);
                        float3 _Add_785CBEC2_Out_2;
                        Unity_Add_float3(_Multiply_70EE69E2_Out_2, _Add_E3FAE77D_Out_2, _Add_785CBEC2_Out_2);
                        description.Position = _Add_785CBEC2_Out_2;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float _SceneDepth_629DAEFE_Out_1;
                        Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_629DAEFE_Out_1);
                        float4 _ScreenPosition_A7683ECB_Out_0 = IN.ScreenPosition;
                        float _Split_5AA1CCB1_R_1 = _ScreenPosition_A7683ECB_Out_0[0];
                        float _Split_5AA1CCB1_G_2 = _ScreenPosition_A7683ECB_Out_0[1];
                        float _Split_5AA1CCB1_B_3 = _ScreenPosition_A7683ECB_Out_0[2];
                        float _Split_5AA1CCB1_A_4 = _ScreenPosition_A7683ECB_Out_0[3];
                        float _Subtract_93D2E4C0_Out_2;
                        Unity_Subtract_float(_Split_5AA1CCB1_A_4, 1, _Subtract_93D2E4C0_Out_2);
                        float _Subtract_26711984_Out_2;
                        Unity_Subtract_float(_SceneDepth_629DAEFE_Out_1, _Subtract_93D2E4C0_Out_2, _Subtract_26711984_Out_2);
                        float _Property_E6C99CE9_Out_0 = Vector1_7E803735;
                        float _Divide_5DC00D5A_Out_2;
                        Unity_Divide_float(_Subtract_26711984_Out_2, _Property_E6C99CE9_Out_0, _Divide_5DC00D5A_Out_2);
                        float _Saturate_3C064589_Out_1;
                        Unity_Saturate_float(_Divide_5DC00D5A_Out_2, _Saturate_3C064589_Out_1);
                        surface.Alpha = _Saturate_3C064589_Out_1;
                        surface.AlphaClipThreshold = 0.5;
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
            // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
            // output.ObjectSpaceTangent =          input.tangentOS;
            // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
            // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
            // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
            // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
            output.ObjectSpacePosition =         input.positionOS;
            output.WorldSpacePosition =          GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
            // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
            // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
            // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
            // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
            // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
            // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
            // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
            // output.uv0 =                         input.uv0;
            // output.uv1 =                         input.uv1;
            // output.uv2 =                         input.uv2;
            // output.uv3 =                         input.uv3;
            // output.VertexColor =                 input.color;
        
            return output;
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
        
            return input;
        }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
            FragInputs BuildFragInputs(VaryingsMeshToPS input)
            {
                FragInputs output;
                ZERO_INITIALIZE(FragInputs, output);
        
                // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                // to compute normals which are then passed on elsewhere to compute other values...
                output.tangentToWorld = k_identity3x3;
                output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
                output.positionRWS = input.positionRWS;
                // output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                // output.texCoord0 = input.texCoord0;
                // output.texCoord1 = input.texCoord1;
                // output.texCoord2 = input.texCoord2;
                // output.texCoord3 = input.texCoord3;
                // output.color = input.color;
                #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #elif SHADER_STAGE_FRAGMENT
                // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #endif // SHADER_STAGE_FRAGMENT
        
                return output;
            }
        
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
                // output.WorldSpaceNormal =            normalize(input.tangentToWorld[2].xyz);
                // output.ObjectSpaceNormal =           mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M);           // transposed multiplication by inverse matrix to handle normal scale
                // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                // output.WorldSpaceViewDirection =     normalize(viewWS);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                output.WorldSpacePosition =          GetAbsolutePositionWS(input.positionRWS);
                // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                // output.uv0 =                         input.texCoord0;
                // output.uv1 =                         input.texCoord1;
                // output.uv2 =                         input.texCoord2;
                // output.uv3 =                         input.texCoord3;
                // output.VertexColor =                 input.color;
                // output.FaceSign =                    input.isFrontFace;
                // output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        
                return output;
            }
        
            // existing HDRP code uses the combined function to go directly from packed to frag inputs
            FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
            {
                UNITY_SETUP_INSTANCE_ID(input);
                VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                return BuildFragInputs(unpacked);
            }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // copy across graph values, if defined
                // surfaceData.color = surfaceDescription.Color;
        
        #if defined(DEBUG_DISPLAY)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO
                }
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                // DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
        
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                // Builtin Data
                ZERO_INITIALIZE(BuiltinData, builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                // builtinData.emissiveColor = surfaceDescription.Emission;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #endif
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassMotionVectors.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
        Pass
        {
            // based on HDUnlitPass.template
            Name "ForwardOnly"
            Tags { "LightMode" = "ForwardOnly" }
        
            //-------------------------------------------------------------------------------------
            // Render Modes (Blend, Cull, ZTest, Stencil, etc)
            //-------------------------------------------------------------------------------------
            Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
        
            Cull [_CullMode]
        
            ZTest [_ZTestTransparent]
        
            ZWrite [_ZWrite]
        
            
            // Stencil setup
        Stencil
        {
           WriteMask [_StencilWriteMask]
           Ref [_StencilRef]
           Comp Always
           Pass Replace
        }
        
            
            //-------------------------------------------------------------------------------------
            // End Render Modes
            //-------------------------------------------------------------------------------------
        
            HLSLPROGRAM
        
            #pragma target 4.5
            #pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
            //#pragma enable_d3d11_debug_symbols
        
            //-------------------------------------------------------------------------------------
            // Variant
            //-------------------------------------------------------------------------------------
            
            // #pragma shader_feature_local _DOUBLESIDED_ON - We have no lighting, so no need to have this combination for shader, the option will just disable backface culling
        
            // Keyword for transparent
            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
        
            #define _ENABLE_FOG_ON_TRANSPARENT 1
        
            //enable GPU instancing support
            #pragma multi_compile_instancing
        
            //-------------------------------------------------------------------------------------
            // End Variant Definitions
            //-------------------------------------------------------------------------------------
        
            #pragma vertex Vert
            #pragma fragment Frag
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            //-------------------------------------------------------------------------------------
            // Defines
            //-------------------------------------------------------------------------------------
                    #define SHADERPASS SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile _ DEBUG_DISPLAY
                #define REQUIRE_DEPTH_TEXTURE
                // ACTIVE FIELDS:
                //   AlphaFog
                //   SurfaceDescriptionInputs.ScreenPosition
                //   SurfaceDescriptionInputs.WorldSpaceNormal
                //   SurfaceDescriptionInputs.WorldSpaceViewDirection
                //   SurfaceDescriptionInputs.WorldSpacePosition
                //   SurfaceDescriptionInputs.TimeParameters
                //   SurfaceDescription.Color
                //   SurfaceDescription.Alpha
                //   SurfaceDescription.AlphaClipThreshold
                //   SurfaceDescription.Emission
                //   features.modifyMesh
                //   VertexDescriptionInputs.ObjectSpaceNormal
                //   VertexDescriptionInputs.WorldSpaceNormal
                //   VertexDescriptionInputs.ObjectSpacePosition
                //   VertexDescriptionInputs.WorldSpacePosition
                //   VertexDescriptionInputs.TimeParameters
                //   VertexDescription.Position
                //   FragInputs.tangentToWorld
                //   FragInputs.positionRWS
                //   AttributesMesh.normalOS
                //   AttributesMesh.positionOS
                //   VaryingsMeshToPS.tangentWS
                //   VaryingsMeshToPS.normalWS
                //   VaryingsMeshToPS.positionRWS
                //   AttributesMesh.tangentOS
        
            // this translates the new dependency tracker into the old preprocessor definitions for the existing HDRP shader code
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            // #define ATTRIBUTES_NEED_TEXCOORD0
            // #define ATTRIBUTES_NEED_TEXCOORD1
            // #define ATTRIBUTES_NEED_TEXCOORD2
            // #define ATTRIBUTES_NEED_TEXCOORD3
            // #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            // #define VARYINGS_NEED_TEXCOORD0
            // #define VARYINGS_NEED_TEXCOORD1
            // #define VARYINGS_NEED_TEXCOORD2
            // #define VARYINGS_NEED_TEXCOORD3
            // #define VARYINGS_NEED_COLOR
            // #define VARYINGS_NEED_CULLFACE
            #define HAVE_MESH_MODIFICATION
        
            //-------------------------------------------------------------------------------------
            // End Defines
            //-------------------------------------------------------------------------------------
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
            // Used by SceneSelectionPass
            int _ObjectId;
            int _PassValue;
        
            //-------------------------------------------------------------------------------------
            // Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        // Generated Type: AttributesMesh
        struct AttributesMesh {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL; // optional
            float4 tangentOS : TANGENT; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        
        // Generated Type: VaryingsMeshToPS
        struct VaryingsMeshToPS {
            float4 positionCS : SV_Position;
            float3 positionRWS; // optional
            float3 normalWS; // optional
            float4 tangentWS; // optional
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        struct PackedVaryingsMeshToPS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            float4 interp02 : TEXCOORD2; // auto-packed
            float4 positionCS : SV_Position; // unpacked
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC; // unpacked
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        };
        PackedVaryingsMeshToPS PackVaryingsMeshToPS(VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            output.interp02.xyzw = input.tangentWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            output.tangentWS = input.interp02.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif // defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            return output;
        }
        
        // Generated Type: VaryingsMeshToDS
        struct VaryingsMeshToDS {
            float3 positionRWS;
            float3 normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        struct PackedVaryingsMeshToDS {
            float3 interp00 : TEXCOORD0; // auto-packed
            float3 interp01 : TEXCOORD1; // auto-packed
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID; // unpacked
            #endif // UNITY_ANY_INSTANCING_ENABLED
        };
        PackedVaryingsMeshToDS PackVaryingsMeshToDS(VaryingsMeshToDS input)
        {
            PackedVaryingsMeshToDS output;
            output.interp00.xyz = input.positionRWS;
            output.interp01.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        VaryingsMeshToDS UnpackVaryingsMeshToDS(PackedVaryingsMeshToDS input)
        {
            VaryingsMeshToDS output;
            output.positionRWS = input.interp00.xyz;
            output.normalWS = input.interp01.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif // UNITY_ANY_INSTANCING_ENABLED
            return output;
        }
        
            //-------------------------------------------------------------------------------------
            // End Interpolator Packing And Struct Declarations
            //-------------------------------------------------------------------------------------
        
            //-------------------------------------------------------------------------------------
            // Graph generated code
            //-------------------------------------------------------------------------------------
                    // Shared Graph Properties (uniform inputs)
                    CBUFFER_START(UnityPerMaterial)
                    float4 Vector4_65EABAB;
                    float Vector1_50818A11;
                    float Vector1_61C806C0;
                    float Vector1_30AAF593;
                    float4 Vector4_4751FA07;
                    float4 Color_3E180C9C;
                    float4 Color_8449C32A;
                    float Vector1_620DD99;
                    float Vector1_D70DF092;
                    float Vector1_450B7EF3;
                    float Vector1_DF4C36BA;
                    float Vector1_B4B00342;
                    float Vector1_A0B72FA1;
                    float Vector1_FD5A3D43;
                    float Vector1_3BD37C41;
                    float Vector1_561AAF3;
                    float Vector1_677CA6D3;
                    float Vector1_7E803735;
                    float4 _EmissionColor;
                    float _RenderQueueType;
                    float _StencilRef;
                    float _StencilWriteMask;
                    float _StencilRefDepth;
                    float _StencilWriteMaskDepth;
                    float _StencilRefMV;
                    float _StencilWriteMaskMV;
                    float _StencilRefDistortionVec;
                    float _StencilWriteMaskDistortionVec;
                    float _StencilWriteMaskGBuffer;
                    float _StencilRefGBuffer;
                    float _ZTestGBuffer;
                    float _RequireSplitLighting;
                    float _ReceivesSSR;
                    float _SurfaceType;
                    float _BlendMode;
                    float _SrcBlend;
                    float _DstBlend;
                    float _AlphaSrcBlend;
                    float _AlphaDstBlend;
                    float _ZWrite;
                    float _CullMode;
                    float _TransparentSortPriority;
                    float _CullModeForward;
                    float _TransparentCullMode;
                    float _ZTestDepthEqualForOpaque;
                    float _ZTestTransparent;
                    float _TransparentBackfaceEnable;
                    float _AlphaCutoffEnable;
                    float _AlphaCutoff;
                    float _UseShadowThreshold;
                    float _DoubleSidedEnable;
                    float _DoubleSidedNormalMode;
                    float4 _DoubleSidedConstants;
                    CBUFFER_END
                
                
                // Vertex Graph Inputs
                    struct VertexDescriptionInputs {
                        float3 ObjectSpaceNormal; // optional
                        float3 WorldSpaceNormal; // optional
                        float3 ObjectSpacePosition; // optional
                        float3 WorldSpacePosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Vertex Graph Outputs
                    struct VertexDescription
                    {
                        float3 Position;
                    };
                    
                // Pixel Graph Inputs
                    struct SurfaceDescriptionInputs {
                        float3 WorldSpaceNormal; // optional
                        float3 WorldSpaceViewDirection; // optional
                        float3 WorldSpacePosition; // optional
                        float4 ScreenPosition; // optional
                        float3 TimeParameters; // optional
                    };
                // Pixel Graph Outputs
                    struct SurfaceDescription
                    {
                        float3 Color;
                        float Alpha;
                        float AlphaClipThreshold;
                        float3 Emission;
                    };
                    
                // Shared Graph Node Functions
                
                    void Unity_Rotate_About_Axis_Degrees_float(float3 In, float3 Axis, float Rotation, out float3 Out)
                    {
                        Rotation = radians(Rotation);
                
                        float s = sin(Rotation);
                        float c = cos(Rotation);
                        float one_minus_c = 1.0 - c;
                        
                        Axis = normalize(Axis);
                
                        float3x3 rot_mat = { one_minus_c * Axis.x * Axis.x + c,            one_minus_c * Axis.x * Axis.y - Axis.z * s,     one_minus_c * Axis.z * Axis.x + Axis.y * s,
                                                  one_minus_c * Axis.x * Axis.y + Axis.z * s,   one_minus_c * Axis.y * Axis.y + c,              one_minus_c * Axis.y * Axis.z - Axis.x * s,
                                                  one_minus_c * Axis.z * Axis.x - Axis.y * s,   one_minus_c * Axis.y * Axis.z + Axis.x * s,     one_minus_c * Axis.z * Axis.z + c
                                                };
                
                        Out = mul(rot_mat,  In);
                    }
                
                    void Unity_Multiply_float (float A, float B, out float Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
                    {
                        Out = UV * Tiling + Offset;
                    }
                
                
    float2 Unity_GradientNoise_Dir_float(float2 p)
    {
        // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
        p = p % 289;
        float x = (34 * p.x + 1) * p.x % 289 + p.y;
        x = (34 * x + 1) * x % 289;
        x = frac(x / 41) * 2 - 1;
        return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
    }

                    void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
                    { 
                        float2 p = UV * Scale;
                        float2 ip = floor(p);
                        float2 fp = frac(p);
                        float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
                        float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                        float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                        float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                        fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                        Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
                    }
                
                    void Unity_Add_float(float A, float B, out float Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_Divide_float(float A, float B, out float Out)
                    {
                        Out = A / B;
                    }
                
                    void Unity_Saturate_float(float In, out float Out)
                    {
                        Out = saturate(In);
                    }
                
                    void Unity_Power_float(float A, float B, out float Out)
                    {
                        Out = pow(A, B);
                    }
                
                    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
                    {
                        RGBA = float4(R, G, B, A);
                        RGB = float3(R, G, B);
                        RG = float2(R, G);
                    }
                
                    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
                    {
                        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
                    }
                
                    void Unity_Absolute_float(float In, out float Out)
                    {
                        Out = abs(In);
                    }
                
                    void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
                    {
                        Out = smoothstep(Edge1, Edge2, In);
                    }
                
                    void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
                    {
                        Out = lerp(A, B, T);
                    }
                
                    void Unity_FresnelEffect_float(float3 Normal, float3 ViewDir, float Power, out float Out)
                    {
                        Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
                    }
                
                    void Unity_Add_float4(float4 A, float4 B, out float4 Out)
                    {
                        Out = A + B;
                    }
                
                    void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
                    {
                        Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
                    }
                
                    void Unity_Subtract_float(float A, float B, out float Out)
                    {
                        Out = A - B;
                    }
                
                    void Unity_Multiply_float (float4 A, float4 B, out float4 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Distance_float3(float3 A, float3 B, out float Out)
                    {
                        Out = distance(A, B);
                    }
                
                    void Unity_Multiply_float (float3 A, float3 B, out float3 Out)
                    {
                        Out = A * B;
                    }
                
                    void Unity_Add_float3(float3 A, float3 B, out float3 Out)
                    {
                        Out = A + B;
                    }
                
                // Vertex Graph Evaluation
                    VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
                    {
                        VertexDescription description = (VertexDescription)0;
                        float _Distance_62611F65_Out_2;
                        Unity_Distance_float3(SHADERGRAPH_OBJECT_POSITION, IN.WorldSpacePosition, _Distance_62611F65_Out_2);
                        float _Property_631B91DC_Out_0 = Vector1_3BD37C41;
                        float _Divide_2A62E038_Out_2;
                        Unity_Divide_float(_Distance_62611F65_Out_2, _Property_631B91DC_Out_0, _Divide_2A62E038_Out_2);
                        float _Power_C69EF6B2_Out_2;
                        Unity_Power_float(_Divide_2A62E038_Out_2, 3, _Power_C69EF6B2_Out_2);
                        float3 _Multiply_70EE69E2_Out_2;
                        Unity_Multiply_float(IN.WorldSpaceNormal, (_Power_C69EF6B2_Out_2.xxx), _Multiply_70EE69E2_Out_2);
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float3 _Multiply_FC816DFD_Out_2;
                        Unity_Multiply_float(IN.ObjectSpaceNormal, (_Divide_9D8CF743_Out_2.xxx), _Multiply_FC816DFD_Out_2);
                        float _Property_5637D767_Out_0 = Vector1_30AAF593;
                        float3 _Multiply_2C756F8_Out_2;
                        Unity_Multiply_float(_Multiply_FC816DFD_Out_2, (_Property_5637D767_Out_0.xxx), _Multiply_2C756F8_Out_2);
                        float3 _Add_E3FAE77D_Out_2;
                        Unity_Add_float3(IN.ObjectSpacePosition, _Multiply_2C756F8_Out_2, _Add_E3FAE77D_Out_2);
                        float3 _Add_785CBEC2_Out_2;
                        Unity_Add_float3(_Multiply_70EE69E2_Out_2, _Add_E3FAE77D_Out_2, _Add_785CBEC2_Out_2);
                        description.Position = _Add_785CBEC2_Out_2;
                        return description;
                    }
                    
                // Pixel Graph Evaluation
                    SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
                    {
                        SurfaceDescription surface = (SurfaceDescription)0;
                        float4 _Property_AC8231BD_Out_0 = Color_3E180C9C;
                        float4 _Property_7EA371_Out_0 = Color_8449C32A;
                        float _Property_CD1D6938_Out_0 = Vector1_620DD99;
                        float _Property_2266DB0F_Out_0 = Vector1_D70DF092;
                        float4 _Property_D8583450_Out_0 = Vector4_65EABAB;
                        float _Split_DF6BC073_R_1 = _Property_D8583450_Out_0[0];
                        float _Split_DF6BC073_G_2 = _Property_D8583450_Out_0[1];
                        float _Split_DF6BC073_B_3 = _Property_D8583450_Out_0[2];
                        float _Split_DF6BC073_A_4 = _Property_D8583450_Out_0[3];
                        float3 _RotateAboutAxis_C5CECE17_Out_3;
                        Unity_Rotate_About_Axis_Degrees_float(IN.WorldSpacePosition, (_Property_D8583450_Out_0.xyz), _Split_DF6BC073_A_4, _RotateAboutAxis_C5CECE17_Out_3);
                        float _Property_BF4E1A07_Out_0 = Vector1_61C806C0;
                        float _Multiply_55AA2E5F_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_BF4E1A07_Out_0, _Multiply_55AA2E5F_Out_2);
                        float2 _TilingAndOffset_E3E63265_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_55AA2E5F_Out_2.xx), _TilingAndOffset_E3E63265_Out_3);
                        float _Property_E759DD72_Out_0 = Vector1_50818A11;
                        float _GradientNoise_D3421C27_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_E3E63265_Out_3, _Property_E759DD72_Out_0, _GradientNoise_D3421C27_Out_2);
                        float2 _TilingAndOffset_77D8C37_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), float2 (0, 0), _TilingAndOffset_77D8C37_Out_3);
                        float _GradientNoise_5A25E411_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_77D8C37_Out_3, _Property_E759DD72_Out_0, _GradientNoise_5A25E411_Out_2);
                        float _Add_8E75E48C_Out_2;
                        Unity_Add_float(_GradientNoise_D3421C27_Out_2, _GradientNoise_5A25E411_Out_2, _Add_8E75E48C_Out_2);
                        float _Divide_F28EE30A_Out_2;
                        Unity_Divide_float(_Add_8E75E48C_Out_2, 2, _Divide_F28EE30A_Out_2);
                        float _Saturate_140F4DFB_Out_1;
                        Unity_Saturate_float(_Divide_F28EE30A_Out_2, _Saturate_140F4DFB_Out_1);
                        float _Property_AE083FAD_Out_0 = Vector1_450B7EF3;
                        float _Power_C2E29107_Out_2;
                        Unity_Power_float(_Saturate_140F4DFB_Out_1, _Property_AE083FAD_Out_0, _Power_C2E29107_Out_2);
                        float4 _Property_B857653E_Out_0 = Vector4_4751FA07;
                        float _Split_A5B985E4_R_1 = _Property_B857653E_Out_0[0];
                        float _Split_A5B985E4_G_2 = _Property_B857653E_Out_0[1];
                        float _Split_A5B985E4_B_3 = _Property_B857653E_Out_0[2];
                        float _Split_A5B985E4_A_4 = _Property_B857653E_Out_0[3];
                        float4 _Combine_7379BC9D_RGBA_4;
                        float3 _Combine_7379BC9D_RGB_5;
                        float2 _Combine_7379BC9D_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_R_1, _Split_A5B985E4_G_2, 0, 0, _Combine_7379BC9D_RGBA_4, _Combine_7379BC9D_RGB_5, _Combine_7379BC9D_RG_6);
                        float4 _Combine_A123A7B1_RGBA_4;
                        float3 _Combine_A123A7B1_RGB_5;
                        float2 _Combine_A123A7B1_RG_6;
                        Unity_Combine_float(_Split_A5B985E4_B_3, _Split_A5B985E4_A_4, 0, 0, _Combine_A123A7B1_RGBA_4, _Combine_A123A7B1_RGB_5, _Combine_A123A7B1_RG_6);
                        float _Remap_B514C3BD_Out_3;
                        Unity_Remap_float(_Power_C2E29107_Out_2, _Combine_7379BC9D_RG_6, _Combine_A123A7B1_RG_6, _Remap_B514C3BD_Out_3);
                        float _Absolute_F2253A3A_Out_1;
                        Unity_Absolute_float(_Remap_B514C3BD_Out_3, _Absolute_F2253A3A_Out_1);
                        float _Smoothstep_E1517198_Out_3;
                        Unity_Smoothstep_float(_Property_CD1D6938_Out_0, _Property_2266DB0F_Out_0, _Absolute_F2253A3A_Out_1, _Smoothstep_E1517198_Out_3);
                        float _Property_DD10EAB1_Out_0 = Vector1_B4B00342;
                        float _Multiply_288BB761_Out_2;
                        Unity_Multiply_float(IN.TimeParameters.x, _Property_DD10EAB1_Out_0, _Multiply_288BB761_Out_2);
                        float2 _TilingAndOffset_72E3B0C6_Out_3;
                        Unity_TilingAndOffset_float((_RotateAboutAxis_C5CECE17_Out_3.xy), float2 (1, 1), (_Multiply_288BB761_Out_2.xx), _TilingAndOffset_72E3B0C6_Out_3);
                        float _Property_AFB7DCF2_Out_0 = Vector1_DF4C36BA;
                        float _GradientNoise_3E203DE_Out_2;
                        Unity_GradientNoise_float(_TilingAndOffset_72E3B0C6_Out_3, _Property_AFB7DCF2_Out_0, _GradientNoise_3E203DE_Out_2);
                        float _Property_A65F0D60_Out_0 = Vector1_A0B72FA1;
                        float _Multiply_7581D03A_Out_2;
                        Unity_Multiply_float(_GradientNoise_3E203DE_Out_2, _Property_A65F0D60_Out_0, _Multiply_7581D03A_Out_2);
                        float _Add_5A1E743_Out_2;
                        Unity_Add_float(_Smoothstep_E1517198_Out_3, _Multiply_7581D03A_Out_2, _Add_5A1E743_Out_2);
                        float _Add_809589DE_Out_2;
                        Unity_Add_float(1, _Property_A65F0D60_Out_0, _Add_809589DE_Out_2);
                        float _Divide_9D8CF743_Out_2;
                        Unity_Divide_float(_Add_5A1E743_Out_2, _Add_809589DE_Out_2, _Divide_9D8CF743_Out_2);
                        float4 _Lerp_20BA14D_Out_3;
                        Unity_Lerp_float4(_Property_AC8231BD_Out_0, _Property_7EA371_Out_0, (_Divide_9D8CF743_Out_2.xxxx), _Lerp_20BA14D_Out_3);
                        float _Property_F97B599C_Out_0 = Vector1_561AAF3;
                        float _FresnelEffect_BF67A096_Out_3;
                        Unity_FresnelEffect_float(IN.WorldSpaceNormal, IN.WorldSpaceViewDirection, _Property_F97B599C_Out_0, _FresnelEffect_BF67A096_Out_3);
                        float _Multiply_E5CE35D3_Out_2;
                        Unity_Multiply_float(_Divide_9D8CF743_Out_2, _FresnelEffect_BF67A096_Out_3, _Multiply_E5CE35D3_Out_2);
                        float _Property_44C0C1B9_Out_0 = Vector1_677CA6D3;
                        float _Multiply_5AE6327A_Out_2;
                        Unity_Multiply_float(_Multiply_E5CE35D3_Out_2, _Property_44C0C1B9_Out_0, _Multiply_5AE6327A_Out_2);
                        float4 _Add_F7DC9567_Out_2;
                        Unity_Add_float4(_Lerp_20BA14D_Out_3, (_Multiply_5AE6327A_Out_2.xxxx), _Add_F7DC9567_Out_2);
                        float _SceneDepth_629DAEFE_Out_1;
                        Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_629DAEFE_Out_1);
                        float4 _ScreenPosition_A7683ECB_Out_0 = IN.ScreenPosition;
                        float _Split_5AA1CCB1_R_1 = _ScreenPosition_A7683ECB_Out_0[0];
                        float _Split_5AA1CCB1_G_2 = _ScreenPosition_A7683ECB_Out_0[1];
                        float _Split_5AA1CCB1_B_3 = _ScreenPosition_A7683ECB_Out_0[2];
                        float _Split_5AA1CCB1_A_4 = _ScreenPosition_A7683ECB_Out_0[3];
                        float _Subtract_93D2E4C0_Out_2;
                        Unity_Subtract_float(_Split_5AA1CCB1_A_4, 1, _Subtract_93D2E4C0_Out_2);
                        float _Subtract_26711984_Out_2;
                        Unity_Subtract_float(_SceneDepth_629DAEFE_Out_1, _Subtract_93D2E4C0_Out_2, _Subtract_26711984_Out_2);
                        float _Property_E6C99CE9_Out_0 = Vector1_7E803735;
                        float _Divide_5DC00D5A_Out_2;
                        Unity_Divide_float(_Subtract_26711984_Out_2, _Property_E6C99CE9_Out_0, _Divide_5DC00D5A_Out_2);
                        float _Saturate_3C064589_Out_1;
                        Unity_Saturate_float(_Divide_5DC00D5A_Out_2, _Saturate_3C064589_Out_1);
                        float _Property_D8E1DB68_Out_0 = Vector1_FD5A3D43;
                        float4 _Multiply_81AE3C9A_Out_2;
                        Unity_Multiply_float(_Add_F7DC9567_Out_2, (_Property_D8E1DB68_Out_0.xxxx), _Multiply_81AE3C9A_Out_2);
                        surface.Color = (_Add_F7DC9567_Out_2.xyz);
                        surface.Alpha = _Saturate_3C064589_Out_1;
                        surface.AlphaClipThreshold = 0.5;
                        surface.Emission = (_Multiply_81AE3C9A_Out_2.xyz);
                        return surface;
                    }
                    
            //-------------------------------------------------------------------------------------
            // End graph generated code
            //-------------------------------------------------------------------------------------
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            // output.ViewSpaceNormal =             TransformWorldToViewDir(output.WorldSpaceNormal);
            // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
            // output.ObjectSpaceTangent =          input.tangentOS;
            // output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
            // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
            // output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            // output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
            // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
            output.ObjectSpacePosition =         input.positionOS;
            output.WorldSpacePosition =          GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS));
            // output.ViewSpacePosition =           TransformWorldToView(output.WorldSpacePosition);
            // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
            // output.WorldSpaceViewDirection =     GetWorldSpaceNormalizeViewDir(output.WorldSpacePosition);
            // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
            // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
            // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
            // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
            // output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(output.WorldSpacePosition), _ProjectionParams.x);
            // output.uv0 =                         input.uv0;
            // output.uv1 =                         input.uv1;
            // output.uv2 =                         input.uv2;
            // output.uv3 =                         input.uv3;
            // output.VertexColor =                 input.color;
        
            return output;
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time paramters with used one (This is required to correctly handle motion vector for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
        
            return input;
        }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : VertexAnimation.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
        
        //-------------------------------------------------------------------------------------
        // TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
            FragInputs BuildFragInputs(VaryingsMeshToPS input)
            {
                FragInputs output;
                ZERO_INITIALIZE(FragInputs, output);
        
                // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
                // TODO: this is a really poor workaround, but the variable is used in a bunch of places
                // to compute normals which are then passed on elsewhere to compute other values...
                output.tangentToWorld = k_identity3x3;
                output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
                output.positionRWS = input.positionRWS;
                output.tangentToWorld = BuildTangentToWorld(input.tangentWS, input.normalWS);
                // output.texCoord0 = input.texCoord0;
                // output.texCoord1 = input.texCoord1;
                // output.texCoord2 = input.texCoord2;
                // output.texCoord3 = input.texCoord3;
                // output.color = input.color;
                #if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
                output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #elif SHADER_STAGE_FRAGMENT
                // output.isFrontFace = IS_FRONT_VFACE(input.cullFace, true, false);
                #endif // SHADER_STAGE_FRAGMENT
        
                return output;
            }
        
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
                output.WorldSpaceNormal =            normalize(input.tangentToWorld[2].xyz);
                // output.ObjectSpaceNormal =           mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M);           // transposed multiplication by inverse matrix to handle normal scale
                // output.ViewSpaceNormal =             mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_I_V);         // transposed multiplication by inverse matrix to handle normal scale
                // output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
                // output.WorldSpaceTangent =           input.tangentToWorld[0].xyz;
                // output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
                // output.ViewSpaceTangent =            TransformWorldToViewDir(output.WorldSpaceTangent);
                // output.TangentSpaceTangent =         float3(1.0f, 0.0f, 0.0f);
                // output.WorldSpaceBiTangent =         input.tangentToWorld[1].xyz;
                // output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
                // output.ViewSpaceBiTangent =          TransformWorldToViewDir(output.WorldSpaceBiTangent);
                // output.TangentSpaceBiTangent =       float3(0.0f, 1.0f, 0.0f);
                output.WorldSpaceViewDirection =     normalize(viewWS);
                // output.ObjectSpaceViewDirection =    TransformWorldToObjectDir(output.WorldSpaceViewDirection);
                // output.ViewSpaceViewDirection =      TransformWorldToViewDir(output.WorldSpaceViewDirection);
                // float3x3 tangentSpaceTransform =     float3x3(output.WorldSpaceTangent,output.WorldSpaceBiTangent,output.WorldSpaceNormal);
                // output.TangentSpaceViewDirection =   mul(tangentSpaceTransform, output.WorldSpaceViewDirection);
                output.WorldSpacePosition =          GetAbsolutePositionWS(input.positionRWS);
                // output.ObjectSpacePosition =         TransformWorldToObject(input.positionRWS);
                // output.ViewSpacePosition =           TransformWorldToView(input.positionRWS);
                // output.TangentSpacePosition =        float3(0.0f, 0.0f, 0.0f);
                output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
                // output.uv0 =                         input.texCoord0;
                // output.uv1 =                         input.texCoord1;
                // output.uv2 =                         input.texCoord2;
                // output.uv3 =                         input.texCoord3;
                // output.VertexColor =                 input.color;
                // output.FaceSign =                    input.isFrontFace;
                output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        
                return output;
            }
        
            // existing HDRP code uses the combined function to go directly from packed to frag inputs
            FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
            {
                UNITY_SETUP_INSTANCE_ID(input);
                VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(input);
                return BuildFragInputs(unpacked);
            }
        
        //-------------------------------------------------------------------------------------
        // END TEMPLATE INCLUDE : SharedCode.template.hlsl
        //-------------------------------------------------------------------------------------
        
        
            void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
            {
                // setup defaults -- these are used if the graph doesn't output a value
                ZERO_INITIALIZE(SurfaceData, surfaceData);
        
                // copy across graph values, if defined
                surfaceData.color = surfaceDescription.Color;
        
        #if defined(DEBUG_DISPLAY)
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO
                }
        #endif
            }
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                // DoAlphaTest(surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold);
        
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                // Builtin Data
                ZERO_INITIALIZE(BuiltinData, builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
        #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
        #endif
            }
        
            //-------------------------------------------------------------------------------------
            // Pass Includes
            //-------------------------------------------------------------------------------------
                #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"
            //-------------------------------------------------------------------------------------
            // End Pass Includes
            //-------------------------------------------------------------------------------------
        
            ENDHLSL
        }
        
    }
    CustomEditor "UnityEditor.Experimental.Rendering.HDPipeline.HDUnlitGUI"
    FallBack "Hidden/InternalErrorShader"
}
