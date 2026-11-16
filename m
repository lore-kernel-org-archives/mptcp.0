Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847687;
	b=04RZTOPsCmhELKwRregtROe5e8iKSogKkZDGOnvtREvdayEZxH/cLWQz7ocV8JQXYPHM
	 t3MjjsGh9VLxtpFaQKT9w8bPQqy279r9lfev4YmyDNDPPbAY5f2uID6dUgJsvwy2w76Ul
	 rFdL+lAVXALp6YTgWDAhhMci2cLUWPA2xpJbUkpnMPx+Wdl0w37ipLREWxqVnBdRFEzOc
	 m0ZiMrt7iFmN2KewgvC2lbXS3tAzoW2Oq0rGXE4qCmX1ynKGlgopIYM110sfRk2+taGas
	 W9aZclmaaqWKWSnuHYNEROT8EJTGClvbdxDQWXCwNyqp59SCtrVSllXVf7vyOGuHUoQ==
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
	bh=HnMRXcTHeQl2I+9hVCCMhY4Dh3fzloUnv2ehv+05U7c=;
	b=dP1SuXOdn0ySRkZw16YRJ6KVuPPwdyIiBXZFUowEDprTv5blm8uQTG5eSlG8ajcYHCt0
	 FYycVZpKwm7Qy3Nj9XgtnlFMMe3GvpAYTLTVJBVHzCoA5IUrd7j+IKoNo7qu3y8MKHRf8
	 hNswabZwIWEeSpoClxZCGP/PUVMIv51IznfUDHxcVI5cvGzUKIq/n33ZDWtSoBht/iuUZ
	 xg6pcsO11A6fYfOiXfDRCTrrK/EX2MdtuLihxxpXzJm7GXyOevBxDGVSMutWGckD2abpR
	 8hNMqT65LIXkWKzAUOdCLkPdKYyqQvT8kkdhNm2+37RX4a0jy3Qxgm5JcdypQm6Wjdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=f74NSWsL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.86
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013086.outbound.protection.outlook.com [52.103.7.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064F606A33F
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 16:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9064F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=f74NSWsL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHa5xh2vQ7UKwVSrRK6SwCnHfZYHqDjK8ghLBYcE9v7bKU5R38HD4ajONk7Kn4gayS7tOo8dbp9/03pxG+HuBGyHyZvSrzCHBJBVWVhevRtZcP9v16ksXQlP2BE1LkiFDbrvuWHlB152oayPdNFML/m5cXIODK2UB7J47kmNcLisqw8eYVGrPAIXuCR0M5QZjcpBA134BSrZPqo1Mwn+W8ZVnWqdk5PEtQmWvcG+Wq6Wv2F+BGHHpn+1U0mxnFy19q03O33VBx0aK2UzZ/T/HrNx2iSjWTauia7qEeNlH2BxIWAuphxtuDVF/yZdcre/PLruo6BMiivV9w9keIwhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=HnMRXcTHeQl2I+9hVCCMhY4Dh3fzloUnv2ehv+05U7c=;
 b=WAcbuwec3XZ5vQbZgny4nJ0aC5PCRbTS8dHzNpVwU6r7IuisBu7r2HqOwac8cFKjlPIEjwbJUI1RVJHz4/j0ShDkl1ENYzCJA+pqUAePggy3BOhJjkHNtu7x3uTQMN3RSVlsUQUiAG9MoI/LvK2TyZVjKUAbWEpENxB2WDh8//WkpHJnsZXTwZ2sKybkQPtWp4RcPeRae0O/AfKnFrhZaya+EYqjaRvx0OlRojEFqMMGLvHcLOJJv+kg26uJvtXnwmaeNVEEFwFiexWrZfyeA2gTJe9Eog+Uw2dwEBSncOOMyqqyvSZrOSnOnzwi3nPJF/kTMCv9e1Hh+xr63WeWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnMRXcTHeQl2I+9hVCCMhY4Dh3fzloUnv2ehv+05U7c=;
 b=f74NSWsLdMITGYqiVyZLAz/xGg2ubB0AlFnS/PR5l/d6EmvZv4SNZHB+cUQkk9QTdxwN0cHkYjBWMGsfCqhXulqHMwWzVz2c4XQkfIHy9/Pyi6skz8xOa0lgm2fUc0SDpn0R1RS+GVxkjZHpo3m6uxjo/2etrGBkg37xKS7K5nTO625JSvpDuYq8BrwOdmdKulRM9Jrd5Lc5mZuEF4zxcgX3tRLfKuZjQ3NiZZJNNDmKUtZCVnNDP8i24jiSUBsRTj/AJtg5PQ8Qj3ypsDdO1CL1/le6rXyrkrymcqUZ013vfkRhkg0S+CpUkRSeyKyWo1hQ//ipZvEQxRlg+SRIGg==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by LV1PR05MB999048.namprd05.prod.outlook.com
 (2603:10b6:408:409::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:46:46 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:46:46 +0000
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
	"weiwan@google.com" <weiwan@google.com>, Gang Yan <yangang@kylinos.cn>
Subject: [PATCH net-next v3 2/3] mptcp: avoid wrapping blackhole timeout
Thread-Topic: [PATCH net-next v3 2/3] mptcp: avoid wrapping blackhole timeout
Thread-Index: AQHddeoQFaxA4sTCpUSwFMSEwjAD4A==
Date: Mon, 16 Nov 2026 16:46:44 +0000
Message-ID:
 <33f003b094444e37f11f9328c783d8c5a42e841a.1794847474.git.x-professor@outlook.com>
References: <cover.1794847474.git.x-professor@outlook.com>
In-Reply-To: <cover.1794847474.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|LV1PR05MB999048:EE_
x-ms-office365-filtering-correlation-id: a8036284-f188-477d-2d28-08df440133e9
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7XnEfcFlZsmhXKcnLix11KH2JX9JxlevKMMcBoHTbgLQjd/nM7lQlxCj8WkziwwYPB0Barl1ZE6D0QInIz+FJ9xoz8T9UXgdX8yPYxNcRGTAaNxKEDw5FLBldvLOYuD0dstEfVCsIoYdcc5y+J56aIpirD+ME6O1vkzyxr0Y4oRUXMbemWQmDx7RAzq9mf0s+gUiB+4QxVVpVnVo5UnrL5fKgoxWcWkiWVj+O8Xh+GNX+R88Fb8zeRhuvb9aUBD7JhV3X17OawATlhHZq76pq9d3dyrCDrJGXNRScXUEK00hzmbHQqsOhxLBtkVMQd3tYOGETHgkKuFDJ456jS62y/VE861ufLmSpqGO98JObhEYLp0Y7KC6bomhQjyIirmcr7dGXA4UNIOK9HoEvXusMBt1tK29wyLO6Xf8GElkGBvlHibbza3jVvc/z04FNz8puGo/rCfP2gpjGsw99XDEKE273kgk5/+Q0fiujmnfHLbqcbFIzxLXeIcg4C3jqfGCbgG2+TFpH7+juWQczfAx0rk6ihyXkwB/R6XvVhfMw7rfmTQjGCM0kL0Nc3tBxpiYGE0sxSd0QUX1IcBRVUIeA11mFHuT/P7meoDg8ra2o3J2QSbaTjI/WgfMjbSRePf0lgxNAv4aFwCcpoTQwBavoXhWm15ESz6o0hh/2rH2aaHZxkAiASn12mbjH5z05x+fVzr/KDu15hXjUQzv3W35/iOlpDzWK0MmGL0CTr1n58/o=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|38102599003|22091999003|41001999006|24121999003|8060799015|8062599012|19110799012|51005399006|4140399003|24021099003|25010399006|31061999003|440099028|3412199025|102099032|40105399003|26121999007|30101999006;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajd2dXp5NTdsWXdTZlhBSDIwYmVFRHV6WE1wdTdvR3EydStzbWFNbTFEQ3ds?=
 =?utf-8?B?bHpiVDJiV0wrZzcxRi83ak1UUzFZd1dWWjVUVFgyb2hlQ29YQi8wNGE5Q1Rs?=
 =?utf-8?B?OUZrSXcrSFAzWW5WS25wNHpuOXVIYWdoazUraWY2a3NNQ24xdzgrRUMrbUY1?=
 =?utf-8?B?aUQ0Nm9PdkF5OU83ajY1czJPMDNudzdreEJScmhPbDIrVW1KTzVlSFlsQmJ4?=
 =?utf-8?B?bG5hKzZHRDkvSHZ3MzdFS0x5a3J0RU9adnRDcEdOTGRBakFZL3BpT2V0RFlh?=
 =?utf-8?B?SitYcFNwMVZYWi8wQVROQlBuTnN5M1lrNkRORHRtcnNwTkVPT3gwMjNpK1ln?=
 =?utf-8?B?YzNCMXloSzlWVWlzZklxcHZLTVZnOWpaUDBkWElIdkMrTlFicTJxVURldGUx?=
 =?utf-8?B?azNreUFqT3R6cW9PMnBzcGNpdzFkNEQxSnVCWHZvM29oTU9wTXluQjBCSXM5?=
 =?utf-8?B?Y1BaSDB2dU9JRXV0L0hscUJ6VDNXdnpsRlZUZFRQWGVtdjlQZGxkc2loVnFQ?=
 =?utf-8?B?QTNTTDJqRVdkOWtDK0svaEdMMlVlSUQyblNBVGhVMVlDc2twNE90NGswbXlw?=
 =?utf-8?B?Z0FEV1U1dTVMeWRHMW5XM3VzZGdTSzVsRFk5azRnaVQxM21RcWswaVNoQ0RF?=
 =?utf-8?B?anlldzlFcHBzRHhQRG5sUzBEdW0weTIvbjJHNHpSVFdrTGQ0Z0pHZEtYNndY?=
 =?utf-8?B?U255YWVCOXVXZStYWE5aM0s0VDI2SnR0WE1ZdkxFZ0E2Q2FJcVd2Smo1Uzgy?=
 =?utf-8?B?cDVzWmpla09FOWtSZGJyMDF0Y3hoSEFnOGR3M2l0eGJQUEx1L0R1TE95OFlQ?=
 =?utf-8?B?VndicCtDOFMwS21DY1NkOGVadk1nRm1hd2xyNWE5QmU0MWhyZVFna1BGVGoz?=
 =?utf-8?B?RjRjYWhsYWNZNWVmUnJNTmJlcEFHS3djaUxQdUpnTGxWK2tCaU1ZYko3L1dp?=
 =?utf-8?B?c0V6SFFJODFMOFZ3VWxLYWRVbmRYc3lGeEQyLzZMNlRCYVNxazZpc2hRRDNk?=
 =?utf-8?B?RG1lVm9qZXRTMkhvVUhtYzJNYm5PVnJpMUZMcExnRzduazByM0RSRmt1RlFs?=
 =?utf-8?B?OGUzVDA1VkZFSVc0RUZLOGNEcU50TkFic1A1cyszWWw5QkNvckhDOEFmQ1Fz?=
 =?utf-8?B?TkV4V3Q2akFiU1U1T3VGb3dzZVJ3aHIvM1hnUGtVbHRaUERka0hHUFVITzhm?=
 =?utf-8?B?UWlwNThDN3hrZDRyYzlseDBOdmhkWTg5TW13M1hLRVZGR3ZMcStRQ1VzMEQ1?=
 =?utf-8?B?WFFlOEpqYnJMc1pHMVBJK3pQQjdNb3ZxNHQwdjBEVVJVWUJ4cnk4VWJJbnMr?=
 =?utf-8?B?RzJGV2ZIalN4c3NVVFJkK1lBU2U2aWdDUENZOHU2cUYvQnFNaW41TG9vbTNz?=
 =?utf-8?B?c1dteHI4NnRUdzFMTVJOVGRWeVRjN2JjdzhOTmdwUW93Vmwyb3VyamEwU3o4?=
 =?utf-8?B?L3lHUlJ0dzFkVkRhSVRJZkhmckpVNmxFdWpCUG5TYk42dkFUU0MyRktsRjE2?=
 =?utf-8?Q?R5mplHpaE5M7UUyNnVGpGIc82WV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkpNd2NDQVhQYXg3U0lXbDNZRnJCZjBCN05zNG9pQkJxais5bStNeWgyOVN0?=
 =?utf-8?B?ZDBtOVpQZ001djhPOXBvcUNucFNET3FhdUx5YVRGMll1THlJTnFDR295VjlL?=
 =?utf-8?B?Y0ZLdHVMRmlvWnUwT2puSU1nRHJJSm8xcDhKWnhJS3k2NGFpUFJDT3JWU0JL?=
 =?utf-8?B?bUk2K3FjOGxVR3BXbjVjY1dQODkzL3ArWDJYQmo0T1U4N29UbnVndjFuUHVD?=
 =?utf-8?B?eTd2MG5lTXRudkJ1QXhnN1Y4eFBhNEdpSzZsb2xocVR0MStRUmtvcjl1TzJ3?=
 =?utf-8?B?anJRRVAxaUh3NmNaQS9neDBZWW1nNkYxdGFnR09hc2U3d0pvaEk5NEp6U2Fj?=
 =?utf-8?B?UHVpMitsOWZyS2JJd0p5K2ZhaTRleFgzMWUzUmd6dTRtU0MwTlh1N2VVK3hK?=
 =?utf-8?B?aS8zZldOcFBRL241UXlwK3JKUUFkUXpxa3I5TU1TT01JVjFqRWpPZyt0MWxt?=
 =?utf-8?B?bXNwdDRhTkNzQm40OS9Xczk0Ti8zbVNLWDY5Y1piQVdzUzkzZ0tiaE9ZZFIy?=
 =?utf-8?B?YUR3dXdEVDRRTE5QbWZGWFVoYWJyMUlwNlRUZWROM2RKUjNtclA0akswNlU5?=
 =?utf-8?B?ZGFvd0hNYjJLNkMzdXl2Q0h6bFpnWktDaWlhN01DM0tRUkZscGRKODVEV2pi?=
 =?utf-8?B?ekZZQVdYZFpRc0RmUlhwcTY3V2RkN1l6M2xqalZDbFFGY1BxcktlY3UwY2E3?=
 =?utf-8?B?ZWFmVWFNcGpnN2M0U3J2MC9Vc01DU1kyWFFRRWJ0NnVOVCtVcGFmRkFNMEdr?=
 =?utf-8?B?akI5Mm5pcXMyYjFGK2FXSlZaS3JZLzlmRmUrOUg1REc0Z0RVcjB0TktuWG9W?=
 =?utf-8?B?TnpCSTN3WTBHdkxqK2EyV3RjWUVRUFVycHNIRktYQjVEa3krRnczN3VzeU1H?=
 =?utf-8?B?VGxjbUlYUDFJSHFvb1ZyNXg0L29PeUQzejRMSlFyTkFyVG1IS0hDckZ3YUpQ?=
 =?utf-8?B?TE9PcTNxSTFIb1JzQVhqMVJRTFFLQjc0MmpFMDE4MjFvN09MNlhZejgyeW4z?=
 =?utf-8?B?WXNwbFMrUnpNbWJ0WFA2SlNxRzE1U3NEdTBCOEQ0R0hjWXlMZm1JKy9GbGlO?=
 =?utf-8?B?S2FHdlpJNHZIM0xYeDdFNHR2OWlOcW9YVUhMdk9rMk9KQW5RamV1TnZ1RWlz?=
 =?utf-8?B?L2psMW5ZQklLRkptN2NpU1RBSndUR1JLd3ZnQU9aaW9jVzAreXpTTEJ2eWcr?=
 =?utf-8?B?SlBGY3ZXeGtRckNPQ1VmUk5PV1Jua2NxOGJDOTVJL1AxWWpheVI2MzJ1Zms4?=
 =?utf-8?B?dy9GOThJQmhyYjdjbXhxT1ZuVXhwV1JmL2tVNU5MakQrclkyMkt3S0hhYmRz?=
 =?utf-8?B?S0hFdGVrbnFOb1c2RFFvcVdvdlFRaHM0VDBlWkpwRWV3cFVKMTdVdTcxN3ZS?=
 =?utf-8?B?U01JT0RHWnhGSG5zZDdiY2NkbE1hNjZ4bDlRTURlcFJnYzYrUGJtRGM5Z3o3?=
 =?utf-8?B?YnJoK01seUo2RnNDN2FiS0xzcnNrQ0U1QzFVb2k1YUNTZFlqSTM4eCtDM1ND?=
 =?utf-8?B?Ui92RDFFbVJLTUFoQ0RGV29YWEpORkc4WlBhK0FNTDdWU29GWlo0YlJlMFZK?=
 =?utf-8?B?eXJPa3dMbVFWM28wZ0xFSGc0TDMwTDhpVWpOVGxkem9Qdnd6c0t2UmxmRXJi?=
 =?utf-8?B?SE5WQktISzc4QjVLOHZ0U1FucmJiVHNkemd4enpjRTdudjFWSFFXV0VlUWZZ?=
 =?utf-8?B?ejJYR3c5S2FwQzF3Ym1PZFdUUVk0a2MyRG5vcmhPZExLTGROc2lOVk1LYTZx?=
 =?utf-8?B?RWZpbkZLMm4yVnZRQTRESGV0RUlLZWZENG9uNjJwTG44MU5hakJFbVhmWEV1?=
 =?utf-8?B?Y1dTVDg5TjRNSnVVOHNEL0Y4UldUbzdmb1gzbmlOUHU5ZDltRzVWTW16Y1VS?=
 =?utf-8?Q?T0BcfHbNCLYxY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8036284-f188-477d-2d28-08df440133e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 16:46:44.7390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR05MB999048

bXB0Y3BfYWN0aXZlX3Nob3VsZF9kaXNhYmxlKCkgY2FsY3VsYXRlcyB0aGUgYWN0aXZlLWRpc2Fi
bGUgaW50ZXJ2YWwgYXMKbXVsdGlwbGllciAqIGJsYWNraG9sZV90aW1lb3V0ICogSFouIFNpbmNl
IGFsbCBvcGVyYW5kcyBhcmUgMzItYml0LCBhCmxhcmdlIGJsYWNraG9sZV90aW1lb3V0IGNhbiB3
cmFwIHRoZSBkZWxheSwgZXZlbiBvbiA2NC1iaXQga2VybmVscywgYW5kCm1ha2UgYWN0aXZlIE1Q
VENQIGF2YWlsYWJsZSBhZ2FpbiB3aGlsZSB0aGUgYmxhY2tob2xlIGlzIHN0aWxsIHByZXNlbnQu
CgpXaXRoIEhaPTEwMDAgYW5kIHRoZSBtYXhpbXVtIG11bHRpcGxpZXIgb2YgNjQsIGFueSB0aW1l
b3V0IGFib3ZlIDY3MTA4CnNlY29uZHMgd3JhcHMuIEZvciBleGFtcGxlLCA2NzEwOSBzZWNvbmRz
IHNob3VsZCBwcm9kdWNlIDQsMjk0LDk3NiwwMDAKamlmZmllcyAoYWJvdXQgNTAgZGF5cyksIGJ1
dCB0aGUgY2FsY3VsYXRpb24gdHJ1bmNhdGVzIGl0IHRvIDgsNzA0CmppZmZpZXMgKDguNyBzZWNv
bmRzKS4KClRoaXMgaXNzdWUgd2FzIGZvdW5kIHVzaW5nIGEgc3RhdGljIGFuYWx5c2lzIHRvb2wu
IEl0IHdhcyBjb25maXJtZWQgd2l0aAphIGxvb3BiYWNrIHJlcHJvZHVjZXIgdGhhdCBpbmR1Y2Vz
IDEyIE1QVENQIGJsYWNraG9sZXMgYW5kIG9wZW5zIGFub3RoZXIKY29ubmVjdGlvbiAxMCBzZWNv
bmRzIGxhdGVyOiB3aXRoIGEgNjcxMDkgc2Vjb25kIHRpbWVvdXQsIHRoZSB1bnBhdGNoZWQKa2Vy
bmVsIHJldHJpZWQgTVBfQ0FQQUJMRS4gVGhlIHJlcHJvZHVjZXIgbmVlZHMgbmVpdGhlciBrZXJu
ZWwKbW9kaWZpY2F0aW9ucyBub3IgZXJyb3IgaW5qZWN0aW9uLgoKQ29tcHV0ZSB0aGUgaW50ZXJ2
YWwgaW4gdTY0IGFuZCBjYXAgaXQgYXQgTUFYX0pJRkZZX09GRlNFVCBiZWZvcmUgYWRkaW5nCml0
IHRvIHRoZSBzYXZlZCB0aW1lc3RhbXAuIE9uIDMyLWJpdCBrZXJuZWxzLCB0aGUgY2FwIGtlZXBz
IHRoZSBpbnRlcnZhbAp3aXRoaW4gdGhlIHJhbmdlIHRoYXQgdGltZV9iZWZvcmUoKSBjYW4gY29t
cGFyZS4gVGhlIHN5c2N0bCBpbnB1dCByYW5nZQppcyB1bmNoYW5nZWQ7IHZhbHVlcyB3aG9zZSBp
bnRlcnZhbCBleGNlZWRzIHRoZSBjYXAgYXJlIHNob3J0ZW5lZCB0byBpdC4KCldpdGggdGhpcyBw
YXRjaCwgdGhlIHNhbWUgcmVwcm9kdWNlciBmZWxsIGJhY2sgdG8gVENQIHdpdGhvdXQgcmV0cnlp
bmcKTVBfQ0FQQUJMRS4gVGhlIE1QVENQIHNlbGZ0ZXN0cyB3ZXJlIG5vdCBydW47IG5vbmUgb2Yg
dGhlbSBzZXRzIHRoaXMKc3lzY3RsLgoKRml4ZXM6IDI3MDY5ZTdjYjNkMSAoIm1wdGNwOiBkaXNh
YmxlIGFjdGl2ZSBNUFRDUCBpbiBjYXNlIG9mIGJsYWNraG9sZSIpClJldmlld2VkLWJ5OiBHYW5n
IFlhbiA8eWFuZ2FuZ0BreWxpbm9zLmNuPgpTaWduZWQtb2ZmLWJ5OiBZaW5namllIFdhbmcgPHgt
cHJvZmVzc29yQG91dGxvb2suY29tPgotLS0KIG5ldC9tcHRjcC9jdHJsLmMgfCAxMiArKysrKysr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbmV0L21wdGNwL2N0cmwuYyBiL25ldC9tcHRjcC9jdHJsLmMKaW5kZXggNjNj
NTc0N2YwZjYzLi4wYjEwZTk0ZTdmNDMgMTAwNjQ0Ci0tLSBhL25ldC9tcHRjcC9jdHJsLmMKKysr
IGIvbmV0L21wdGNwL2N0cmwuYwpAQCAtNDg3LDYgKzQ4Nyw3IEBAIGJvb2wgbXB0Y3BfYWN0aXZl
X3Nob3VsZF9kaXNhYmxlKHN0cnVjdCBzb2NrICpzc2spCiAJdW5zaWduZWQgbG9uZyB0aW1lb3V0
OwogCWludCBkaXNhYmxlX3RpbWVzOwogCWludCBtdWx0aXBsaWVyOworCXU2NCBkZWxheTsKIAog
CXBlcm5ldCA9IG1wdGNwX2dldF9wZXJuZXQobmV0KTsKIAlibGFja2hvbGVfdGltZW91dCA9IFJF
QURfT05DRShwZXJuZXQtPmJsYWNraG9sZV90aW1lb3V0KTsKQEAgLTUwMSwxMiArNTAyLDE3IEBA
IGJvb2wgbXB0Y3BfYWN0aXZlX3Nob3VsZF9kaXNhYmxlKHN0cnVjdCBzb2NrICpzc2spCiAJLyog
UGFpcmVkIHdpdGggc21wX21iX19iZWZvcmVfYXRvbWljKCkgaW4gbXB0Y3BfYWN0aXZlX2Rpc2Fi
bGUoKSAqLwogCXNtcF9ybWIoKTsKIAotCS8qIExpbWl0IHRpbWVvdXQgdG8gbWF4OiAyXjYgKiBp
bml0aWFsIHRpbWVvdXQgKi8KKwkvKiBMaW1pdCB0aGUgYmFja29mZiBtdWx0aXBsaWVyIHRvIDY0
LiAqLwogCW11bHRpcGxpZXIgPSAxIDw8IG1pbihkaXNhYmxlX3RpbWVzIC0gMSwgNik7CisJZGVs
YXkgPSAodTY0KW11bHRpcGxpZXIgKiBibGFja2hvbGVfdGltZW91dCAqIEhaOwogCi0JLyogUGFp
cmVkIHdpdGggdGhlIFdSSVRFX09OQ0UoKSBpbiBtcHRjcF9hY3RpdmVfZGlzYWJsZSgpLiAqLwor
CS8qCisJICogQ2FwIHRoZSBkZWxheSBmb3Igc2FmZSBqaWZmaWVzIGNvbXBhcmlzb25zIG9uIDMy
LWJpdCBzeXN0ZW1zLgorCSAqIFRoZSB0aW1lc3RhbXAgcmVhZCBpcyBwYWlyZWQgd2l0aCBXUklU
RV9PTkNFKCkgaW4KKwkgKiBtcHRjcF9hY3RpdmVfZGlzYWJsZSgpLgorCSAqLwogCXRpbWVvdXQg
PSBSRUFEX09OQ0UocGVybmV0LT5hY3RpdmVfZGlzYWJsZV9zdGFtcCkgKwotCQkgIG11bHRpcGxp
ZXIgKiBibGFja2hvbGVfdGltZW91dCAqIEhaOworCQkgIG1pbihkZWxheSwgTUFYX0pJRkZZX09G
RlNFVCk7CiAKIAlyZXR1cm4gdGltZV9iZWZvcmUoamlmZmllcywgdGltZW91dCk7CiB9Ci0tIAoy
LjQzLjAKCg==
