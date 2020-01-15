// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Leaves"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TreeLeavesSingle01("TreeLeavesSingle01", 2D) = "white" {}
		_TreeLeavesSingle01_Opacity("TreeLeavesSingle01_Opacity", 2D) = "white" {}
		_Desaturation("Desaturation", Float) = 0
		_Power("Power", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TreeLeavesSingle01;
		uniform float4 _TreeLeavesSingle01_ST;
		uniform float _Power;
		uniform float _Desaturation;
		uniform sampler2D _TreeLeavesSingle01_Opacity;
		uniform float4 _TreeLeavesSingle01_Opacity_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TreeLeavesSingle01 = i.uv_texcoord * _TreeLeavesSingle01_ST.xy + _TreeLeavesSingle01_ST.zw;
			float4 temp_cast_0 = (_Power).xxxx;
			float3 desaturateInitialColor42 = pow( tex2D( _TreeLeavesSingle01, uv_TreeLeavesSingle01 ) , temp_cast_0 ).rgb;
			float desaturateDot42 = dot( desaturateInitialColor42, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar42 = lerp( desaturateInitialColor42, desaturateDot42.xxx, _Desaturation );
			o.Albedo = desaturateVar42;
			o.Alpha = 1;
			float2 uv_TreeLeavesSingle01_Opacity = i.uv_texcoord * _TreeLeavesSingle01_Opacity_ST.xy + _TreeLeavesSingle01_Opacity_ST.zw;
			clip( tex2D( _TreeLeavesSingle01_Opacity, uv_TreeLeavesSingle01_Opacity ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
2123;55;1595;895;194.479;519.3684;1.3;True;True
Node;AmplifyShaderEditor.SamplerNode;37;195.8256,-227.5756;Float;True;Property;_TreeLeavesSingle01;TreeLeavesSingle01;1;0;Create;True;0;0;False;0;e5c852699b77ff84aab35b0db09b4f40;e5c852699b77ff84aab35b0db09b4f40;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;367.1211,-385.4683;Float;False;Property;_Power;Power;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;45;639.7293,-379.048;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1.9;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;43;482.1926,36.29034;Float;False;Property;_Desaturation;Desaturation;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;732.2246,218.0246;Float;True;Property;_TreeLeavesSingle01_Opacity;TreeLeavesSingle01_Opacity;2;0;Create;True;0;0;False;0;312492f0566921d4aa09b3d8255902ac;312492f0566921d4aa09b3d8255902ac;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;46;1078.222,-429.6681;Float;False;ConstantBiasScale;-1;;2;63208df05c83e8e49a48ffbdce2e43a0;0;3;3;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DesaturateOpNode;42;844.7866,-142.2521;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;40;1154.046,2.630524;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SH_Leaves;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;0;37;0
WireConnection;45;1;47;0
WireConnection;42;0;45;0
WireConnection;42;1;43;0
WireConnection;40;0;42;0
WireConnection;40;10;38;0
ASEEND*/
//CHKSM=6B41B3E5B62C6FF95391C0C9798965E26B02F948