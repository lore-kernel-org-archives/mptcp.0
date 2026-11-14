Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794672755;
	b=TJI1liAwXP0bUZHgLPducFitHHDqbR2lq64q20XTxjyakbGWCpr4lpu+NYzo2mbxzetk
	 L54fLNugS+t86r0N88z5Fa+ud/Tlroz6KF02I7kFhaPB9vRpTwF2aw16ZePRdQdyGE6/j
	 P+8WLpB3BDNtGo9QATLXwAN3e3ulPydYNMU8/gkEFJjWulpLrS9Eb5cU1x+lz926wqPjK
	 aoM+GurDwFUCAoIE6RlNOJIBWSycDD2P5AqRvaB0Whv7fRMTAHuKk42DYa2PnSGiTR6dS
	 vzGiy/lmsDcaIDsU6mkczejA1tCXw/+0pZKfmPu1xH9xDsdeU9GFK87etTQ2u3PZLxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672755;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
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
	bh=636EHer3YsUHmZNmuFLw2g9hSAEv0HtXpMgI8eeuJJ8=;
	b=0H8QeU+EO4WWY6jH3+syMs2IiAaNY8tSkgKRhqM8Y19sP7tj7ZqIxkKgpP6dJI3P4m5R
	 tRDKQtfA5cORkMnhdQPMy04ol1Pl54Or8oIk6IIWfeufI+W9C2uEz9D1izxRGTBSDWsVo
	 6sSLsTyy9rLjsw8hica7Z+yhbo+NsoLmgtZw7Hgdxo79bcOEVwaCsD65Oqxlu4PiPQnvp
	 6w4gczAALdr1+zSCm6bNbAetcZXWJ9JkKwf2SeoNmj10aztrlqm/NdIaHTqjaFXxkTKbc
	 oW4qEoLDGnyLieSnQeB4lsOwfLhdhtmMivUf3lWrq5Ppp3Ty9zDRvvtFJgCVurnFiMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PRx9QDGC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.24
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011024.outbound.protection.outlook.com [52.103.12.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29A606A886
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 16:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B29A606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PRx9QDGC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeohRRlVyL/1Sr6Wp7eOTXquRIXOmVgiU7+jMWcWoB/JRC4+RVIAQBbhY8EoyYPzascwwtn0NTGRw+OgdY8XRgPzr29CR+qWb/bvwTLm7J7y0AvaUWAl+Kh7WctT95c9yyYfgg0xfKtiYHe9EAUftFMcTi/ht54cBedmrY0oBxcx97GgUMHFNMKUCS5pNHq6lsCzR27ar4ZwEgXhkOLoqk3V6MnvoTP9PKZN5Nhm/TBfrGf3yekVDQQSrv2pJztfty4+V84BrfrnU89Kv+TnG6TjPHTFcvwtPr4Je8+764dzhSMjlTCelMDTA0aeY56ffsnd04IEbZNgIDH42Qsdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=636EHer3YsUHmZNmuFLw2g9hSAEv0HtXpMgI8eeuJJ8=;
 b=VM7LvVV4nRNuf0X8oytNi0q+zkLTsYO1xBNxoSzIp76jpQsx8NjJMccqm/hsMwBfhwzgd/dZX941M+POwHuMi23zzt5OGfi1zSsUHSBgqP8aJueKoQ3Soe4eItjbrsg5qhEQkKTI5mrPPtpnkl9j58ksf9ae+3r1AzKDnWxXItYZYU16xWkgIkrmiQAln/XJW4s8n0NdJwL04hfdvbG0gWGaWbFDmbAQ5KxOtUH7l1nnUYf3M6Iia1lVWM3nXHQl8rG5Ne2QNz4u3D4MZOOwgGp2ti6vWccabH2u6f3ImwsIEAbXTtODVEQAaesdJxAyKn+/uwtSKDxEPvoUZ2qK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=636EHer3YsUHmZNmuFLw2g9hSAEv0HtXpMgI8eeuJJ8=;
 b=PRx9QDGCv1HOK7PXybodpkd+ucANVkZACiFPR1Wizbwxpr4ankRS1wlkCEsCMzMDfpT+Sg51O+6IuH06L2EwsCTLBmJuA63oXTzWfKJjxeOXpK+v4MndQj0spc9znqzmB8TEd4BGnXMdjuwUd/rrGQjcWZ1/cJ0cwdSNV51ETKJqC2FY8K41JyV86V8aPUr/ZRa8bUqL0yT9FhJiG4VTgkRD6TjbWxH9pJ8iL06ldeeWhIjeFrSJQZDw/+RHkE8frfmgns+oaWW2XJ1YEmrDeVLWCALkazTSt4Uykvf6+gcfQCBjTANzOdXRzWiVjw5hQhoZ/had38gp31ol1Vgxdg==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by CY5PR05MB999471.namprd05.prod.outlook.com
 (2603:10b6:930:128::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 16:12:32 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 16:12:31 +0000
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
Subject: [PATCH net v2 0/2] tcp/mptcp: prevent blackhole timeout arithmetic
 wraparound
Thread-Topic: [PATCH net v2 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Thread-Index: AQHddFLzQPLWdTevZEuOlEKHRyp44Q==
Date: Sat, 14 Nov 2026 16:12:31 +0000
Message-ID: <cover.1794672619.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|CY5PR05MB999471:EE_
x-ms-office365-filtering-correlation-id: e5bc0ed3-bd1c-451f-f44c-08df426a1609
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|51005399006|5062599005|8060799015|8062599012|19110799012|24021099003|31061999003|25010399006|24121999003|4140399003|15080799012|22091999003|10035399007|1602099012|40105399003|102099032|440099028|4302099013|3412199025|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkxlNUVGQktNcUUwbzlXOVVQRXpQZFprTnhOc1ZLU05qUXRtbU5xazExNHFX?=
 =?utf-8?B?K3pRMlBndHl1OXN1VXBiTWlnMTIyVkJSeU4rSXh0Qlk4VXdHZW5Uc0RYRzBZ?=
 =?utf-8?B?YzFwT1h6czd3SjcvM0t1OXlHRkxkWUxSdjcyL0F3MDVJMjNEZGlVbWs4bTdP?=
 =?utf-8?B?TFljL0dlM3JGV2VsTGhUczZVUFY3OGtRUk5YOW1LOGhMUUlyUHJ5YkRxQzBt?=
 =?utf-8?B?S3g2MEVCZUFla2U0cmdlS0VmYlJuRmFYTU55Zk5pUzdObmRnWjVYU09yRFE4?=
 =?utf-8?B?VVZBZ0ZMd3NPNWVXcjNxZGJ5RzNMbGVhSGNGaXNDaEpwTXBHWTBHQnZpUlhC?=
 =?utf-8?B?d0wwTkNvcmlBeGlLQ2piMjRwUFpUMnFtRmNSZDJzK0gyb09maFhrVEkxdnQ5?=
 =?utf-8?B?eHUxOCtydisxZDRmTDhjaDFUNDVrY0g0U2d0Y25TaXVTdEtYci9BSHBXaUZN?=
 =?utf-8?B?RVVNS29YWVEwVjZIZGEyWkMyeU1ISEc4WUk2M0NweUFKRFV3SWZNUlIrbTI0?=
 =?utf-8?B?TzJ5VDUwT1NnVXpsNVNTYXRDeXRlTTRBSVVMejE3VGpyNWphV1plMEZaT2tM?=
 =?utf-8?B?QTRTcUhpRUphSkEwc3dYNlVGeWdhWEJQTVc2UzZZQ1FJQ3lydUhKdlJ1R0Ra?=
 =?utf-8?B?c2R0dy9wQURQQzY0bk55WjJESGxGWmY2OXZiT09QMFBCNTgxY3F0dmNZdFdL?=
 =?utf-8?B?dWdJQytjanZRMDllaW9DRldxRnl3QjhlNTJvaUVtNldJSlZuOXcyekYvS1hF?=
 =?utf-8?B?ekFPT3E4aEdTZklvOVZrN0ZXaHZtMURXZlAvSWE5NnRWMlFxZmM4YmJITlFT?=
 =?utf-8?B?THBlUFk0enRhUGhYdVBpOWpndXRDVlh2eGM0U096OWFNakVyMytMTTZTS0RC?=
 =?utf-8?B?WEErTnNXbm9CeDhKa3phTUZGUmFNdUwzcVphRXlYcjBQb0V3OFBDM05WNC9Q?=
 =?utf-8?B?NmtlaWpLcWJydXYvbEFaV1E1S3Z2RkJuYlNEajhhcnJEb1A5VTg2UDZNWW1z?=
 =?utf-8?B?aG1mWkhvc0R6eTM3SHZhY2dwRi9lUzgrR29SSHJtSFRmT3ZhZFN6aW50eHd2?=
 =?utf-8?B?cVZyUjY3VEVORUx4UExPeUJZTk4wQnV3Z25LYzF4K0JRSi80bjg3MDFYR2NP?=
 =?utf-8?B?YWkrekFFRzAyM1VSVTN5VXZzc013TFMxY3B0VktzbDBSdFM5Q21NVmdDNita?=
 =?utf-8?B?ODVSSlAvZ0VZTWJKbkF4eFpzV1ZtRHpwN3JuaS9GdGpkeVRsSVkzb0pDMHdh?=
 =?utf-8?B?WGVTWllJdlNpS1Y4bitjVVAwazJEYUMvK3B4SUNMelc4b2dZaWM2Slh2RGpt?=
 =?utf-8?B?c0lacjhyMVo2OXlOcVJ5ZEFHalFPdmM3MmZzRnNrWUo2aHpzK29wRzJmM016?=
 =?utf-8?B?M0hKcnlSRUhNQ29LbDFWQWtDTUNva0Y5OFRpMi9rdlFjWHQ5dGNQbUhyZWlT?=
 =?utf-8?B?TDFjM1N0eXY4TVY2SzZvaTZwVk8waXcxdmVaUVAzZ2xKM3RYVXBzTzB6V0NZ?=
 =?utf-8?Q?5j5dUzczo99i46OrFDcZEa9vI4e?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnR4Y2pvOFVVWmVpek1qcUsvNmdqb3VlV2lOZCtyM1Y0WE14S2lYZFJyRktv?=
 =?utf-8?B?UjErZGpWTHRBdFkwbTFmMkdPNzRvcFo1eVVzcmt5aEozL1dwVUtjTWRBaEYw?=
 =?utf-8?B?Qk50d3J4ZDZZOGZWQSt2Y1BmMUc4bnlBa0JFUXlHdnhRNTJhZWZKR2w0NlZK?=
 =?utf-8?B?VXRPOUgyUU1mVDJYZG9sVXZWeUdzT2xPMkU2elpzNUdvZnVJTVhCY0NrUjJo?=
 =?utf-8?B?eVBJdFJRN0ptOTNIRyt0M0xUQ1J4bVRxVWdBZC8zKzRESS9lNUNCcy9WUzJq?=
 =?utf-8?B?MEhxUUpCZ0dKZ2xRdG5GUFRpQUoxVjYyMnl4dW1PZXlscDd5MHlhV3FhK2Zz?=
 =?utf-8?B?eTR6OUhJNXlaNDF2dld4Y1RoYlpLSTlmcFFUMC9TUVF4ejBuNUxLYkt3Wlho?=
 =?utf-8?B?SHdOc29kbmNXWXpsRXNJcmllUHdLSElvWnVLeStsdDdFYlRodnZrYU1VeTBG?=
 =?utf-8?B?Q1F5dUprSVlyZ0NKUlpsZ2tSUitURnF2bUlETHJwbEdvc0E1VDEwK1RrQnBV?=
 =?utf-8?B?dFNlRzRNTHZUTXNNVHRxQ2RvYTZUWUpoRjZ1Z3lHVDk1L0VKU3YyUWdyUkFY?=
 =?utf-8?B?bVBrYjltS2RLVU9Fbzc5ckhPb2ZxNkE4L0tKSnNOWW1xVE5DU2hZS0ZraTlV?=
 =?utf-8?B?dWVXUHNyQUx0SG1TbVFLU0Y1YW9qeE93cXEvRXRxUjczcDlSVnFJSjBpQ01Z?=
 =?utf-8?B?QTdVWXhuMDROaTZjVVBYNWlidDRCN1BkMUJVQnlPWWloMHdnSEJqM1VqNlY2?=
 =?utf-8?B?UW43RnAvd2Faa2JjWmFmcjlwT1YzcmNnWmJZVXJmRU5lMHVJQm5iMG9VK2M1?=
 =?utf-8?B?blVuRmtjNjBFWWFPc1hpZ2k3QlY5bjNFTWNsRmRiMUxOUjEraVhhVXVJMmtT?=
 =?utf-8?B?NSthVzJ1cWpBcGwxT05hYWFBL2xJTWxoVjJDemxyTk82bmM1NERubU1yaFRS?=
 =?utf-8?B?ZVZINkZBVzZpVDRybVloL2pEZlQ0UzdlZ0JLNkd5L0dtMTNKQXA4Z3dQSUt1?=
 =?utf-8?B?S2ZDZlB2aUN1NG1ZeTJ4QVp5Mm5FTENBVEtVMzF3cDlvaTZzdXlQQlI4TFh2?=
 =?utf-8?B?ZFdMNk1ScWdrSnZ5Rk1LWFAwNE85dDhxMXQxOW41VWZRSVZPQk5iUEJkSDhh?=
 =?utf-8?B?Ump3RTR6c1JUbjZkU2ZrS1RpL3lOcGJWT2pNOTF3K3JFZXRrM3EzdE9DVVE0?=
 =?utf-8?B?blFkQzFPWVU2c21Fa0tCMVRhaHVtM3hib1IyMEtkTXIyZ3dSZzcxZEdJdXVX?=
 =?utf-8?B?OUdkOVplZlVmZlBXRHRQL0Jjb1JEVW4wY1BmMGZ2czNyMVZmekdqN2h3Q3FQ?=
 =?utf-8?B?ODlITlFGZStRTENoVzg0cTFVR1dMT0xIdlZYN01ZSlgvWFJoNzNYRW1xTnR0?=
 =?utf-8?B?OTZFV3hsYkN5ejhaeU5tNzVUN2dOU0ttZERFYTJHc01oMVJqNGRFclhnY1Y2?=
 =?utf-8?B?cjkxU2o3RFo3MEtISTJFeDdBRHdDSUhrOW50SENqMUVVUUplVkhBUjUrbHcz?=
 =?utf-8?B?WDZxc0VsY1NmaEl4SnJCeDlmOGJUb3RPZDRMVlR3SFZZelREV3JDZi9wS2lL?=
 =?utf-8?B?dHRTMlMyV0VqR1FObGc5SjNjN1RkTzN5VHZFa0toVzRwWHFwNjdKTHkzNjRJ?=
 =?utf-8?B?eFdGNGp5KzhwRS9DeHBMcThoTGhnbzFnenhCQVBWMDNSdHZOVzZwQ09KWXhV?=
 =?utf-8?B?bnUyV1IzVnJtbkw4Q09RMUsvd2JMUTd0TlJLZUlQK2k5aUcyUDRxYU1kblVG?=
 =?utf-8?B?NUU3Zkp6a1JDM2RhbGZjVmNRazdUSHRLY2M2bFhTT2ZDdVVKMi9qbktyZ2tn?=
 =?utf-8?B?V2o4ckhvMFh0dS9kUmNuNVpIRmIrd1IyaWcrWlIzSWR0TzQ1Y3RNemNWc3Z5?=
 =?utf-8?Q?kdqMlI8ee7b4B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bc0ed3-bd1c-451f-f44c-08df426a1609
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2026 16:12:31.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR05MB999471

VGhlIFRDUCBGYXN0IE9wZW4gYW5kIE1QVENQIGJsYWNraG9sZSBoYW5kbGVycyBtdWx0aXBseSB3
cml0YWJsZSB0aW1lb3V0CnN5c2N0bCB2YWx1ZXMgYmVmb3JlIGFkZGluZyB0aGUgcmVzdWx0IHRv
IGEgamlmZmllcyB0aW1lc3RhbXAuIFRoZQptdWx0aXBsaWNhdGlvbiBpcyBwZXJmb3JtZWQgaW4g
MzItYml0IHVuc2lnbmVkIGFyaXRobWV0aWMsIHNvIGEgbGFyZ2UKdmFsdWUgY2FuIHdyYXAgaW50
byBhIHNob3J0IGRlbGF5IGV2ZW4gb24gYSA2NC1iaXQga2VybmVsLgoKV2l0aCBIWj0xMDAwLCBh
IHRpbWVvdXQgb2YgNjkxMjIxMyBzZWNvbmRzIGFuZCB0aGUgbWF4aW11bSBtdWx0aXBsaWVyIG9m
CjY0IHNob3VsZCBwcm9kdWNlIDQ0MiwzODEsNjMyLDAwMCBqaWZmaWVzLCBidXQgdGhlIGN1cnJl
bnQgY2FsY3VsYXRpb25zCnRydW5jYXRlIHRoZSByZXN1bHQgdG8gNTEyIGppZmZpZXMuIEJvdGgg
cGF0Y2hlcyBjb21wdXRlIHRoZSBkZWxheSBpbiB1NjQKYW5kIGNhcCBpdCBhdCBNQVhfSklGRllf
T0ZGU0VUIGJlZm9yZSBhZGRpbmcgaXQgdG8gdGhlIHNhdmVkIHRpbWVzdGFtcC4KClRoZSBpc3N1
ZXMgd2VyZSBmb3VuZCB1c2luZyBhIHN0YXRpYyBhbmFseXNpcyB0b29sLiBJbiB0aGUgdjEgYXJp
dGhtZXRpYwpBL0IgdGVzdHMsIGxvb3BiYWNrIHJlcHJvZHVjZXJzIGluZHVjZWQgMTIgYmxhY2to
b2xlcywgd2FpdGVkIDEuMiBzZWNvbmRzLAphbmQgdGhlbiBtYWRlIGEgbmV3IGNvbm5lY3Rpb246
CgogIFRGTzogICBiYXNlIHByb2JlIDEuMDI2IHMsIFRDUEZhc3RPcGVuQWN0aXZlRmFpbCArMTsK
ICAgICAgICAgZml4ZWQgcHJvYmUgMC4wMDAgcywgVENQRmFzdE9wZW5BY3RpdmVGYWlsICswLgog
IE1QVENQOiBiYXNlIHByb2JlIDMuMDg3IHMsIE1QQ2FwYWJsZVNZTlRYRGlzYWJsZWQgKzA7CiAg
ICAgICAgIGZpeGVkIHByb2JlIDAuMDAwIHMsIE1QQ2FwYWJsZVNZTlRYRGlzYWJsZWQgKzEuCgpU
aGUgVEZPIGNvdW50ZXIgcmVjb3JkcyBhbm90aGVyIGZhaWxlZCBhY3RpdmUgRmFzdCBPcGVuIGF0
dGVtcHQuIFRoZQpNUFRDUCBjb3VudGVyIHJlY29yZHMgYSBjb25uZWN0aW9uIHRoYXQgc2tpcHMg
TVBfQ0FQQUJMRSBhbmQgZmFsbHMgYmFjayB0bwpUQ1Agd2hpbGUgYWN0aXZlIE1QVENQIGlzIGRp
c2FibGVkLgoKQ2hhbmdlcyBzaW5jZSB2MToKCi0gQWRkIGEgcmVhc29uYWJsZSB1cHBlciBib3Vu
ZCBmb3IgdGhlIFRDUCBGYXN0IE9wZW4gc3lzY3RsLCBhcyByZXF1ZXN0ZWQKICBieSBLdW5peXVr
aSBJd2FzaGltYS4gVGhpcyB2ZXJzaW9uIHByb3Bvc2VzIG9uZSBkYXkgKDg2NDAwIHNlY29uZHMp
LAogIHVzaW5nIHRoZSBleGlzdGluZyBJUHY0IG9uZV9kYXlfc2VjcyBib3VuZCwgYW5kIGRvY3Vt
ZW50cyB0aGF0IGxpbWl0LgogIEtlZXAgdGhlIGV4aXN0aW5nIE1QVENQIHN5c2N0bCBpbnB1dCBy
YW5nZS4KLSBDbGFyaWZ5IHRoYXQgdGhlIG11bHRpcGxpZXIgaXMgbGltaXRlZCB0byA2NCBhbmQg
dGhlIGZpbmFsIGRlbGF5IGlzCiAgc2VwYXJhdGVseSBjYXBwZWQgZm9yIHNhZmUgamlmZmllcyBj
b21wYXJpc29ucyBvbiAzMi1iaXQgc3lzdGVtcywKICBhZGRyZXNzaW5nIEdhbmcgWWFuJ3MgY29t
bWVudC4gS2VlcCB0aGUgUkVBRF9PTkNFL1dSSVRFX09OQ0UgcGFpcmluZwogIGFubm90YXRpb25z
IG5leHQgdG8gdGhlIHRpbWVzdGFtcCByZWFkcy4KLSBJZGVudGlmeSB0aGUgb3JpZ2luYWwgcnVu
dGltZSByZXN1bHRzIGFzIHYxIGV2aWRlbmNlIGluIGJvdGggY29tbWl0cy4KLSBSZXRhaW4gR2Fu
ZyBZYW4ncyBSZXZpZXdlZC1ieSB0YWcgb24gdGhlIHVuY2hhbmdlZCBNUFRDUCBhcml0aG1ldGlj
IGZpeC4KCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL2NvdmVyLjE3OTQzMjU2NjUuZ2l0
LngtcHJvZmVzc29yQG91dGxvb2suY29tCgpPbiB0aGUgZmluYWwgdjIgeDg2LTY0IEhaPTEwMDAg
a2VybmVsLCBUQ1AgYWNjZXB0cyA4NjQwMCBhbmQgcmVqZWN0cyA4NjQwMTsKTVBUQ1Agc3RpbGwg
YWNjZXB0cyA4NjQwMSBhbmQgSU5UX01BWC4gQm91bmRhcnkgdGVzdHMgYWxzbyBjb3ZlciB6ZXJv
LApuZWdhdGl2ZSBhbmQgb3ZlcnNpemVkIHZhbHVlcywgZmFpbGVkLXdyaXRlIHByZXNlcnZhdGlv
biwgZGVmYXVsdHMsIGFuZApuZXR3b3JrIG5hbWVzcGFjZSBpc29sYXRpb24uIFRoZSBsYXJnZSB0
aW1lb3V0IHVzZWQgaW4gdGhlIHYxIFRGTyB0ZXN0CmlzIG5vdyByZWplY3RlZCBieSB0aGUgVENQ
IHN5c2N0bCBsaW1pdC4KClRoZSBNUFRDUCBibGFja2hvbGUgdGVzdCB3YXMgcmVydW4gb24gdGhp
cyB2MiBrZXJuZWw6IGFsbCAxMiBjbGllbnRzCmNvbXBsZXRlZCwgYW5kIHRoZSBwcm9iZSB1c2Vk
IFRDUCBmYWxsYmFjayBkaXJlY3RseSAoMC4wMDAgcywKTVBDYXBhYmxlU1lOVFhEaXNhYmxlZCAr
MSkuIFRoZSBmdWxsIHg4Ni02NCBrZXJuZWwgYnVpbGQgYW5kIGFmZmVjdGVkCm9iamVjdCBidWls
ZHMgb24geDg2LTY0IGFuZCBpMzg2IHBhc3NlZC4gVGhlIHVwc3RyZWFtIFRDUCBhbmQgTVBUQ1AK
c2VsZnRlc3Qgc3VpdGVzIHdlcmUgbm90IHJ1bi4gRnVsbCBhbGx5ZXNjb25maWcvYWxsbW9kY29u
ZmlnIFc9MSBidWlsZHMKc3RvcHBlZCBhdCB3YXJuaW5ncyBwcm9tb3RlZCB0bwplcnJvcnMgaW4g
dW5jaGFuZ2VkIGxvY2tkZXAsIGNvZGEsIGFuZCB4ODYgY2FsbHRodW5rcyBjb2RlOwp0aGUgYWZm
ZWN0ZWQgb2JqZWN0cyBwYXNzZWQgVz0xIEtDRkxBR1M9LVdlcnJvciBpbiBib3RoIGNvbmZpZ3Vy
YXRpb25zLgoKVGhlIHBhdGNoZXMgYXJlIGluZGVwZW5kZW50IGFuZCBoYXZlIHNlcGFyYXRlIEZp
eGVzIHRhZ3MuCgpZaW5namllIFdhbmcgKDIpOgogIHRjcDogYXZvaWQgd3JhcHBpbmcgRmFzdCBP
cGVuIGJsYWNraG9sZSB0aW1lb3V0CiAgbXB0Y3A6IGF2b2lkIHdyYXBwaW5nIGJsYWNraG9sZSB0
aW1lb3V0CgogRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2lwLXN5c2N0bC5yc3QgfCAgMSArCiBu
ZXQvaXB2NC9zeXNjdGxfbmV0X2lwdjQuYyAgICAgICAgICAgICB8ICAxICsKIG5ldC9pcHY0L3Rj
cF9mYXN0b3Blbi5jICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrLS0tCiBuZXQvbXB0Y3Av
Y3RybC5jICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKy0tLQogNCBmaWxlcyBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0OiAz
MGM3MTQ3NmQ4NDJiMDk0NjUxYmQ3NzEyZjZjOGVlODcxNjE0N2QwCi0tIAoyLjQzLjAKCg==
