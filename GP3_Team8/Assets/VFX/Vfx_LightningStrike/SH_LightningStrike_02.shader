// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_LightningStrike_01"
{
	Properties
	{
		_SH_LightningStrike_03("SH_LightningStrike_03", 2D) = "white" {}
		_Emission("Emission", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend One One , One One
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _SH_LightningStrike_03;
		uniform float4 _SH_LightningStrike_03_ST;
		uniform float _Emission;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_SH_LightningStrike_03 = i.uv_texcoord * _SH_LightningStrike_03_ST.xy + _SH_LightningStrike_03_ST.zw;
			float4 temp_output_16_0 = pow( tex2D( _SH_LightningStrike_03, uv_SH_LightningStrike_03 ) , 4.14 );
			o.Emission = ( ( temp_output_16_0 * _Emission * i.vertexColor * i.vertexColor.a ) * ( temp_output_16_0 * i.vertexColor.a ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
-1913;7;1906;1004;2012.264;663.0848;1.6;True;False
Node;AmplifyShaderEditor.SamplerNode;14;-944.1806,-339.0523;Float;True;Property;_SH_LightningStrike_03;SH_LightningStrike_03;5;0;Create;True;0;0;False;0;c31da365764aca84d991f2702a3addc4;c31da365764aca84d991f2702a3addc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-786.9706,-20.17671;Float;False;Property;_Emission;Emission;6;0;Create;True;0;0;False;0;1;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;17;-575.9706,-100.1767;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;16;-586.9813,-357.4524;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;4.14;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-371.5704,81.52328;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-240.9706,-328.1767;Float;True;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-15.70308,-54.07049;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1261.403,214.6001;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1371.698,-311.8997;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;4;-868.4996,81.20003;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1327.301,-23.29994;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-557.9996,373.5998;Float;True;Property;_T_LightningStrike_01;T_LightningStrike_01;1;0;Create;True;0;0;False;0;5010e3e241145204a8a30ff1a5979a04;5010e3e241145204a8a30ff1a5979a04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;2;-1170,-332;Float;False;3;0;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;19;-897.1772,201.4177;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;5010e3e241145204a8a30ff1a5979a04;5010e3e241145204a8a30ff1a5979a04;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-721.6025,498.4297;Float;True;Property;_T_LightningStrike_02;T_LightningStrike_02;4;0;Create;True;0;0;False;0;65b45afc7e9523c4ca26cf338ff99a28;65b45afc7e9523c4ca26cf338ff99a28;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;6;-1250.9,90.60004;Float;False;Property;_Speed_Lightning;Speed_Lightning;3;0;Create;True;0;0;False;0;0,1;0,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;22;462,-105.8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SH_LightningStrike_01;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;4;1;False;-1;1;False;-1;4;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;14;0
WireConnection;20;0;16;0
WireConnection;20;1;17;4
WireConnection;18;0;16;0
WireConnection;18;1;15;0
WireConnection;18;2;17;0
WireConnection;18;3;17;4
WireConnection;21;0;18;0
WireConnection;21;1;20;0
WireConnection;4;0;7;0
WireConnection;4;2;6;0
WireConnection;4;1;5;0
WireConnection;1;1;4;0
WireConnection;11;1;4;0
WireConnection;22;2;21;0
ASEEND*/
//CHKSM=69D2749DFB58F1473D66B42A903562B0F4DAD6DB