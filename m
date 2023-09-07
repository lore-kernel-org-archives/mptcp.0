Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2051.outbound.protection.outlook.com [40.107.115.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C263A
	for <mptcp@lists.linux.dev>; Thu,  7 Sep 2023 00:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMqe/ZDhI5oW8zSvVPJttihq62+0F2v4U/o6U04sn6Vp2kDYg+/0reKUlX0D+YqTxcAvaLhB39QTNY4XqO0CgptS/lXqwFJesVFUKHLoJ3lZoiSog6aB+/Ev5zuDcW5zQFZjeyvtXECb9F1pY2c3/lCp82TjGh0g3ds64P1wx3qiqBngse+m1GZIEagnnzfiwgdedAToxvjpCv8LAhn2MKrVpe3uCiQ14tuAnD6lybnbDcaFpbzEe93qXBskR74yBeWY8SbNcKcWryO+cvByH9HYpznHMhq1BikJFy7kjapI5lBCTT8nDAno/8cndUovraUlR9ai1H4bsGzjZXEjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5202Fha3Twxq6bBCE94ie9iQ3t0QOIcMIGkwdUkjC0k=;
 b=bAKzfAqvsmtowKcs7a9BzM494A06s8I8/a/XN1jYaBA9xQ2p2bx4JXQgiOkztRZLCDoKIpv7BDAWiLiWk86OKiX3E3sa/O4js2I99W03E42yb/yBRqfQLLc/OfmxmXwgDgw1bAOyfFQ9buc667o0BhFuggp+ehpEDA+SHoTyhb7hMupBXXgY/Rg9yPVM6y0Wh4pbyRWsCvijfWBakRX36IGz+tgCoLJS0B5g9GeWkSo5bURsjf+mx7KmbsSAEQZENnfyVjJ9v4m2JV2tNR5YfvYcVC67SoTv5UyYBlu8TebEB41IVSDLvel7yezloYr3ZbeQOvZJK//M6DxoEaOw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blueflag.consulting; dmarc=pass action=none
 header.from=blueflag.consulting; dkim=pass header.d=blueflag.consulting;
 arc=none
Received: from YT4P288MB0088.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:ef::19)
 by YQBP288MB0162.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:77::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 00:35:54 +0000
