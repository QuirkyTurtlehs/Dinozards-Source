// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Lava_V2_02"
{
	Properties
	{
		_LavaNoise1("LavaNoise1", 2D) = "white" {}
		_LavaNoise2("LavaNoise2", 2D) = "white" {}
		_Dark("Dark", Color) = (0.73,0.73,0.73,1)
		_Color0("Color 0", Color) = (0.9333334,0.6313726,0.1843137,1)
		_Yellow("Yellow", Color) = (1,0.97456,0.364,1)
		_Emission("Emission", Float) = 1
		_Albedo("Albedo", Float) = 1
		_LocalVertexOffset("Local Vertex Offset", Range( 0 , 0.0003)) = 0.0002
		_Specular("Specular", Float) = 1
		_Grey("Grey", Color) = (0.73,0.73,0.73,1)
		_LavaNoise3("LavaNoise3", 2D) = "white" {}
		_Tesselation("Tesselation", Float) = 3
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
		uniform float _LocalVertexOffset;
		uniform float4 _Grey;
		uniform float4 _Yellow;
		uniform float4 _Dark;
		uniform float4 _Color0;
		uniform float _Albedo;
		uniform float _Emission;
		uniform float _Specular;
		uniform float _Tesselation;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_2 = (_Tesselation).xxxx;
			return temp_cast_2;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float mulTime50 = _Time.y * _Speed;
			float2 uv_TexCoord55 = v.texcoord.xy * float2( 1.6,1.6 ) + float2( 1,1 );
			float2 panner47 = ( mulTime50 * float2( -0.01,-0.01 ) + uv_TexCoord55);
			float2 uv_TexCoord54 = v.texcoord.xy * float2( 1.2,1.2 ) + float2( 1,1 );
			float2 panner46 = ( mulTime50 * float2( 0.01,0.01 ) + uv_TexCoord54);
			float2 panner59 = ( mulTime50 * float2( 0.01,-0.01 ) + uv_TexCoord54);
			float2 panner135 = ( mulTime50 * float2( 0.01,-0.01 ) + uv_TexCoord55);
			float4 tex2DNode134 = tex2Dlod( _TextureSample0, float4( panner135, 0, 0.0) );
			float4 temp_output_69_0 = ( ( ( ( tex2Dlod( _LavaNoise2, float4( panner47, 0, 0.0) ) - tex2Dlod( _LavaNoise1, float4( panner46, 0, 0.0) ) ) + tex2Dlod( _LavaNoise3, float4( panner59, 0, 0.0) ) ) * tex2DNode134 ) * tex2DNode134 );
			v.vertex.xyz += ( ( float4( ase_vertexNormal , 0.0 ) * ( temp_output_69_0 * 100.0 ) ) * _LocalVertexOffset ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float mulTime50 = _Time.y * _Speed;
			float2 uv_TexCoord55 = i.uv_texcoord * float2( 1.6,1.6 ) + float2( 1,1 );
			float2 panner47 = ( mulTime50 * float2( -0.01,-0.01 ) + uv_TexCoord55);
			float2 uv_TexCoord54 = i.uv_texcoord * float2( 1.2,1.2 ) + float2( 1,1 );
			float2 panner46 = ( mulTime50 * float2( 0.01,0.01 ) + uv_TexCoord54);
			float2 panner59 = ( mulTime50 * float2( 0.01,-0.01 ) + uv_TexCoord54);
			float2 panner135 = ( mulTime50 * float2( 0.01,-0.01 ) + uv_TexCoord55);
			float4 tex2DNode134 = tex2D( _TextureSample0, panner135 );
			float4 temp_output_69_0 = ( ( ( ( tex2D( _LavaNoise2, panner47 ) - tex2D( _LavaNoise1, panner46 ) ) + tex2D( _LavaNoise3, panner59 ) ) * tex2DNode134 ) * tex2DNode134 );
			float lerpResult138 = lerp( 1.0 , (float)0 , temp_output_69_0.r);
			float4 ifLocalVar85 = 0;
			if( lerpResult138 > _Grey.r )
				ifLocalVar85 = _Yellow;
			else if( lerpResult138 == _Grey.r )
				ifLocalVar85 = _Dark;
			else if( lerpResult138 < _Grey.r )
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
-1913;1;1906;1010;5324.254;1095.115;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;122;-4825.416,-891.5429;Float;False;911.1338;926.8278;Panners in all 4 different directions, low speed;8;54;55;46;47;59;49;50;135;Quad panning;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-4775.416,-461.685;Float;False;Property;_Speed;Speed;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-4622.14,-686.7799;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1.2,1.2;False;1;FLOAT2;1,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-4605.797,-239.481;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1.6,1.6;False;1;FLOAT2;1,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;50;-4571.541,-462.198;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;47;-4136.104,-612.8164;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;123;-3836.6,-914.0045;Float;False;899.5962;1122.734;Comment;14;77;11;45;52;56;78;76;69;129;130;131;132;133;134;Quad noise mixture;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;46;-4139.003,-841.5429;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;45;-3774.798,-629.6111;Float;True;Property;_LavaNoise2;LavaNoise2;1;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-3786.6,-864.0045;Float;True;Property;_LavaNoise1;LavaNoise1;0;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;52;-3468.368,-830.416;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;77;-3213.901,-653.5177;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;59;-4120.282,-366.3414;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;78;-3404.674,-611.7855;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;56;-3773.948,-397.2521;Float;True;Property;_LavaNoise3;LavaNoise3;10;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-3356.701,-581.6151;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;131;-3100.854,-399.8597;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;135;-4117.507,-166.2852;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;134;-3754.89,-89.05099;Float;True;Property;_TextureSample0;Texture Sample 0;12;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;130;-3314.854,-327.8597;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-3265.854,-314.8597;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;133;-3034.854,-122.8597;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;124;-2890.68,-482.2386;Float;False;723.8352;809.9552;Float required for If = Lerp setup. MultiplyX100 = PowerSetup, No grey values;10;109;15;14;83;13;111;84;126;127;138;Two different setups;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;132;-3229.854,-72.85974;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2693.356,-427.8269;Float;False;Constant;_Lerp1;Lerp1;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-2757.046,134.7798;Float;False;Constant;_Multiplyx100;Multiply x100;9;0;Create;True;0;0;False;0;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;14;-2687.266,-345.8643;Float;False;Constant;_Lerp2;Lerp2;2;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-3172.004,-44.27023;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;125;-2120.377,-209.4825;Float;False;868.3292;543.6273;Comment;4;117;115;113;112;Slight vertex normal offset;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;120;-2628.607,-1426.317;Float;False;759.7163;911.1566;Color sytem - if over or equal to grey value = Yellow. If under = Orange;5;85;90;98;95;139;Color system;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;121;-1783.871,-1149.879;Float;False;487.0995;801.0002;Parameters to tweak the Emissive, Color and Specular;6;104;96;103;105;97;106;Emissive, color & specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;90;-2564.326,-1206.343;Float;False;Property;_Yellow;Yellow;4;0;Create;True;0;0;False;0;1,0.97456,0.364,1;1,0.01863085,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;98;-2578.094,-1376.317;Float;False;Property;_Grey;Grey;9;0;Create;True;0;0;False;0;0.73,0.73,0.73,1;0.73,0.73,0.73,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;95;-2578.607,-1033.958;Float;False;Property;_Dark;Dark;2;0;Create;True;0;0;False;0;0.73,0.73,0.73,1;0.73,0.73,0.73,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;112;-2070.377,-140.4842;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;139;-2561.713,-812.8922;Float;False;Property;_Color0;Color 0;3;0;Create;True;0;0;False;0;0.9333334,0.6313726,0.1843137,1;0.4235294,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-2524.414,48.46703;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;138;-2465.495,-443.3994;Float;True;3;0;FLOAT;0.8113208;False;1;FLOAT;0.3490566;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-1757.048,219.1449;Float;False;Property;_LocalVertexOffset;Local Vertex Offset;7;0;Create;True;0;0;False;0;0.0002;0.000137;0;0.0003;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-1832.251,-49.28293;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-1733.871,-1079.179;Float;False;Property;_Albedo;Albedo;6;0;Create;True;0;0;False;0;1;-1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-1725.871,-579.3783;Float;False;Property;_Specular;Specular;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-1730.907,-800.5342;Float;False;Property;_Emission;Emission;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;85;-2185.373,-1132.263;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-2858.189,-356.3101;Float;False;Constant;_30xMulti;30x Multi;7;0;Create;True;0;0;False;0;30;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-1539.197,-847.6243;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-1535.771,-601.8784;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1531.771,-1099.879;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-2778.919,-243.0284;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;126;-2736.41,-280.35;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-1487.048,-38.85499;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;127;-2832.41,-268.35;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-1447.912,-322.9437;Float;False;Property;_Tesselation;Tesselation;11;0;Create;True;0;0;False;0;3;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;-2460.55,-214.2383;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1135.971,-719.9479;Float;False;True;6;Float;ASEMaterialInspector;0;0;StandardSpecular;SH_Lava_V2_02;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;50;0;49;0
WireConnection;47;0;55;0
WireConnection;47;1;50;0
WireConnection;46;0;54;0
WireConnection;46;1;50;0
WireConnection;45;1;47;0
WireConnection;11;1;46;0
WireConnection;52;0;45;0
WireConnection;52;1;11;0
WireConnection;77;0;52;0
WireConnection;59;0;54;0
WireConnection;59;1;50;0
WireConnection;78;0;77;0
WireConnection;56;1;59;0
WireConnection;76;0;78;0
WireConnection;76;1;56;0
WireConnection;131;0;76;0
WireConnection;135;0;55;0
WireConnection;135;1;50;0
WireConnection;134;1;135;0
WireConnection;130;0;131;0
WireConnection;129;0;130;0
WireConnection;129;1;134;0
WireConnection;133;0;129;0
WireConnection;132;0;133;0
WireConnection;69;0;132;0
WireConnection;69;1;134;0
WireConnection;109;0;69;0
WireConnection;109;1;111;0
WireConnection;138;0;15;0
WireConnection;138;1;14;0
WireConnection;138;2;69;0
WireConnection;113;0;112;0
WireConnection;113;1;109;0
WireConnection;85;0;138;0
WireConnection;85;1;98;1
WireConnection;85;2;90;0
WireConnection;85;3;95;0
WireConnection;85;4;139;0
WireConnection;96;0;85;0
WireConnection;96;1;97;0
WireConnection;104;0;85;0
WireConnection;104;1;106;0
WireConnection;103;0;85;0
WireConnection;103;1;105;0
WireConnection;83;0;69;0
WireConnection;83;1;127;0
WireConnection;126;0;84;0
WireConnection;115;0;113;0
WireConnection;115;1;117;0
WireConnection;127;0;126;0
WireConnection;13;0;15;0
WireConnection;13;1;14;0
WireConnection;13;2;83;0
WireConnection;0;0;103;0
WireConnection;0;2;96;0
WireConnection;0;3;104;0
WireConnection;0;11;115;0
WireConnection;0;14;137;0
ASEEND*/
//CHKSM=E93291179395AA14DB614B2BF06F7A16BDA6B5DA