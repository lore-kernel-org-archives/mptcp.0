Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325679;
	b=H8OB9kg4DxmxnVfkEWskHcuqAPEod95+4GYPpTEwvY/OLoX3eYY3/icmCFNAxh7ME1c5
	 nYiI+/VqvX26ZqbyZMyJN2y9Ys0PWd17kDMa6uP5W9RKQGBIJIuXW22bqaw2NAXuGoggv
	 ZpRoFTpyu1NRpeotx9Y4b981DAhrRIZYIr5cH0LQD8tqBnfjcHRmGXB+5OmrcJStEt+0z
	 MKdtEjDRK9EgjUwWIHgmXhdwM7Hmyh4iFLUqfcllM/rUz4PTY4hmVymU2e92h+ESX7DGm
	 aDgJvdHyI624//eMDBwfzyPgRquLfNYA2Isd8F6y2nncP7RTh5/7w5+dNVjiTuZTjIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325679;
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
	bh=MBD8OTpbfb3Cko2+Fm7mVxj/RngcPsjPd/G7Mkm6GU4=;
	b=AT+kUWJNHOZMvr4ne9rrE30/N5dSQQQJgQKaPV4EG9+DsDqj7rXgOVMeJscbML+HXFfj
	 go0QjCUDPIhyHdyetQdkPvCuX61Yhq0nhMmdtEN8+2VjjrPLEu+ICcUll3ZBiDwUAP95V
	 pTVeMS2IranyMePfkbDvb8cy3MDMTlaBzl3cUpAHsfmXmiBW3uVUTShBIYj48RjN1XXid
	 uBeqOVw1rZhok34DQoi4ehqYLU7zPW1P026Q3iECqhA4yJ++SClvu4EH0r8qsYcctFq5X
	 +qjIeTnPYfLz+xSJftIBh4nQXXcwTIfd/kmKTrvubmfYgIgEoxmprOHfuPU/f0wBXDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=OCWtTKBl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.70
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48472606A325
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 15:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48472606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=OCWtTKBl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0dJi+llzbxTSnG3Ew789tKmTuTjZut/9oVaFFbTE6MFjaH9ocmGatzOCaxKOuu8/gwQDOcZEMumrdogGA0BiTyeIYkjVRZsl3S70YC9TvmGnePYM1JClqpKjXx6dd+9EvNcaMJBxMjo5qqV4OmYuzXd92MGt5yRJiJYxTL8+7s2YNduTqiF2lTxRv2cW1u7sVDZ1T7rsIcU8WfxWoadAzK7jW+LJP8q2ICxmSCMtjUo7ibPFeq+UxJ+VpxQxYu68fund6sjj1eEHRK5HaxNP3jTa2rPna+CSNkZyQDKXJGqY8BF9qkDeXLpcSUxz4Zq84RrocIAap3tt4YAYAV0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=MBD8OTpbfb3Cko2+Fm7mVxj/RngcPsjPd/G7Mkm6GU4=;
 b=wJOUB/CQH+0a71qZoNN/ZEYDlHTVfxg/zyCD8GAfeXqe+AiP/t6e3269pmIPyiUUSptEHtsun6Fm+YTgNj8pfFNF4Rp02tAFMSu+B0JQFDjOryE/jyQ4XtnvamhRroIC8U+Gq1sxFU3OpK+/zq+LMkVI7iVIqOYRFW+e84+E2KR20MDTp3gkAGb1JAzad1oV5Basz6RK1aFQTkzk7pAlDIfho8p5EghpnHY/o+wiJEL1Ev6SQ+SIukWX1YDzU2grnwJKQKUqsg7Gwer/7UjPEQ6Cq9gS0gg5ljFiU1byj3CJXsebX4pC1LxWTit8UJEKqxr5bc0d+YU0MzTyExlE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBD8OTpbfb3Cko2+Fm7mVxj/RngcPsjPd/G7Mkm6GU4=;
 b=OCWtTKBlhDHruBf/HMRL39gVopRWos4ubjqgbhyW2xAw7zGmEyflJFtdRQiz1DnYBNVymo/2fG2vEiy/Gf3WvV9GaMLdluzo7yRSicrtjH83SZjWwo0qG7hzWuPoC7kSTEt7l8V+Wv3E3ugxf24qtq6dxItRItfIbec25l/WAH7S9RtNE9mBQr7xS5WdlmczFukzhY8m83udBeAFLakhuPpDzySm1jsCMWL3uBejN8F/ufAtb/IoLaTUMrHSNTQlqs99iBciXfcN/HnMyWWmJCx9RdFQIK5I+VOnCinjagFZ6hXq0rxJsrelJQbOzVHJK6D3CnPxjFCGvv+jY3vcPQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by SN7PR05MB7775.namprd05.prod.outlook.com
 (2603:10b6:806:105::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:47:56 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:47:56 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "matttbe@kernel.org"
	<matttbe@kernel.org>, "martineau@kernel.org" <martineau@kernel.org>,
	"geliang@kernel.org" <geliang@kernel.org>, "ycheng@google.com"
	<ycheng@google.com>, "weiwan@google.com" <weiwan@google.com>
Subject: [PATCH net 0/2] tcp/mptcp: prevent blackhole timeout arithmetic
 wraparound
Thread-Topic: [PATCH net 0/2] tcp/mptcp: prevent blackhole timeout arithmetic
 wraparound
Thread-Index: AQHdcSra+844o4e65Uy62frlOoREyg==
Date: Tue, 10 Nov 2026 15:47:56 +0000
Message-ID: <cover.1794325665.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|SN7PR05MB7775:EE_
x-ms-office365-filtering-correlation-id: 1df778a8-30c3-476d-ba65-08df3f41fd37
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24021099003|25010399006|31061999003|38102599003|24121999003|22091999003|8060799015|8062599012|19110799012|15080799012|40105399003|52005399003|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1p0aNObSCSr6A9SiHIEGL9Yzf8ecjrw0I5Z2kCU3hrugVbRsHbQPC/oZXB?=
 =?iso-8859-1?Q?Apz1HG1MyjmJxI4UvryeFthpIl/hFfJW/NkTrvs39HCd+hcQ0JiRruBv/f?=
 =?iso-8859-1?Q?mP07UFiQ/3RY3Ftv7m5TNgrgJKypSTeK4bzzBkMcKmeEea8Lch39E+nSCi?=
 =?iso-8859-1?Q?9j5k3SyNqArpe6CDVozpy8v0+P64eRiDpxLJfKT1n8htZN3goU+WyJL+xs?=
 =?iso-8859-1?Q?6SY8+0VZ6Wx3NhhliIsRv8JOxjLENf4TW5FuG8Jyc0ZD5+ZhVCrmO2scfZ?=
 =?iso-8859-1?Q?Slg+rgbctMm4+GHvR4EpHSeKAQsvA/P+OT+jQsBOsZmbZqgsI2wk+NK7U9?=
 =?iso-8859-1?Q?OxtwOeuu7WDWaEQuQfZJrYrzAe1UKzdDxM5IZZ5IZpkRHtzHe52TMo3HuJ?=
 =?iso-8859-1?Q?o3gJqT/mQuItFR1rTD/68LKyrNJR8zuqbq4R9TEZLCS/HgrV2zAEYzLYRe?=
 =?iso-8859-1?Q?TJuP/1LwgnmiaOZ5ASW7U1GPnAHIEuYA6OeLAFFBXV6KHxh3B4VdpbL8wG?=
 =?iso-8859-1?Q?a76NWiJHA/hmkJVthatNBgEoakJVeDdPj4uNChRIwM2BhA6X5Ihh/RCpBc?=
 =?iso-8859-1?Q?4ynaNlAAr35/2BgZiegBEGJ2R0roujD9fjDd9tbDaQp/nTik0GwqvB2tyf?=
 =?iso-8859-1?Q?Okb8mUcB2YRHvSbBsqgnXgoP7p/n/LapqrRjFJ4WPOK+I0WzxkrKorPAhS?=
 =?iso-8859-1?Q?dfUzZMNXqQsNYkXkrL0HdxRU++j72zIksWnN+vtU6uRAhv+K0HIWGeEEnA?=
 =?iso-8859-1?Q?piE/GZkcfHkwyHaDrsszbOkOKcBgIjchEMxksaFzOFBFaQpTJT6zJLfkVD?=
 =?iso-8859-1?Q?G1Z9bAW/I5K2T1bQDzrr/zLx+yJYTF6BOwbEaW1rUZz/cD2cSVi53+56t1?=
 =?iso-8859-1?Q?CgKxTsAzBI1EACx8S4jwrPIcKkqCOkVty4RatYufVi+eAsT35OydTZSqU9?=
 =?iso-8859-1?Q?uNRrc7+Uaw3aB4ouI/JsZUpk+e/sqPuJFhEQ0VRKG2HSIy7u1qQZDkcATh?=
 =?iso-8859-1?Q?OCeYj7wfepZa43LqocQIRWX7KLWg4mTcr2JMcJlofU3BpTYlGNhKZ9XmTr?=
 =?iso-8859-1?Q?HZsJnENySHm+fg6LB7OocZpaVY2GP80hV+kFpyQLWrTR?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p65eNPpE7+CFndWZb+ea7AUikqMPCfC9Zw56DkvIeU+zx1bpqghewsGC9o?=
 =?iso-8859-1?Q?8E6Hgq6+SbpfN1cJmrdWWJkroECpo2i8Pruris63VGb8VcAzz5SgobEsHN?=
 =?iso-8859-1?Q?TRpjLetsI8TSkPXhrVjvObGO079zT252q4kUSKg6/Rol50iUAw/zmADctz?=
 =?iso-8859-1?Q?+RAaBggQxM4iFXBQAG9Dxd0OscTlP8Y/N8HNyL/AYANx8b0bJ3jyOAjmPn?=
 =?iso-8859-1?Q?N/54IW950lGulHoUOY7LeV1z3si2iIkv0g0OUywnrEOJgLZUXA4bs7EBOn?=
 =?iso-8859-1?Q?g/u3QbzElvJyRTi0WcY2T/qDP1tNI6lqTCjPCWt3F6asnevNLFfHzWu5oo?=
 =?iso-8859-1?Q?AzouHIRGDysMrH8L3qwwTQX/xKHcIcsESKbXWVMeXnS+gic+xPGYAQrQUQ?=
 =?iso-8859-1?Q?g2ymwr8AJXJOj7VnCpxWjrCsogrJ7F5pMpBjBqcotxhyffnFCtqAdlIMKq?=
 =?iso-8859-1?Q?cOCqHO6DavV3JqSsF36HyKItusfGlLNaBCGGUUoSg2+JqkRhTb1UXJQ/9C?=
 =?iso-8859-1?Q?Ke8FfPyRsqgDXTGKG7KdBHyQOErNMW7At0STLWe5yGEOb9H5bcOCSj0o7g?=
 =?iso-8859-1?Q?YUsxe2RAh3u4m0kuq4nVWx+Bebv6oHQJc1EjRzkn4z+AvN4xMHypJtxpV0?=
 =?iso-8859-1?Q?la//CBn05UODRSNULfMrww6uNbbqxfk9WsEqv9ldiwr5mzK8Vqs0ges0vE?=
 =?iso-8859-1?Q?2b6+noWJ/paxA1CxhLuT0H5ZiP7gv5v+VGkE1ZCQrtrLPPz3UiGkI/ynKW?=
 =?iso-8859-1?Q?OgxR7wsCPgx4tfX8ptg1zoiua7sDHTIGXdDh9b7KtUFwViImutKyWf+5sZ?=
 =?iso-8859-1?Q?XqJXIMG1I6QhsWQMYh3mU6HlJvcusCGHX3Zefxh6+mCYv0tvfVnmTG+5Ri?=
 =?iso-8859-1?Q?vEGLL49Nd3gSeavuoO8OuEuopfAxqzVHAdpTWtmKOGZXliXTXmCmomgms3?=
 =?iso-8859-1?Q?rFUMHOeja5yLTQaPEZom2Vd1T/nLTtZ8XX0Aw6i1D1P8QkWiD/Z+9NRHgr?=
 =?iso-8859-1?Q?sbMsfDwNm6lN+87JfSIh82fz7NYBWUl7BRRGuGyMoytr8sB+buJER1leGX?=
 =?iso-8859-1?Q?g+/RENuqRsC4PCnMly/r1TNMCkhIquiJSnMoXzl3usO5DGxn40rGOEBjwy?=
 =?iso-8859-1?Q?RaOrOddKSGXmoKnXnmwQu2IoVER0H6sXbIIwoVroC/m2zdPigG8n3PwlsF?=
 =?iso-8859-1?Q?QU9WuNf2BLT7wLUvPZvK57ypgs4Rju8HrgvYhrLkHi07DcGOq0svc+DrAX?=
 =?iso-8859-1?Q?iB+iJ13fvZhMgYVqdauOEWB1/1AGqw+8d/xevvLspRQhrCaS2qowGC4cWN?=
 =?iso-8859-1?Q?jsNQsAYTDvAXZ4S2CfJDB6h0hX8/DcPW0shFllcd0xILHW6eSsO22OrZaW?=
 =?iso-8859-1?Q?95f8HumO7jfg3cbhKhEhhraxjcR2NwVAeyVxG31amdK7i9MwPdokryr6ud?=
 =?iso-8859-1?Q?gbAAmxB7hF7MxWdn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df778a8-30c3-476d-ba65-08df3f41fd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 15:47:56.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7775

The TCP Fast Open and MPTCP blackhole handlers multiply writable timeout=0A=
sysctl values before adding the result to a jiffies timestamp. The=0A=
multiplication is performed in 32-bit unsigned arithmetic, so a large=0A=
value can wrap into a short delay even on a 64-bit kernel.=0A=
=0A=
With HZ=3D1000, a timeout of 6912213 seconds and the maximum multiplier of=
=0A=
64 should produce 442381632000 jiffies, but the current calculations=0A=
truncate the result to 512 jiffies. Both patches compute the delay in u64=
=0A=
and cap it at MAX_JIFFY_OFFSET before adding it to the saved timestamp.=0A=
=0A=
The issues were found using a static analysis tool. A loopback reproducer=
=0A=
induced 12 blackholes, waited 1.2 seconds, and then made a new connection:=
=0A=
=0A=
  TFO:   base probe 1.026 s, TCPFastOpenActiveFail +1;=0A=
         fixed probe 0.000 s, TCPFastOpenActiveFail +0.=0A=
  MPTCP: base probe 3.087 s, MPCapableSYNTXDisabled +0;=0A=
         fixed probe 0.000 s, MPCapableSYNTXDisabled +1.=0A=
=0A=
The TFO counter records another failed active Fast Open attempt. The=0A=
MPTCP counter records a connection that skips MP_CAPABLE and falls back=0A=
to TCP while active MPTCP is disabled.=0A=
=0A=
The base and fixed kernels used the same x86-64 HZ=3D1000 configuration.=0A=
The changed objects also build cleanly with W=3D1 under i386 defconfig,=0A=
with MPTCP, IPv6, and sysctl enabled. The i386 objects have no undefined=0A=
64-bit multiplication or division helper.=0A=
=0A=
The current objects have identical disassembly and relocations to the=0A=
min_t() version on both architectures; the x86-64 objects also match=0A=
those from the runtime-tested kernel.=0A=
=0A=
The runtime configuration had KASAN and UBSAN disabled. No BUG, WARNING,=0A=
or Oops diagnostic appeared. TCP and MPTCP selftests were not run.=0A=
=0A=
The patches are independent and have separate Fixes tags.=0A=
=0A=
Yingjie Wang (2):=0A=
  tcp: avoid wrapping Fast Open blackhole timeout=0A=
  mptcp: avoid wrapping blackhole timeout=0A=
=0A=
 net/ipv4/tcp_fastopen.c | 4 +++-=0A=
 net/mptcp/ctrl.c        | 4 +++-=0A=
 2 files changed, 6 insertions(+), 2 deletions(-)=0A=
=0A=
=0A=
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0=0A=
-- =0A=
2.43.0=0A=
=0A=