Received: from YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
 ([fe80::72a0:f5ae:95f1:355e]) by YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
 ([fe80::72a0:f5ae:95f1:355e%7]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 00:35:54 +0000
From: Alexander Witte <alexander.witte@blueflag.consulting>
To: Mat Martineau <martineau@kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Re: Subflows for specific types of traffic?
Thread-Topic: Subflows for specific types of traffic?
Thread-Index: AQHZ4CAXQwBJ0sltNkmx6Liw76nI6LAM0mKAgAGz1YA=
Date: Thu, 7 Sep 2023 00:35:53 +0000
Message-ID: <97EFFF48-340C-4859-9657-ED70137C2CF7@blueflag.consulting>
References: <37779FCF-34D3-449F-B966-925845496DA5@blueflag.consulting>
 <2686ea81-0ae3-4c3f-92fc-59cb9275829a@kernel.org>
In-Reply-To: <2686ea81-0ae3-4c3f-92fc-59cb9275829a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blueflag.consulting;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT4P288MB0088:EE_|YQBP288MB0162:EE_
x-ms-office365-filtering-correlation-id: 8a38f6d0-f112-4db1-0ab6-08dbaf3a64fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QD7KwUfPJNdLB3viOK+l/iGMminlONeCpI/JkfMuaxTJL44wy4W9pWNqFbhp+BlIp4qgHr4FZhS3mcDbppwMif8mq+MtTbrQaalWC8LVQXBeq0pqaJd3OmFAeYMAOuom8Wyk+6GE//JGV0VUf8BNcPQeNWmw8GJtY5jXulhbjnKU0LCQymWbGSa96kbvrnfFojB8mKUmfNRbHqbwLQzR1d5bbxvcmv3+eaE07pIrsiylDimYxS1JM7ixUQj3asU3TMWnj7ZQSsWqO0iZs5oAd8bi4PoX65u8/uZ62BlYmIXDPn8XjMSPBQYqQlf6r4/tp6EEsAGAVnhgPUNzvd5uoH7qLP4fkazZzd+eq1OsxX/x9eM7qH96ugAYd3Y2qi8iljHZoQ+3vKt6yueVnOvfimiVqv9FCIYqp63WakBhwMgAPOKoJc6dSb9ZSH5DwdTDEW99OTMPwsFdgreOPf2B60qybNs4umBqWXsBBTM/mVVYkjnro2x6HcTJ4CESLqGdkFHrzJqsIfOSwRmhh1uv3cPGcclmw3jE2alYGmDfuhKLHJfAdl6y2SC/6Wc81ZEY0wdCeVIqS0/gxKp8YtZF0C7qNxIp7L5vg1uED1nrn/x93s+hjqUcTNT9kms2rkc9mclc1UaceBk9i0rA1Yzs9g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4P288MB0088.CANP288.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39830400003)(136003)(451199024)(186009)(1800799009)(53546011)(6486002)(6506007)(71200400001)(38100700002)(86362001)(33656002)(38070700005)(122000001)(2616005)(2906002)(6512007)(478600001)(91956017)(41300700001)(8936002)(4326008)(8676002)(5660300002)(66556008)(316002)(66476007)(6916009)(66946007)(44832011)(64756008)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2JadmZDQ1d2TkE2QmRqNVErNkVwNVF4NlJzUEdXQmdLRWJNOXQxTlB5TCtk?=
 =?utf-8?B?ekNpYXkwMGVhVnphZHdxd2NrZzRoSFFUcCtZWG5UV3B6bHd6U2RwTlpJUk9L?=
 =?utf-8?B?K0xnL05zRVZ1NmdsY2dSenJTRDc5S1BLeDdITTB5ejlqcENvNXBYN2YvUTRE?=
 =?utf-8?B?VFZtUHE1eFZ0amo1U05SZmplZGNTaUE4SVg3Yk9CVlVCalYxcmp5a2o0bkQ2?=
 =?utf-8?B?SFNwUFlhMFpvWTNtckY4dTlPdDVKNTY0SVExUlVuaWRQUGNPK1plc3hnVi81?=
 =?utf-8?B?ZCt2dnA2LzUxN20yRnFuZTdjbHd3ekxidHZMazBOazBvVDJxU1Y1ZzdGUGtl?=
 =?utf-8?B?ekEyTnlzNDc3WEtkZmRraXlBZzIzd1hpV0VKNDdTT2Q4ZFpnVzNFSUZjQWo0?=
 =?utf-8?B?OVAzVmNLemd0bEZsQ3FrYjRjTDlYcnJGSlFFVUJOWlAxVVdpRG1BT1lDcldn?=
 =?utf-8?B?QmRoN2x5ZFp0UjNzcU4vSGpVYVd1ZDAxUWR0eGp1eSt4SFZVczNpL0YvZHNs?=
 =?utf-8?B?YVF5VnV4NWhaS3RiWUFkN0pKRjVYbVpWUGt1N3N0anpGaHA1OGd4Y0FoUTR3?=
 =?utf-8?B?MUkreWF6Mk1iVThoV2JLcGsxSHBPN3MwRVczZERZM25XaFVHd29NQkdyUjJn?=
 =?utf-8?B?TlpybncvZDZ0dG9GL2pPYURzQXBzWnhCeDdTdWRTOHA2b05BNFhud21RTWhV?=
 =?utf-8?B?WkxMUDJ6NWxxcm5hRHFjNGtocnhpaXRhTHFUdzM4SkllY0g4MmJwK2UyZ2tW?=
 =?utf-8?B?bU9vRGtNTWVjUzJINXRwVWFqVTdKSmNWOCtUMS9aNzdYVHZvSTBCUHFTM2Rt?=
 =?utf-8?B?WEtFb2FiendSNi8vVmRheXI3ZVg2UGhrOGI4RnkxS3VSM0REczJVYldnY2Vi?=
 =?utf-8?B?U3NONU5GZkx2b21nU0V6ZVFlb3dwVlJQa2gxcDFUdnlmMEhjSGpweHdSRnJK?=
 =?utf-8?B?MTVIYWNPU2dJRFhNelIrMjZPTkp3amljY2FXNHJrQ3BpQmkyY2xDZFdTeFFS?=
 =?utf-8?B?WEZ4MTY0dWsyS0QyQ0dwNmpSYzQvcE0rQ1JSZEN6OWluMXAxTXgwTkdQOTVL?=
 =?utf-8?B?SzlwRUVLQ2h6bmlLS3crZVdxVzlHSkxETy84cnVuT3NleWN0a1hzeWQ2NFVj?=
 =?utf-8?B?Qys1anJuRDhIeUx3bnN1aFZ1VWdGeUJiUGhrbkNjdXZLVFFPdEN1ZHMybkpq?=
 =?utf-8?B?T256VEZPWmdadGU1NkFkcUxHVTR2a2YySWlGRURrdmVGZ0NQbmxFM3lYbDF0?=
 =?utf-8?B?Z05jSVM3cFZ5NjFOa2k3YjNlaG5MUHN5Njc4eWp1K0l0ZG90aEVMM0J3OWhj?=
 =?utf-8?B?M1R5R0VNV1BnQnFoRHZEQzFyMUpFVllCV3V2VDZzaFp1MWd1SHU3S2l3TUZU?=
 =?utf-8?B?dDRoN2MxVUpxaHZyblFRNjc3WEtRT2dGK3RUV2VIRi8xRWJjK3QyKzVlNjlY?=
 =?utf-8?B?cVVGVmw4b0VINHhBdGQ1VUpDeWVWM3o2N2hLU3B3YnV6TkxNU2Y1OUJocDhx?=
 =?utf-8?B?bFZqQWpIbHd6aTBoNVY4RytDYW5oNEJ6S1BOeUFDV0F0NnJjL1VnS3BRZ0FE?=
 =?utf-8?B?Z0IrSWcyMEJubGNDaVlpck1MbjI4N1RwOUJ0RTJWcEdwbzhQRnE4ZHYwd1o2?=
 =?utf-8?B?RldjUThlb3NjZnVadTlXczY2OGZOVDZqWTRHaGRkb1E1eVJsaWV0MFVhQ3Z4?=
 =?utf-8?B?M0p5KzRPWnNPR1VNZ004c0FUVElVN2pYT1phaGJoc05OdEU1d0dRZ202eXJz?=
 =?utf-8?B?ZElsckpQcVNwU2lsTDd6bW1rQ25mUFRoYjhsckM4OC8zYjZ3RFEzaFdYa0tL?=
 =?utf-8?B?OGNaTC85KzZZWXcvWngxTFJsaUVKOGlIejQ4OEVSdlpSN2V5U0JZUGtibG5x?=
 =?utf-8?B?N3FNT0tub00vZitXdE5WbEIyMURYSDE2TVhvOGZab0xQNXM2Y2RFcHJoMHk0?=
 =?utf-8?B?Zk0vbHVQNy93WGdZWFA5Wlh1U1lXUVpKMUVBQkRVcWl5V2MxOGVQSDlLY2hR?=
 =?utf-8?B?QXRKNGdWbmdEdlFWWGJmVnRvU2hKRStLRFF3OUxrSG5VNGVtSmI0MFR6bm5K?=
 =?utf-8?B?Sno0UWVaNzhIbnRmczZORzA0VDdvSzhHWGlQb2hGOXdvbTVDQVZRMklLV3BO?=
 =?utf-8?B?bzMzVE5acWhKMERvVjlXWmI3SGozeWhabFllcWpzQ3FMejRTVDI0NGtHbE1G?=
 =?utf-8?B?WnJuWkFRS1pRdnluK1dlbmtzQWxFTlJFMW1jSWEwdTF6NEl6dzNPemFuU0RH?=
 =?utf-8?Q?8eKB9rripB2Snx4PjBL7OOjano4Hv4Cbx/vQv/MgYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D924C7B4F07941B2D1E3ADB17DB4C9@CANP288.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: blueflag.consulting
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a38f6d0-f112-4db1-0ab6-08dbaf3a64fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 00:35:53.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f1904ac-547a-45c3-932d-4fa0466bd2fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUtpsjolZMdTaU1liqYqXCkkGflJ0PNdDTSTYChL+Jvxv/IJeqTongVnIERP/ORsyXNcvjbstrTZ1KWmHoSkg7ZvBUWfTzAmL6ZD9YHQRSZKYsznNyQflvURUsOt5Wni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBP288MB0162
Message-ID: <20230907003553.9WgHEjyxkHrJaTk_ULVbdauK6Q80kitRVI0Wnd1d97k@z>

SGkgTWF0LA0KDQpBcG9sb2dpZXMgSSBoYWQgc2VudCBhIHJlcGx5IG5vdCBpbmNsdWRpbmcgdGhl
IG1haWxpbmcgbGlzdC4gIEFueXdheSB0aGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGUgcmVzcG9u
c2UuICANCg0KSSB0aGluayBJIGdvdCBpdC0gYSBzaW5ndWxhciBQYXRoIE1hbmFnZXIgcGx1Z2lu
IGNhbiBhY2NvbW1vZGF0ZSB0aGUgbWFuYWdlbWVudCBvZiBzdWJmbG93cyBmb3IgbXVsdGlwbGUg
TVBUQ1Agc29ja2V0IGNvbm5lY3Rpb25zIChhbmQgY291bGQgY29udGFpbiBsb2dpYyBzcGVjaWZp
YyBmb3IgZWFjaCBzb2NrZXQgY29ubmVjdGlvbikuICBXZeKAmXJlIGxvb2tpbmcgdG8gZG8gYWxs
IHRoZSBQYXRoIE1hbmFnZW1lbnQgdXNpbmcgdGhlIG1wdGNwZCBwbHVnaW4gc3lzdGVtLg0KDQpB
cyBmb3IgdGhlIE1QVENQIEJQRiBwYWNrZXQgc2NoZWR1bGVyLCBpcyB0aGVyZSBhbnl3aGVyZSBJ
IGNhbiBnbyB0byByZWFkIGFib3V0IHRoaXMgZnJhbWV3b3JrIGFuZCBpdHMgRVRBPyANCg0KVGhh
bmtzIGFnYWluLA0KQWxleFcNCg0KPiBPbiBTZXAgNSwgMjAyMywgYXQgNDozNSBQTSwgTWF0IE1h
cnRpbmVhdSA8bWFydGluZWF1QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCA1IFNl
cCAyMDIzLCBBbGV4YW5kZXIgV2l0dGUgd3JvdGU6DQo+IA0KPj4gSGkhDQo+PiANCj4+IENvdXBs
ZSBxdWVzdGlvbnMgKGJyYWNlIHlvdXJzZWxmLCB0aGV5IG1pZ2h0IGJlIGR1bWIpOg0KPj4gDQo+
IA0KPiBIaSBBbGV4YW5kZXIgLQ0KPiANCj4gTm8gcHJvYmxlbSwgaGFwcHkgdG8gaGVscC4NCj4g
DQo+PiAxLiBJZiB3ZSB3YW50IHRvIGRpcmVjdCBzcGVjaWZpYyB0eXBlcyBvZiBhcHBsaWNhdGlv
biB0cmFmZmljIHRvIHNwZWNpZmljIE1QVENQIHN1YmZsb3dzLCB3b3VsZCB0aGlzIGJlIHRoZSBy
b2xlIG9mIGEgY3VzdG9tIGRldmVsb3BlZCBwYWNrZXQgc2NoZWR1bGVyPyAgSWYgc28sIEkgYW0g
YWxzbyBhc3N1bWluZyB0aGF0IHRoZXJlIGlzIG5vIHVzZXJzcGFjZSB3YXkgdG8gbWFrZSBjaGFu
Z2VzIG9uIHRoZSBmbHkuLj8gIFRoZSB1c2UtY2FzZSBpcyBhcm91bmQgZGVmaW5pbmcgcnVsZXMg
bGlrZTogInNlbmQgYWxsIEhUVFAgdHJhZmZpYyBhY3Jvc3MgdGhlc2Ugc3BlY2lmaWMgbGlua3Ms
IHNlbmQgYWxsIE9USEVSX1RDUCB0cmFmZmljIG9uIHRob3NlIHNwZWNpZmljIGxpbmtzIg0KPj4g
DQo+IA0KPiBFYWNoIE1QVENQIGNvbm5lY3Rpb24gb25seSBoYXMgb25lIGRhdGEgc3RyZWFtLCBz
byBpbiB5b3VyIGV4YW1wbGUgYSBIVFRQIGNvbm5lY3Rpb24gd291bGQgaGF2ZSBhbiBlbnRpcmUg
TVBUQ1AgY29ubmVjdGlvbiB0byBpdHNlbGYuIE9USEVSX1RDUCB0cmFmZmljIHdvdWxkIGJlIG9u
IHNlcGFyYXRlIE1QVENQIHNvY2tldHMuDQo+IA0KPiBUaGlzIHNvdW5kcyBsaWtlIGEgam9iIGZv
ciB0aGUgcGF0aCBtYW5hZ2VyLiBUaGUgY29ubmVjdGlvbnMgZm9yIEhUVFAgd291bGQgcHJlc3Vt
YWJseSBiZSB1c2luZyB3ZWxsIGtub3duIEhUVFAvSFRUUFMgcG9ydHMuIElmIHlvdXIgaW5pdGlh
bCBjb25uZWN0aW9uIGlzIHRvIHBvcnQgODAgb3IgNDQzLCB5b3UgY291bGQgZXN0YWJsaXNoIG5l
dyBzdWJmbG93cyB0byB5b3VyIGRlc2lnbmF0ZWQgSFRUUCBsaW5rcy4gSW5pdGlhbCBjb25uZWN0
aW9ucyB0byBvdGhlciBwb3J0IG51bWJlcnMgY291bGQgZ28gdG8gZGVkaWNhdGVkIG5vbi1IVFRQ
IGxpbmtzLg0KPiANCj4+IDIuIEFub3RoZXIgdGhpbmcgd2UgbWlnaHQgd2FudCB0byBkbyBpcyB3
ZWlnaHQgdHJhZmZpYyBiYXNlZCBvbiBzb21lIGJ1c2luZXNzIGNyaXRlcmlhIGllLiDigJw4MCUg
b2YgSFRUUCB0cmFmZmljIGdvZXMgb24gc3ViIGZsb3cgIzEgYW5kIDIwJSBvbiBzdWIgZmxvdyAj
MiAoYmVjYXVzZSBzdWJmbG93ICMxIHVzZXMgYSBjaGVhcGVyIGNlbGx1bGFyIHByb3ZpZGVy4oCd
KS4gRnJvbSByZWFkaW5nLCBpdCBhbHNvIGFwcGVhcnMgbGlrZSB0aGlzIHdvdWxkIGJlIHRoZSBq
b2Igb2YgdGhlIHBhY2tldCBzY2hlZHVsZXIgd2hlcmUgd2UgY2Fubm90IGR5bmFtaWNhbGx5IG1h
a2UgY2hhbmdlcyBmcm9tIHVzZXJzcGFjZT8NCj4gDQo+IFllcywgdGhpcyBpcyB0aGUgcGFja2V0
IHNjaGVkdWxlcidzIGpvYi4gV2UncmUgd29ya2luZyBvbiBhIEJQRiBwYWNrZXQgc2NoZWR1bGVy
IGZyYW1ld29yayB0aGF0IHdvdWxkIGFsbG93IGN1c3RvbWl6aW5nIHRoZXNlIHBlci1wYWNrZXQg
ZGVjaXNpb25zLg0KPiANCj4gDQo+IC0gTWF0DQoNCg==
