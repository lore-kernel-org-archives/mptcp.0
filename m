Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892931;
	b=F6Q/SL9Y3Q/HglsljeQgQ4pBtcJ6p0qX8F9EPa55zw6rxrcRHuZJXDiuOjUy9Ya+QWoJ
	 iEcXn0PoVU5d2uKnQ06AnyCmsmMull1JUjpqzPI9uxbKh8qUCYHOenWEMplJGBh1FtFvb
	 JZh3aaDtkOXXrTq+pxm/DOJX4VDtvMjj1j84ub01wmWks3auTh8YDnZQuWWyBxp6MU4fr
	 cmYdSKkiu3lG7Jew9s216DIMauqmkllSu4p1ylyA3+cEzatmVc/3ixca/ZCVrBkX/nfqJ
	 cQ/5d34nieBxYtwjQHeYYgtxKqNhkV1iTd3RiR4fq34QryFmsO8lXrYmnmXoNiZS9bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892931;
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
	bh=djT7JqX0kTEvHCwzeIbwEDy5nbwlLWHcTCeiI0OwfUc=;
	b=3uoKLS+6fV2KnMz9BrfjTO37XWnRtN3RTYGrdyV8Qpz1HCrYLpLfjjUAQ5PxUXGK6929
	 VBvvnt3bNVsZYy30q2zKM87A2j97Ah+P2B2lEzLA4tfO357+UspYDaOPlg8vSrAlC9C9f
	 x6NTGPMuZ3VQRjtD6E1ugxCU4OutV6Ia+RDRecoXXYY7GCiecDQ+WK+crASshv1QO4LjH
	 CLfbGvA7MPdPww5x3ySMkd9GKXkZJ4E/UCFKiNe4Fv5WmJ2lfSE8fKCldVAKGKlD2zUFY
	 kS/LMjh1G8yLHTISDLT7sPdQsvhP9uaHX+gOcE/P+QdW+WJvQsOsBqoJlK8ADlOwLOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=brJIKpd9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F1606A332
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 05:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 136F1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=brJIKpd9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2UFEHOfGILRZTw+r/iO8UGJEPtZ/ryZ1NQ3CEEVYgPLyj057u/PCkCc3OiojfMQlgirmp4dd/1ZEppH4AunZ9aiisoaNEas99/d8CcLl6fDtLAHCfVrOdTBdBsHk+D70DG6ltcKG4Yh3zW2j6kA1UyrZcVHxExyk2uOVzj9R+06DUOTOItEdwS9ih6O78CUSSVNHqvmjH2JtqDyj/N/1PkYf74hdNzjTG6tiSJ8irF0a5E1oi/RJKxlAy1LTdLYvy6RTIeHsokcpO9wCIx8DXLZQ39QWbTfs8pifLsMRn3oZFu/FV6vx1Lo2ZNakLOoFhoMNHJ/lenNrOIeqA6WtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djT7JqX0kTEvHCwzeIbwEDy5nbwlLWHcTCeiI0OwfUc=;
 b=oxA+jQ4tW8XVcZH1rY3Yhj6kAv4x+XXuD38n+dvpx7dFOP1yJKMljm2u1zEwfI0DtvI/T3bvCe/G+BNoUILNilvRxfrBwB7Q9IEfNSqc/oBVqiwQhAATYNZB0xRdO8d/178i6EWgUWK4dGj23p1T75IaLOKtkagvCJVPq7qJ1ZOh1QYAkROMZzwHzQtrIOJHvg8wqlyyYe7tcBkVt6gld/EhGubm/aWB5Wh+aNmVmy5yiR0DLbo4Pad4webyMxdvx/PORiSre90yk0cpDnsn3l1v9/yv/JdlXuJEyvbDaOyZpIAR1HBuf23yGnRtCL2PvH/iYxRirD2Wr5nDn0V4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djT7JqX0kTEvHCwzeIbwEDy5nbwlLWHcTCeiI0OwfUc=;
 b=brJIKpd9MW/5xlwXogCjbMdRa+0I2ZNTj44qSrQDUy7thrFEkPrSI1+5HBYTD3cO9ryJnZSpIc+em+B48dChyl1qq9gUfP6nmk60x+spCse9gY8/Fy+4mSIXOS1BAFPsXzY3Q6NIIhashvr0fD73e74l7Y6gWf2IiD1qM7A3+gK6/SC3pHdmNONSDTDM3Ta6r0jMaVgA6Y+WdO24EYRXqXMeLsukjDByjuKK2sBDUkKlBa57fMyZ8yGNDxCXbCR+pzd40XrrEtKM+e4fPkfjSjaQghPL6nkvUDu6P/USm0zJ2lnNPmDYarMmHt+6QIw7IfZO0EYlpM05tFnxcaRwKA==
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com (2603:1096:400:156::12)
 by TYCPR01MB6654.jpnprd01.prod.outlook.com (2603:1096:400:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 05:22:05 +0000
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8]) by TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:22:05 +0000
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
Subject: [PATCH net 2/3] net: bound receive window predictions before
 narrowing
