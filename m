Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847606;
	b=ovWYxszDuI5PtHM6lTBZRV2uAFSv7ONln66iB/bbhye52epV41F06jOfdevA1Y+f7jUR
	 qevK+3Apm8gO62X6axGRf5qzmF/f8ek8sav6lkhhKLLa05bXkIhaYPnJqhETDSTztOTGG
	 Kl0gc6LzQYGH3QKSMNOPOEkgrEulIN5layYlu0FaLgcDjKfh9PsrW3/sqbZsHz9SBLr3e
	 NZ/pQ7Ls8W0rskfv10HpUNmXRh094CezQtX5RRzjiiXThoBU2MdFSBR9kbcTUQD2f0OzM
	 mEHI/xhsvsXrCSMhqFr6oJuagb3vu3R1tGxqB3bZoWpsJznQ+E8jVsOBRKy92i37f9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847606;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rHESyRjzwA/kXTHGgp8tSYugiabvXB9yhx4gzssp+cM=;
	b=v8n83yqrcJWH503PD02WBx1WRnxNqBQ+esPbGzZXc8xJjWI+H+3dfdvFEoiG02tSLfUf
	 qVTtTGJD7J6eRelw6wAThjTwCL+ymAfK1mAPtFFfTasuOovvvSKqqMnMbW5GtLZRqUd1e
	 t2dCfV8VdDH+WqQhMr2o4FCxw1VJmqxstApaxX2tdY0FUImMUDuI5r2Xyd0pd4CJulDgo
	 oIoGhrKwz8XPVTTAaPTtxNoCN4frOuaQ6NGKv1EqjhJitd40fyBJ+9dwLJCd8YNyDWsHz
	 HEznJMjc/k1HTcUNQng9iikLdiOeJb9XcFN/BBfd3o7hh00qkx2+3z5St6PGsdDm49w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gx4tC3Ot;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.39
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010039.outbound.protection.outlook.com [52.103.10.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C9606A32C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 16:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 309C9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gx4tC3Ot
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmOS5lr4KrBI4vIhegcsr6R51BGAGp87RaK2l6/jHq9LwXT+f9Gk31QlkvmV26fAaeoVRZP0eN7zMvfQKRybwMqEtZtFSLeFt31DWsvFr5yOMclK4HVhvyF9irzKJ1QKOM9SvaCsy40c6wJmCX3pRPFq+jTkU87xjntA01cdKg2aPztRC0Pq4nNg6UIQVLgtruhFuwGZeIUcyRE7ObJ9MjiJL84xr9bvxRNjI0R9kq4irlTdRJu3Fz9WOzcRv5DLlybo09rHB44GwLk4ZUwL9pxz7X5ZSwCFeXdBrDMGbRpbrFuKgghpEHSJ5hAVj4zb9FgdEswg/h6bHtupOHTjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rHESyRjzwA/kXTHGgp8tSYugiabvXB9yhx4gzssp+cM=;
 b=bTEtO6JpRW+9x7UCK+Otdn0wR8MUa0pDlLnJsMtIlSrFneWPnoxB8uLdHvvzH84+JGEXU7GSqTZU0LYrU+QKus7mn93xmxjPSDPPzUfnoVyzh73fd0fsH7Q24/CnK3u5Sjse16LJTrnYmXN/vYKpkI/tgv0K2mQ1noJY8lhKkWi8sVJsGMW0bim8d3TC9YsL5F1YJbz5HDjnfx2UeHiZ5ghmx3cdcu3en4PLiQn17SsB7sBWq70ubzETMuLlzSjpr8+puo4P0gY5rNpkSpkEvwIPswA/CJSxoahtIV9ItElPP5qOCCnSI1lN8LPHA1U5M+SmTxr8QgRmxq85iqv9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHESyRjzwA/kXTHGgp8tSYugiabvXB9yhx4gzssp+cM=;
 b=gx4tC3OtyTD4tDZSamyl6tq3tnmgTA07ZjCA8j/cV8f6UYvBqCNZKImw6GnOfIgSgKN3aqtRkYlcakcu1UjIBKFAyqe25EJ2erlVzi5ezFopVovJeZ8Ga7Ubto32Q4U2ztubfyLB/9/zOTIFWKioVXbnkaKVjmx6aniCUmUhzkAQLMfM8+ZJ0W/cIgfhv4QnqJVLJnTUD2m+mm4pukYGRXTII8/IQADq5cVuq/UYolX8DM3Tra5mJrLsPh6BwmYAGZwEGMlZA2nBDVKSykdZSomV2lZmHNUf3GQAFw6Ye9UOd6RvaH10LtC8q354C3qInnG9pAUwNd5UtHuuI+XIFA==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by LV1PR05MB999048.namprd05.prod.outlook.com
 (2603:10b6:408:409::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:46:43 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:46:42 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "gang.yan@linux.dev" <gang.yan@linux.dev>,
	"kuniyu@google.com" <kuniyu@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>,
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org"
	<geliang@kernel.org>, "ycheng@google.com" <ycheng@google.com>,
	"weiwan@google.com" <weiwan@google.com>
Subject: [PATCH net-next v3 0/3] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Thread-Topic: [PATCH net-next v3 0/3] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Thread-Index: AQHddeoOqMLHJYr2wUWSRTRZFXAAYg==
Date: Mon, 16 Nov 2026 16:46:41 +0000
Message-ID: <cover.1794847474.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|LV1PR05MB999048:EE_
x-ms-office365-filtering-correlation-id: ea93af5f-3273-4ae8-d2a7-08df44013114
x-ms-exchange-slblob-mailprops:
 obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2aDUe2oMT6Cctkw//qk4l6AkPKai972W72OdusDyVSzWWS2jzYgy39Z+/fICAYBAtQaXz1/FPo27WgWDqQ+P+7F3VOfV6PSw5gghN2WLsqULMXWXAM6HBHZu94Rzi3klLLxp8GIOFk7da1U6hjlp9VhZdb2d1/GJ7dG6VliRy5EuSS/VWrcyjwdHXk80Tjw39fsxuYTU+udkg7S+7KmjmlECnMfwijFuCPBGC1NQGAW6xD5HbdzJimX0Su6BlPoITkrr9Wc03T/b7Lt3/+If4e5C5lqkCqVNk/FmcuclCUq75hr8sm2jAdG9Id1rRAGHih6pZBGHZRxOkdhHznHAdLm27k9FtKfMUdjSJC7y7K2fO+85biJ+7kXxJY3FVylKKGCmP4KebPCXHnDtNZQSnYZTrIvg0QabVFCPSS3UtOi+KdRnSkutkpXqPo6ZPG0RgBF7F2GQ3haCytpUma2CP4qTjxnD9BbTLKJxwQWmEjpQzDqcxtTNABQ6cPV3k6l0BY7S0FRHrxyBl6B+1iHOtHEzfduvIUzywUAsF/eEOxTGIS9AGsNoXd697MMboAGIgtbOr+SjIYNGX//h34FyXavbhsnrNIpn/scKGduPUAcHV26GMg2moSGuCDNo2PHS+LPlUCP+FknsysGFHlvncIwSLK5iY8rNh9Tr9A5S3ZwMuvIDDF03P5A2jXDrOcKxGfPEKaqT/mMiV9OzbG4DVVYN3rKzT0A6jqb+OPeAkJ4C35MCDuQhjXylK81T+qOtRIKP1SXxAfJXjRnkF4sTei7AbQL0Rk++x
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|38102599003|22091999003|5062599005|24121999003|8060799015|8062599012|19110799012|51005399006|4140399003|24021099003|25010399006|31061999003|440099028|4302099013|3412199025|102099032|1602099012|10035399007|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWRGUDFaVWNuWnk5S3JZenp6Nm5KT2x6WjhkbXdzY0t2UVQ2cld2QmhKZGJ5?=
 =?utf-8?B?blFMbEVBeXl0WkRaYVcvc213aEV3aWh5MzZiY0ZXRjdsZzNwcWk4NVRnU1Jy?=
 =?utf-8?B?aWJ5eEE4RGxBUXJRQUdVRWtqZHZqU1piRS9SVkxsMjFVelRWek1GWk1uM2xt?=
 =?utf-8?B?emV1WnRJZytlcEtvSFFHV1FxUlFuY1ZkN2hFVG9zcHFqazFacE1zYmlIVnV4?=
 =?utf-8?B?RjJ2OXNIYTZ3emxFVk1nREFyaDVkc1FTMUJjRVlUV2R5MWdtei9GRVJVOUdq?=
 =?utf-8?B?VkFzb291dzJQUXRJbVlJcjBqVUdYcm5LTExqQzFGN25hR041UDlsVkYwb1FF?=
 =?utf-8?B?RXpZbDlvMUpLN25YamhvTjBVRnZxbU9KdHVoL0lpRk10eFV3TjVPVUx1MjRw?=
 =?utf-8?B?WUk4M0UrdUdRZ0h3R0xmVWVTcGh1MUh3UElMWE55ZFBRSGR0UVdCeVNXRHdn?=
 =?utf-8?B?N2psYTFYcEpCVlNVM0pjT0M2cnhZZFY1cGxLbkJLNXJsQjlsNVJ2UVVYbk04?=
 =?utf-8?B?SE1GdlNkOHpFSUo1Z3RyWG4yemdwMTdSdmxzOFdTNFBYcUdTNDJkK05GVXlE?=
 =?utf-8?B?VWVYaFkrNWxVY083elB4U3RIcmFsRHFhV1VZMkFUaTRTL2pYY3F6MWtiT2c0?=
 =?utf-8?B?UnRoRDFsYVJrYkM4YzlYNjhvK0RTZ2VGYUFjTDNFNDF4a2JCWFFpQnVidHFQ?=
 =?utf-8?B?Um9SdFVib0k3VDdSejduWlpMTGpKRjlkK280S3FCOUoxMTl2aS92U2htei9U?=
 =?utf-8?B?MXJjSDVtNGt6UCt5UnZkZzVscW83RFVRL0w3V2pBWWZSMGp5NXFVWnRyNHh5?=
 =?utf-8?B?d1d0WUxpQ0lubnFITU5rMVFmQjNZSG9PbE9wKzFBZzBTajNJaC8xRnNTdFV6?=
 =?utf-8?B?NzFENXYrZ3pCNHcxbU5sM0ZwdE5ZR2FhTVhWQWhkZDN4cGZOU3Q3bW55MjRD?=
 =?utf-8?B?M2tRS1A5OVdqaFJRSUxWRWtBcUdBSFpQbmM3SmpwU3pzdDJnVWYvcWwwZ1pE?=
 =?utf-8?B?RGtVR3JXcjlPV0NPZCtFN0VRYUJxdm8zRDkzWCtzOFdPdmtHMkE4S0gxcUgr?=
 =?utf-8?B?OHM0ZWVUZ0RDQUFtOU9mM3RIOEhWb0FYKy8yQVpNUGpuMmxzb2ZxeHUzVWxM?=
 =?utf-8?B?U2xGcWdKZE5ENkxNRXNyazk4VXdRbG9VRmxjL0RiRk5Nb2U1cG11WjBJekpu?=
 =?utf-8?B?Y1ZmVjRtdkxOM2VwcWEyalUxSW9weVNlM1RsTHB3ZEpmQkw0S3FEZDhvZDEy?=
 =?utf-8?B?aXJGanJMMjRMNmNMbHNiSGJKOGo3K1UvNHBiY0hlT05Ib3R6NWZaeVJudEFH?=
 =?utf-8?B?NzJMV0dVUTdVaVhmcC83V2JRS2NxUUNubHh3TzhlQkd0Y3Jpa3VtOUxQakxH?=
 =?utf-8?B?blJPTFlMNnFDeWtsL2RQRmxDSEFDQnlkL2hhN0piWUgxRkhhMnVGWExWbnZO?=
 =?utf-8?B?QVdGTU9ESnF4MHZzTHUwV0lWKzNPOTNoUTlCRkNCOEM0RWFnUERScGErd1Zm?=
 =?utf-8?Q?S21e3XZWbeUbsPXfYAQaICVC7fx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bklNOGhtVnFMWTdKWkpOVkhHUHRCaVlkOFBlMkxUUy9wZWU0RDhja1NZQ1ZR?=
 =?utf-8?B?dlU4TUpDV05ObThReC9IUlJFL1N1QjBuRDJ3dGZVTGF3WmFNUTJoYjZTTkkx?=
 =?utf-8?B?ZlZUTXZNL2pkaEhvbndJaHRmYitoUXNYYVJiV1lYL0Y1LzhvSEQwcm5CajJG?=
 =?utf-8?B?MlVtK0dQY2h6MXRuNU5UNXNKL1NURWd2S3JvQ2hrVWNGSmRVWGNtcG03cGFr?=
 =?utf-8?B?K21LVUN4UmduNENBYWJ0bGRJUjZJL1F6NUxGSnNOSzdNcmhhNzdFYmRwdnhV?=
 =?utf-8?B?USsza2daK0NYdFRabU5ZWHhQKzRrTjBUT0V0UTg4UC9YUFJPY20vS0xCdjdj?=
 =?utf-8?B?dkVNWGc4ZVRJOS9rZVhjSHVtRTdaVHhGZTVidU9LbXdDK3kyU0Y0bGU0NU5x?=
 =?utf-8?B?amRLY2UvQmNGZVlMQ3hxbGlrSVE3MVpFMnZoNTdrcHZKbnI1bks2Mkw3MEZ6?=
 =?utf-8?B?bjUreEt2cHJJQ280TkgycU5CYTNEb0Z0dFNlVXlzOWRGcDI3ZWhmZ0J3WEl0?=
 =?utf-8?B?dHVzL2t6SUltTTAvcDd6ZVYyaFBmcDNIWXVlVDFMVkgycTZ2eXRrNFBvc1Nv?=
 =?utf-8?B?Z3BTQXprQkpYREExY0VBWloyQ3FiU1VqL05LSTJSQkZ2Zm8rMlpJUkJTRHFz?=
 =?utf-8?B?MVV4K2VJWUNyWUQ3emF5MzlYQ1JMc1JuRGdKeGUvcWJRRUx3OUFQSmpPUStV?=
 =?utf-8?B?dmR1TW5NMWFUS0ZVbkVGeXpRbUFZdzB6NkJBZTRieWxFaGVEa0RFZmtFS3VH?=
 =?utf-8?B?cEMvMWRETUVYNlpISmRiT3dFcEdnbnNhZ3BpZ3gxMW9CaGtMeVExYkdLT1JB?=
 =?utf-8?B?d0ZjY2EzRHE3bWVHK3RINkg4ZnE5aSt0YnlyemJyb3RlUEFyYWR0RGM1Ky94?=
 =?utf-8?B?RUQvVHlFblNpV21walFHcXkvREJ1RGJseDdQTnBKdVJXclZrOElZaVZpM1NI?=
 =?utf-8?B?Z3RBYk9nOFhRNnpPRjVHajAyTXlEMktNLzFrdkFsNkpmQjlIdXNDYUwzWEFp?=
 =?utf-8?B?MGhkY2ZzS0xWcEFZcjQ2d0YzN2ZJYnBBaXNZa0RMYTIvYWhZYWd1OWdLYkRI?=
 =?utf-8?B?R2tjTG83UzBscU1zSEg4RFdhU0NMbExIdzVCSWFqNEZhaGw4T2VSWUhCZHlO?=
 =?utf-8?B?N2s5RDlnL0RCbDdjcC9xNjc4eU5ybzVyNnFYUXNQMjcyYVdBdUN3NDZOeHBH?=
 =?utf-8?B?RXVaUDd0b1lXRi9uTGxndVRTWnFZOVhzRURzR2tkZi9EYXAxQU1VVmVmcGFa?=
 =?utf-8?B?Zys2N3pzSnVTaFgvUHJraXBCRTBOckJ0RkdzY0xPTXpLN0gzTCtxcEhwdDd6?=
 =?utf-8?B?T20xYWlZL2h5VFl5VVEvcXQ2NlI1MlNlT3FiQlNmemVicnlQZVNsdkd6MGV1?=
 =?utf-8?B?azBpRkNEU3lLYjRJRm8yUUdVcDZaeEdrWjJDaC9Ba2cybHJiUTJSNCtmemU5?=
 =?utf-8?B?TTl1a2xqd3BPNUFXc1AreFNEQitteTdUWFEyUVBreEFrOE5lM0FuZmhaS09j?=
 =?utf-8?B?Sk41eC9qb0JaTytIaWs1M0pQV3VwMVdQVEtrM0x5NFpGRUxHL3ZyNzhoaW9k?=
 =?utf-8?B?SEFTYU1GYzNCbE9VZUZrL3RCaTM1WHJqNW9xVGJuMHFTeWJDSWsvZHVjWTNh?=
 =?utf-8?B?T3VEd2RpV1VLL2JaMHY4L1p4L21pWVJnY09qT0NhNGxobTEraG1DejA2U0tN?=
 =?utf-8?B?K3Z4TDFqVldPaEJBKzB5MWR6RjQvQW9lVGxxU2ZUaXN5SFl0WGlXZEpGS1lP?=
 =?utf-8?B?ZmFaQ0dSVDl3TVp4bEdEYmQ4ZWg2QW1vUldnOXlDTW45cnlwZVRZZ3VoekdB?=
 =?utf-8?B?eHBYREtwK1JlSGo4MnJTUUV0QndCQzB3SXZQN0RNazc4Z1pUb2JBUFRxUVRK?=
 =?utf-8?Q?3eTKJYnFyhFbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ea93af5f-3273-4ae8-d2a7-08df44013114
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 16:46:41.8493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR05MB999048

VGhlIFRDUCBGYXN0IE9wZW4gYW5kIE1QVENQIGJsYWNraG9sZSBoYW5kbGVycyBtdWx0aXBseSB3
cml0YWJsZSB0aW1lb3V0CnN5c2N0bCB2YWx1ZXMgYmVmb3JlIGFkZGluZyB0aGUgcmVzdWx0IHRv
IGEgamlmZmllcyB0aW1lc3RhbXAuIFRoZQptdWx0aXBsaWNhdGlvbiBpcyBwZXJmb3JtZWQgaW4g
MzItYml0IHVuc2lnbmVkIGFyaXRobWV0aWMsIHNvIGEgbGFyZ2UKdmFsdWUgY2FuIHdyYXAgaW50
byBhIHNob3J0IGRlbGF5IGV2ZW4gb24gNjQtYml0IGtlcm5lbHMuCgpXaXRoIEhaPTEwMDAgYW5k
IHRoZSBtYXhpbXVtIG11bHRpcGxpZXIgb2YgNjQsIGFueSB0aW1lb3V0IGFib3ZlIDY3MTA4CnNl
Y29uZHMgd3JhcHM7IDY3MTA5IHNlY29uZHMgYmVjb21lcyA4LDcwNCBqaWZmaWVzICg4Ljcgc2Vj
b25kcykgaW5zdGVhZApvZiBhYm91dCA1MCBkYXlzLiBQYXRjaGVzIDEgYW5kIDIgY29tcHV0ZSB0
aGUgZGVsYXkgaW4gdTY0IGFuZCBjYXAgaXQgYXQKTUFYX0pJRkZZX09GRlNFVCBiZWZvcmUgYWRk
aW5nIGl0IHRvIHRoZSBzYXZlZCB0aW1lc3RhbXAuIFBhdGNoIDEgYWxzbwpsaW1pdHMgdGhlIFRD
UCBzeXNjdGwgdG8gb25lIGRheS4KClBhdGNoIDMgYXBwbGllcyB0aGUgc2FtZSBvbmUtZGF5IGxp
bWl0IHRvIG5ldC5tcHRjcC5ibGFja2hvbGVfdGltZW91dCwKZm9sbG93aW5nIEVyaWMncyBjb21t
ZW50IHRoYXQgdGhlIHR3byBzeXNjdGxzIHNob3VsZCBiZWhhdmUgY29uc2lzdGVudGx5CmFuZCBN
YXR0aGlldSdzIGFncmVlbWVudC4KCkJvdGggbGltaXRzIHJlamVjdCB2YWx1ZXMgdGhhdCB3ZXJl
IHByZXZpb3VzbHkgYWNjZXB0ZWQsIHNvIHRoZSBzZXJpZXMKdGFyZ2V0cyBuZXQtbmV4dCBhbmQg
aXMgbm90IGludGVuZGVkIGZvciBzdGFibGUuCgpDaGFuZ2VzIHNpbmNlIHYyOgoKLSBUYXJnZXQg
bmV0LW5leHQgYW5kIGRyb3AgQ2M6IHN0YWJsZSwgYXMgcmVxdWVzdGVkIGJ5IEVyaWMuIEtlZXAg
dGhlCiAgRml4ZXMgdGFncy4KLSBNb3ZlIHZlcnNpb24gaGlzdG9yeSBhbmQgZWFybGllciB0ZXN0
IHJlc3VsdHMgdG8gdGhlIGNvdmVyIGxldHRlci4KICBUaGUgY29tbWl0IG1lc3NhZ2VzIGRlc2Ny
aWJlIHRoZSBwcm9ibGVtLCB0aGUgZml4LCBhbmQgaG93IHRoZSBmaW5hbAogIGNvZGUgd2FzIHZh
bGlkYXRlZC4KLSBVc2UgNjcxMDkgc2Vjb25kcyBhcyB0aGUgZXhhbXBsZSBhbmQgcmVwcm9kdWNl
ciB0aW1lb3V0LiBJdCBpcyBpbnNpZGUKICB0aGUgb25lLWRheSBsaW1pdCBhbmQgc3RpbGwgd3Jh
cHMgYXQgdGhlIDY0LWZvbGQgYmFja29mZiB3aXRoIEhaPTEwMDAuCi0gTWVudGlvbiBpbiB0aGUg
Y2hhbmdlbG9ncyB0aGF0IHdyaXRlcyBhYm92ZSB0aGUgbGltaXQgbm93IGZhaWwuCi0gQWRkIHBh
dGNoIDMsIGxpbWl0aW5nIG5ldC5tcHRjcC5ibGFja2hvbGVfdGltZW91dCB0byBvbmUgZGF5Lgot
IFBhdGNoZXMgMSBhbmQgMiBoYXZlIHRoZSBzYW1lIGNvZGUgYXMgaW4gdjIuIEdhbmcgWWFuJ3Mg
UmV2aWV3ZWQtYnkgaXMKICBrZXB0IG9uIHBhdGNoIDIuCgp2MjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci9jb3Zlci4xNzk0NjcyNjE5LmdpdC54LXByb2Zlc3NvckBvdXRsb29rLmNvbQp2MTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9jb3Zlci4xNzk0MzI1NjY1LmdpdC54LXByb2Zlc3Nv
ckBvdXRsb29rLmNvbQoKVGVzdGluZyBvbiBuZXQtbmV4dCA3Y2NjNWUwNTA0M2IsIHg4Ni02NCwg
SFo9MTAwMC4gVGhlIGxvb3BiYWNrCnJlcHJvZHVjZXJzIGluZHVjZSAxMiBURk8gb3IgTVBUQ1Ag
YmxhY2tob2xlcyBhbmQgdGhlbiBvcGVuIGEgcHJvYmUKY29ubmVjdGlvbjoKCi0gVGltZW91dCA2
NzEwOSBzZWNvbmRzLCBwcm9iZSBhZnRlciAxMCBzZWNvbmRzOiB0aGUgdW5wYXRjaGVkIGtlcm5l
bAogIHJldHJpZWQgYWN0aXZlIFRGTyAoMS4wNTYgcywgVENQRmFzdE9wZW5BY3RpdmVGYWlsICsx
KSBhbmQgTVBfQ0FQQUJMRQogICgzLjA1MyBzLCBNUENhcGFibGVTWU5UWERpc2FibGVkICswKS4g
V2l0aCBhIDUgc2Vjb25kIHdhaXQgaXQgc3RpbGwKICBza2lwcGVkIGJvdGgsIG1hdGNoaW5nIHRo
ZSB3cmFwcGVkIDguNyBzZWNvbmQgaW50ZXJ2YWwuIFRoZSB2MyBrZXJuZWwKICBza2lwcGVkIGJv
dGggYWZ0ZXIgMTAgc2Vjb25kcyAoMC4wMDAgczsgKzAgYW5kICsxKS4KLSBUaW1lb3V0IDY5MTIy
MTMgc2Vjb25kcywgcHJvYmUgYWZ0ZXIgMS4yIHNlY29uZHM6IHRoZSB1bnBhdGNoZWQga2VybmVs
CiAgcmV0cmllZCBib3RoLiBPbiBhIHRlc3Qga2VybmVsIHdpdGggcGF0Y2hlcyAxIGFuZCAyIGFw
cGxpZWQgYW5kIG9ubHkKICB0aGUgVENQIGlucHV0IGxpbWl0IHJlbW92ZWQsIGJvdGggcmVtYWlu
ZWQgZGlzYWJsZWQuCi0gT24gdGhlIHYzIGtlcm5lbCwgYm90aCBzeXNjdGxzIGFjY2VwdCAwLCAx
LCAzNjAwLCA4NjM5OSBhbmQgODY0MDAgYW5kCiAgcmVqZWN0IC0xLCA4NjQwMSwgNjkxMjIxMyBh
bmQgSU5UX01BWCB3aXRoIEVJTlZBTCwgbGVhdmluZyB0aGUgcHJldmlvdXMKICB2YWx1ZSB1bmNo
YW5nZWQsIGluIHRoZSBpbml0aWFsIGFuZCBpbiBhIG5ldyBuZXR3b3JrIG5hbWVzcGFjZS4KICBE
ZWZhdWx0cyBhcmUgdW5jaGFuZ2VkLiBXaXRoIDg2NDAwIHNlY29uZCB0aW1lb3V0cywgdGhlIHJl
cHJvZHVjZXJzCiAgc3RpbGwgZGlzYWJsZWQgYWN0aXZlIFRGTyBhbmQgTVBUQ1AuCi0gVGhlIGFm
ZmVjdGVkIG9iamVjdHMgYnVpbGQgd2l0aCBXPTEgb24geDg2LTY0IGFuZCBpMzg2IGF0IGVhY2gg
cGF0Y2guCgpUaGUgMzItYml0IGJlaGF2aW91ciBvZiB0aGUgTUFYX0pJRkZZX09GRlNFVCBjYXAg
d2FzIGNoZWNrZWQgYnkgaTM4NgpidWlsZHMgYW5kIGFyaXRobWV0aWMsIG5vdCBhdCBydW50aW1l
LiBUaGUgVENQIGFuZCBNUFRDUCBzZWxmdGVzdHMgd2VyZQpub3QgcnVuIGxvY2FsbHk7IG5vbmUg
b2YgdGhlbSBzZXRzIHRoZXNlIHN5c2N0bHMuCgpUaGUgaXNzdWVzIHdlcmUgZm91bmQgdXNpbmcg
YSBzdGF0aWMgYW5hbHlzaXMgdG9vbC4KCllpbmdqaWUgV2FuZyAoMyk6CiAgdGNwOiBhdm9pZCB3
cmFwcGluZyBGYXN0IE9wZW4gYmxhY2tob2xlIHRpbWVvdXQKICBtcHRjcDogYXZvaWQgd3JhcHBp
bmcgYmxhY2tob2xlIHRpbWVvdXQKICBtcHRjcDogbGltaXQgYmxhY2tob2xlX3RpbWVvdXQgdG8g
b25lIGRheQoKIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0ICAgIHwgIDEg
KwogRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL21wdGNwLXN5c2N0bC5yc3QgfCAgMSArCiBuZXQv
aXB2NC9zeXNjdGxfbmV0X2lwdjQuYyAgICAgICAgICAgICAgICB8ICAxICsKIG5ldC9pcHY0L3Rj
cF9mYXN0b3Blbi5jICAgICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrLS0tCiBuZXQvbXB0
Y3AvY3RybC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrLS0tCiA1
IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgoKYmFzZS1j
b21taXQ6IDdjY2M1ZTA1MDQzYjFiYjg0MzI2YjE5YTJiMDU5MzhkOGY3YTJhZTYKLS0gCjIuNDMu
MAoK
