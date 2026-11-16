Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847687;
	b=wyT9erM5VTx3hfi/uJuru/oN1HuEMnt/xmvFdpptibglsuf5cUmKgYCu4gI9Ld1S244c
	 WBy1EyKSLYHIjuUqTUzvmWfKEAJK0V2I01v3N/4IikM9rdUlJ5Y1PNrgMqojcJKx9aOpE
	 xshJTnoF1dYRq2aKy7xQ5CtV/RQYDUBRbvi38TK4+0ayn8IyM8Y+vUBL1vNwqHecAI/mp
	 2uNnY9YUhb4GSBH23TdVq6Da1CT1RM4qEeFsDmFs4o7VBB1SpAvgbAZ9T0OrCn1DAeikI
	 ckua00KQKUp4M4MQWbqJpNGnrxjy+42FbBMQI7NVYguxz9Gi6RFCFnT9S7gH7TPmQAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847687;
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
	bh=QWX5fPkQa1fWTpUEy3ctkammhIJjh2MgMhS3WlIegak=;
	b=LU8P/xBpBnVRUu5xAeDeDWYteO7KzB7iD3nwxHmwDShLVYyvvSCST1eK20mYxDB2GJHD
	 46LsLvj5Sczsa/gmlgc5rcB4tULUkFi6ofM/1li2P/cz5IYpZgzXYlCoQc1oeMm/femwD
	 egwKOGVhkffAkoQNBgoLGMjsYj4maF6Ihfato2JDXbmf8p/KCnoJrWao+kCBJV2CS0XM7
	 KsvfwEHnOemP/MTQ03go85dsW5rUFM75f5YUGIV+F2FZZTIbL6yg5nCak4jrNHcf5ypov
	 QaIFUlk0qluHuiecwNfY49jJ9sg+k5T8BU6HMDiXLi28yA437XHW/07TmHfHSmD05gA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=MrN78mpz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.86
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013086.outbound.protection.outlook.com [52.103.7.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38695606A33D
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38695606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=MrN78mpz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvKdaXbV4k3c3pHkHKj4ShQJV2946mMDQvVXF34wTXhAV3mQY6kupHpCQfw/B0DgUChO4DBd8V0fvlpUAgRMMRemdV/bta4sj1kVyFPRIU4ca5+VtlDo5bABN61ttCjD0lsOAQ/NAIxqvmHCtUpozFXwd+L+8er8o55Bdu2g+xNo7Ot3pesyd6xBiQ+iFJ/V1Y0VMxb6bOPWniBGpcoYxHJTWl7pC9EZp9GKtkpIOmkf7PWxVSJB7/uvJKD6gpyzA4jKUSB/M4yslmnPGkq8DzDFsh3aY/0m8AEn5ah2uHrVGdkDd8Bdo5G9yVJaiwv3zfz8D7SHlBpcxm3111EA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=QWX5fPkQa1fWTpUEy3ctkammhIJjh2MgMhS3WlIegak=;
 b=hpyzIkhau6iQap1QPJ5jlI2A/Mh4mtodX3kmMPOxB1ZX7NI6rNVUMqXnaHlvMwlojJDE5CgGTg9XiT7DIuCaoNdasm7Do1LZuBSxQ1a7H/v0ajWb3GSeDCZPBR4SICQHHo++2Fmwtj3cmRUe7M+hDWCQcVQpgs18HG1TWA7JWf38mpoNg36fXX2pk4FZveCPiUeFhD7GzOGq9r9MNRg6dtzPBKQN/Za7kQAvgsQLHuDas5zeHJxTsRIKcjDfnGBJ7e5UhA3nHdT9OFw05MxbSMtBlk6hTotPIaPY1T1ESaKADQnQVtr7RL7hzGuUl+n4FYzJ5UjbPGn9P+PnymHL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWX5fPkQa1fWTpUEy3ctkammhIJjh2MgMhS3WlIegak=;
 b=MrN78mpzsBpHmym320mp3Ogb3DoE/graXggImVRFzZYscBchex+aSmzxne1WI1TEqKDJ20VtfrYX2ZHBKYLWSMFX1z+NqkUqEyD3hD3NadkRmkbOPkwkecUim1X7TBxaKTJ5BD+PDSc08a/fMZFxingsFfk1Ut8AcEZR0lAP4eqrfWANLIaeRHz8f0p2XsE5P04sdYIYk4I6ChQDIdY1i7z1h/PeplGyQzXvFjXM5WPw/HC1ErOqlqndkBUvNUeDS0sgXX3fNSpPiS7E6LsRMsuLlkWjK/sYaU9hBGxO0XAhtuVIR8XB2yPZAArqxTRd/Jp6hrRlDKvo1bffuGVhug==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by LV1PR05MB999048.namprd05.prod.outlook.com
 (2603:10b6:408:409::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:46:48 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:46:47 +0000
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
Subject: [PATCH net-next v3 3/3] mptcp: limit blackhole_timeout to one day
Thread-Topic: [PATCH net-next v3 3/3] mptcp: limit blackhole_timeout to one
 day
Thread-Index: AQHddeoRKfQFnkqpKEeI5FF0V5woJw==
Date: Mon, 16 Nov 2026 16:46:46 +0000
Message-ID:
 <568bf901e401ab7186ba2af8fabdaeb6cadfd800.1794847474.git.x-professor@outlook.com>
References: <cover.1794847474.git.x-professor@outlook.com>
In-Reply-To: <cover.1794847474.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|LV1PR05MB999048:EE_
x-ms-office365-filtering-correlation-id: d2026c4f-ff29-45c5-48f4-08df440134ab
x-ms-exchange-slblob-mailprops:
 9IecXKUgicApcBHgIkF1u3SRiU/lhwt0lsNFu8mdc4L/Btnem6ER4tg7FUW6VZA3vpQNn2Rwo8XRh9UPJD7lvUNPrvpji3C5z6/trGk5uTxIfAbf4AfHbNHfug+xGgiGffnG89YVG9ogE725RSrkBLQbV7ktku7teqhc8VKzLt2nYv4fyioOY4p4UZxFHauHzkokzNiY0M8GNTFGmKFI4A2zz6vNB11b9BXhGjntvnjDJY26TkW+zwzPtn3WpgYHcTMCf2GbbowB7rvFzspTU6wjAh+zGQ1/CXUxZIcvSySBB6btqU21BZD/zhujM9F9r8xra0jNE0a0VCCi9sgRlJmJmPQ6TTpgZkcp9CrTY06ZrzImC1DBiKQVKQghjudfqsNa2ONZzUccZEP12Fw1ni0yzY37rmhbt4Sh8yb3WMo5WhI4SmLUNUB9HaTDEK9if8io5bAK/s7otljq9hO3upDah6TOHL9fNKB35OfgmBQkT79YsDTblmUriIOYV/rRvLO1dLM/2vd4/ng4aHUorMk1Ufh6vv2G9nfooREIPixApFW7ocHczuffn+cr0o0xNOnlxaz+rzgpWiJ00RqWJphKfgt+9rMnb2ICcI/K7OTgY9sP0Eo0Q660O5JtwnvnebtKoO9V2TrF44k5dr9wG6gIGVWPo6IccEL6zZ9FoWOUn7KSZSa1SFVRCqOg1KWrhVmtQittOKC/uuUCYpPzXIiEiz55d0OUici8b8U0TeSRaAd0lvMF4w==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|38102599003|22091999003|24121999003|8060799015|8062599012|19110799012|51005399006|4140399003|24021099003|16051099003|25010399006|31061999003|440099028|3412199025|102099032|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFk4UGpqaVpnS2NqMm9xdndFNDc0Z1BNWW5IVC9wTVBEajZBOHU1ZTdzSDZV?=
 =?utf-8?B?azVUSUxucVN1S3ZialdWQzBxbXViKzFmYzYvMC9YWnFueThCN0Y1NE9yWVU5?=
 =?utf-8?B?OGo4UUJZU0tCVVA3ZS9KYVhUQ0JsUVRpZERSUjh1OUpCamdNNnY0VThCSGRt?=
 =?utf-8?B?VEJvbDhxbW53WXA2cGFsK3N1d3FISWxYRGpOL3ROcjhNR2wvb2ZpcGNobFZQ?=
 =?utf-8?B?L1dzbmdIb2FXWmY1Y09VSk00OW1BRDVYNzdaMDdwTk9EZnlZaVBma21QQWdt?=
 =?utf-8?B?dHZyV2FEVFJaNTlBOXZEaDBsZHRlT0twUFhTc0NYamsvMFNORHFQSUM0alh2?=
 =?utf-8?B?eUFNSDZoSnlGUkhHK2l0bTYzQWsva1hpSFZSL3BoTFcwaUZ4cTc5ZEdSRDg5?=
 =?utf-8?B?Qm1tWk1wb0ZiN0xTQ1JEMmhNbmdYSW44bThWRStOZlJwbmJxWUh2SzJ3VGkr?=
 =?utf-8?B?OEFwdDBSRi94WEY3VmpUYVFCTlVYZXNITXlTM2gvNTRudXFQaytMMDJhb2Q0?=
 =?utf-8?B?YU91M2hpQ1p5b2RUbHNrTmIwaWt6TTFQcmJ3TXBLK3RWRUZXa0REY2toNXh2?=
 =?utf-8?B?ODg5ZXNJNWl2NTIwSjNmTDdZckltZHpwd29nZkNwYTNGZ2kxaS9oZk02bTJm?=
 =?utf-8?B?UC9xeWJjNE0rMlVrd0NDWlJDbkRxVEs3S255YXAzK2J0c0ExSW00L0o5Qk1w?=
 =?utf-8?B?ZVZYT3ZvWWFuOTllcXh2dUtrdkZjYzBldkFjUk5SeFBBZ21MazdwNlRPVXpJ?=
 =?utf-8?B?cE0yVkEyOFFibENnUmk3VkdMWlEvN1lVNzRRL3dOeWlmSFlKVXRKbWFWWXlJ?=
 =?utf-8?B?dDM1em1hV3J6VU1QWFJJTytqcjRMR3ZZMnEvcnZ2a3VTZjNva0llcS91czZG?=
 =?utf-8?B?VkdscjBtZkJsRlAxdjQ4T1phZWFTQlFEYlA4dzdvZmdMZHZ3ZThWQzIvYzN3?=
 =?utf-8?B?YlppSU9naTI5YjE4Uzl3MDZ2ejdFRXdpcUNTQXVvSWF1U2VZdnJ6L2FscmFr?=
 =?utf-8?B?aWtIdnY1K0FOb1FkYmpiQlF4TkNWa0JrZiszZTR5dENPUEp0UGtIMytYK1BJ?=
 =?utf-8?B?Ykw2QmVMaURjSmsvVy9xNlY4Y1pNUno5bUhmRXNpdjhZNDFYczgyWlhYM04x?=
 =?utf-8?B?S0srbnIzbkZJbzBlSkV5TkRGcDZSZVBzU05VazFML1VGaGg4Y2dMa0l0MXFu?=
 =?utf-8?B?VDkzQzNYQzdOb2QyM1VNeStuK2p5N2hhazhYa3dMdTJ6QXRUTWEvUzcvR2JS?=
 =?utf-8?B?TUtrSUtHRXNVSDRJaGJ2cklSdk1ZY0dSTTZKd2RITGdZODFkajc1ZE8xVXhS?=
 =?utf-8?B?QWRMR1JBN2Y2L1NhOFhzZkE3WkRvK3Q2YUlzLzlUeklIZ3RJQlo1UHlNZUhN?=
 =?utf-8?B?aDhFR0I5cHVYZ1laNlN5TDlhK0QrcXE0a2MwWkpZUEdkaDJpK09rcU9PNmdX?=
 =?utf-8?B?Ym81VHZaWlJzRVdOUGg0ekNKVlZpYnFuR05icGlkdEZyOVFVVDZiV2pRdFRa?=
 =?utf-8?Q?UjaX5A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3A3T3QxWHZZcEFRdzMwbEdsOU1oNm5oS0NxakUwaUFPT2xXaWNxdlN5cDd4?=
 =?utf-8?B?RDFVdVNPcVladXRRa0R5d0VIRDZMNmlKalROQm5KNFpxSS9wM2lmbklLanBD?=
 =?utf-8?B?VkRMUWlWd2d5b1pXQW90WjBoOEp0OTd1UWhHOWJpaHovREhUM1EvazBGbVFF?=
 =?utf-8?B?enNRNmcvQjZvM0tqdGwxVU53LzdURXdMUXB0bTFKcmJYbzVvNElPSGl2Ymhm?=
 =?utf-8?B?M3Zob0UxUStwSEZvemthUEwyS0UvVmY4YjdkV0RJOEYvZVZHV0dUVys5Rjkv?=
 =?utf-8?B?TkM2ZVVmVmxrN2hYV3pQMG5KbGlLQ2JkdTBZMDlUNDhwcURmV1QxdGMyNTlB?=
 =?utf-8?B?cVo2dWxJNEZ6RDVwZ2F6RXV2T200NWQ1THFTWW54NS9QanQ5UEFhazRuSEVQ?=
 =?utf-8?B?bS9ZbXRNVGE2dXhMN0RwbmpWeEJseFpRNGVjUFI3bjZhRFpMaUlxUG5JelJM?=
 =?utf-8?B?OWVkYm1ieTYyUFcxOG5IZ1lxUkRneGxjUjVac1ZsTU9ObzMvWjk2VFlEb0dU?=
 =?utf-8?B?WnprUi84YUs4bVgrbk1FeXRaNkg2U29Ub0liVmJsditJbGNWd2RDakR2alE5?=
 =?utf-8?B?RjhxNHBNSEpEVkVmbENWcGVvYnlnN0w0aG5LSmhHMjYzZy9WSWNUdG5BcnJW?=
 =?utf-8?B?YWF5bGR0VCt3NVUvSVIrTUwwK1NaR3NhN2ZnQVhISkYxTlNjNnVCYlg2dE9o?=
 =?utf-8?B?RmNIOGZIdGd5UUFLSGcvWUt4OFBwTTRaZ204ZkFqNU55azFtNGxjZkkxbVZN?=
 =?utf-8?B?Q2pMaEk5YzJvekw4UjQ0TWpuZzNRd085VkxFK0UyUU42L2pPa1N3ckhuK0VJ?=
 =?utf-8?B?bUcwNG5tQnpsbzJ6dDJ4TzFacVZaNXhVYTdwcTg0V29FRURNMW5ibE9SQWcy?=
 =?utf-8?B?WHpRQzc5SFdwMDlRcUNIaWcyTzJwelRUa1ZyREJIMzd2cjRkaHhQUDl2cmVF?=
 =?utf-8?B?elZlS1RzWFRZUEd2U1REZUtGWDhUNGV5Qlc3N2xYZFZ1bmhzRS9xcTNWYjdw?=
 =?utf-8?B?SE0zR3FyL1laalUrdHM5c2YvYUc0Ujh4blUyZnVFODF4QVhYZmJvR3grbktp?=
 =?utf-8?B?aUJxWXM0a0RDOHozR3BMaFJ4N0VFKzJyVDRvTUR3OVJvNGk4ankxZTNUdmhB?=
 =?utf-8?B?NFNWQU5SK2laYVRmNHVCVjNOWk9HMklBbGNIYVZ1SVRDUVBEdmJxdXJ1L0xr?=
 =?utf-8?B?Zkw2T1p2NHF4d3A1QkRYc2NDZjJCamVpZlh2eHZhTjZaeGZJUXZHRmRtYksr?=
 =?utf-8?B?cTRza3pGS2Zid214dVVuay9vRzV0MmtmWGhRaGhHZm1tV01hYXlsZVNxaTBx?=
 =?utf-8?B?VWd0Qzhzc3c0dVNmaEJsRndMMWFmdDl0MGdGeWo4WlZwL0k1M3lLSXptNWJW?=
 =?utf-8?B?ZHBoS2JBRmVBclJMcHlCTm96Um5LWkFjSkQ1R0VtNkZMRDhpQWpVc0lpMUlF?=
 =?utf-8?B?ZkRVRmQxcS80NFNLWjN1V1lGTndiUzl6V3M3N2hJY0xQZ054TFhTcFFrdTVS?=
 =?utf-8?B?ZXAzWGd6RHBmd0pwdVhRUi85amkybnFxOUYwMWM3NUEvMDQxN1dVcEJtZGky?=
 =?utf-8?B?MWFqMk5MaXpUN1p6ZHduWXU5eEpPY05GSEZDa3R5ZGV2MERvSDhBMGQ1bGNB?=
 =?utf-8?B?bWgwNEhRWGlxSlFMN1cvQTEvNHRCQUVsVkhRcFptVElwT1lGSWRaM1dsNTRE?=
 =?utf-8?B?VTNOV21sRHAvTkZ2V0NPaDN1QjlHR2FWd1RGTFNGYjkzOCsrMy8xWVJHQVgr?=
 =?utf-8?B?N3FrN0ZRcjJVWnhVSkwxeGFJMVNFZG1EYXAzTTg1Sks2eWtWLzZKTGJqOW1S?=
 =?utf-8?B?SS9BYkZZRUp4c1hkZVJVQWRYZ1NVZHdXcHpWandqUFFvdkhYakJTaitYVE9Q?=
 =?utf-8?Q?Il43ZMYfiN2Bm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2026c4f-ff29-45c5-48f4-08df440134ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 16:46:46.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR05MB999048

bmV0Lm1wdGNwLmJsYWNraG9sZV90aW1lb3V0IGFjY2VwdHMgYW55IG5vbi1uZWdhdGl2ZSBpbnQg
YXMgdGhlIGluaXRpYWwKcGVyaW9kIGZvciBkaXNhYmxpbmcgYWN0aXZlIE1QVENQIGFmdGVyIGEg
YmxhY2tob2xlLCBhbmQgdGhlIHBlcmlvZCBjYW4KdGhlbiBncm93IDY0LWZvbGQuIEEgbXVsdGkt
ZGF5IGluaXRpYWwgcGVyaW9kIGlzIG5vdCB1c2VmdWwsIGFuZCBvbgozMi1iaXQga2VybmVscywg
dmFsdWVzIGFib3ZlIGFib3V0IDEsMDczLDc0MSBzZWNvbmRzIGF0IEhaPTEwMDAgYXJlCnNob3J0
ZW5lZCBieSB0aGUgTUFYX0pJRkZZX09GRlNFVCBjYXAgZXZlbiBvbiB0aGUgZmlyc3QgYmxhY2to
b2xlLgoKTGltaXQgdGhlIHdyaXRhYmxlIHZhbHVlIHRvIG9uZSBkYXksIG1hdGNoaW5nCm5ldC5p
cHY0LnRjcF9mYXN0b3Blbl9ibGFja2hvbGVfdGltZW91dF9zZWMsIGFuZCBkb2N1bWVudCB0aGUg
bGltaXQuIFRoZQpkZWZhdWx0IG9mIDM2MDAgc2Vjb25kcyBpcyB1bmNoYW5nZWQuCgpXcml0ZXMg
YWJvdmUgODY0MDAgc2Vjb25kcywgd2hpY2ggd2VyZSBwcmV2aW91c2x5IGFjY2VwdGVkLCBub3cg
ZmFpbAp3aXRoIC1FSU5WQUwgYW5kIGxlYXZlIHRoZSBjdXJyZW50IHZhbHVlIHVuY2hhbmdlZC4K
ClN1Z2dlc3RlZC1ieTogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBrZXJuZWwub3JnPgpTaWduZWQt
b2ZmLWJ5OiBZaW5namllIFdhbmcgPHgtcHJvZmVzc29yQG91dGxvb2suY29tPgotLS0KIERvY3Vt
ZW50YXRpb24vbmV0d29ya2luZy9tcHRjcC1zeXNjdGwucnN0IHwgMSArCiBuZXQvbXB0Y3AvY3Ry
bC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL21wdGNw
LXN5c2N0bC5yc3QgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvbXB0Y3Atc3lzY3RsLnJzdApp
bmRleCBiOWI1ZjU4ZTA2MjUuLmNhMDAyNTNjOGFlOSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlv
bi9uZXR3b3JraW5nL21wdGNwLXN5c2N0bC5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3b3Jr
aW5nL21wdGNwLXN5c2N0bC5yc3QKQEAgLTYzLDYgKzYzLDcgQEAgYmxhY2tob2xlX3RpbWVvdXQg
LSBJTlRFR0VSIChzZWNvbmRzKQogCWJsYWNraG9sZSBpc3N1ZSBnb2VzIGF3YXkuCiAKIAkwIHRv
IGRpc2FibGUgdGhlIGJsYWNraG9sZSBkZXRlY3Rpb24uIFRoaXMgaXMgYSBwZXItbmFtZXNwYWNl
IHN5c2N0bC4KKwlUaGUgbWF4aW11bSB2YWx1ZSBpcyBvbmUgZGF5ICg4NjQwMCBzZWNvbmRzKS4K
IAogCURlZmF1bHQ6IDM2MDAKIApkaWZmIC0tZ2l0IGEvbmV0L21wdGNwL2N0cmwuYyBiL25ldC9t
cHRjcC9jdHJsLmMKaW5kZXggMGIxMGU5NGU3ZjQzLi4xZjE2N2Y3MmMxZjUgMTAwNjQ0Ci0tLSBh
L25ldC9tcHRjcC9jdHJsLmMKKysrIGIvbmV0L21wdGNwL2N0cmwuYwpAQCAtMjAsNiArMjAsNyBA
QCBzdGF0aWMgaW50IG1wdGNwX3Blcm5ldF9pZDsKIAogI2lmZGVmIENPTkZJR19TWVNDVEwKIHN0
YXRpYyBpbnQgbXB0Y3BfcG1fdHlwZV9tYXggPSBfX01QVENQX1BNX1RZUEVfTUFYOworc3RhdGlj
IGludCBtcHRjcF9ibGFja2hvbGVfdGltZW91dF9tYXggPSAyNCAqIDM2MDA7CiAjZW5kaWYKIAog
c3RydWN0IG1wdGNwX3Blcm5ldCB7CkBAIC0zNTAsNiArMzUxLDcgQEAgc3RhdGljIHN0cnVjdCBj
dGxfdGFibGUgbXB0Y3Bfc3lzY3RsX3RhYmxlW10gPSB7CiAJCS5tb2RlID0gMDY0NCwKIAkJLnBy
b2NfaGFuZGxlciA9IHByb2NfYmxhY2tob2xlX2RldGVjdF90aW1lb3V0LAogCQkuZXh0cmExID0g
U1lTQ1RMX1pFUk8sCisJCS5leHRyYTIgPSAmbXB0Y3BfYmxhY2tob2xlX3RpbWVvdXRfbWF4LAog
CX0sCiAJewogCQkucHJvY25hbWUgPSAic3luX3JldHJhbnNfYmVmb3JlX3RjcF9mYWxsYmFjayIs
Ci0tIAoyLjQzLjAKCg==
