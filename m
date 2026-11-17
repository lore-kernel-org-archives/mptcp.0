Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892930;
	b=v4RuHhxjro6r8J1HsFWXFYpfLPrtD3L86gMQdX3z1LuQsAoBA73bAla8VF/FxotQiP+k
	 mi3nSud/EkXTqgH6yGV9EnhBnUQKtbAI/Wuv+8VyTd55ykE/3WUK6Dj2MA/GJMS7q709Q
	 WT+VhTx2z2wdgSfQhKVFIs/poOl4MeokGsFjuR9cra7OPLk0Mz4w3TNGv0MnFU81aQbVa
	 qNvq3WWu84P6UAJZ4mOaG2ac2B0LJE/7GTpHpel9FCUcwCYmwB8RqKdA7vpviDfaigEIs
	 m0bloXh8hPtkR2XdGDTPqykciZN2bQj384aO6Sg/4L+E2y1tOMLJOnPAk/fkG78/Aww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892930;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=ki0NAn7ZKr2Dqsmoq7UhhVuiPKc5pWVggGB9FEpXgyM=;
	b=k7bXbDJ8RFWcP7hBQGpwNUnG8SOUSX/Y+uJGXSWNoR/LE3pTTa5cs9uhEIiqDSaMXAGy
	 kN81nh2aBCfvzg9qnU18VvyPKLCVRQkmRECADdp2Vg2lqUwGmiykwSXvbE2RmP8TGYiHF
	 LJpEPQ4sRuXfNc22pBscGpIzD3o4etM2H5mZotHQrkHVJgLfLcGwr1/PKoeuNOy1TTT+L
	 cGrM3KR1l4g9weDdzUvszLAcgTZ9YjekvFM81TURxqzwKsGiU9n8TeWbLL7eET+wrchzi
	 B8b6vb47HWEQep1ZILRoVSn8joXc6IuH49pHkAOb+T1jZn4W3VxPld9q0PD2rXb0UuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pxI+i3yO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE91606A33A
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 05:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE91606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pxI+i3yO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AREmltcoTk5HxNV+CPtst4g2GS3fsChwLig6jHp9TjVWO1i2nLRA4MCVqavRuKbbvDyAS3ZE1ZxwTQvY29fyZ7Xx6II3eSLN4EGjuoftvZUijs6hRqUWRkjHChx8PvosMvCFFrncOZCj3gJwTEsNcJ6w2WYq6cz0/5vuO3Jh+yp1WOHRxfLLiqB5ak+eQMuX2O0XSYoIbuU3SMU3mNOKPUbCL63JNoCK8YSD26By9kuw/b5XfyA+VXgM5vmLDGogJPddh3OxoGx01C2RvPWdfkB66CmS6vJ0KifgQv+8IMMwsajSAA28AWmuX5tejGJ+X1Mc7TeLd5QbwFZbNi5hyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki0NAn7ZKr2Dqsmoq7UhhVuiPKc5pWVggGB9FEpXgyM=;
 b=Brbm37iRP4/DtvnVEUaLlVyebDOXs/fysESH2BNY4/y5vklE+bFQCU/iilTwe2Gejtxr/y3ANXkwL2bdwZBZQ+EvSJ5rrq9fDLNT/yl76efL4njNIxZFagfBLWoBULo2e8xIUnySYyzlxrjOU/iTtErG+1s41R1H3Z20l+fP3cOt24RQFiUwObYn+Qrq2SqjMjIzhjT6MUtMO5C863M2n9odrmYztLq+ijUDfGlnJAT1sEXTlcCZt/s65kj7twR8qETo6rJQsRTqklAoXcbTNPwM/TVggSOqHLxowWQxHV+/QQVYicK5eGon61Mj4/FqFmLbmL5TLfuzboNy29XCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki0NAn7ZKr2Dqsmoq7UhhVuiPKc5pWVggGB9FEpXgyM=;
 b=pxI+i3yOBr43aF+pDAry9p2HEH7ODDC7y1vUaxwKl4Oc2Up11E6N5afMHpiQIIrWJJ2HNYtkva2pAFQi+McC4iuyEeq6+KmZCcknejxTQ5pM2PerKDfi886SN5m+Jm140kpPV4LHGdBSm4uk2xV6cM82vl+NgFM/o8KQkfBkgCfMDi/ZPcabPk+X3OOaGI2mYpyAn1Z1eWU4u6SXAAynJy+eSLH2qh8/yTmeP1Avyoi068O5XvGUF5hhOOTBCnZsK4E9fZlbTw9H2XPpBbcYGxILx6DpYBFvYb+iXNNdj4lRoyYCjaOBnB/neEXJZMhWE/6r4IeGFgH1BGyQyVsGsQ==
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com (2603:1096:400:156::12)
 by TYCPR01MB6654.jpnprd01.prod.outlook.com (2603:1096:400:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 05:22:04 +0000
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8]) by TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:22:03 +0000
From: lei lei <llleigoing@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>,
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org"
	<geliang@kernel.org>
