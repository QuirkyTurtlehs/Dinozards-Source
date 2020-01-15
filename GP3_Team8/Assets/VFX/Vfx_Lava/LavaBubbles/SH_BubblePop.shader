// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_BubblePop"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_LavaNoise1("LavaNoise1", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_LavaNoise2("LavaNoise2", 2D) = "white" {}
		_Color1("Color 1", Color) = (0.9333334,0.6313726,0.1843137,1)
		_Noise_Opacity("Noise_Opacity", Float) = 1
		_Yellow("Yellow", Color) = (1,0.97456,0.364,1)
		_Emission("Emission", Float) = 1
		_OpacityAlpha("Opacity/Alpha", Float) = 1
		_Albedo("Albedo", Float) = 1
		_Specular("Specular", Float) = 1
		_LavaNoise3("LavaNoise3", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Speed("Speed", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _LavaNoise2;
		uniform float _Speed;
		uniform sampler2D _LavaNoise1;
		uniform sampler2D _LavaNoise3;
		uniform sampler2D _TextureSample1;
		uniform float4 _Yellow;
		uniform float4 _Color1;
		uniform float _Albedo;
		uniform float _Emission;
		uniform float _Specular;
		uniform float _OpacityAlpha;
		uniform float _Noise_Opacity;
		uniform sampler2D _TextureSample0;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float mulTime40 = _Time.y * _Speed;
			float2 uv_TexCoord42 = i.uv_texcoord * float2( 0.1,0.1 ) + float2( 0.1,0.1 );
			float2 panner43 = ( mulTime40 * float2( -0.01,-0.01 ) + uv_TexCoord42);
			float2 uv_TexCoord41 = i.uv_texcoord * float2( 0.05,0.05 ) + float2( 1,1 );
			float2 panner44 = ( mulTime40 * float2( 0.01,0.01 ) + uv_TexCoord41);
			float2 panner49 = ( mulTime40 * float2( 0.01,-0.01 ) + uv_TexCoord41);
			float2 panner53 = ( mulTime40 * float2( 0.01,-0.01 ) + uv_TexCoord42);
			float4 tex2DNode56 = tex2D( _TextureSample1, panner53 );
			float lerpResult72 = lerp( 1.0 , (float)0 , ( ( ( ( ( tex2D( _LavaNoise2, panner43 ) - tex2D( _LavaNoise1, panner44 ) ) + tex2D( _LavaNoise3, panner49 ) ) * tex2DNode56 ) * tex2DNode56 ) * 30.0 ).r);
			float4 color68 = IsGammaSpace() ? float4(0.7294118,0.7294118,0.7294118,1) : float4(0.4910209,0.4910209,0.4910209,1);
			float4 ifLocalVar74 = 0;
			if( lerpResult72 >= color68.r )
				ifLocalVar74 = _Yellow;
			else
				ifLocalVar74 = _Color1;
			o.Albedo = ( ifLocalVar74 * _Albedo ).rgb;
			o.Emission = ( ifLocalVar74 * _Emission ).rgb;
			o.Specular = ( ifLocalVar74 * _Specular ).rgb;
			float temp_output_25_0 = ( tex2D( _TextureSample0, ( i.uv_texcoord * 1.0 ) ).r * 1.0 );
			float lerpResult20 = lerp( 0.0 , 5.0 , ( 1.0 - (i.vertexColor).r ));
			float temp_output_4_0 = ( _Noise_Opacity - ( ( 1.0 - temp_output_25_0 ) * lerpResult20 ) );
			o.Alpha = ( _OpacityAlpha * temp_output_4_0 );
			clip( temp_output_4_0 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
-1913;7;1906;1004;3660.539;1803.119;3.535701;True;False
Node;AmplifyShaderEditor.CommentaryNode;33;-4018.019,-623.7611;Float;False;911.1338;926.8278;Panners in all 4 different directions, low speed;8;53;49;44;43;42;41;40;39;Quad panning;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-3970.018,-191.761;Float;False;Property;_Speed;Speed;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-3810.018,16.2388;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.1,0.1;False;1;FLOAT2;0.1,0.1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-3826.018,-431.761;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.05,0.05;False;1;FLOAT2;1,1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;40;-3762.018,-207.761;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;44;-3330.019,-575.7611;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;34;-3026.02,-655.7611;Float;False;899.5962;1122.734;Comment;14;63;60;59;57;56;55;54;52;51;50;48;47;46;45;Quad noise mixture;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;43;-3330.019,-351.761;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;46;-2978.02,-367.761;Float;True;Property;_LavaNoise2;LavaNoise2;3;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;45;-2978.02,-607.7611;Float;True;Property;_LavaNoise1;LavaNoise1;1;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;47;-2658.02,-575.7611;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;48;-2418.02,-383.761;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;49;-3314.02,-111.7611;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;51;-2978.02,-127.7611;Float;True;Property;_LavaNoise3;LavaNoise3;11;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;50;-2594.02,-351.761;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-2546.02,-319.761;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;54;-2290.02,-143.7611;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;53;-3314.02,96.2388;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,-0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;55;-2514.02,-63.76114;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;56;-2946.02,176.2388;Float;True;Property;_TextureSample1;Texture Sample 1;12;0;Create;True;0;0;False;0;47f1e25344983eb4a852e2ae7bb3cc01;47f1e25344983eb4a852e2ae7bb3cc01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-2525.747,983.9026;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;35;-2082.02,-223.761;Float;False;731.3357;427.4213;Float required for If = Lerp setup. MultiplyX100 = PowerSetup, No grey values;6;61;72;67;66;62;58;Two different setups;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-2466.02,-47.76115;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-2602.747,839.9027;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;13;-2001.247,1294.102;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-2050.02,-95.76114;Float;False;Constant;_30xMulti;30x Multi;7;0;Create;True;0;0;False;0;30;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;59;-2226.02,144.2388;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-2316.748,898.9027;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;61;-1938.019,-15.7612;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;60;-2434.02,192.2388;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-2142.748,789.9027;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;4f484fd7341a8b04b8b1d3536bf88f77;4f484fd7341a8b04b8b1d3536bf88f77;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;15;-1789.247,1289.102;Float;True;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;10;-1527.247,1292.102;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-2370.02,224.2388;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1757.779,783.9326;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;62;-2034.02,0.2387981;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1890.019,-159.761;Float;False;Constant;_Lerp1;Lerp1;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;-1826.02,-943.7611;Float;False;717.7163;594.1566;Color sytem - if over or equal to grey value = Yellow. If under = Orange;4;74;70;69;68;Color system;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;66;-1890.019,-79.76114;Float;False;Constant;_Lerp2;Lerp2;2;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1970.019,16.2388;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;20;-1285.247,1225.102;Float;True;3;0;FLOAT;0;False;1;FLOAT;5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-1415.414,830.7567;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;70;-1778.02,-559.7611;Float;False;Property;_Color1;Color 1;4;0;Create;True;0;0;False;0;0.9333334,0.6313726,0.1843137,1;0.2358491,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;72;-1650.019,-111.7611;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1020.847,585.9028;Float;False;Property;_Noise_Opacity;Noise_Opacity;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;-1762.02,-895.7611;Float;False;Constant;_Grey;Grey;8;0;Create;True;0;0;False;0;0.7294118,0.7294118,0.7294118,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1069.951,948.5156;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;38;-653.1782,-487.8217;Float;False;487.0995;801.0002;Parameters to tweak the Emissive, Color and Specular;6;84;82;80;79;76;75;Emissive, color & specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;69;-1762.02,-735.7611;Float;False;Property;_Yellow;Yellow;6;0;Create;True;0;0;False;0;1,0.97456,0.364,1;0.1509434,0,0.002732187,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-988.8014,459.6104;Float;False;Property;_OpacityAlpha;Opacity/Alpha;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-604.0526,-135.8219;Float;False;Property;_Emission;Emission;7;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;74;-1378.019,-703.7611;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-834.1233,686.3358;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-605.1783,88.17809;Float;False;Property;_Specular;Specular;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-605.1783,-407.8218;Float;False;Property;_Albedo;Albedo;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1809.111,408.5509;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-591.8016,441.6105;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1816.111,509.5508;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-397.1783,-423.8218;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-413.1783,72.17809;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-413.1783,-183.8219;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;29;-1503.369,522.3762;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;SH_BubblePop;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;1;False;-1;0;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;39;0
WireConnection;44;0;41;0
WireConnection;44;1;40;0
WireConnection;43;0;42;0
WireConnection;43;1;40;0
WireConnection;46;1;43;0
WireConnection;45;1;44;0
WireConnection;47;0;46;0
WireConnection;47;1;45;0
WireConnection;48;0;47;0
WireConnection;49;0;41;0
WireConnection;49;1;40;0
WireConnection;51;1;49;0
WireConnection;50;0;48;0
WireConnection;52;0;50;0
WireConnection;52;1;51;0
WireConnection;54;0;52;0
WireConnection;53;0;42;0
WireConnection;53;1;40;0
WireConnection;55;0;54;0
WireConnection;56;1;53;0
WireConnection;57;0;55;0
WireConnection;57;1;56;0
WireConnection;59;0;57;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;61;0;58;0
WireConnection;60;0;59;0
WireConnection;3;1;17;0
WireConnection;15;0;13;0
WireConnection;10;0;15;0
WireConnection;63;0;60;0
WireConnection;63;1;56;0
WireConnection;25;0;3;1
WireConnection;62;0;61;0
WireConnection;65;0;63;0
WireConnection;65;1;62;0
WireConnection;20;2;10;0
WireConnection;32;0;25;0
WireConnection;72;0;67;0
WireConnection;72;1;66;0
WireConnection;72;2;65;0
WireConnection;6;0;32;0
WireConnection;6;1;20;0
WireConnection;74;0;72;0
WireConnection;74;1;68;1
WireConnection;74;2;69;0
WireConnection;74;3;69;0
WireConnection;74;4;70;0
WireConnection;4;0;11;0
WireConnection;4;1;6;0
WireConnection;26;0;27;0
WireConnection;26;1;4;0
WireConnection;84;0;74;0
WireConnection;84;1;79;0
WireConnection;82;0;74;0
WireConnection;82;1;76;0
WireConnection;80;0;74;0
WireConnection;80;1;75;0
WireConnection;29;0;30;0
WireConnection;29;1;31;0
WireConnection;29;2;25;0
WireConnection;2;0;84;0
WireConnection;2;2;80;0
WireConnection;2;3;82;0
WireConnection;2;9;26;0
WireConnection;2;10;4;0
ASEEND*/
//CHKSM=B4BB6F83A35FC17D6DD5F8D44AF4BDCBB92983F5