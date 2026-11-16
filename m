Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847688;
	b=m7IAHQglQcadw3dVKi5GFYD3XUR97+lkDjFiYCEYABU4lJV9f/8qS0ROobbCtkqIy40Z
	 xaACVrCTw5Ig6aFfAmLEpi1T57YYCIPGHrDkFhl4nZvEAOb7HP7Vl283pdaGM73+kyfdi
	 yEZFkiTjN3d4FHYWwEOkNIhGwov3Mb+O57gAOtEcL52Jed6yu4jIlsMmeLirn9+vCxx3E
	 Mbh7V8lJ32IepYLbVqMMBKeV/d0wBxu6OQ0JPu7iVHYIjr0XDI5cXqiAIin/XqBIVqe1R
	 tLLX5PVQwmNEvV2/4PVqVpgNYJ7iSqQJshv3a6LV60a3pn4jtHgcXIpRkCQoYyvx4AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847688;
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
	bh=ggR5sLN+sNmP0FjSNxPSoarorkdlltHcjHSNAlB5sOU=;
	b=CnmUeIvmDAATB7EoXclj52xFT1IJQLg1djLg6YAlMhpR7eY0WpcWwPR18feb/EpeKljY
	 Uw/fS6V32JmRQRaVt9gjbTxAmPAzvUNawu9IHKz/NBuS2cjz9qWSnWkhGNwFtmxE3F2H8
	 OfzZa6kk3jiF6eqs5lQUYZNhQeG0yYqRKjD+Aj9J4+ASaG0tIwo+10IPAjDgRBxIDkMUz
	 Dd6yW+yQ3g1xdTMKgHt1HVjeeEFxLZ/qa9TuWBIcT+TRSuorbNO2gzVKM1F6cR/i9MzPW
	 u6D6Og+w6Iw1YICQ6SbbJXekERxYqLyjEmviDaHaW+Zg4Czny7ggRl/6HE2P/xhOVfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VGB5p2eg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.86
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013086.outbound.protection.outlook.com [52.103.7.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A6606A336
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D26A6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=VGB5p2eg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9ZetgttbR28tBDYQ2dwMSwh4qIpoI3BiU6sbN03cFVxJ0xCZEQg4BcVQJeXNkRzcw7PtR+LFuLhTlsecgXZgzyPbVz8999ZDXyzFVB1AiiqSoIPgwwOWO+MPyJU9NaL1SFHCWJ2bUu0FOi0O75MzM0BY+9vDPsuqn2rLYzkCtaHCss1tGPxqU2n520TcCn5iOnj9NCBtvPPwk8JirpapghHVXj5t9X7dPxLl9otn446SZW0IYAI16S/6/y+FXD1m/RCUsT3doEefdjugeIEFb9RthdmwRrtOkQ9Ct1U4FnWhGNeY8gsHYvSIdweKnI8lGcmCWqGirVK2Uzzq0uByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ggR5sLN+sNmP0FjSNxPSoarorkdlltHcjHSNAlB5sOU=;
 b=EU+eo72R6PPUP4BMZtCXYHRUeayCnqu5WrFIhl5/JAz9N4zE/yVv4dX9s1ALt+W2oNgQHHonb3gGqyErLbLUA/cctFlxcv0q+du2moXDAr8i5TY6Pfp37uax+kMNwnpj103D34vFlO3kuh+jdvDIBO+9TSpGfyWGsZpKJSA6gqKASGLo6sSH8u4T5SyzRvXON4/VSndeIxlgzAWfAt/eveWPt2NWExPWQqC/wmzOwDSqZ7GqZfg0rruexi5cBb8bIng6iXsKivj/txupqqSMVXhondCnTWN5A9uGUc6kwM/ZMTI/6rw3YtPb48tO0O0aSZYfWtJ+wxdNTlR2DGsXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggR5sLN+sNmP0FjSNxPSoarorkdlltHcjHSNAlB5sOU=;
 b=VGB5p2egrrKTN9NVqXlFLXDqC0MPew2hNR7KRBo8f4sbO8r6eXcrKVpcDh2hLx42Ld80kH1RaptLltmZXynqpxeCYgQhdIl1Lv5gmIieie5eWdYzeYY+p5pJF9IEZ1XwUDG5DvMycYPGd0ehkISDmwnlVoyLaHmHLi64DlVCSTQ6oW39YjMUdHwrRp8qAdCEhcfs0QIB/iar4rkP5raF2gpoLoRgt01+77u6M4/uGoDrSWfrHIP1oEPfZd4uvYmLLigICA9tAn5kGnvvUmn356GU/4TkQ4jN9X8nH6DzgGwMOYC5VsYeZwHAH4+wQKIXT0xWnG5YowPnsOdFlJPEBQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by LV1PR05MB999048.namprd05.prod.outlook.com
 (2603:10b6:408:409::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:46:44 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:46:44 +0000
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
Subject: [PATCH net-next v3 1/3] tcp: avoid wrapping Fast Open blackhole
 timeout
Thread-Topic: [PATCH net-next v3 1/3] tcp: avoid wrapping Fast Open blackhole
 timeout
Thread-Index: AQHddeoPIhnf2O7J80K6ffxnlWZk0A==
Date: Mon, 16 Nov 2026 16:46:43 +0000
Message-ID:
 <963cd91054a37f6308da9a327d9bb027a0306cb6.1794847474.git.x-professor@outlook.com>
References: <cover.1794847474.git.x-professor@outlook.com>
In-Reply-To: <cover.1794847474.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|LV1PR05MB999048:EE_
x-ms-office365-filtering-correlation-id: ea1fe6e5-7c93-49ad-4a2c-08df44013253
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CIpfZuvi1NHUC3OVIR+IHyAD5XTVF8b1I9TsXqFrKUlvQHGUXoOQd/5u3PG/3as4JMowBYTy1zWwj3Y1gwqvcKWrfrVJDWMZN6eIxXCEXDMSZpwCvbomJQqXd6YZoludto2wXz3+uTPC9T94W7MQjGPTDwLdsEGAA0J6/wKQrRZo1HKhsz0H/ZmWGt7RPtY3BxgaNZT5GaOmRQvidb2gYiXbD3QbVuzAAa6/OoQKVllQ9g9JZDSNZ0cKq3IHpjCgyJrj0hzc5xmfnXkGjkUKoQ4eDuyIQVz71XE5w+jDzvAuhDGCDP2XR4y+MVdi641coqM/z0MRpUkOgoMkcDPUR9m/2nNvK+/tpWqDOIx0rY9cEYwjVdSR3fFHw2jznnMn5Obxqz7ovoFSkqZ8so2q0kpQhbwyFQklVex1Od0wB46Nkw6UvYoJHNHwzLQo7BBx5VNk25+/gYSdo53DfY1DAr6FHkSy9rpDGldzDH079/INFGc3Z5lioSZdql034pUeYWKlj5yMB6c+wcFj8TB0pjM4Zb7uo1gzLc4Brrq7UATZlP04W7uWiV/lppLaApcxcHGIkcMP7LvupKp9QRyy+khjf8S+gnHdMPQ1nHLg6ALP2nE56DwA8su3wcsOKwF2yzdohIuBGahjHQW8rr1TAWUtOpYdYtPhg8OKDs3fe1rjVnR+lX3b8hoxMjmcu6R7P0nYYuFPYLvo6BpcYL/FFD4YDe9dfHzqkl2pwv19bTkcQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|38102599003|22091999003|41001999006|24121999003|8060799015|8062599012|19110799012|51005399006|4140399003|24021099003|25010399006|31061999003|440099028|3412199025|102099032|40105399003|26121999007|30101999006;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVRuVnVDdDBDN2tDRkROc3Z2VG5aSEZQNGNzRnIrcnI1d1pPTGFDMmFtS0dK?=
 =?utf-8?B?Qm5GckVaVmZwcDhoMUVoQWkvZzdEeG9hTE5BbWdPc1diZkdRSlkvaXp6cDky?=
 =?utf-8?B?R2hxcHltRHZmNi85ZHVoUERTcVpqSjF3N0s5ZkdTaUxQU29yd2V4QnRPVTJk?=
 =?utf-8?B?ZmN6VDkydk5IQkFhQTJDbGI2cXhHWDZiTnNTYmVIcWdEZDE2ZFc0d1FXWWcv?=
 =?utf-8?B?dHAxaHZiTHVpdHFIdmZhODBTL2hYNU10NDVueG44NnVpRkxVVjFKQURCSy9N?=
 =?utf-8?B?MlErckR1S0Y1VzBtTGFpOGluaGl4UmlPbzB4em9oSm1JYnVCK3VtRFpUbnNh?=
 =?utf-8?B?RHYzSUtBZnFsZjRXNFQ3Y0NoWGE4QjJkOWRYRzVIUlJaa2g0dnBzaEh1di84?=
 =?utf-8?B?VkFrWUxxd2RJRXZaSXdXYmdjSUR5RXdtejZMR3BkeEc0akpBZS9sWnBWME9k?=
 =?utf-8?B?MlNmQyt6a3E3ZHE1YlVqRDRRVUZqUGkrc1Avd3JtSlp0Mm11RTB0cGErenl0?=
 =?utf-8?B?NHRVUjlleHg1eFJkRlYrOG5ySXc5MFFJSUpNT3BFMGRrOW5FU05qZ0JBdDEz?=
 =?utf-8?B?b2gyUFFiU3lJT3hMUVdWNDllcWFFellCTS81Mlg2elFHVjBubTdlL242WnJ1?=
 =?utf-8?B?UGZGWFFMQ1ZqcWZ3VUpaZG80TTFLUk15VDF1SmlkYzRwMitzT2daanpxM3RF?=
 =?utf-8?B?MFNmVWh6eUY2Vnp1VnVBVjhhS3l3d3pvMGVJcVg1VkFsWlFSUzlON3FYL3Vo?=
 =?utf-8?B?cEZKL0tHaHVVOFN2UkFPMkRNb2pwUUtxUThpSnhyQXFoVWJIdE5VMmJveW1j?=
 =?utf-8?B?MmRUTzJPNG9qZ09rN1R1eHhoRVlYMU9PcmFpNW51TXI2L2JQcHgyOTlLdUho?=
 =?utf-8?B?SnJWL2FBR2Z0d285aFNMZDhIRzdKRzk0TFVYRGV6ZTJ4ZFRtSE9MOHVkQUI2?=
 =?utf-8?B?dXRXeFoyYXJmbFRpMUJlSVFTekNua0lHYm5XejdKeWphc1QwWkNaTy9VeXJT?=
 =?utf-8?B?MEFkOFdGcUhuZEhEbGhUL1RYcVhkQndNbTVTazlCS2w5MzJ0MjU4N2ZQV3JC?=
 =?utf-8?B?NGU0SlZ5SE1qKy9KRW9jazk0K2xrdXNyRnp6aytpVzZZYkQ2Nlc5SzhhR29G?=
 =?utf-8?B?VVdOeGVTdS9OWjllR1dGNEt6VEsrNUt2WXlnT0QydkV3dFJBOEo4d2Z4Q2Fh?=
 =?utf-8?B?cFRmZFEycE1QOVpmSENZUHF1SGVNVlJlWldTRVVsSWYrSVhJcWVqM3F0bGJB?=
 =?utf-8?B?ZHVTTmRHMWF2OC9acWdpMTFLQy92a1NFcFBGNjdwOXVsb3cxYkJ3bUxrQjV2?=
 =?utf-8?B?Y2Y5cUJ5K1JyaGZiSWpaSGRzdnJSNXdBTXF0eENnQlphb2tJbU4wRzA3WlJJ?=
 =?utf-8?B?MlJpWVJDcW9lOWEwbUx1MVBVK0ZobXBZdDQ0YTJKbkZOeHg1VXVhQkJnNHZD?=
 =?utf-8?B?bThJSGZOSHpaTlZDMFF0MlJhN0FNWWxEYkdjeGFnMFNBemtpczMyWnQzZXNu?=
 =?utf-8?Q?Dh2We/SP+fa5PlOQgShzlQunmQz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDBhSlp2SkxOOW5MQkloOFNjQmJ6MURPeE5vd3h5TXhoRlA2emhwUGFyK0lJ?=
 =?utf-8?B?aXRYaTNZWHhSb1pEcXh3S2REMnNZZ2kyY1ZZc1FDSDB5d09TbXZ4V0MxbEJK?=
 =?utf-8?B?N2ZVWkJrYUJJck83UnR6c1RKam1VVUdRcVpDc3dnMmJEMm5YSHNBanJVcUhF?=
 =?utf-8?B?Unl4cWRFalFnUEhkT3VUbmJzaEQxMzV3b29LV0xTcjZMOW51N1E3cUowOWpU?=
 =?utf-8?B?RmJjTVRrQ0VoNDZYOU9KUHJrb1NjUnl5TlU5S25FaGNNWHBJMGtKcVZRSjIx?=
 =?utf-8?B?L3VlelpBYkJ2RjIwNkU5RUQzRUp0TEIvV3pKc2JIYTUyVzVSRHA4U25TajRE?=
 =?utf-8?B?QmN6bE5SRWd2NThhVDJiS2hqVmdxRXgrTDdxYVFZVVVYK05OTEtaT21pUUsw?=
 =?utf-8?B?WXdIRnhtZ3Iwb2VJMGVHSHJPVm5KWG05dkFjS0pHczF4RWtaWGVQK2ROVzI5?=
 =?utf-8?B?TEtHSVd5dmo0MmVwcy91MDNuUEcwNmNiY3BvRmJjWFQ3WkZ2YmdEYUZoNUFv?=
 =?utf-8?B?RjY0b3JFQTdyZmIwSGNITTVPbTFYTGYvV3FJdkFNRWVBZ3Y4cXBjRDdzUEZV?=
 =?utf-8?B?d3FuQ0RkNCtXZDVtbHM3eUoxa1hLVVN2dWd3TkhKb3BWaGhVVjJHNzV5T05h?=
 =?utf-8?B?V0k5aDExdlVHc1RXK0Y3djNETmFDdDU2M3BoenBYd2NHY045bFpsd1NMT0N6?=
 =?utf-8?B?Q2lhdExPT0FxaSs2clFjdTQzZXdlZkdvWEpSVzVoT1o3c3BzS3BuOGFEN1pa?=
 =?utf-8?B?RFRnRGs1Q2dKMkM3Mzd3dXFqdFZqbTdLMnlrdDk0NHJocy9YWGllNlNYSGRl?=
 =?utf-8?B?QkpkTkF3VlJYUjhwbmxkQjNjdDJ0RU1zVGU5Zmc3eGdjTmZ3OUIrU01iQ2Rt?=
 =?utf-8?B?TTZ5VmhZemg4T1R3bVJ3YVNjbURueCt0TEVMV0VrcDdrQXJEbHNmN3J1bmIv?=
 =?utf-8?B?OUtjRmwvNVpnQ1J5RlRYMStjNWVveE1sWlNlSDF0Y0Q1ZWRMaGpxNXlSZWdX?=
 =?utf-8?B?VEo0WUREeEJUeHdNVkZjUnBxZTlvalV1TVpVYU9OaHF2VzRRUkNGQlZtdFVo?=
 =?utf-8?B?OUtCYS9tcFZSejlKMGYxbVpmZGtvb2JtZ2Q0clJ4VHpxZ25MTXBQMm5aQjlB?=
 =?utf-8?B?RkZLUnBjM1I1K1E3T0RMamV5YTZYUHZiL1p4U1JIeC9zLzlTTTNHSnNXUVg3?=
 =?utf-8?B?U1Bxc1VBVmVPVllaeEd4WndsNm1taWJEVnBMcG9rc2p0M2w1aDBzdTFJRlF6?=
 =?utf-8?B?SVJXRklLZHRBdGgyb2lJdUZ1YzFva2pBTXEzWUljQVg2NVNZbWxrZ2k3SWcr?=
 =?utf-8?B?Y2tGWGRCVVNqSkxJa3A4ZDM5SFJEeWZNTXcxdzBrV0k5b2RSQkJTamRtbU5B?=
 =?utf-8?B?ak96WnRSMjR1T2orZTBwM1pFTUlyREJLOFpSWWx1QzBqV2lvbU9yS3lHaVgr?=
 =?utf-8?B?KzdlZkVSOTc1RnVGaFd2SXRXR3ZWMmxvamFUTWFoK3BRNlBITXEwL05MY0hV?=
 =?utf-8?B?RU1WSTlucnUyRktmQS9hZ2ZndkRXQnpSUUFEYVdKT2dEYWNqOXI1WW5WVG1P?=
 =?utf-8?B?YXBDWHpCRFB1a25Cd25uMHpvTjZGR29zdG04VEtXWnc1V2dYZlR1Nm9aSTF2?=
 =?utf-8?B?a1lDRERvc2VJOFhzYmd4T1psbGEzbjJ0ZmpwQjUrREU2KzUrRlZjVnU0NE9V?=
 =?utf-8?B?eUxydnB4MDZsMk1lblJHKzM2azZhaFBONFpVZmJVSitDdmVaQ2dTQk40empv?=
 =?utf-8?B?L1VJUVgzK2JQNVgvNlc0T0lWVUpiSVJNMS82MkxGeExwTWRGSmJFeE91Skdo?=
 =?utf-8?B?VjV5azBlbUFDTnZYUlVMWFhUenYrNkxHWitMSklRYVpjblo0NHYzdjVYYXFV?=
 =?utf-8?Q?TL6mj8Yk8Xrao?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1fe6e5-7c93-49ad-4a2c-08df44013253
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 16:46:43.3010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR05MB999048

dGNwX2Zhc3RvcGVuX2FjdGl2ZV9zaG91bGRfZGlzYWJsZSgpIGNhbGN1bGF0ZXMgdGhlIGFjdGl2
ZS1kaXNhYmxlCmludGVydmFsIGFzIG11bHRpcGxpZXIgKiB0Zm9fYmhfdGltZW91dCAqIEhaLiBT
aW5jZSBhbGwgb3BlcmFuZHMgYXJlCjMyLWJpdCwgYSBsYXJnZSB0Y3BfZmFzdG9wZW5fYmxhY2to
b2xlX3RpbWVvdXRfc2VjIGNhbiB3cmFwIHRoZSBkZWxheSwKZXZlbiBvbiA2NC1iaXQga2VybmVs
cywgYW5kIHJlLWVuYWJsZSBhY3RpdmUgRmFzdCBPcGVuIHRvbyBzb29uLgoKV2l0aCBIWj0xMDAw
IGFuZCB0aGUgbWF4aW11bSBtdWx0aXBsaWVyIG9mIDY0LCBhbnkgdGltZW91dCBhYm92ZSA2NzEw
OApzZWNvbmRzIHdyYXBzLiBGb3IgZXhhbXBsZSwgNjcxMDkgc2Vjb25kcyBzaG91bGQgcHJvZHVj
ZSA0LDI5NCw5NzYsMDAwCmppZmZpZXMgKGFib3V0IDUwIGRheXMpLCBidXQgdGhlIGNhbGN1bGF0
aW9uIHRydW5jYXRlcyBpdCB0byA4LDcwNApqaWZmaWVzICg4Ljcgc2Vjb25kcykuCgpUaGlzIGlz
c3VlIHdhcyBmb3VuZCB1c2luZyBhIHN0YXRpYyBhbmFseXNpcyB0b29sLiBJdCB3YXMgY29uZmly
bWVkIHdpdGgKYSBsb29wYmFjayByZXByb2R1Y2VyIHRoYXQgaW5kdWNlcyAxMiBGYXN0IE9wZW4g
YmxhY2tob2xlcyBhbmQgb3BlbnMKYW5vdGhlciBjb25uZWN0aW9uIDEwIHNlY29uZHMgbGF0ZXI6
IHdpdGggYSA2NzEwOSBzZWNvbmQgdGltZW91dCwgdGhlCnVucGF0Y2hlZCBrZXJuZWwgcmV0cmll
ZCBhY3RpdmUgRmFzdCBPcGVuLiBUaGUgcmVwcm9kdWNlciBuZWVkcyBuZWl0aGVyCmtlcm5lbCBt
b2RpZmljYXRpb25zIG5vciBlcnJvciBpbmplY3Rpb24uCgpDb21wdXRlIHRoZSBpbnRlcnZhbCBp
biB1NjQgYW5kIGNhcCBpdCBhdCBNQVhfSklGRllfT0ZGU0VUIGJlZm9yZSBhZGRpbmcKaXQgdG8g
dGhlIHNhdmVkIHRpbWVzdGFtcC4gT24gMzItYml0IGtlcm5lbHMsIHRoZSBjYXAga2VlcHMgdGhl
IGludGVydmFsCndpdGhpbiB0aGUgcmFuZ2UgdGhhdCB0aW1lX2JlZm9yZSgpIGNhbiBjb21wYXJl
LCB3aGljaCBsaW1pdHMgdGhlIGxvbmdlc3QKYmFja29mZiB0aGVyZSB0byBhYm91dCAxMi40IGRh
eXMgYXQgSFo9MTAwMC4KCkFsc28gbGltaXQgdGhlIHdyaXRhYmxlIGluaXRpYWwgdGltZW91dCB0
byBvbmUgZGF5LCBzbyB0aGUgZXhwb25lbnRpYWwKYmFja29mZiBkb2VzIG5vdCBzdGFydCBmcm9t
IGFuIGltcHJhY3RpY2FsbHkgbG9uZyBwZXJpb2QuIFdyaXRlcyBhYm92ZQo4NjQwMCBzZWNvbmRz
LCB3aGljaCB3ZXJlIHByZXZpb3VzbHkgYWNjZXB0ZWQsIG5vdyBmYWlsIHdpdGggLUVJTlZBTCBh
bmQKbGVhdmUgdGhlIGN1cnJlbnQgdmFsdWUgdW5jaGFuZ2VkLiBUaGUgd2lkZXIgY2FsY3VsYXRp
b24gaXMgc3RpbGwgbmVlZGVkCmJlbG93IHRoYXQgbGltaXQsIGFzIHRoZSA2NzEwOSBzZWNvbmQg
ZXhhbXBsZSBzaG93cy4KCldpdGggdGhpcyBwYXRjaCwgdGhlIHNhbWUgcmVwcm9kdWNlciBrZXB0
IGFjdGl2ZSBGYXN0IE9wZW4gZGlzYWJsZWQsIGFuZAp0aGUgc3lzY3RsIGFjY2VwdHMgODY0MDAg
YW5kIHJlamVjdHMgODY0MDEuIFRoZSBUQ1Agc2VsZnRlc3RzIHdlcmUgbm90CnJ1bjsgbm9uZSBv
ZiB0aGVtIHNldHMgdGhpcyBzeXNjdGwuCgpGaXhlczogY2YxZWYzZjA3MTliICgibmV0L3RjcF9m
YXN0b3BlbjogRGlzYWJsZSBhY3RpdmUgc2lkZSBURk8gaW4gY2VydGFpbiBzY2VuYXJpb3MiKQpT
aWduZWQtb2ZmLWJ5OiBZaW5namllIFdhbmcgPHgtcHJvZmVzc29yQG91dGxvb2suY29tPgotLS0K
IERvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0IHwgIDEgKwogbmV0L2lwdjQv
c3lzY3RsX25ldF9pcHY0LmMgICAgICAgICAgICAgfCAgMSArCiBuZXQvaXB2NC90Y3BfZmFzdG9w
ZW4uYyAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0IGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2lw
LXN5c2N0bC5yc3QKaW5kZXggMGI3YmZiZDk4YTkyLi5kYzMzZjgyYTg5OTcgMTAwNjQ0Ci0tLSBh
L0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0CisrKyBiL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0CkBAIC0xMDU1LDYgKzEwNTUsNyBAQCB0Y3BfZmFz
dG9wZW5fYmxhY2tob2xlX3RpbWVvdXRfc2VjIC0gSU5URUdFUgogCWdldCBkZXRlY3RlZCByaWdo
dCBhZnRlciBGYXN0b3BlbiBpcyByZS1lbmFibGVkIGFuZCB3aWxsIHJlc2V0IHRvCiAJaW5pdGlh
bCB2YWx1ZSB3aGVuIHRoZSBibGFja2hvbGUgaXNzdWUgZ29lcyBhd2F5LgogCTAgdG8gZGlzYWJs
ZSB0aGUgYmxhY2tob2xlIGRldGVjdGlvbi4KKwlUaGUgbWF4aW11bSB2YWx1ZSBpcyBvbmUgZGF5
ICg4NjQwMCBzZWNvbmRzKS4KIAogCUJ5IGRlZmF1bHQsIGl0IGlzIHNldCB0byAwIChmZWF0dXJl
IGlzIGRpc2FibGVkKS4KIApkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMg
Yi9uZXQvaXB2NC9zeXNjdGxfbmV0X2lwdjQuYwppbmRleCA5ZGY5M2FkMjE5ZGIuLmZiMGYzMTI0
ODM2ZCAxMDA2NDQKLS0tIGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMKKysrIGIvbmV0L2lw
djQvc3lzY3RsX25ldF9pcHY0LmMKQEAgLTExNTIsNiArMTE1Miw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgY3RsX3RhYmxlIGlwdjRfbmV0X3RhYmxlW10gPSB7CiAJCS5tb2RlCQk9IDA2NDQsCiAJ
CS5wcm9jX2hhbmRsZXIJPSBwcm9jX3Rmb19ibGFja2hvbGVfZGV0ZWN0X3RpbWVvdXQsCiAJCS5l
eHRyYTEJCT0gU1lTQ1RMX1pFUk8sCisJCS5leHRyYTIJCT0gJm9uZV9kYXlfc2VjcywKIAl9LAog
I2lmZGVmIENPTkZJR19JUF9ST1VURV9NVUxUSVBBVEgKIAl7CmRpZmYgLS1naXQgYS9uZXQvaXB2
NC90Y3BfZmFzdG9wZW4uYyBiL25ldC9pcHY0L3RjcF9mYXN0b3Blbi5jCmluZGV4IDdmN2ViM2Nj
MWMwNC4uODgzZjBmMWU3ZTA3IDEwMDY0NAotLS0gYS9uZXQvaXB2NC90Y3BfZmFzdG9wZW4uYwor
KysgYi9uZXQvaXB2NC90Y3BfZmFzdG9wZW4uYwpAQCAtNjEzLDYgKzYxMyw3IEBAIGJvb2wgdGNw
X2Zhc3RvcGVuX2FjdGl2ZV9zaG91bGRfZGlzYWJsZShzdHJ1Y3Qgc29jayAqc2spCiAJdW5zaWdu
ZWQgbG9uZyB0aW1lb3V0OwogCWludCB0Zm9fZGFfdGltZXM7CiAJaW50IG11bHRpcGxpZXI7CisJ
dTY0IGRlbGF5OwogCiAJaWYgKCF0Zm9fYmhfdGltZW91dCkKIAkJcmV0dXJuIGZhbHNlOwpAQCAt
NjI0LDEyICs2MjUsMTcgQEAgYm9vbCB0Y3BfZmFzdG9wZW5fYWN0aXZlX3Nob3VsZF9kaXNhYmxl
KHN0cnVjdCBzb2NrICpzaykKIAkvKiBQYWlyZWQgd2l0aCBzbXBfbWJfX2JlZm9yZV9hdG9taWMo
KSBpbiB0Y3BfZmFzdG9wZW5fYWN0aXZlX2Rpc2FibGUoKSAqLwogCXNtcF9ybWIoKTsKIAotCS8q
IExpbWl0IHRpbWVvdXQgdG8gbWF4OiAyXjYgKiBpbml0aWFsIHRpbWVvdXQgKi8KKwkvKiBMaW1p
dCB0aGUgYmFja29mZiBtdWx0aXBsaWVyIHRvIDY0LiAqLwogCW11bHRpcGxpZXIgPSAxIDw8IG1p
bih0Zm9fZGFfdGltZXMgLSAxLCA2KTsKKwlkZWxheSA9ICh1NjQpbXVsdGlwbGllciAqIHRmb19i
aF90aW1lb3V0ICogSFo7CiAKLQkvKiBQYWlyZWQgd2l0aCB0aGUgV1JJVEVfT05DRSgpIGluIHRj
cF9mYXN0b3Blbl9hY3RpdmVfZGlzYWJsZSgpLiAqLworCS8qCisJICogQ2FwIHRoZSBkZWxheSBm
b3Igc2FmZSBqaWZmaWVzIGNvbXBhcmlzb25zIG9uIDMyLWJpdCBzeXN0ZW1zLgorCSAqIFRoZSB0
aW1lc3RhbXAgcmVhZCBpcyBwYWlyZWQgd2l0aCBXUklURV9PTkNFKCkgaW4KKwkgKiB0Y3BfZmFz
dG9wZW5fYWN0aXZlX2Rpc2FibGUoKS4KKwkgKi8KIAl0aW1lb3V0ID0gUkVBRF9PTkNFKHNvY2tf
bmV0KHNrKS0+aXB2NC50Zm9fYWN0aXZlX2Rpc2FibGVfc3RhbXApICsKLQkJICBtdWx0aXBsaWVy
ICogdGZvX2JoX3RpbWVvdXQgKiBIWjsKKwkJICBtaW4oZGVsYXksIE1BWF9KSUZGWV9PRkZTRVQp
OwogCWlmICh0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KSkKIAkJcmV0dXJuIHRydWU7CiAK
LS0gCjIuNDMuMAoK