Subject: [PATCH net 1/3] tcp: saturate window-to-memory conversions at INT_MAX
Thread-Topic: [PATCH net 1/3] tcp: saturate window-to-memory conversions at
 INT_MAX
Thread-Index: AQHddlOTKLjbZ8HIl0CF2rfFttVicg==
Date: Tue, 17 Nov 2026 05:22:01 +0000
Message-ID: <20261117052200.1507847-2-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
In-Reply-To: <20261117052200.1507847-1-llleigoing@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8485:EE_|TYCPR01MB6654:EE_
x-ms-office365-filtering-correlation-id: 972230ee-ab41-458f-30cf-08df446ab68e
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mCYd7/icPJlj+s+m08RC6kd5M5dm29JQCnhi2qcD5I1g2UvpVJk6LIS6stOA7VYA77TmE/hz/aCM3ahjdU1DkS09xQEjNqUD4YptMzrbs/2Iax48Goc7D7U+/A7mypUIguioUcCQ5whsr1M/ws08h9i2LIAh7yFXpCcanJoXO1JvaY9yZANRm4MMkvRll1TdGf0/LQEzB+xzWCnNy8lRJREf9AzMPHJD3Nu3nk+VaXcZxXW+ChXhazrwM+bm5nfziD6Qv/qb7JbVTssWKQRQlZhtqpzCsD7XlkWtpaEGdLY7ln2fLNLderhEXc6BULnNOB9aBnLXHNgVZTBHwiFcUFBIJI7jvHJJFMHPq7Akv9K2Z6tQzpd61YjhF4Es25dlCQItQZRvuescrM1WlUCBkKR1lCuN/qhwdj/X8OmIMY1i78zMRpEMNW5ZMxEoeiwDUfnM/EdfNu3M49pPuKtG449mkQfnp6n8klRihxuZRCbjGxa4doxDMTcg9hkRRpwqCcpk7BE3h0xaSatfHWjIfCc6tBYbdwDXS9QdcTjrMzaTDhUD5/zqyRidmyODgfp48qtVS+I7y7sABY9w3+HXtWs8QDkaTDU+rGC38/izsInKRVPcpMGWnYYg4eZWCt8Fcw85Usj/+GMO5euibd5aIvLg5VnDjExNYiAI4FqP2Ubae+Y8CwnsGbQFYZnCBeYWrtimZTqKIbLWYzbe62hxWkadoUM6VQI+nukr5VW8HrQozVnMlMM3o9aZbHmkUL7kvVZbiW13t89PFR7w6Mhj35
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|8060799015|39105399006|19110799012|38102599003|15080799012|37011999003|4140399003|20031999006|24021099003|31061999003|25010399006|40105399003|41105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnBMMlpwWFdGR241WjZ6dHZGMjJqVkMvTmNDRXNSWmNBNXpDWm9GcjhjL3Zr?=
 =?utf-8?B?bTM0bEZYZmU0NVRHcmRud1JIeHY5WmV5OFRYUGRkR2JtVlR1bXNyS1NId2x0?=
 =?utf-8?B?Y1dJTms2bE5hZzM5VEpMTzhQM0l2ZFJ5aUtXYUMyQXBpRnRCMG83ZFZvaHdi?=
 =?utf-8?B?bTV3cFlaQVZrN3BETEN3RE82V3BxdkdvWG15VEtlQVhVOVpDcWF2d1IyUUQv?=
 =?utf-8?B?ZnlqNGVUdHJtazhRYWViUnpYS0dCZTVhdHh0NElRZHdtMXdnUk0wTjU1UmhC?=
 =?utf-8?B?OVduc1BQWFQ1eEpFbW1Jb2VTb096NkJianB4ZDJvd3NLSWM3R0VoeXNhNVlB?=
 =?utf-8?B?dllhdjgzZXU2cHZOMUhYU3N0RTFCaklWV2xIak5NWmVQOGltdlRvQUlsdklJ?=
 =?utf-8?B?ZGs4ZEVTTmVJdFBPS0tLSi9yeGlBTVB2NDUwblFYSnJkY05pR282T2xIbXhM?=
 =?utf-8?B?TnhRZ29Ha0xTTUhLWFVMSmZYYXVqVGRTZWhvVjNaeUEvR0UvdFNQMDgrNS9i?=
 =?utf-8?B?VHpWa3hGRkNPNk5BMWJ5Q1p0Y3BzVmt5RGg2cVcvU1d3aFBKdjRVTE00MjBw?=
 =?utf-8?B?L0tJUTRkWmdUR2ptdU1Jd3ozcHV1SXNpNHBaWUtUdE4xdCtSMnM0Qk00d1Zo?=
 =?utf-8?B?OUFRRW8wY2M2VldlMndZUFBUUG1QK1VDMWZvVmpCMWRGbnpCbmg2aGNRV3ov?=
 =?utf-8?B?MkpiVWxpYlVXeDVXOXBmQ2JpUGx3QkJaM1BjS0hiVmlLdndUcGtuZjVnV3h0?=
 =?utf-8?B?QktRUDRjZFlISE5mczVFTW5iREVZVDdvcENvdjhGR2VRK2lTRGRxMWFDajVW?=
 =?utf-8?B?d2NmOStDZ1JiZEVsL1RHcXI5dS9neEZ3ZTRNczg1cU54bDVKMFJ1UytuYTEr?=
 =?utf-8?B?YU9UOEM5RjFEcHBBekxHczFQOXJyRjhtOGlMMlgzT2l4RVgxdUFOZzA0c25R?=
 =?utf-8?B?a2xqLzZtMjVTVGZoWng5TDhtSk4reVAveTIrYmZJUUMvT1JSSTJVNEVqS2dT?=
 =?utf-8?B?ZGtmdlYyakxLM3lmUHNyalZGeHUxb0U4RlJlbmU4ZDJhK1J5cHdNYkFDMVNC?=
 =?utf-8?B?VFQxejlSLzNYdHZOM0JTdEFIWmNtSStScmlud0hyVlE0SDcvQ2NOM2YrL08r?=
 =?utf-8?B?YVdQMXBkT3kxV0N2RXBPYkwyYUpLUzRtb2pXWFhpWHA0REQrLytZVGNTK21p?=
 =?utf-8?B?bVZuWXc0TUIyYnJQRW5PUFIyWWxyc0tWaFNyb2JEc24zM0xwQlZuWlNrZDlC?=
 =?utf-8?B?OGRZdlBucU1rQUluMjZ5OXhGSWpZTzdVbTk4TmI5S2dqc3BVdG9WWTVkN2hQ?=
 =?utf-8?B?VlhkZnU3NnBTUVladHdzRFpYQ2s3MFJFeVBNbGN0YnFhMWpFRlBRd253STNT?=
 =?utf-8?B?NlVhbWdxWEhJSU5yWlBGM0tBOElQNXAyWWorc0UwNU4vWjcxYzkyYzhOTHZE?=
 =?utf-8?B?WU0wbWlkOVg4dExMOHd4Z2J0bDYwaGpQeTJsUlNqN091akczMi9JRmEvTi8y?=
 =?utf-8?Q?vQSZOw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1N3czM1VXA4NzVoWkxBUE1OSDArMGtwSkhyV2c5Y29kSHdSazJWdEx4QU41?=
 =?utf-8?B?NDVkVjV2UTM0aFk1clZOaEI2RjhTd2RWUS9PSkF1WU9pc1kzSmdRK1lUd1Uz?=
 =?utf-8?B?am1kbnpOWFpQOWRLY1hBbExqZGtuVlI0RU5rVzU2K2dRYjgvenNETzZtVkxp?=
 =?utf-8?B?QmFmRXMyRTZ2S3RQOWJuMEhJVzBNU1pmSWNZT21valFpZ3Q1MG13b0JXVFd4?=
 =?utf-8?B?VU5iNTl2eEh1dTI3QzkxU2s3UGwwSk1iY01qems1YTIydFAwUklZSXB5NkFj?=
 =?utf-8?B?OVp0Q2NPL3N0MndMNGo1eVIvVFN4M3RxQ01HSlByYTE1RGh4YnpudzdMcDgy?=
 =?utf-8?B?Vm5LMUZUd29mRi91anpVRlY0dS9OZzBhaVg3VER1SXhtTnF3Y3VjQVE2cEJz?=
 =?utf-8?B?eEp6THdBbnhFbWdrakYrcEZ3bzNBd0pRUDdvbmY3RGlWVk9PdHBNUVh2V3Zj?=
 =?utf-8?B?RDZEbkFJK25CalpNdWpIVWUraWVDWlJKcmxUWFhEWGZYZXlEUUF2WngvNW9N?=
 =?utf-8?B?ZnAyTG53V2NvcEdXa0lYSytHUEprNnl2SSt4RW5WS0IvbDVwM3hwMU9acWg3?=
 =?utf-8?B?TTEvL09Jc0szTllVN3BhWnI4d0NKNmljTkxLaytwVHhLbTVPaFU0ZVBUU0U4?=
 =?utf-8?B?NzNPOVIxbUdoUXRCMy9qM096S2VNMWd5RGFSSFR3cHBpU0Z0M0wrU09yQTdC?=
 =?utf-8?B?bzBEY3pEdTEwcEtMNVJzb01MQXN5ZGgxUTI3bDh0aFNTTzUvZWp1TEx1ZmlB?=
 =?utf-8?B?aXBsMWRTcHNicnZLcjhsUi8rZGJSMURRb3FxV2EvWUNiTHFMS2xFT0g4QjhP?=
 =?utf-8?B?VVQzMnF3L0RxcHdkYnYxdjJndDVURUhqcHJwa2c3Wjl5UjVRem16cjZWSTU5?=
 =?utf-8?B?cUN5MzBXWjI3U28wUmtqZ0JmbWZRUFRYUHRWSThqMHRGNDlZdmVGa1AyZUJi?=
 =?utf-8?B?S0FmcDUrMXJhRUp5NTZKMTFxR1FIYTNLTEJtR2VzZjlzdjNYSDdjQW4ycUNB?=
 =?utf-8?B?ajBtQlBBSGFxNkpzZDNMTldVbWZJdWRZTGwvM29VNnNaazRKUTltU09iZzkr?=
 =?utf-8?B?RGJDU1ZONWdhNTE1ZHBRUVZua2pLaHl0QVFXQ0hKbFVIc3hlM3p6ZkdBbVVK?=
 =?utf-8?B?WWU3U29KQy82Mys3NXlzaU1tT3liQUZ5TVhDV2UrMHdyaXJDNXBzYlBhUVVW?=
 =?utf-8?B?cnREZGs5NWg4cEpKcVdUZmFoNGl5dlI4YzBzNE5vdHJKOFZLYXNVUStmZ2FC?=
 =?utf-8?B?dERHOEpqcDM5ajdnampPZEExb0dnRlU2dkRTYk5PM2U4d2pwUzFXazdpSXBE?=
 =?utf-8?B?bThNUE9SeTRFZVllcEtHQ1A1V3EvS3pFTDlsOFhaZC95QytRTXZ3VTl0SFpu?=
 =?utf-8?B?UFRObUlHVXpRZThHQmRQckx3MHpaakZGc0pzQ1ZiUjM4V3lobjVYVEgxeWF4?=
 =?utf-8?B?c2VRekloWnAreU0zZkdsVkxlUTdwUmtjb1plZDZCbkQrZDg5U0pwNTBSaGxy?=
 =?utf-8?B?K1R1NVY3YXpvL0RsYXhPSXFXMnJ2K1JzODNFRFMyZGRRRThVVHA5Y2FaUzJ6?=
 =?utf-8?B?VzM3OXJOTEtiOHBKRFk4YVBGaVJyb0R1KzFKT1lxa3djWVFMSHAxc1V4ZWFu?=
 =?utf-8?B?LytxelJMeXFyYjlSOHY1TzJib0ZuWnpsRjJ5TEk3TkZ3UG5ZSnNkRVA5aXZT?=
 =?utf-8?B?TW56VVAyQkVsRlNuUFNHcnFOWENpd3BTbjhhTDlaREFibS9US2c2M0VmMXF1?=
 =?utf-8?B?eDVXZVp2cUg0TmpuMUxCMXNmUkh5MUdHMVJrNE9RcWd1cU1URmF4aG41bHJO?=
 =?utf-8?B?U2RxY0orRmJPUHlBUFU5TVhEbjVVWVk2T2l2bDhHM0tBK3RqQlhuZFYvMEho?=
 =?utf-8?Q?w6m8RNiRe1lOI?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8485.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 972230ee-ab41-458f-30cf-08df446ab68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 05:22:01.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6654

