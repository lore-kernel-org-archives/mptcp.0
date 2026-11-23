Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426488;
	b=lRwJyGxhc/YSqKsWWfVl9WEe5O9tc3Ui7aUCNSkf99aynBKT5bynEKZquhFsoRvnDClu
	 14IcKDnMjb7ezYjvX9AFN5qLtSKJuiTNfwGhSJQW/djB2IzYBF+eF3zLhFn7S7TzCc4zt
	 33TXyH0wWAIqqlW0W9qyw9Ohj+oNTYxfVArXtFp97KsNca2EHFvGmmAvPzvvBDZCDX41u
	 uoEJ62ZhLMwvOWmSFFi6gLHERyEJvydFs+OpYUffzS/+90eKOyfxsIcVDKKRDhvRop3Nm
	 StTaIF3A2xtUn0JUnppXMLPOLRHzV1BD9hJNlaEh+zuzlRgVjCfPNqxSSWFDCYW5VwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426488;
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
	bh=Vr9js6lJ45Qmm2DWd4ewv+0Q2ymoCpee1vMvzWkkXyc=;
	b=qd4Wk0I+z+FsgzVceHTME2kYkahQ3DBUWgB+V+c2kgpV0ISCBKCn35LJj3gmaQ7CBTAg
	 rFEd2Tr6sfmw31vzDDPs7m2BS2ww2g7mUas2Nmobab2FScdy2EKpQVxVUj2WV0QUQGzMF
	 zBtzLXtHjpaHbiiHMFtj8s1A/BWWKy8x9+GpceW7cdAtJ5qIx/LKbdASIYxkOgIFnd/LS
	 5dn/6rO/Ip0Vg/qs3auYIx9FAMeb+BLld1QzbGSgdbvkUrPsN5voZlHNJsvKvmFtyrumn
	 QTiN3it6IuoKSBhcibNToi0bP7g5YMsDzm6qRpP0X9PVuQGtbWYP5zt6fyfpABr0WRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UEt+N5NP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FA606A31E
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 09:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C51FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UEt+N5NP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L251MSlMmxXdNldXDfzWIAOMk/luqDNg960RQsqh0T7xoJtCQ4d0Q3FonmXKV0aB9Xw4VjM2D5xHeUHnpt0+AefQffayaL1Z3hNcwfDTnfdWIbhXq4GdP0nNFlwupdBFroyQmqKf60yrjJoQSrfK1QIekJqDhsizVRtcmMOF5KGykJmYqGMXQvY1dYeskHykqIuX6MtVe8a48rfx0eSS/YHCu8SEIswg6IKNgCHz5ppLJpcoo6IEcMEp4O827MP37iGxk8ePOFbP8Rey0hptgPr2cHFQ9rPL77u40b+KD5/l3Tc16aRr6LW4Zf2Ps2VlWI/7bBt6O22Ce5Nz+OZJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Vr9js6lJ45Qmm2DWd4ewv+0Q2ymoCpee1vMvzWkkXyc=;
 b=mwSoS9e+CJTYKvRMH/2R5A9re2G9neFDHz6r/Cuj2RVphfBCKKDb79P/zRXdMOuzaP4qVe2eKdMi6DkPWn6NvWdpQghl7vLJiYAv0owM6jMH+Tz1ggmmYktZFJsC3QwO6VLMjhwzszNaiXQ/fi6gmVWrnnMOVaGOiTr/3Ze8jDsufgsdyDTo4gd9EGT8wBKwBlBNhGi7D0HsXRW4ZufMffVfmXdua9eobP2uqVEo4lTLoBPuOPHOC28/v08YIIUcfS9DK0pp2eBN6mBlf2buBkbKyM9nlvqxskm3WQYKzeCjrBHInEtg3oxer53HMrHIcPJfIiNFYFC44EbU47T4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr9js6lJ45Qmm2DWd4ewv+0Q2ymoCpee1vMvzWkkXyc=;
 b=UEt+N5NP1JUdezmzP0LJ7+muMma2rkyWyxerOCdM5W4/wtwXsgdT6zB5Ql7vlm92nGYU6wVksOk6cFFlAeBFzbjMjX03ZLk7xqv73ucuuQeyfpDyvQaZE4hhvCyguNhuwSko11EqYL7kIXO4p29UkizcawLk7POfpE2OwbU/Rhbwq1tGKNjl1okhjhTJBUtw0sU5QnwodJnFLwTVy21NEE58JFqslEPYB8UAkYiEjYpP1bofC649K5RXe9s3GNtwxXyMRHYOo+cPGFM40MiMTQTCy3DOFZE4AL1gwol6StPE/2pc9XjPP4MX95QPSA9kShGsnVKZ8Z17V0PG2HFt+A==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SJ0PR05MB8664.namprd05.prod.outlook.com (2603:10b6:a03:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:04:32 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:04:32 +0000
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
	"weiwan@google.com" <weiwan@google.com>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>
Subject: [PATCH net-next v4 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Thread-Topic: [PATCH net-next v4 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Thread-Index: AQHdeymn8lJ4XQWO202US2XHZsJUCQ==
Date: Mon, 23 Nov 2026 09:04:32 +0000
Message-ID: <cover.1795424546.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SJ0PR05MB8664:EE_
x-ms-office365-filtering-correlation-id: b5fc9a9b-08bf-4007-fbfa-08df4940c9d1
x-ms-exchange-slblob-mailprops:
 obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2aDUe2oMT6Cctkw//qk4l6AkPKai972W72OdusDyVSzWWS2jzYgy39Z+/fICAYBAtQaXz1/FPo24Av8NgM2ZeQcB/4rGa2+YLTCAfkG7IpjKIZ2L9i4kOaDZfm6oWSjJKf7AtSbG92kzNjXzELIv97ttufCQSqzkLzlO/kaz2WcVrW8yStxgviWAwsnZhLLXFXj6H9L7HrccF0kJ4mZ+s4r+k83NZBL27fl6c9lJTcY5jqQD4heh334e6CDlvyoIsYifczTxsDADQxY8CX++FtmqhGrvmNttkEOQ2E8TEnMTjZ4gRM7Qj2ML3rjMGxEDoQ2Ad48rcM4C10mRzKjpbq6MqkC/4FVG1X3kzaekAmA6SxdL7GKW+9jcIWLjApf8zJrBwadFgO2PgN5Swy7kTKyPjU1lsodUdj9lYHYsVKvHQn/ueYjPZufPrIg1pIyd6MJlV28y5pr8+sB/VmQTGxKyJXngQaqJ57Qv2Ny8vBl1gvgnUMMY791xV/TLmUalJ0z9xUZUtEISFcKDZ+vvBRAxD0vQSmWCVctkk4Zc7Zg0pTeUmHE03hp0ezmNWKBOho90/2ok7E3naI0S/Sq76Jk94aJf6uUybVaehG0ryLp/+xRBkA0GBqxvPezwWYW3giBAtIf5kGBbA0eWIUENZvUSVlT6T5Osl7zZYwM0rcqSj/J/l50RuBEQwiGLUrBNTfxIAFY4v6hj9TUGBL3C1Oml2YkLG5vELuC5aCZOjUnNz1FXxr5gOyRCDO1tmDmhMBoyxY1NC9ujrMl09SE+tV4Z9lSejciCH
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|38102599003|22091999003|5062599005|8062599012|19110799012|8060799015|51005399006|24121999003|25010399006|4140399003|24021099003|4302099013|440099028|3412199025|102099032|1602099012|10035399007|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VKSWSIZo24L0zQ+Urek3XyawcMEvtaI1x718WBcUErGmbz590EoP667Cx0?=
 =?iso-8859-1?Q?HN19EJGwZcgubiiQEWvl+Pinut1cjkx3hoOvmNUaSr11Xr3EuBp4azXS+a?=
 =?iso-8859-1?Q?20SK+9pH6UOeDFzUIJaNm6p6v1D5gPMmikR6urq5mFliNexnYEKXrN7XGA?=
 =?iso-8859-1?Q?qCDj+NzuI8jrLlsqPehyF+6fvov8w9jUDdLJHO2vZZl2da1MbrXsty4/Ve?=
 =?iso-8859-1?Q?4gwKOvUTcM3U7ioknaWPE68FPU3JWxWL6cKf7cM1EzNwTlnh1rYZ6gdvdy?=
 =?iso-8859-1?Q?4c5/nADhVBiArl7ep9uxjnG8Wem9s+fNyGtLhKzpJBqPunMEtZdgYv84qn?=
 =?iso-8859-1?Q?1pBOzTFRClaXphVqfUwhNRtbBOZh0FT+Be3ZeZdqBiyyyls0Tglt78GWs8?=
 =?iso-8859-1?Q?M5ZUkikuBTy5C3SsTgtae1kKeQWQlBfW7VXuNznBeFoSmp9PAHfL0ev/SE?=
 =?iso-8859-1?Q?aEG0/eUh42MyPtuhtn3BFxzaSe/Js5Nog9hBZ0nTq4sJscyBHYJLlo5GcJ?=
 =?iso-8859-1?Q?KO0OMYnWvsnM1mahR13OBQiD1F4HU0uXjFunAl028QfkFavVSaG/bf0R1O?=
 =?iso-8859-1?Q?7UjczVSLx78eVX86ILrdr8zkPkBIkyLVdq2864n7V7CqnfWzlQp0QHVqHR?=
 =?iso-8859-1?Q?uBLsA3TZ1dsYdhOeN6Uh2ouykcO1O0dRX6vbCr2lS3BFO+5mI8gYLLBOqx?=
 =?iso-8859-1?Q?LwuWIlMi4X5JdpTW+Pv9C+Vh7osUx1jyk8MiprBfFISDNZRi8q7INK1FPb?=
 =?iso-8859-1?Q?biqdSmao3EFL34netEDu4IA1Xt+YuwPSZJ2hFTvZ4Pmowky3SjVDWR1sPn?=
 =?iso-8859-1?Q?ro6PMw7tmfxNtbZ6NxUfPMdX+oYgPmJFRuxdn2/cFSuwO0diZqEw/96LmN?=
 =?iso-8859-1?Q?HPUeSpKSyS8swJ93zhYeGC9gkVzhnBEEiZYw2fo1dq71DEQR8GvEuaX/rY?=
 =?iso-8859-1?Q?nbwci6iJhzeiPunGhm6owID1P6WvJZT+DyqLn4zIDPJDzw2BBPpWRD12cy?=
 =?iso-8859-1?Q?XzsymrFQjiX2Dh+h2fisEc3oeGhKSlZIgmY2w0XewmOG4Gq1RwPqwnwv4C?=
 =?iso-8859-1?Q?fIjWv2ZFvEOtYpr3C8Fzx869txuJN13w3HXVOk8yT8HJU2s0BRG5hE6nIE?=
 =?iso-8859-1?Q?fTtRWmILxEmOyR6dtPa0vUpnL8Rb57I/moXMv6S1BkIhPyPXNe?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5/QAZHTV84GhZcoRM1AOkL9ApqCcyhoJFyNtGgcF1bjhxUUGVMkU8proNw?=
 =?iso-8859-1?Q?ed8w6jyuH3Zua2FDCc6o4NRjiwYTmG+TuuEhhLUVTqG/eVAQQq+KxJWV1t?=
 =?iso-8859-1?Q?nV30z7hSthqVxVKl1PAIqXVoAkCD25Q2AJVoG/VYicSb9Yuammdbccp7B+?=
 =?iso-8859-1?Q?z4rlL5MKcCRNcZZeRPxYrUWg2Cd/JKVMzuBw/cYCWV3MpXUe1gECeMPsnI?=
 =?iso-8859-1?Q?I8xmoAy0QKml2swXqLCI9NmS07FpE6dNMcBGaR0ahLuD/rDNmBl9GkkhzU?=
 =?iso-8859-1?Q?rmZGXFdnS5FnHrFGzT0m8B0pA6ze0gLzDKeEK/wT625iU0asyxkRiEd3CE?=
 =?iso-8859-1?Q?WSOeYFlOvQfdlNvMGWE6KJfhQL2irFvzyFQTmZqdqHTRwWdA5QTr3uJYLJ?=
 =?iso-8859-1?Q?IBvYSCQ52teLoEkMTuwRjU98y/IvXJ52Iu6mXdJj3kOWyBZrQJROa73wsw?=
 =?iso-8859-1?Q?eZ0TtEc2jAAxro3HQi4OVBEPQdvkKfOy5qN7D2vzYTZ8/0uUBOiO0/9a8E?=
 =?iso-8859-1?Q?axspG7qbkDPkLNDutTjw5D0m3ftBWoV4SG6LrRv5jxWOd2vRczOtio3r1P?=
 =?iso-8859-1?Q?4i9b4Rg+WKm9Lw4z9vkuv3F1agFxcvf4JMuNGFZVQrJ2i7TdebPEzLw1mg?=
 =?iso-8859-1?Q?XPpkxAK71zgrl3RyQORhRcSd8CHEmOQ1CKrAFqaKIqyZDFhr+FKthys0Pi?=
 =?iso-8859-1?Q?wfSi0gmrPYCSAEvzTXVznMpiyhCYDaNwyPfHouaV3js5+u29oNrx4HRa8s?=
 =?iso-8859-1?Q?FzfR+3G68j2V/5SP8lw5BXt7em/l6UsRP4pkPv8abmZq0XOJT5STB1FbAZ?=
 =?iso-8859-1?Q?USAbOh66eLuGul21urrxchGXjoZgu/7mg/zw7oKEZjl+5+wquNJn89HHW8?=
 =?iso-8859-1?Q?ep04XxcWN+sIHftar1bXjJowZwH4ueTXLTfvz5GPo6z5md7v4g2G/S9AeD?=
 =?iso-8859-1?Q?KD2HRlhCssTnssSxEaVK59xVpPJYy/qxh6YeZLzE4YHLWO96Z9NZmAvl+J?=
 =?iso-8859-1?Q?swwk/tNf4S8mRhYM9k4LfjPgT9New2qYyF1XfSeXqSChvBcx5yCyApxGd7?=
 =?iso-8859-1?Q?l6wrs/vRXgrQzGIBUOO/NaS+SRZ4cZuLFaJ1LK51zvkemnoX2Dv9K1uJPm?=
 =?iso-8859-1?Q?AI/5+HEpFRjhqee+01WIvULzljXPtPF7khpXYb/2oDs8QZYjQD0MoN2906?=
 =?iso-8859-1?Q?uER3sLKE/i3Dd7QQc1yDrMIHKQ4/nWs5aUffT4W4CaL+z3iHDv2Zj0JbRh?=
 =?iso-8859-1?Q?AfUNCkgtUqafCPofqs7ANPGythj14SIEJkhkWT3hb2rDuXWsXCweyBonF4?=
 =?iso-8859-1?Q?kFCA38RTbZIXjnqtxkZKDFFpEdcSQZ2Ds54SK+AmcSkZD6lDCfZe4KYb8J?=
 =?iso-8859-1?Q?sOEh44H/SS8Ujlb4uNJUdGsnBx1/2sykziao4UP+cGRgnZtAQtwSAIz6bj?=
 =?iso-8859-1?Q?aDMl9EbzkOcq80oA?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN6PR05MB3281.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fc9a9b-08bf-4007-fbfa-08df4940c9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:04:32.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8664

The TCP Fast Open and MPTCP blackhole timeout calculations can wrap in=0A=
32-bit unsigned arithmetic, even on 64-bit kernels. With HZ=3D1000 and a=0A=
64-fold backoff, 67109 seconds becomes 8.7 seconds instead of about=0A=
50 days.=0A=
=0A=
Compute both delays in u64, cap them at MAX_JIFFY_OFFSET, and limit both=0A=
initial timeout sysctls to one day. The new input limits reject values=0A=
that were previously accepted, so this series remains for net-next and=0A=
is not intended for stable.=0A=
=0A=
Changes since v3:=0A=
=0A=
- Drop the Fixes tags from both patches.=0A=
- Leave the existing comments unchanged, as requested by Matthieu.=0A=
- Combine the MPTCP arithmetic fix and input limit into one patch.=0A=
- Name the MPTCP limit one_day_secs, as in TCP.=0A=
- Drop Gang Yan's Reviewed-by from the combined MPTCP patch because the=0A=
  added input limit was outside the patch he reviewed. Keep Eric's=0A=
  Suggested-by for the MPTCP input limit.=0A=
- Add Kuniyuki's Suggested-by for requesting a limit on the TCP sysctl.=0A=
- Move the test notes out of the commit messages, as requested by Eric.=0A=
- Rebase on net-next eb6d6c80d354.=0A=
=0A=
v3: https://lore.kernel.org/r/cover.1794847474.git.x-professor@outlook.com=
=0A=
v2: https://lore.kernel.org/r/cover.1794672619.git.x-professor@outlook.com=
=0A=
v1: https://lore.kernel.org/r/cover.1794325665.git.x-professor@outlook.com=
=0A=
=0A=
Testing on v4 and its unmodified base, x86-64, HZ=3D1000:=0A=
=0A=
- Loopback reproducers induced 12 blackholes with a 67109 second timeout=0A=
  and opened another connection 10 seconds later. The base kernel=0A=
  retried active TFO and MP_CAPABLE; v4 kept both disabled. Both probes=0A=
  completed using TCP on v4.=0A=
- Both sysctls accepted 0, 1, 3600, 86399 and 86400, and rejected negative=
=0A=
  and above-limit values with EINVAL without changing the stored value.=0A=
  These checks passed in the initial and a new network namespace, with=0A=
  unchanged defaults and independent namespace values.=0A=
- The affected objects built at each commit on x86-64 and i386 with=0A=
  W=3D1 and KCFLAGS=3D-Werror.=0A=
=0A=
The 32-bit cap was checked by compilation and arithmetic, not at runtime.=
=0A=
The TCP and MPTCP selftests were not run locally.=0A=
=0A=
Yingjie Wang (2):=0A=
  tcp: avoid wrapping Fast Open blackhole timeout=0A=
  mptcp: avoid wrapping blackhole timeout=0A=
=0A=
 Documentation/networking/ip-sysctl.rst    | 1 +=0A=
 Documentation/networking/mptcp-sysctl.rst | 1 +=0A=
 net/ipv4/sysctl_net_ipv4.c                | 1 +=0A=
 net/ipv4/tcp_fastopen.c                   | 4 +++-=0A=
 net/mptcp/ctrl.c                          | 6 +++++-=0A=
 5 files changed, 11 insertions(+), 2 deletions(-)=0A=
=0A=
=0A=
base-commit: eb6d6c80d35449c27471b1874f13066c09a8964d=0A=
-- =0A=
2.43.0=0A=
=0A=
