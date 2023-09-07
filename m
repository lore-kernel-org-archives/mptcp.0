Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2051.outbound.protection.outlook.com [40.107.115.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04F63A
	for <mptcp@lists.linux.dev>; Thu,  7 Sep 2023 00:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnEzx8tll3imIJn7M73xUkueSePoROmzaN9dMhfRFmR8ppjwo/6B7caeCpq1A5/v2rW4JfqtuRwJmvsI0nO8l1mvpwhZF6RYym0xz23xZpDpAJctTy0bwFyRpM4c70rh7Qw5Rjg3xSOm4HR4FEIj+8NK7eshHm6tA+anCeMbMIzzRqTuB0cJi81SX+irAcXtsO2V4cZZcnf7AtQe5DvylmZUXta1zsGCbA8cHhUL3T6ogqYcWHNp/wP4Ti0QIhCwfnUxZ6lfuETHZNmcuagLhtYaGuI9m9TOt8iDtJZ9vLQizfADS4nk9jTEGY5JdaWJ9YyIRQGGU9V0OXhuwKE2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5202Fha3Twxq6bBCE94ie9iQ3t0QOIcMIGkwdUkjC0k=;
 b=bCRe5+97SmbxrIx79umucIZTEWt8aewED+01qqdLCgEiHjD4yg1cxhsedNgbKZpQKm17cDnL5rb2blK8mJJsnIo5YHojzVuGviEabMZU83K0nweFYUWochangY4OtX8ZIL/Erxb19GNtbbJvcv+6g9z0uEYmW+t0SCiH+wW0rB/vfAsZB8HCA1nPN7yqJ+j0fuhzKZNi3vIbXDrczWwvIAgD8g44u9I80IaXHjnTqE41gn4tRF/zk+7zgLtBRN4rYigNvUNBfNDYHMrK2Mr+SX0o5uc9L+u48CQ89h/CvUdu0T+uE1E2SgI9xI1OZstySItUZs5UISPuXMgMl4kDmw==
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
Date: Thu, 7 Sep 2023 00:35:54 +0000
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
x-ms-office365-filtering-correlation-id: af251c27-6c2d-4181-b4b0-08dbaf3a6548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lo/qqLRpQp67D+bB1OOswRznvJeB+/5MKn0i52KE8uSCp/8wLkzXuhsnysG/Po/0obO5YsQ/Kgn9sw0zJzDV004a/MQbVbWnx4rcjNQE1fzoCFSSmfPYwnmKifq+Akc9QPT8cvPkwZoBC0s63bnEhIugectiDoOEKFHf1SKsmZ+5pobCORefKfEjqOlnWFHMVXt7NOY/pi8KBxoniwt6LaH6tLsj1zgSLTtBLXCE7IpTHuoli9vE3rv7Wo+J/vJEWFbJ2UTDN26IhUmcg+BMHlXJiHeJgqFhIZaFIWf/vo7eGHaZF+95dm5Jd+3H0avPQ7m8OINfdy8bjdIDapLEiecNtq0lVDw+1gHzE5RswpA93pdoJ8Siy5PDrVoZECHtdAzLw4RYirMJL/E1GK5vDQv1erWRxvSCjqfhFpQHDFc4UE5pFDTXUL9d1uqZEXUbNGDIB2asplPImCHNbXVghhjXPqWzV7vGsL6+vDZ5TsbAOSe4eBinWrxUk2IZWc2LoJ5yD7QvqgDWCg5PQceJc8tfJH00zj1pDYPRzuWytJlb5tV2lflcftdD20glSIcvhMl6gqViUtuom/4d7yjyadfB0S5/EBeQzhGqDk5K2bzjkIa6tegpJtGF57PSm3lmndjrSzBZ3PrkbZoewogpIg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4P288MB0088.CANP288.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39830400003)(136003)(451199024)(186009)(1800799009)(53546011)(6486002)(6506007)(71200400001)(38100700002)(86362001)(33656002)(38070700005)(122000001)(2616005)(2906002)(6512007)(478600001)(91956017)(41300700001)(8936002)(4326008)(8676002)(5660300002)(66556008)(316002)(66476007)(6916009)(66946007)(44832011)(64756008)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2dWdURRNFcxdWhoT1p3dFdjekg4aE9LOWpkWnRVL0VuZ0lCYVF5YnMwWllj?=
 =?utf-8?B?bGhPKzl0KytiR3BCRCtzS0dLUmUwaThkZDJiWHhQQm1idnRWYlRRK1d1VHpq?=
 =?utf-8?B?QVJiNXd2TXI2WnQvNDVJUWgrODZxaHQrRExGaG9oc3BvVnJyYTVDMFl2WW10?=
 =?utf-8?B?S0JKNlJkc1hySUVQaktEd1dQNnEveTNuZWMyelJaOUduakZFdnROcFdXT0FM?=
 =?utf-8?B?UkR1NERXbm5EcE9PTzA1ekdPM2xEcHB6TDdkODZtSlZRK3ZpaWxuUy9uVXcx?=
 =?utf-8?B?Zk03ZDR5VTA1NDJQc3RtU1picVY0R1ZZZnd2YzFoZ3BaM2c2YXN1TFFRNFF0?=
 =?utf-8?B?NVdXWnRIenc1RlhEaHF1Tnc3QVdhOFdRMURpUXB0NW5BdGVEY3l1Z0N0Qmxw?=
 =?utf-8?B?R3l4Tyt0SXJSUlRFTWNreU9NT1NULzRLWDNhTVpsalY0Z29lM0xubU5HekN3?=
 =?utf-8?B?Y1luT1JveWVLb3ppQW4wZlpuN2xYS3lIRjRMOW9BUFBuN2JuQXJURE9Ma0JX?=
 =?utf-8?B?WUVkRjBzVDlrRUZQVkZKTURqWVdJOVdPcCtGeEhSRytnUk4wK1Y5Q1NlRGRu?=
 =?utf-8?B?dFdwTnp5TTU5eGRLUXVSam9UUmJ0RCs2N01XSXNTdjFhc09DWk0rK013b2NE?=
 =?utf-8?B?eGZsZ2N2WURHRU9INWFRMnFiM3pHVHNtUVJ1djV4ZGdtYjJqN1lHNFNQVlRQ?=
 =?utf-8?B?MDF5K2VwenFxSzFlZy9wL0xLalVLSVRVRGF2VUtta1RQV2M1YUFVUER3UVBo?=
 =?utf-8?B?SnJEc05sM0JqZEJETzh1b3NqOGpoOHpmUGE2QWVUUFR3ZURhV0pjcTcwOEVa?=
 =?utf-8?B?Z2RnS28xTEVkNDVNaFVZQTEvZkVVTklvdW1jWFZSY0YrVjBQQW5oQndwQnFj?=
 =?utf-8?B?ckc1SERUbWVrSHpYdHpvQ1VIYVkvdTRpRVFLTUNuQXlhaDdxZGdOZmxVU3pM?=
 =?utf-8?B?b0hka2FML3JUcjJkelJNdlR4NmtGMzdrZXlSalA3MjI5bTlDT2RNazgwMjFj?=
 =?utf-8?B?ZVVuaE9yVVZzU29xSVZFSEVhMnFCZ1g2aGZmNlRKcTJzc2NIdmhKOG0xRmJa?=
 =?utf-8?B?MU5OZWorSGxSSmZDbUMyL1dwY0V2dHBNT1BQcWtrSXhla0JxS0lScDM1TnJX?=
 =?utf-8?B?WFlwQ0Y1eHVhMVRIbGxxaThTc2dLOTE1SmV3TFRmN0VGY2g0c2FmdWxtTVo5?=
 =?utf-8?B?UFV6Ujh1cStLeFF6UFBWMnZibTlGaDdlS2F5S0pjN0tVSVM5am95TEgwN2Jw?=
 =?utf-8?B?RnUvTG1nRys1SzFQOHB6MmxaV2wvZ1U5SktIK0NleGhNYlVIWW5kT0VzcWRC?=
 =?utf-8?B?cmhYWm14Y1poYUpIMXVkWWJnRmJzSllwQmNTQ2JuaE80T0VjdURXSTVXNU9k?=
 =?utf-8?B?WGFUZE1tQ0lwVHpkQ3BEMERMNDNKOUxtVkY3RFlHSHRTUEJJeHIwMTlZL1Bp?=
 =?utf-8?B?RmE2S3R4QWV5QUNXOU1XNFdLVWJ6aWt4bzhRd1o3MU9tdHVUbXpoOTBoQjBD?=
 =?utf-8?B?TExlR0xTWHlRYWRieklieStrMVlMdExKaTJ0VUt5ZGVJSFVQQTBxYlB2TmZR?=
 =?utf-8?B?UkNLRkNvNzVLWi9zOHQ5eGpjTzFtWkV1eWlKUXJ1WC85ZndPSDErQS9xRjRk?=
 =?utf-8?B?YVNGbFhQbXdQL2VaT0Z6bWVJbGtyYlVicUVVY0tUSmhSOXZ2TEVzc3Q5YTRz?=
 =?utf-8?B?eVNBL0Q5U3cyYWlDcTNRYWU1NmY5bUNaOW1ielJBeWdJZnhHNW5pZTVVTUdR?=
 =?utf-8?B?VFNWNGV1cXRsc25RRVNacGpUa3JOKy9Nc3BKcG9IOGlNYkwyZUNLY0lDa3gy?=
 =?utf-8?B?c0RMVWVQVkw4MUZobml6ekc2b0JNYzFseU5RR1QxNFFXUUFpSWNMYVovU0JE?=
 =?utf-8?B?MG8ybEN3YUgxbnVpcFBZZWwzdGF0K1RrYnl6enJhYTNUSTltVTdVNzRaUXFh?=
 =?utf-8?B?NUhGQ0JUUTl4VEpWNTliRG5nSmpCandwckhZbVFTVWRGNDduMW9zL252S0s0?=
 =?utf-8?B?VXpVQmRnbHY5d3Mwbis1VFkxZ2tLSEZVcm9KK2NoSlQzc0hoUlZDWm1HZ2tV?=
 =?utf-8?B?ZTN0dTJ2NHlpUlZZdVoyOTRReE0vZ05vMkN2aGhWdmhpdGF1YWVQK25NNUMw?=
 =?utf-8?B?L0lpNDViY1FHTDJKcWsxRW9DWkxlU2Uvc045cnVSQVJ3cDh4M3ZKQ0dHV2NL?=
 =?utf-8?B?eHdjUk5IWjk0cFJ4QkYrblBKRWpnbWVQL0JrRkwxWEpHTmJYYUUzTzhZSjBL?=
 =?utf-8?Q?SF34KUE3rQN2GB7YDaz0OqrsYXM8N4JEgDFS6eXI7g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26928EE1842D01458AF44654C3F770AB@CANP288.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af251c27-6c2d-4181-b4b0-08dbaf3a6548
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 00:35:54.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f1904ac-547a-45c3-932d-4fa0466bd2fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WXfsIPpyHpAGUEAXpwmnbNBh19MRLWd6eVh3M1hW5zawn3uJiOLjFez+LoFkJzqBmeb3Re7j75BXNhnpn4aHBhNDgcQSAa9W0N0Z+Qaub2ZSzXynTrq2+llTBu6Ua7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBP288MB0162

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