X190Y3Bfc3BhY2VfZnJvbV93aW4oKSBjb21wdXRlcyBhIHJlY2VpdmUtbWVtb3J5IHJlcXVpcmVt
ZW50IGluIHU2NCBidXQKcmV0dXJucyBpbnQuIEEgcmVzdWx0IGFib3ZlIElOVF9NQVggY2FuIHRo
ZXJlZm9yZSBiZWNvbWUgbmVnYXRpdmUgb3IKd3JhcCB0byBhIHNtYWxsZXIgcG9zaXRpdmUgdmFs
dWUgYmVmb3JlIHRoZSBjYWxsZXIgY29tcGFyZXMgb3IgbGltaXRzIGl0LgoKVENQIGFuZCBNUFRD
UCBTT19SQ1ZMT1dBVCBoYW5kbGluZyBjb21wYXJlIHRoaXMgcmVzdWx0IHdpdGggc2tfcmN2YnVm
LgpUaGV5IGNhbiBhY2NlcHQgYSBsYXJnZSBsb3cgd2F0ZXJtYXJrIHdpdGhvdXQgaW5jcmVhc2lu
ZyB0aGUgcmVjZWl2ZQpidWRnZXQgYmVjYXVzZSB0aGUgdHJ1bmNhdGVkIHJlcXVpcmVtZW50IGFw
cGVhcnMgc21hbGxlciB0aGFuIHRoZQpleGlzdGluZyBidWZmZXIuIFJlY2VpdmUgYXV0b3R1bmlu
ZyB1c2VzIHRoZSBzYW1lIGNvbnZlcnNpb24gaGVscGVyLgoKU2F0dXJhdGUgdGhlIHU2NCByZXN1
bHQgYXQgSU5UX01BWCBiZWZvcmUgcmV0dXJuaW5nIGl0LiBUaGlzIG1hdGNoZXMgdGhlCmludCB0
eXBlIG9mIHNrX3JjdmJ1ZiBhbmQgcHJlc2VydmVzIHRoZSB2YWx1ZSBhbmQgcm91bmRpbmcgb2Yg
ZXZlcnkKcmVwcmVzZW50YWJsZSByZXN1bHQuCgpUQ1AgYW5kIE1QVENQIGxvb3BiYWNrIHRlc3Rz
IHdpdGggdGNwX3JtZW1bMl09SU5UX01BWCBhbmQKU09fUkNWTE9XQVQ9SU5UX01BWC8yIHJlcHJv
ZHVjZSB0aGUgbWlzc2VkIHVwZGF0ZSBhZnRlciBsZWFybmluZyBhCnNjYWxpbmcgcmF0aW8gYmVs
b3cgMTI4LiBXaXRoIHRoaXMgY2hhbmdlLCBib3RoIGJ1ZGdldHMgcmVhY2ggSU5UX01BWC4KCkZp
eGVzOiBkZmEyZjA0ODMzNjAgKCJ0Y3A6IGdldCByaWQgb2Ygc3lzY3RsX3RjcF9hZHZfd2luX3Nj
YWxlIikKU2lnbmVkLW9mZi1ieTogbGxsZWkgPGxsbGVpZ29pbmdAb3V0bG9vay5jb20+Ci0tLQog
aW5jbHVkZS9uZXQvdGNwLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC90Y3AuaCBiL2luY2x1ZGUv
bmV0L3RjcC5oCmluZGV4IDVjOTIwM2FhZS4uMDk4MjdmMWFlIDEwMDY0NAotLS0gYS9pbmNsdWRl
L25ldC90Y3AuaAorKysgYi9pbmNsdWRlL25ldC90Y3AuaApAQCAtMTc5OSw3ICsxNzk5LDcgQEAg
c3RhdGljIGlubGluZSBpbnQgX190Y3Bfc3BhY2VfZnJvbV93aW4odTggc2NhbGluZ19yYXRpbywg
aW50IHdpbikKIAl1NjQgdmFsID0gKHU2NCl3aW4gPDwgVENQX1JNRU1fVE9fV0lOX1NDQUxFOwog
CiAJZG9fZGl2KHZhbCwgc2NhbGluZ19yYXRpbyk7Ci0JcmV0dXJuIHZhbDsKKwlyZXR1cm4gbWlu
X3QodTY0LCB2YWwsIElOVF9NQVgpOwogfQogCiBzdGF0aWMgaW5saW5lIGludCB0Y3Bfc3BhY2Vf
ZnJvbV93aW4oY29uc3Qgc3RydWN0IHNvY2sgKnNrLCBpbnQgd2luKQotLSAKMi40My4wCgo=
