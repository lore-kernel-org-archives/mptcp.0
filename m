Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892932;
	b=ukTrN1bmftz1Ulpa99mrY0gPxAm4mWx4tfmpcLIRyF6AS5+lyzYYAmA4j2HTOV5tHVTM
	 qgO65B/FabJw4ZLOOmCgqyPqZEoF3fQggEHRWltTAClgnBFiXrGd+heJqDKwDfKRzPhRy
	 ntErTl1146wqZ0EEaI+aGm5XN2fpee8xHBn67wb/gPVeizVIiDccd6UJkO/w6+CevzBtw
	 KM9y0vTjQzWk0gxLj+tx/FMYkXV4AKTOygYTX5oXSCRzusKauCUcNwWT53MVWjxLXqS35
	 bQ61XS+N2/7pfic71mHOMVVt+fTZk469jOW63vnBGMLF1Uura+5FMMYvHN2ls/SMPaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892932;
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
	bh=DSG9+XFxyYCqwK9X0ajL/EREQyacZ5kDLklRdX+queM=;
	b=MZtJazsdHzlZr2T6FzkBSONthgR6vJu4hwx5yTTjVN+wSkLc8q6/8FS5lqULa4IhMfuV
	 FoX5q1KpKlbK1JdjU3F8iwFosMfyTLUMaT3GtUomw63Q7OZ7Pfg2uxqARLPIOQgCzYUqt
	 xsjqcAkCDCuN3YwyzsEAfUziR78MYiMwljZY8ekmoZ8bbkYIWP3CrbOc/PdGrncRKRJq1
	 lIVf8RT4WzwLQhPBzuGq+a5DRB4tmHxrOt5QH9DugbxVr65mpjW1QxKy8Wd3Iv+eB5x+D
	 ZD/plGVhVJy0+GcHfMcUQE5iM3qS/to20bFIBQpsuKmx27ucERG23ktlYB1ga1+/HHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="I+/56oWi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF453606A335
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 05:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF453606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=I+/56oWi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+Cq7ZZT7GURFjvE44FsNAcaTiC3e7X2cDZNSnHdqeJhxZ9e1U6qjgxcxdOxZQUvRlNIbz7FtjSxxE252tGwqt0RNM5jt1aTFKoc8StfW9xNanfiVFyZwA4l+L7lkda4wCXUI26E979O4UXqSmr4Vr+MqudYY094amSvymSOOayWLwAoHGfLU1OvcCW8c2xe4A8g8L4RRZI7fQUTbnGO7iUnvlzdo3nJw1PVNB7bCiHgy6ZNeV6FIYVH1up6/5VAdKz7kSb9e7jrFF8P6V+2zKYhdeJnXs367QtMFaBP7Gh4sxDsxr3NvA5TUad690I+0GXfoGw6x6aSTFn+B/vlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSG9+XFxyYCqwK9X0ajL/EREQyacZ5kDLklRdX+queM=;
 b=IbNp2mdVJON2bJcc+d55dgjET8l+kN4emA9AodFL+1PMsu60T0qw5Ikw9qLpWTjB14+w8Ae6cdYoNZoTSGFCuz8SUluSRNA3t5N/iEh5FJnZ/LAttQrZVP3bGvSJy3M+hdZxOkZ9PiZnfr071f7k+ShRAW1gNKDzwaXpvf3iJNmtD0/3KIv5LbONFcVQX4t/dv0gUtz3z9helTulr+PbZ5IJpeTPnU5RfdEIipYd2iUICdSZRNQWEm2jL8rxQcnWJAI6lHAU9Bchk04uXGMPuHa1Dfv/4UspE1cMzCRjj2V216gG0u5w9SHy9DCgl35sqq9en/k4EDKX1rnEFmec9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSG9+XFxyYCqwK9X0ajL/EREQyacZ5kDLklRdX+queM=;
 b=I+/56oWie27880d9NJSkWhamGN6hKhF34yDQHOYauFZs490ri1ljvpTig5vXPpzBZVLpG9ikWT/g6aGRBsoGWOpCuu5bFJK4FS9le2xoHVaMAIOcTYj/sdtxW6+MvS3z03F3nbfIcTrc508GedTY5C7dwOiaV4JowaBqZdw0UMbhh/WAYqEZPZpQBU/tjHAfYwRsMIoVRh1bzFpisXc0EgjjXfuD2oR1pYMlG8Jhks1mOvwPOh+EhKYudYUgESYB84YqlwPBvFXOkShjWsEafCcgRA/39igZR1cwJwcnzQknAXiBeYfcwXOvtmrmryNQ3+KVdFChLEJzM39has5mJw==
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com (2603:1096:400:156::12)
 by TYCPR01MB6654.jpnprd01.prod.outlook.com (2603:1096:400:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 05:22:07 +0000
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8]) by TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:22:07 +0000
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
Subject: [PATCH net 3/3] mptcp: exclude MSG_PEEK from receive buffer
 autotuning
