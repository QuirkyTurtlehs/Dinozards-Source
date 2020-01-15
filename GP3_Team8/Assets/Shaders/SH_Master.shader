// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Master"
{
	Properties
	{
		_Color0("Color 0", Color) = (0,0,0,0)
		_DinoStatue01_Texture_N("DinoStatue01_Texture_N", 2D) = "bump" {}
		_DinoStatue01_Texture_AT("DinoStatue01_Texture_A+T", 2D) = "white" {}
		_DinoStatue01_Texture_R("DinoStatue01_Texture_R", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _DinoStatue01_Texture_N;
		uniform float4 _DinoStatue01_Texture_N_ST;
		uniform float4 _Color0;
		uniform sampler2D _DinoStatue01_Texture_AT;
		uniform float4 _DinoStatue01_Texture_AT_ST;
		uniform sampler2D _DinoStatue01_Texture_R;
		uniform float4 _DinoStatue01_Texture_R_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_DinoStatue01_Texture_N = i.uv_texcoord * _DinoStatue01_Texture_N_ST.xy + _DinoStatue01_Texture_N_ST.zw;
			o.Normal = UnpackNormal( tex2D( _DinoStatue01_Texture_N, uv_DinoStatue01_Texture_N ) );
			float2 uv_DinoStatue01_Texture_AT = i.uv_texcoord * _DinoStatue01_Texture_AT_ST.xy + _DinoStatue01_Texture_AT_ST.zw;
			float4 tex2DNode15 = tex2D( _DinoStatue01_Texture_AT, uv_DinoStatue01_Texture_AT );
			o.Albedo = ( _Color0 * tex2DNode15 ).rgb;
			float2 uv_DinoStatue01_Texture_R = i.uv_texcoord * _DinoStatue01_Texture_R_ST.xy + _DinoStatue01_Texture_R_ST.zw;
			float4 tex2DNode17 = tex2D( _DinoStatue01_Texture_R, uv_DinoStatue01_Texture_R );
			o.Metallic = tex2DNode17.r;
			o.Smoothness = tex2DNode17.g;
			o.Occlusion = tex2DNode17.b;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
2322;101;1467;877;762.9377;450.104;1;True;True
Node;AmplifyShaderEditor.SamplerNode;15;-392.6899,-75.53566;Float;True;Property;_DinoStatue01_Texture_AT;DinoStatue01_Texture_A+T;2;0;Create;True;0;0;False;0;81d361aa0da1a0f4b904e741af33e917;881bacbbfee679846be48a1d017f2776;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-348.8735,-368.553;Float;False;Property;_Color0;Color 0;0;0;Create;True;0;0;False;0;0,0,0,0;0.2924528,0.2649374,0.2193396,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;16;-376.0652,146.5711;Float;True;Property;_DinoStatue01_Texture_N;DinoStatue01_Texture_N;1;0;Create;True;0;0;False;0;c36223ca210dd0846b6db9f37de5c142;d0e22f9478b2f5c418c7a255ac283d34;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-359.8971,379.5173;Float;True;Property;_DinoStatue01_Texture_R;DinoStatue01_Texture_R;3;0;Create;True;0;0;False;0;7525deb5729d84a47844724a9742fdfe;927af766bf95fec4280468623ccfca90;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;18;4.763816,-164.1286;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;49.06232,-284.104;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;233.6241,-12.94359;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SH_Master;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;6;0
WireConnection;18;1;15;0
WireConnection;19;0;6;0
WireConnection;19;1;15;0
WireConnection;0;0;19;0
WireConnection;0;1;16;0
WireConnection;0;3;17;1
WireConnection;0;4;17;2
WireConnection;0;5;17;3
ASEEND*/
//CHKSM=6CDE06FA6DA81E83A54920EBCC6EBCF3B58D7AC8