Thread-Topic: [PATCH net 2/3] net: bound receive window predictions before
 narrowing
Thread-Index: AQHddlOU9m+68aSRCUiFP+HgpVaLmw==
Date: Tue, 17 Nov 2026 05:22:02 +0000
Message-ID: <20261117052200.1507847-3-llleigoing@outlook.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
In-Reply-To: <20261117052200.1507847-1-llleigoing@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8485:EE_|TYCPR01MB6654:EE_
x-ms-office365-filtering-correlation-id: 8a1597e0-f68f-48ba-f294-08df446ab7d4
x-ms-exchange-slblob-mailprops:
 CLk2x5OX5VamqICzye+315pYcDqahkiG68M+RirdauX1SGz0VxjI9jE6JBSJ3jxrHUHMumpLhvA/iC4f40P4P0jHa6Z1mz2ESEJGWVC95LmfP1s0ncFk5Q3m4ZOjafWRjd1XYiMy+txUx3VaQUa37vv6uafeSs0K5+p+cv68M3ctAWZFFUJOY1PrRMHqF4W+gRMIiFsiYUY87TgNtcwUh66X0pJbPYmafqo3wvCWl5ufUAzCGS+vhq+7ofO8IN7c5ElclrQIAZKYQf3lcWhAfCqmT0XNSXa1Xgcg86zK+9sFSiEQC2iDI1RDYcJUy9W3tnIMVFCumXiyRxAX7tXodFRCdj24DERnx76q+I082SIXSuGVol1Ihu1wI+TlGUlLJ2hPNXTUQjGFa1wq2YYkq5MyFaRq02WtUTqtjiu9EaGMk6LhRkR+T5YB42o+8S9G+eP5Hp/NGwZS968SyftRPaMxJwcepN7utuHSYFindgl+u7D+TdqxrQr8uIfNFUsfS3LBKhNPvPEInwH9izCoTzWiFNZ2O3IYxal4luAI9/DAlIIRaUIabfUymLEGOc459C0F5CHobgt874gwJe1mvo3D/SQI3OpazPZRqQr5dqXJNpVJe5oj2wsDzMIP/Ko3qexMNbONDew+RY/74njs7CkmJLmULyowAq9Q9/PJ5DzM/+yehypnARd7mBL/T/VY5VHNAGKcFQhpz6e2696G2A==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|8060799015|51005399006|19110799012|38102599003|15080799012|37011999003|4140399003|24021099003|31061999003|25010399006|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlBIR2hOaXIyOHR0WitiZit1dXk0MFQ0blJ1c2dlZTBUbi9OL1hCM3VsTHZH?=
 =?utf-8?B?cm11bUFkV0E2dUYzT3dwcXdnS1RXc2FKUjM5RktIZ3FiVXMyS21RbzNLT0xM?=
 =?utf-8?B?QUpxaGV1cXIwazF5WS8vRlZwWHdmaGhlWDdmcEE1SkQ3SjVSL3UyZkEvUU00?=
 =?utf-8?B?VjRiZGE4bkpVQ1dxdGlNNUs4aVZwbklpZk1vcE10RWRuQjc4NDFMekRjVG9j?=
 =?utf-8?B?L3I2NW1JUDVRUGwranowUlUvWjZNYk1qYmVFVytvbGs3SmVhRGVBNEpZZERP?=
 =?utf-8?B?ckt2Z3ZrekRya0VTUTFHQ1BHU1RKL3Fnc2N3dzBRckpuTmVROU9LbGp5bWFU?=
 =?utf-8?B?UjZKSEtJKzgvYUJMLzJzZElUYXk3anVHajlHMnRkUlNCUTBrYU8yV25oNGg3?=
 =?utf-8?B?ODlmTm9YRHJDeUkzMWFLOE94VjR5Vm80WjRrdmNYblRhaDRNNnZSWlNTbllB?=
 =?utf-8?B?VDdmSitaS2NOSnE1b3ZLOXRJSDZXVHh3TEg0KzZSOTd4V1NLUGVLSGtCZ3ds?=
 =?utf-8?B?YS9PMnlEUWJ0QjhLTGE3V3Y4OGdLQ05DVnNyVEpkYS9EdlY2NkRzM0tRMUw5?=
 =?utf-8?B?dnNuYzRjN2ZIMGRZSHdwa28rN2ZYRThmRGhMQ3pkcllIWXR2TU5LeHlSWTRj?=
 =?utf-8?B?N1RqNVM4U2Q0dW1VUmczbmcrcjJpaHpHcVNDR2dQTzJXUi9CN0FnQXhPdktq?=
 =?utf-8?B?TnVsc1AyWFNYMy9qdEVKUGxoUWxmK0pVWWxHTVhieHB1SXRERk5BNld4Y3Jx?=
 =?utf-8?B?OEZpbmU3V0lLOVhqVHp0cEhGOHlEZDh1REVFamd1Qk9lZndlaVgrSjZoOXV5?=
 =?utf-8?B?TzB0NWpXUkRlbmVrSVRzRnZIUmoxTEpHdDl0Y0lmd1BIOFphRHJOMUVrS2NI?=
 =?utf-8?B?NVJiZ3puZzZVVGx5VEdRcDF4RFlQN0h4L0VNWG9qOUJjUXRwSEl3bkVac3ZR?=
 =?utf-8?B?SFFtVU5ESHl0bXpZWW9IUHdEd0NKTHhtQ3JMbHVwS2locWhNeXhUVnh2dmVl?=
 =?utf-8?B?N0RhWTNzWkJ0YVNML3pVbXRGTkV3bndPKzB1N3VRNklUQ2pSczZOdyt5UndX?=
 =?utf-8?B?cnpqT2ZIUklzRjlFWTE0UzFvZHp6L0dzWlliSGhZeVU2NXpoSWVPK0Z1MTNh?=
 =?utf-8?B?dG01Y2NYU0svUlNpcmljZ0RhSXhVZUVSU1R4V2M2amZkcE1FUCtScEFvS2My?=
 =?utf-8?B?TFVpVXJWRy9GSHFXRjhjTitjSUFMaFBxR2hjbG9uNTRuUFFVdGZ0ekxHMCt5?=
 =?utf-8?B?S0s3N1REUUhVcW5rRzAyQVlaUmNEb1Rnak9kUzhCWXhFZmE5OEc4SDVlWS9r?=
 =?utf-8?B?RXJ5ZTBOdU0xK3BrSXo4S24yN2ZCVzZvSk1UbVhwN2VhNmQyMGNLdXROaytF?=
 =?utf-8?Q?boX+Ae+Sx+6VCdhQGmYhPPk1INAalVio=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzdndUJlNmRBSFd6L21SV29JSGxsT000MWM0TFJyZ0JuWnJxNWFNUGhFK203?=
 =?utf-8?B?enExTnppcTFJZXRLaTVNY3hXMERIU09WTFZ5ZUlmVFBPeFZONVZMVHEzYllB?=
 =?utf-8?B?SXZLZFNFcllYV09kOVl3Z01BTnlkRlRVRXF5VXEwczN2WCtBRWFoMmdjK0JK?=
 =?utf-8?B?aytQTTBxcEswRWVKUSs4UGk5Tys3aENqaGFSQnlMY21RODUrMTlzelFDZjVj?=
 =?utf-8?B?cnRST1ZoRVNRRWxLaUNvZVpqbkk4ZSs5dlRRdER4c1pMQ3JsMlNYU0tDU1BD?=
 =?utf-8?B?OW9hT0wrM1drbE0zR1k0d3BETnY0cUEycEJYeU9XeGpzUkJrT0tLTjRJbURC?=
 =?utf-8?B?N0xqM1NOZ29USk9QTzhuU25ZWTlSOEF2VlRMNjlrV1hZQ1puYzRyWEtQK094?=
 =?utf-8?B?OE51aGQwSHNkalhjOTkvTUtHSkdKN3ExTG5PQXZoaVdKd1NnYVZVTFNJTVY4?=
 =?utf-8?B?T2dxdjdPSnZ5T2pKWWpQYzBHVEVZZ1REVmdNdVliYVhEeFYrbmhCbVhNdm84?=
 =?utf-8?B?TTdERzlqU2RVbmVjcURMdmpxZHVvQ1RmSDI5bE1SSjR6MjUxb1ZWdjlFWGpM?=
 =?utf-8?B?RHRXME40NWVQeitVZWFhNndzNDk5czlkMDdVRDMzM1Y5S3RqckRCTGlhNUs0?=
 =?utf-8?B?anI3S1Y5ckJodjc5ZmpGMlFkc2E0NE9Db2FZb0JwcWdMUVhNY1hKbzFJdXMx?=
 =?utf-8?B?NGxRQnV2RHBhNXFRbmY1OGI1dHBjbUltU3FJWDJBUVNUZjJIQ3lwYmMxLzNq?=
 =?utf-8?B?azVIVTlBUm5OYUs3bDNTbDd0ZXJ6d0xsekhXQmtYU1RBbFdaQUltbkkwTXhs?=
 =?utf-8?B?V28zdUdLR0hhR2pHSVplei9sNHJDLzFHU29OTDlucHd3K1R1U0tIUmNEVk9H?=
 =?utf-8?B?d2MwemJ5SFg1SG90L283cjVvNVRQRmZ2c1JBT3ArVG5YR0piNW5JU1I5NlFD?=
 =?utf-8?B?YVdKV25oYjdJWFNKUS9zZlVibXZNbjNvTlRmRFNHVlZrVTFqRWRucDFjUTh2?=
 =?utf-8?B?S2syTk9HdnBXMEViV2c0ajhvU1VRUURlS0RiNkdQYVVYVFlPcSt5Nmo0Y2h2?=
 =?utf-8?B?TVlRcUhwaStsZjFvTTJZQWgwMDdtQ3VpY09Wd2tLL0JpbGJ4VkdZZ0lXL3gx?=
 =?utf-8?B?eU9UdnZqOTRzdWtIdTZzOGpNT0hZVlpIN0FxR0ZuZG5SQWcvRmV3a1Vzdmd1?=
 =?utf-8?B?VzJBKy9TQVNLcWQ3bGJyODNoaUFCY1dkTGlyTStCNm55Z0VaM3BZaUo1UE45?=
 =?utf-8?B?YWVydmZ4eFJ6VE5vNGI2b1FSTnBQN2YxSzVlOHM5WHNpdmJWVHFXdVB3K1pl?=
 =?utf-8?B?ZUNtWnl3bnR5dEUwMU5sVUp1OGJQZmtMVzhUM0QzRVM2T1E4YThjTnJsQ1Fj?=
 =?utf-8?B?YTFWT3lPWXVWUEk2bUpSTHBrcmkzbjBCN0x6alVLZG1WMXdPSmdVL1RGNkc4?=
 =?utf-8?B?RkwxV0dreTVXTTMzcnA0UGloSVZqdkNoeGNES0RKcDF2SGZvRE42VkVsRHVN?=
 =?utf-8?B?QndDTEJqY1BQU0JCYkhBRWhneUJBMXVBU0FHL0Yrcm0yeVVEOVJMU2lVeXJG?=
 =?utf-8?B?YytKVURzUGQxNVpXakhiRzQ3VkFoTkYyOEpNQnBiWVdUOVJ1TUF3Wk9nVUJK?=
 =?utf-8?B?SmF6bi9aSXVEL2RzQm9lcnpQWWdVNDdmbE1ZR09TZm9RTGE5UGtCRkxFS0V2?=
 =?utf-8?B?dnlEaE8vTUZwWXFranU2Nm5HS3RUOFcyREhJcVZxcFNQTUJWQUtaWWdPZkRq?=
 =?utf-8?B?cDM5dXQvdVBXOFZWbXUyeGFXdExwOVZlUHF6bjNoOXlqVEVjakxocVluMUV5?=
 =?utf-8?B?MGFYZnNaWjJscHBCSk1yYlNkejFrSGc3ZU8wSDFJdGVQeEZuTVk1V2gyakNi?=
 =?utf-8?Q?7gbL9CShfFxKX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1597e0-f68f-48ba-f294-08df446ab7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 05:22:02.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6654