Thread-Topic: [PATCH net 3/3] mptcp: exclude MSG_PEEK from receive buffer
 autotuning
Thread-Index: AQHddlOU5y50aLkDxEeMH8LypaS4hA==
Date: Tue, 17 Nov 2026 05:22:04 +0000
Message-ID: <20261117052200.1507847-4-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
In-Reply-To: <20261117052200.1507847-1-llleigoing@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8485:EE_|TYCPR01MB6654:EE_
x-ms-office365-filtering-correlation-id: 9c2b5445-011a-4de3-0553-08df446ab902
x-ms-exchange-slblob-mailprops:
 7qh87CJt6y1mqZO6407WRLxlypE3k+eji948BCY56UxJrO+2ARSi5vt7QyuXBdz/eDt9CDgy3DZLhmP5vNspQ/S/C4qFwMaO2TG7HeZTiuS84pTJugny3Q0u3MelD/VeO6i5qheuQQ1Q67/Idt+L7EQ1qHv72Lo/sqd6BF2RoLxn1uQ1dd8eqf6X+JM635vlAVjkSAhSSzc/kkAsYvEK03g9zhV94RpuG0mlIGIj0q1EGD7FTsR3y5gcJ0sgAxilC7HKdrBqbAGSdZiZYWScit/6LOXoatY+gF+UA8v4p3AUqIpr4X5Kw6xvXyOp7ABSO/hzPdRBt1oRekgMm3P9DIsD+IXENwqBXuJvyzZmVghIMdd3Du4ruyLAodKX/TpQL+xtflYjf9mSUUdCLIiYj1+SZWZz0WQE3w67j4ZPEEBgqO/kVdpHREZ6XpGrUjWomJcTMKQkxVyjpSxRmq9r9YMiV7shIgYhb4Hk+A2Yd8IPNAnZ0UGZTEaWHxK/Rc57iCrtm5pvwyL6wRwpH1M+Xhu2P/yp1K/aIIRralGVp+SrnU0MhguFpqsofoyk/c4irwDfnhrq2GZflQh93pxB+zCB2te2KkZOQlVrKLqU1PnSnvs4ZDuOMloRYHjrsUiOT4aG0igpFy0EEuwYpuniF0Lr+DGQYJFjlis0FQ6K9okIGPyvfip5pGwUCJtVc0ZUaWB8xiwHjwsGfaV8/TW4SshWxFgLgPlt3kQnGjrVRq5WJZxERMoF3ufKgFMm4dNk
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|12121999013|8062599012|8060799015|51005399006|19110799012|38102599003|15080799012|37011999003|24021099003|31061999003|25010399006|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3N0MGFaZDY0b21zWXNGMUY5RE9odXArV1JsU01lRkdSS3I4dXpIZjA5K3JZ?=
 =?utf-8?B?eVFXWUpJbHlyZ2RtWFdNaDlESDBUUzlGQWdKbkNyRHdPR2xYTWdLUi9iUzkr?=
 =?utf-8?B?YWVvcVhBeGtCQ3VxTVRnQ0Vuc2N0TjBSb3lIZDdVaU1LbmZPakJlL3dKeFJP?=
 =?utf-8?B?VWdrc3BsVjZZOUNmOHgzY3M4VXVkZkZFaVAvalFXbG5tZzlMOWMwOFNHTEZV?=
 =?utf-8?B?eFhCVEhVSmxWWDJoT2ZjM1VSVHRjY3ZCUHU0ekp0L09NVFRvTUtjTWpmY2ZN?=
 =?utf-8?B?SkliSU9ESVpyYTlrSC8rMThqd0x2VGx4OS8xZVVHZjFEM011SytmcFlHMHM4?=
 =?utf-8?B?cnBKVW9WR3BLb2VWdVZtNFM3WVNLRnRaa3hHb1REY1N5NlJSV2U5ZnV6KytM?=
 =?utf-8?B?Mjh2Um53QUQ0UGcwQUI4MEJFcjNGcjBwejU2THg4MU9WelNReTgrV05XVWxx?=
 =?utf-8?B?ZFVhQ0JHQnJnSlMya3p1ck5NTThVcCtTZ2JnUVZzM3hOQ3A2Q2pwZEhqdC9v?=
 =?utf-8?B?TmhZUkMvUU82dEJicGFGSnRIQjB6RDdGdGNjS3Z1V1JoQkRDNW9GTUNlTXNF?=
 =?utf-8?B?WGUvTFNNNittSTF4K20zQlh6emZFaHRBcUI2SmtYRTVKRWdPeE9UcHZ5QUpl?=
 =?utf-8?B?bjhCNFBrNnc3dlBOVS9aMkdXTjQ0Q3BjSStkaXNKelRiZURkTnd0ZzFuSkFL?=
 =?utf-8?B?Zmo1a25jd0pQOHV1TGtFekdXUk84Qzc4bmZrYzcybS9QQ21Eckw2M1ZFa0FW?=
 =?utf-8?B?NCtJd2dXb3lrUVFwRk9QK1J1TjhUdlZBdm5ZckNDMVhCc3A1SloxbGxhVXNX?=
 =?utf-8?B?dGlOOEpOcENvQ2twZ2dYTFhCelNSL2U2UFlCOVl5bmlXamY2UDNsSWV6Zk5X?=
 =?utf-8?B?M3pCMHhScENXT0RZL0s3SjkybVpEc09iN0pVb1JjeGlNVnEwUzd6bUs5N1Na?=
 =?utf-8?B?aDFWU1I0L3JGeUZoSzVkQ29NNzhQV2NHOStZZ3JNay9ZdlJ0RUNqMzV4Wjhq?=
 =?utf-8?B?dk5FRUd4N0RWTmJtRTREYm1jakNrSzhScEtZNWdmbWIyeHFEejNEclFSNXdq?=
 =?utf-8?B?NnY2RUNmUWlQbE1saTF1OHZuVzRBNUlhaVpheFpybm1jcTVCeFp4ekxZejJD?=
 =?utf-8?B?NjJadXZHNFMwak5DUFVaUXI4MmJGbVNmWlVwWThJOCtIYllTMjcrNEcvV3V5?=
 =?utf-8?B?YU9FY0NOYzV2cURZRGNEYXpZSlhQdW5CS2VhL1pLWTI4aUR1NGJBWEw0QTFi?=
 =?utf-8?B?aWVsT2pSTlkrTEVVS3U3dU9ScUlNaTFtRUJBNnlvZUtFYk8wTUpHd0lBTzdY?=
 =?utf-8?B?UXV4OGMyVkIwTjNCM3Q0UnEwM1JLM1NZYk5VTCsrajNVakt5dVIxU29UcVB2?=
 =?utf-8?B?ME5hNXNhR0M5S252OVZUaWtRYmpJajhLNi8wUmh6TXMvb2VNRUFrMUNvNG82?=
 =?utf-8?Q?RyUouDZF?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2hMYlZ1b0kxejBRU3V6ckhBd3hSMlpENm1pdDJ0akxyekI5alQ3L2xFVlFu?=
 =?utf-8?B?bld1VzVST01aUElVT3hUUVpOK1U4TjJnM3lIZWhFV2hXM2VkUE03bkRBcllL?=
 =?utf-8?B?SHB3b2NJN1RKbE5kRGIvdFdJVVNPQnFiZURocks0UVVpK3AyK0tiM1pRTGpE?=
 =?utf-8?B?VzhCVVcycjVpRm4xMjdwQi9FRHpIWlFxNko2NmpCdGY0bG15QnVNbFJTeGJO?=
 =?utf-8?B?NGtSNkpZMmNGb3ZJSTZzZVFESDZ3QW1sZ21ZMTFKNk5DTVYrb1A2aDdTclgy?=
 =?utf-8?B?T2RRMHB6Q3FLbVZuQ1htZEZTdzA1M3RHRGtubWtBV1ZBaWpNM01LaXNFQ0Jv?=
 =?utf-8?B?ZmVGU29pUkE3cmxpWkN0QUN5YVFUYjFsbTBDNnJLaExjRTRqNkhHRXF6dFZO?=
 =?utf-8?B?SzBsaC9xY3NNRE1hcWhvWDJmd3UyQ0x1UWdLOXVmZjRvMStPZ0VabElvRWMx?=
 =?utf-8?B?c0ZWWEpHeFRIbS85Y2orazhQdmhCWllzQUZoazdSalNXZDI2K210aWhGNkho?=
 =?utf-8?B?OGYvb0VKQWN5SDg5azFyckJmSHN4Tlg0cElBODZnY29CU3kzVHB4SjZvczVH?=
 =?utf-8?B?a09ISmorRWtYcjByNHVhaTk3akt3SjN2ZW5SeU4wQUNxanMya080RS92aktY?=
 =?utf-8?B?Sm9hUDhZRkdGaXlvZUpFWUJDek91WnBFUUExY0tROWMxQWtoQXAvNzZqK05D?=
 =?utf-8?B?ZVBHb1hQRHZDc2RSb24zR0dQOGt1azcvT0VadjZoa0NGeTFxZXVxbnk2OWIw?=
 =?utf-8?B?bTJMcjBZeStSSFRYbWVjK1BINTMwbS9UaC95R2NSZ1dkWVBLRnl1dFpnVHFa?=
 =?utf-8?B?Zm1idytPQ2tER05GeE9pQ2lpZnNKQXA1S3ZSeEV2L3h0U3BLV3h6ZHpIZWlz?=
 =?utf-8?B?ekVKMUwzRDhUT2tpS2pRRHg2UUs1MVphR05zbEwybE83b0tmTlF6LzNZTW9j?=
 =?utf-8?B?cWRrcHY4S0NQZEpYQ1BSNmN5QS8vcVBuNFBZbzQ2ZC9GK3I5dFJ1T3ZrNjEr?=
 =?utf-8?B?cTFpamFkN1ByczBaNUp0c1ord0RrYUpVQTFSMWVtLytQQWsvS2pmeWRZbXlV?=
 =?utf-8?B?eG9aa043MnJ2TUl3cnlhNFF5SisxZ2lQcDM2R2xkN2M2RUloeUc3cDMrcVl6?=
 =?utf-8?B?ZkFwQmhRMG5weXhyL0RDb2RraUtoS28rSGhDWVAyTlozL1l5WWM4bFZTNzB1?=
 =?utf-8?B?Vmg0T2hNQys1SkR1RlRGMHhOZkVKTEpsOWR0bktqZnRIZkxNUzNGaldZMnpy?=
 =?utf-8?B?bWxsbFRCSElYRmFWR096OTJoTTdVam5rNmZYSmtnb2hWWVBOSUkxckVzTDNj?=
 =?utf-8?B?NHdUcXg2TU1EbzZBL2FQdVdaZlI1S2dBV3VXSm05c0lWcklRaEwwVjNuM3Iz?=
 =?utf-8?B?N0ducTJYd2RMdHRtRWdwcUd2RUpXWGJYREtCa0xSVEJ4SjNiakFZLzVIMzBF?=
 =?utf-8?B?cFpRaUw2aHJ3NEYzQno3YlpuYXJrcXZLMHlOdVFJRGhPbS9JWjZ2SXNpOXdi?=
 =?utf-8?B?ZVFDc0RBaUJBRmIyNm1Cd3hEenpRSFFZYjVkcllaMGhTeGFwdHBjTUNXRGNE?=
 =?utf-8?B?bXNiUFFIdFVXQ2FZY25DU1lMRzExQXRjRndQMlNKRWh6YlRzb1ZCTUVHemgz?=
 =?utf-8?B?RGsvQUxKbzByQUw2WlhnSWdxV1M2YTVZR2ZaNWZlZ1RiTndVRmIvTnBJcTV6?=
 =?utf-8?B?ZXhkaG16Ykh6UXIvTE5KV1VsS3VaYjlkTGhaLzdPYkdQTC9qVHROdUFoOE5I?=
 =?utf-8?B?Um9GZHpOcmdSdERtbXBaQ3pQdW5OMWdaUGVWWUNKZ0pLVmF0VUZWRVNBZU0w?=
 =?utf-8?B?Z0hLdnh2Q2FCOEF1cHp2MUliTUZySWdLdEFpZk56eDE5MnU3K1ZERkQzNkw1?=
 =?utf-8?Q?ERHgPeWdZDHb6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2b5445-011a-4de3-0553-08df446ab902
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 05:22:04.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6654

