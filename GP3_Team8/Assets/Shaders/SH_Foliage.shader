// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Foliage"
{
	Properties
	{
		_FoliageAtlas01_opacity("FoliageAtlas01_opacity", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_FoliageAtlas01_diffuse("FoliageAtlas01_diffuse", 2D) = "white" {}
		_FoliageAtlas01_normal("FoliageAtlas01_normal", 2D) = "white" {}
		_ColorAdd("ColorAdd", Color) = (0.3157262,0.5188679,0.3211065,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _FoliageAtlas01_normal;
		uniform float4 _FoliageAtlas01_normal_ST;
		uniform float4 _ColorAdd;
		uniform sampler2D _FoliageAtlas01_diffuse;
		uniform float4 _FoliageAtlas01_diffuse_ST;
		uniform sampler2D _FoliageAtlas01_opacity;
		uniform float4 _FoliageAtlas01_opacity_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FoliageAtlas01_normal = i.uv_texcoord * _FoliageAtlas01_normal_ST.xy + _FoliageAtlas01_normal_ST.zw;
			o.Normal = tex2D( _FoliageAtlas01_normal, uv_FoliageAtlas01_normal ).rgb;
			float2 uv_FoliageAtlas01_diffuse = i.uv_texcoord * _FoliageAtlas01_diffuse_ST.xy + _FoliageAtlas01_diffuse_ST.zw;
			o.Albedo = ( _ColorAdd * tex2D( _FoliageAtlas01_diffuse, uv_FoliageAtlas01_diffuse ) ).rgb;
			o.Alpha = 1;
			float2 uv_FoliageAtlas01_opacity = i.uv_texcoord * _FoliageAtlas01_opacity_ST.xy + _FoliageAtlas01_opacity_ST.zw;
			clip( tex2D( _FoliageAtlas01_opacity, uv_FoliageAtlas01_opacity ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
2123;49;1595;901;141.477;278.3573;1;True;True
Node;AmplifyShaderEditor.SamplerNode;18;-96.88959,-283.7893;Float;True;Property;_FoliageAtlas01_diffuse;FoliageAtlas01_diffuse;2;0;Create;True;0;0;False;0;fc7e2183097b49e47841972fcd9392cb;e5c852699b77ff84aab35b0db09b4f40;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;29;-75.05623,-490.4874;Float;False;Property;_ColorAdd;ColorAdd;6;0;Create;True;0;0;False;0;0.3157262,0.5188679,0.3211065,0;0.7830189,0.7830189,0.7830189,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;30;-3.289886,176.9178;Float;True;Property;_FoliageAtlas01_roughness;FoliageAtlas01_roughness;5;0;Create;True;0;0;False;0;33889344feced2845b9466f017a38dca;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;70.80969,379.6145;Float;False;Property;_Rougnessintensity;Rougness intensity;4;0;Create;True;0;0;False;0;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;40.18824,-54.35995;Float;True;Property;_FoliageAtlas01_normal;FoliageAtlas01_normal;3;0;Create;True;0;0;False;0;81c972c4941fc9947a6e1c6cfa770f78;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;339.0197,-317.5292;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;357.6547,218.9418;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;305.1348,345.7457;Float;True;Property;_FoliageAtlas01_opacity;FoliageAtlas01_opacity;0;0;Create;True;0;0;False;0;b8f727e99d967f147adcb0fd512cc035;312492f0566921d4aa09b3d8255902ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;835.0464,-21.36948;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SH_Foliage;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;1;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;34;0;29;0
WireConnection;34;1;18;0
WireConnection;31;0;30;1
WireConnection;31;1;27;0
WireConnection;0;0;34;0
WireConnection;0;1;26;0
WireConnection;0;10;19;0
ASEEND*/
//CHKSM=39DCA4C02CD7E9FF11715C19C1FD507B6DC8E3C7