dGNwX3JjdmJ1Zl9ncm93KCkgYW5kIG1wdGNwX3JjdmJ1Zl9ncm93KCkgY29tcHV0ZSBncm93dGgg
dGVybXMgaW4gdTY0IGJ1dAphY2N1bXVsYXRlIHRoZSBwcmVkaWN0ZWQgcmVjZWl2ZSB3aW5kb3cg
aW4gdTMyLiBUaGUgcHJlZGljdGlvbiBjYW4gd3JhcApiZWZvcmUgY29udmVyc2lvbiB0byBhIG1l
bW9yeSBidWRnZXQgYW5kIGFwcGxpY2F0aW9uIG9mIHRjcF9ybWVtWzJdLgoKRm9yIGV4YW1wbGUs
IG9sZHZhbD0xNiBLaUIgYW5kIG5ld3ZhbD00MTA0IEtpQiBwcm9kdWNlIGEgc2xvdy1zdGFydAp3
aW5kb3cgcHJlZGljdGlvbiBvZiA0IEdpQiArIDggTWlCLiBTdG9yaW5nIGl0IGluIHUzMiBsZWF2
ZXMgb25seSA4IE1pQiwKc28gdGhlIG1lbW9yeSBsaW1pdCBpcyBhcHBsaWVkIHRvIGFuIGFscmVh
ZHkgdHJ1bmNhdGVkIHByZWRpY3Rpb24uCgpLZWVwIHJjdndpbiBpbiB1NjQgYW5kIHByb21vdGUg
bmV3dmFsIGJlZm9yZSB0aGUgaW5pdGlhbCBzaGlmdC4gQ2xhbXAKdGhlIGNvbXBsZXRlZCBwcmVk
aWN0aW9uIGF0IElOVF9NQVggYmVmb3JlIHBhc3NpbmcgaXQgdG8gdGhlIGV4aXN0aW5nCmludC1p
bnB1dCB3aW5kb3ctdG8tbWVtb3J5IGhlbHBlcnMuIFNpbmNlIHNjYWxpbmdfcmF0aW8gaXMgYSBu
b256ZXJvCnU4LCB0aGUgcmVxdWlyZWQgbWVtb3J5IGlzIGF0IGxlYXN0IGFzIGxhcmdlIGFzIHRo
ZSB3aW5kb3cuIFByZWRpY3Rpb25zCmFib3ZlIElOVF9NQVggdGhlcmVmb3JlIGFscmVhZHkgcmVx
dWlyZSBhIHNhdHVyYXRlZCByZWNlaXZlIGJ1ZGdldC4KVGhlIGhlbHBlcnMnIHJldHVybiBzYXR1
cmF0aW9uIGFuZCB0aGUgZXhpc3RpbmcgdGNwX3JtZW1bMl0gbGltaXQgdGhlbgpwcm92aWRlIHRo
ZSBhcHByb3ByaWF0ZSBtZW1vcnkgYm91bmQuCgpUQ1AgYW5kIE1QVENQIGxvb3BiYWNrIHRlc3Rz
IHVzaW5nIHNtYWxsIHdhcm0tdXAgcmVhZHMgZm9sbG93ZWQgYnkgYQpxdWV1ZWQgYnVyc3Qgb2Yg
YWJvdXQgNCBNaUIgcHJldmlvdXNseSBsZWZ0IHRoZSBidWRnZXQgYmVsb3cgdGhlCmNvbmZpZ3Vy
ZWQgNjQgTWlCIGxpbWl0LiBXaXRoIHRoaXMgY2hhbmdlLCBib3RoIHJlYWNoIHRoYXQgbGltaXQu
CgpGaXhlczogYWEyNTFjODQ2MzZjICgidGNwOiBmaXggdG9vIHNsb3cgdGNwX3JjdmJ1Zl9ncm93
KCkgYWN0aW9uIikKU2lnbmVkLW9mZi1ieTogbGxsZWkgPGxsbGVpZ29pbmdAb3V0bG9vay5jb20+
Ci0tLQogbmV0L2lwdjQvdGNwX2lucHV0LmMgfCAxMSArKysrKystLS0tLQogbmV0L21wdGNwL3By
b3RvY29sLmMgfCAgOSArKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfaW5wdXQuYyBiL25l
dC9pcHY0L3RjcF9pbnB1dC5jCmluZGV4IGEyMDc0YTFhZi4uNmQ1OTUwZGJlIDEwMDY0NAotLS0g
YS9uZXQvaXB2NC90Y3BfaW5wdXQuYworKysgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYwpAQCAtOTQw
LDkgKzk0MCw5IEBAIHZvaWQgdGNwX3JjdmJ1Zl9ncm93KHN0cnVjdCBzb2NrICpzaywgdTMyIG5l
d3ZhbCkKIHsKIAljb25zdCBzdHJ1Y3QgbmV0ICpuZXQgPSBzb2NrX25ldChzayk7CiAJc3RydWN0
IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7Ci0JdTMyIHJjdndpbiwgcmN2YnVmLCBjYXAsIG9s
ZHZhbDsKKwl1MzIgcmN2YnVmLCBjYXAsIG9sZHZhbDsKIAl1MzIgcnR0X3RocmVzaG9sZCwgcnR0
X3VzOwotCXU2NCBncm93OworCXU2NCByY3Z3aW4sIGdyb3c7CiAKIAlvbGR2YWwgPSB0cC0+cmN2
cV9zcGFjZS5zcGFjZTsKIAl0cC0+cmN2cV9zcGFjZS5zcGFjZSA9IG5ld3ZhbDsKQEAgLTk1Miw3
ICs5NTIsNyBAQCB2b2lkIHRjcF9yY3ZidWZfZ3JvdyhzdHJ1Y3Qgc29jayAqc2ssIHUzMiBuZXd2
YWwpCiAJCXJldHVybjsKIAogCS8qIERSUyBpcyBhbHdheXMgb25lIFJUVCBsYXRlLiAqLwotCXJj
dndpbiA9IG5ld3ZhbCA8PCAxOworCXJjdndpbiA9ICh1NjQpbmV3dmFsIDw8IDE7CiAKIAlydHRf
dXMgPSB0cC0+cmN2X3J0dF9lc3QucnR0X3VzID4+IDM7CiAJcnR0X3RocmVzaG9sZCA9IFJFQURf
T05DRShuZXQtPmlwdjQuc3lzY3RsX3RjcF9yY3ZidWZfbG93X3J0dCk7CkBAIC05NjEsMTAgKzk2
MSwxMCBAQCB2b2lkIHRjcF9yY3ZidWZfZ3JvdyhzdHJ1Y3Qgc29jayAqc2ssIHUzMiBuZXd2YWwp
CiAJCSAqIEl0IG1pZ2h0IHRha2UgZmV3IGFkZGl0aW9uYWwgbXMgdG8gcmVhY2ggJ2xpbmUgcmF0
ZScsCiAJCSAqIGJ1dCB3aWxsIGF2b2lkIHNrX3JjdmJ1ZiBpbmZsYXRpb24gYW5kIHBvb3IgY2Fj
aGUgdXNlLgogCQkgKi8KLQkJZ3JvdyA9IGRpdl91NjQoKHU2NClyY3Z3aW4gKiBydHRfdXMsIHJ0
dF90aHJlc2hvbGQpOworCQlncm93ID0gZGl2X3U2NChyY3Z3aW4gKiBydHRfdXMsIHJ0dF90aHJl
c2hvbGQpOwogCX0gZWxzZSB7CiAJCS8qIHNsb3cgc3RhcnQ6IGFsbG93IHRoZSBzZW5kZXIgdG8g
ZG91YmxlIGl0cyByYXRlLiAqLwotCQlncm93ID0gZGl2X3U2NCgoKHU2NClyY3Z3aW4gPDwgMSkg
KiAobmV3dmFsIC0gb2xkdmFsKSwgb2xkdmFsKTsKKwkJZ3JvdyA9IGRpdl91NjQoKHJjdndpbiA8
PCAxKSAqIChuZXd2YWwgLSBvbGR2YWwpLCBvbGR2YWwpOwogCX0KIAlyY3Z3aW4gKz0gZ3JvdzsK
IApAQCAtOTczLDYgKzk3Myw3IEBAIHZvaWQgdGNwX3JjdmJ1Zl9ncm93KHN0cnVjdCBzb2NrICpz
aywgdTMyIG5ld3ZhbCkKIAogCWNhcCA9IFJFQURfT05DRShuZXQtPmlwdjQuc3lzY3RsX3RjcF9y
bWVtWzJdKTsKIAorCXJjdndpbiA9IG1pbl90KHU2NCwgcmN2d2luLCBJTlRfTUFYKTsKIAlyY3Zi
dWYgPSBtaW5fdCh1MzIsIHRjcF9zcGFjZV9mcm9tX3dpbihzaywgcmN2d2luKSwgY2FwKTsKIAlp
ZiAocmN2YnVmID4gc2stPnNrX3JjdmJ1ZikgewogCQlXUklURV9PTkNFKHNrLT5za19yY3ZidWYs
IHJjdmJ1Zik7CmRpZmYgLS1naXQgYS9uZXQvbXB0Y3AvcHJvdG9jb2wuYyBiL25ldC9tcHRjcC9w
cm90b2NvbC5jCmluZGV4IDg5NjhkYjU4MC4uYjNiOTc5NDAzIDEwMDY0NAotLS0gYS9uZXQvbXB0
Y3AvcHJvdG9jb2wuYworKysgYi9uZXQvbXB0Y3AvcHJvdG9jb2wuYwpAQCAtMjE2LDggKzIxNiw4
IEBAIHN0YXRpYyBib29sIG1wdGNwX3JjdmJ1Zl9ncm93KHN0cnVjdCBzb2NrICpzaywgdTMyIG5l
d3ZhbCkKIHsKIAlzdHJ1Y3QgbXB0Y3Bfc29jayAqbXNrID0gbXB0Y3Bfc2soc2spOwogCWNvbnN0
IHN0cnVjdCBuZXQgKm5ldCA9IHNvY2tfbmV0KHNrKTsKLQl1MzIgcmN2d2luLCByY3ZidWYsIGNh
cCwgb2xkdmFsOwotCXU2NCBncm93OworCXUzMiByY3ZidWYsIGNhcCwgb2xkdmFsOworCXU2NCBy
Y3Z3aW4sIGdyb3c7CiAKIAlvbGR2YWwgPSBtc2stPnJjdnFfc3BhY2Uuc3BhY2U7CiAJbXNrLT5y
Y3ZxX3NwYWNlLnNwYWNlID0gbmV3dmFsOwpAQCAtMjI2LDE1ICsyMjYsMTYgQEAgc3RhdGljIGJv
b2wgbXB0Y3BfcmN2YnVmX2dyb3coc3RydWN0IHNvY2sgKnNrLCB1MzIgbmV3dmFsKQogCQlyZXR1
cm4gZmFsc2U7CiAKIAkvKiBEUlMgaXMgYWx3YXlzIG9uZSBSVFQgbGF0ZS4gKi8KLQlyY3Z3aW4g
PSBuZXd2YWwgPDwgMTsKKwlyY3Z3aW4gPSAodTY0KW5ld3ZhbCA8PCAxOwogCiAJLyogc2xvdyBz
dGFydDogYWxsb3cgdGhlIHNlbmRlciB0byBkb3VibGUgaXRzIHJhdGUuICovCi0JZ3JvdyA9ICh1
NjQpcmN2d2luICogKG5ld3ZhbCAtIG9sZHZhbCk7CisJZ3JvdyA9IHJjdndpbiAqIChuZXd2YWwg
LSBvbGR2YWwpOwogCWRvX2Rpdihncm93LCBvbGR2YWwpOwogCXJjdndpbiArPSBncm93IDw8IDE7
CiAKIAljYXAgPSBSRUFEX09OQ0UobmV0LT5pcHY0LnN5c2N0bF90Y3Bfcm1lbVsyXSk7CiAKKwly
Y3Z3aW4gPSBtaW5fdCh1NjQsIHJjdndpbiwgSU5UX01BWCk7CiAJcmN2YnVmID0gbWluX3QodTMy
LCBtcHRjcF9zcGFjZV9mcm9tX3dpbihzaywgcmN2d2luKSwgY2FwKTsKIAlpZiAocmN2YnVmID4g
c2stPnNrX3JjdmJ1ZikgewogCQlXUklURV9PTkNFKHNrLT5za19yY3ZidWYsIHJjdmJ1Zik7Ci0t
IAoyLjQzLjAKCg==