X19tcHRjcF9yZWN2bXNnX21za3EoKSBwYXNzZXMgYnl0ZXMgY29waWVkIGJ5IE1TR19QRUVLIHRv
Cm1wdGNwX3Jjdl9zcGFjZV9hZGp1c3QoKSwgYWx0aG91Z2ggdGhvc2UgYnl0ZXMgcmVtYWluIGlu
IHRoZSByZWNlaXZlCnF1ZXVlLiBSZXBlYXRlZCBwZWVrcyBjb3VudCB0aGUgc2FtZSBkYXRhIGFz
IG5ldyBhcHBsaWNhdGlvbgpjb25zdW1wdGlvbiBhbmQgY2FuIGluZmxhdGUgdGhlIHJlY2VpdmUt
bWVtb3J5IGJ1ZGdldC4gU3VidHJhY3RpbmcgdGhlCnVucmVhZCBxdWV1ZSBhdCBhIG1lYXN1cmVt
ZW50IGJvdW5kYXJ5IGNhbm5vdCB1bmRvIHRoYXQgcmVwZWF0ZWQgY291bnQuCgpUaGUgcmVjZWl2
ZSBwYXRoIG9yaWdpbmFsbHkgc2tpcHBlZCB0aGlzIGFkanVzdG1lbnQgZm9yIE1TR19QRUVLLgpD
b21taXQgNTgxMzAyMjk4NTI0ICgibXB0Y3A6IGVycm9yIG91dCBlYXJsaWVyIG9uIGRpc2Nvbm5l
Y3QiKSBtb3ZlZAp0aGUgYWRqdXN0bWVudCBjYWxscyB3aXRob3V0IHByZXNlcnZpbmcgdGhhdCBj
aGVjay4KCk9ubHkgYWRqdXN0IHJlY2VpdmUgc3BhY2UgZm9yIG5vbi1wZWVraW5nIHJlYWRzLiBL
ZWVwIHRoZSByZXR1cm5lZApieXRlIGNvdW50IHVuY2hhbmdlZC4KCkEgbG9vcGJhY2sgdGVzdCBs
ZWF2ZXMgYSBmaXhlZCAzMiBLaUIgcXVldWUgdW5yZWFkIGFuZCBwZWVrcyA0MDk2IHRpbWVzLgpC
ZWZvcmUgdGhpcyBjaGFuZ2UsIHNrX3JjdmJ1ZiBncm93cyB0byB0aGUgY29uZmlndXJlZCA4IE1p
QiBsaW1pdC4KQWZ0ZXJ3YXJkcywgYm90aCB0aGUgYnVkZ2V0IGFuZCB0aGUgcXVldWUgcmVtYWlu
IHVuY2hhbmdlZCwgYW5kIGEKc3Vic2VxdWVudCBjb25zdW1pbmcgcmVhZCByZXR1cm5zIHRoZSBv
cmlnaW5hbCBkYXRhIGludGFjdC4KCkZpeGVzOiA1ODEzMDIyOTg1MjQgKCJtcHRjcDogZXJyb3Ig
b3V0IGVhcmxpZXIgb24gZGlzY29ubmVjdCIpClNpZ25lZC1vZmYtYnk6IGxsbGVpIDxsbGxlaWdv
aW5nQG91dGxvb2suY29tPgotLS0KIG5ldC9tcHRjcC9wcm90b2NvbC5jIHwgMyArKy0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9u
ZXQvbXB0Y3AvcHJvdG9jb2wuYyBiL25ldC9tcHRjcC9wcm90b2NvbC5jCmluZGV4IGIzYjk3OTQw
My4uNzlkYjgwNjNhIDEwMDY0NAotLS0gYS9uZXQvbXB0Y3AvcHJvdG9jb2wuYworKysgYi9uZXQv
bXB0Y3AvcHJvdG9jb2wuYwpAQCAtMjIxNSw3ICsyMjE1LDggQEAgc3RhdGljIGludCBfX21wdGNw
X3JlY3Ztc2dfbXNrcShzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBtc2doZHIgKm1zZywKIAkJCWJy
ZWFrOwogCX0KIAotCW1wdGNwX3Jjdl9zcGFjZV9hZGp1c3QobXNrLCBjb3BpZWQpOworCWlmICgh
KGZsYWdzICYgTVNHX1BFRUspKQorCQltcHRjcF9yY3Zfc3BhY2VfYWRqdXN0KG1zaywgY29waWVk
KTsKIAlyZXR1cm4gY29waWVkOwogfQogCi0tIAoyLjQzLjAKCg==
