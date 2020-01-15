// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Character"
{
	Properties
	{
		_Dinozard_AT("Dinozard_A+T", 2D) = "white" {}
		_Dinozard_N("Dinozard_N", 2D) = "bump" {}
		_Dinozard_R("Dinozard_R", 2D) = "white" {}
		_DeathAnimation("Death Animation", Range( 0 , 1)) = 0
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

		uniform sampler2D _Dinozard_N;
		uniform float4 _Dinozard_N_ST;
		uniform float _DeathAnimation;
		uniform sampler2D _Dinozard_AT;
		uniform float4 _Dinozard_AT_ST;
		uniform sampler2D _Dinozard_R;
		uniform float4 _Dinozard_R_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Dinozard_N = i.uv_texcoord * _Dinozard_N_ST.xy + _Dinozard_N_ST.zw;
			float3 lerpResult62 = lerp( UnpackNormal( tex2D( _Dinozard_N, uv_Dinozard_N ) ) , float3( 0,0,0 ) , _DeathAnimation);
			o.Normal = lerpResult62;
			float2 uv_Dinozard_AT = i.uv_texcoord * _Dinozard_AT_ST.xy + _Dinozard_AT_ST.zw;
			float4 lerpResult63 = lerp( tex2D( _Dinozard_AT, uv_Dinozard_AT ) , float4( 0,0,0,0 ) , _DeathAnimation);
			o.Albedo = lerpResult63.rgb;
			float2 uv_Dinozard_R = i.uv_texcoord * _Dinozard_R_ST.xy + _Dinozard_R_ST.zw;
			float4 tex2DNode3 = tex2D( _Dinozard_R, uv_Dinozard_R );
			float lerpResult60 = lerp( tex2DNode3.r , 0.0 , _DeathAnimation);
			o.Metallic = lerpResult60;
			float lerpResult61 = lerp( tex2DNode3.g , 0.0 , _DeathAnimation);
			o.Smoothness = lerpResult61;
			float lerpResult55 = lerp( tex2DNode3.b , 0.0 , _DeathAnimation);
			o.Occlusion = lerpResult55;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
-1913;7;1906;1004;6117.301;924.4779;3.645;True;False
Node;AmplifyShaderEditor.CommentaryNode;64;-1261.121,-159.2448;Float;False;495.3003;668.4001;Character Textures;3;3;1;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;3;-1086.821,279.1553;Float;True;Property;_Dinozard_R;Dinozard_R;2;0;Create;True;0;0;False;0;7309b9b9491f7854dbffa4090da700f6;7309b9b9491f7854dbffa4090da700f6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1211.121,88.85509;Float;True;Property;_Dinozard_N;Dinozard_N;1;0;Create;True;0;0;False;0;62b0c29d57d2d244ab94c8c0ae768725;62b0c29d57d2d244ab94c8c0ae768725;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1099.221,-109.2449;Float;True;Property;_Dinozard_AT;Dinozard_A+T;0;0;Create;True;0;0;False;0;None;e400f8c1dcb95de49a3a573311edc6ce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;56;-842.6245,883.4077;Float;False;Property;_DeathAnimation;Death Animation;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;62;-189.1133,529.8425;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;60;-180.2269,736.3262;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;61;-183.5681,942.1808;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;55;-171.4959,1176.039;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;63;-211.1877,304.9519;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;419.4562,662.3362;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SH_Character;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;62;0;2;0
WireConnection;62;2;56;0
WireConnection;60;0;3;1
WireConnection;60;2;56;0
WireConnection;61;0;3;2
WireConnection;61;2;56;0
WireConnection;55;0;3;3
WireConnection;55;2;56;0
WireConnection;63;0;1;0
WireConnection;63;2;56;0
WireConnection;0;0;63;0
WireConnection;0;1;62;0
WireConnection;0;3;60;0
WireConnection;0;4;61;0
WireConnection;0;5;55;0
ASEEND*/
//CHKSM=041850EEC901F1F1AAA6F8E877CC74C696D3AFFA