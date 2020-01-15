// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Lava_V2"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_LavaNoise1("LavaNoise1", 2D) = "white" {}
		_LavaNoise2("LavaNoise2", 2D) = "white" {}
		_Color0("Color 0", Color) = (0.9333334,0.6313726,0.1843137,1)
		_Yellow("Yellow", Color) = (1,0.97456,0.364,1)
		_Emission("Emission", Float) = 1
		_Albedo("Albedo", Float) = 1
		_Specular("Specular", Float) = 1
		_LavaNoise3("LavaNoise3", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Speed("Speed", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _LavaNoise2;
		uniform float _Speed;
		uniform sampler2D _LavaNoise1;
		uniform sampler2D _LavaNoise3;
		uniform sampler2D _TextureSample0;
		uniform float4 _Yellow;
		uniform float4 _Color0;
		uniform float _Albedo;
		uniform float _Emission;
		uniform float _Specular;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float mulTime50 = _Time.y * _Speed;
			float2 uv_TexCoord55 = i.uv_texcoord + float2( 1,1 );
			float2 panner47 = ( mulTime50 * float2( -0.01,-0.01 ) + uv_TexCoord55);
			float2 uv_TexCoord54 = i.uv_texcoord * float2( 0.5,0.5 ) + float2( 1,1 );
			float2 panner46 = ( mulTime50 * float2( 0.01,0.01 ) + uv_TexCoord54);
			float2 panner59 = ( mulTime50 * float2( 0.01,-0.01 ) + uv_TexCoord54);
			float2 panner135 = ( mulTime50 * float2( 0.01,-0.01 ) + uv_TexCoord55);
			float4 tex2DNode134 = tex2D( _TextureSample0, panner135 );
			float lerpResult13 = lerp( 1.0 , (float)0 , ( ( ( ( ( tex2D( _LavaNoise2, panner47 ) - tex2D( _LavaNoise1, panner46 ) ) + tex2D( _LavaNoise3, panner59 ) ) * tex2DNode134 ) * tex2DNode134 ) * 30.0 ).r);
			float4 color98 = IsGammaSpace() ? float4(0.7294118,0.7294118,0.7294118,1) : float4(0.4910209,0.4910209,0.4910209,1);
			float4 ifLocalVar85 = 0;
			if( lerpResult13 >= color98.r )
				ifLocalVar85 = _Yellow;
			else
				ifLocalVar85 = _Color0;
			o.Albedo = ( ifLocalVar85 * _Albedo ).rgb;
			o.Emission = ( ifLocalVar85 * _Emission ).rgb;
			o.Specular = ( ifLocalVar85 * _Specular ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
-1913;1;1906;1010;5402.414;1865.208;2.5;True;False
Node;AmplifyShaderEditor.CommentaryNode;122;-4768,-1008;Float;False;911.1338;926.8278;Panners in all 4 different directions, low speed;8;54;55;46;47;59;49;50;135;Quad panning;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-4720,-576;Float;False;Property;_Speed;Speed;14;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-4560,-368;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;1,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-4576,-816;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;1,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;50;-4512,-592;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;46;-4080,-960;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;47;-4080,-736;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;123;-3776,-1040;Float;False;899.5962;1122.734;Comment;14;77;11;45;52;56;78;76;69;129;130;131;132;133;134;Quad noise mixture;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;11;-3728,-992;Float;True;Property;_LavaNoise1;LavaNoise1;5;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;45;-3728,-752;Float;True;Property;_LavaNoise2;LavaNoise2;6;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;52;-3408,-960;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;59;-4064,-496;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;77;-3168,-768;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;78;-3344,-736;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;56;-3728,-512;Float;True;Property;_LavaNoise3;LavaNoise3;12;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-3296,-704;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;135;-4064,-288;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;131;-3040,-528;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;134;-3696,-208;Float;True;Property;_TextureSample0;Texture Sample 0;13;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;130;-3264,-448;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-3216,-432;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;124;-2788.302,-598.4999;Float;False;709.4353;459.5552;;7;13;14;83;15;127;126;84;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-2756.302,-470.5;Float;False;Constant;_30xMulti;30x Multi;7;0;Create;True;0;0;False;0;30;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;133;-2976,-240;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;132;-3184,-192;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;126;-2644.302,-390.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;127;-2740.302,-374.5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-3120,-160;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2596.302,-534.4999;Float;False;Constant;_Lerp1;Lerp1;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;120;-2576,-1328;Float;False;717.7163;594.1566;Color sytem - if over or equal to grey value = Yellow. If under = Orange;4;95;90;85;98;Color system;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-2676.302,-358.5;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;14;-2596.302,-454.5;Float;False;Constant;_Lerp2;Lerp2;2;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.ColorNode;95;-2528,-944;Float;False;Property;_Color0;Color 0;7;0;Create;True;0;0;False;0;0.9333334,0.6313726,0.1843137,1;0.4235294,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;98;-2512,-1280;Float;False;Constant;_Grey;Grey;8;0;Create;True;0;0;False;0;0.7294118,0.7294118,0.7294118,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;90;-2512,-1120;Float;False;Property;_Yellow;Yellow;8;0;Create;True;0;0;False;0;1,0.97456,0.364,1;1,0.01863085,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;13;-2356.302,-486.5;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;121;-1728,-1280;Float;False;487.0995;801.0002;Parameters to tweak the Emissive, Color and Specular;6;104;96;103;105;97;106;Emissive, color & specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.ConditionalIfNode;85;-2128,-1088;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1680,-928;Float;False;Property;_Emission;Emission;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-1680,-704;Float;False;Property;_Specular;Specular;11;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-1680,-1200;Float;False;Property;_Albedo;Albedo;10;0;Create;True;0;0;False;0;1;-1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-1488,-976;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1472,-1216;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-1488,-720;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1088,-848;Float;False;True;6;Float;ASEMaterialInspector;0;0;StandardSpecular;SH_Lava_V2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;50;0;49;0
WireConnection;46;0;54;0
WireConnection;46;1;50;0
WireConnection;47;0;55;0
WireConnection;47;1;50;0
WireConnection;11;1;46;0
WireConnection;45;1;47;0
WireConnection;52;0;45;0
WireConnection;52;1;11;0
WireConnection;59;0;54;0
WireConnection;59;1;50;0
WireConnection;77;0;52;0
WireConnection;78;0;77;0
WireConnection;56;1;59;0
WireConnection;76;0;78;0
WireConnection;76;1;56;0
WireConnection;135;0;55;0
WireConnection;135;1;50;0
WireConnection;131;0;76;0
WireConnection;134;1;135;0
WireConnection;130;0;131;0
WireConnection;129;0;130;0
WireConnection;129;1;134;0
WireConnection;133;0;129;0
WireConnection;132;0;133;0
WireConnection;126;0;84;0
WireConnection;127;0;126;0
WireConnection;69;0;132;0
WireConnection;69;1;134;0
WireConnection;83;0;69;0
WireConnection;83;1;127;0
WireConnection;13;0;15;0
WireConnection;13;1;14;0
WireConnection;13;2;83;0
WireConnection;85;0;13;0
WireConnection;85;1;98;1
WireConnection;85;2;90;0
WireConnection;85;3;90;0
WireConnection;85;4;95;0
WireConnection;96;0;85;0
WireConnection;96;1;97;0
WireConnection;103;0;85;0
WireConnection;103;1;105;0
WireConnection;104;0;85;0
WireConnection;104;1;106;0
WireConnection;0;0;103;0
WireConnection;0;2;96;0
WireConnection;0;3;104;0
ASEEND*/
//CHKSM=12B2D95F928AAA130A5BE3A2BE43B2DBAF58982C