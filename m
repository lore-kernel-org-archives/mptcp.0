Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2067.outbound.protection.outlook.com [40.107.115.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56471CA7D
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 17:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7MOHHYKCSydR6Xj86QwxaafPcnC4wzbXeymr2syD31Yl42Tg8mEX0TwNdyE6R9NIAlMqE/Rr4M2lCjoVwENJM+/UdbJkMvh0ZMEWEFUCQ8RjSL7KeU35PMBhx/s46zwIXRnsK1uGIVUbLYOP/C/kOz29/lBuZYWf7k2OV+i7v63PSJxRkBjHshFq1Zfo5fZCe6fPNMgl94KbKQ9BrEUnviWo30BL9fRv6C8KwhD2u5TPWPAQWEqQTI6WCZ5luxx/hTyFAnNJ2NcmC6+1rqYksugL0m5Jt0Ee09lL4a6wi4W9/yORj9TmGspRM1H8k9k7M3OmMfUaXWp8le/yhefeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIdTvJHir2yl4odcX5I4geQuQY1vFslcIkUzoRykE4s=;
 b=QXH9JPe4bqbVanEHFDhI00u9DwUyU3V4tCqMGyYFpxvxZl0No2ZuZTK77sQF11rWQl6HSf2R7/RwjI1k+Tb8+radIz0jwPmHMZ8swrFUFNHWCbL6vfvMaKVNJFJl6VTOuviXqOFN9n8c0F3e04sgbOEZvRYbSShomFz5/nNj49mIcjPQFiNWWfEcBoFvCXE7uq8sq57bdMynFwZwhSdn/DQ23yptu3BCqtL3pPgwSdxWGvZyaEznOqexhq5DERMwUR5/xPz/Q1qR3bxn1m5EhikLrJ7A+HBtD9pVLYLb30oH0ccQ+LbqRHaDVPgZHc1sv97Q+MzqTS6zA1LLxvyewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blueflag.consulting; dmarc=pass action=none
 header.from=blueflag.consulting; dkim=pass header.d=blueflag.consulting;
 arc=none
Received: from YT4P288MB0088.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:ef::19)
 by YT3P288MB0078.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 17:40:41 +0000
Received: from YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
 ([fe80::72a0:f5ae:95f1:355e]) by YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
 ([fe80::72a0:f5ae:95f1:355e%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 17:40:41 +0000
From: Alexander Witte <alexander.witte@blueflag.consulting>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Subflows for specific types of traffic?
Thread-Topic: Subflows for specific types of traffic?
Thread-Index: AQHZ4CAW3i80IyOubkaY6+1yPQXc0A==
Date: Tue, 5 Sep 2023 17:40:41 +0000
Message-ID: <37779FCF-34D3-449F-B966-925845496DA5@blueflag.consulting>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blueflag.consulting;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT4P288MB0088:EE_|YT3P288MB0078:EE_
x-ms-office365-filtering-correlation-id: bafb9cad-d222-4648-40ae-08dbae37396d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1e3GdT8XTPNZguxcAp6+6XQBPDckfzLwfufbCOYpEG2/Zgherr2VMiKP27TXBVhQOKtQpn3ZCt5lmugdeQb+YLsmqpK3ZGAzlmce5q8oVDVuKy6veH5GmuSwZ+OPyJrL9mUhCGbRPPKQOpNWOs/W/rF945ud0eLOJLFPrcG9JymrB82j6leIbBsI+hrIP9l0KIlPbAPzv7V+tYjJp5BBwVkyvj/jlyTiBtTXvZak89Ho3iSdFrPMqN+4YPFsHDj/1uFKnW2iPQVv5ARJFHbPWE6uQgVab/2wQRbXB5v+ox6oCCgpjEgFjcDxnyqxjgblV9lIC38KMVtsC6Yyjyr7H3fy/gsEU0YEyyuSnFnzFhw5BmSOmsglAFKrfVg+p7Ap4uPWFXimh2jtliqdHR66SLoOQi/cy4fVw1tfsF+VR2Fs/mq7orwG5VSzj7t25ayssLe/GJi3TduoRWXlw44q9eaQBTuVBnHromZVTO8eY+x2Or4LmmmJj8/lr45sBpuOXZE3ABrrbJGkPOS29TqvcxrHXb/pWI6CKj7MLtilFz/d+QKA+iH+3TGtcycz2pKoYIj6T1aW3RfpKhjhTgX8bvSRwFGEDUtkYqmscHGEdW52l79wOISmUlk9cy/FIQZZZ9hZ1U33bxuPlJdzbJXOpg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4P288MB0088.CANP288.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39830400003)(376002)(396003)(451199024)(186009)(1800799009)(4744005)(41300700001)(44832011)(76116006)(8936002)(478600001)(71200400001)(2906002)(91956017)(66946007)(5660300002)(8676002)(64756008)(316002)(66556008)(66446008)(6916009)(66476007)(6512007)(6506007)(6486002)(2616005)(38070700005)(122000001)(86362001)(33656002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlJLVTNHN2VGNUt1VTB6bDJUODZ2WlRGK0FJOHIrVGtjUXNqYUlSdGEza21i?=
 =?utf-8?B?WkI1V1h5dHcyOWpMMVY0anRpSVJETHp5akRxWWxDQTJjb0xiN2l5dk5ETzNW?=
 =?utf-8?B?dFF4cnF3ck9YQUkvcG1haHBoek9KdnpwYklwbUZWODlvUlVqb2RpSWYxbU9L?=
 =?utf-8?B?cWlTR3ZGYVpUdHZKMlU1SmVwaVR2UTQ2cFhIbWgrZ3RnaUdoNVh5WjlJcDRE?=
 =?utf-8?B?WlhQcWJJS21CODdrakxnTlNJY0duU3M2eUQ0VEpvaEtkYlFBTUhpTTJFaEhV?=
 =?utf-8?B?YzRuZEc4ZVVBNDlVVlhBNXZoemdZS01mR3oyMHlJNVYwQnVCVTZKdkdjR1dG?=
 =?utf-8?B?M1BzYzZQUVJlZXVpVWo0M2VyZkxoci9JN1ZKZlBSdWdxS0YzaHZrSk9BM3BN?=
 =?utf-8?B?QUNxVU5ONEhicTB0OU80UkRZa3laYjlsc1daakVPb0xEMHBRMEdDT1JiMzcv?=
 =?utf-8?B?M1p6YXRlb0FFbWcxc3pKNzJsRGR0TFE3Y1hNekYyOUtCbmo0RE9CWWZXZGtM?=
 =?utf-8?B?MERhL0ZhdW9TdXJqdm5rdTAzWlk2VjBsUS9TNHBUMXc5TGs0aXJ2bkhla3BV?=
 =?utf-8?B?dkVpTnBVMDZNYVVJNlJnY1FETFRDR0VFbHB4UzFRQlptcEh1U25QNVlQMlMx?=
 =?utf-8?B?U3BwaldOMk1GRWl2RDVmbU5QaGRKclNZbzlXTjNHbkJUNTFHTyswdkNGc2Fy?=
 =?utf-8?B?RWw3MElPOFZ1VERtRlNvWE9xRm5xQmRibHR1RnNVQURwVEtKeDdCZzQwOWV0?=
 =?utf-8?B?UXVhOU9qRWNDRi9kb2ovd3dEODhON1pNZzc1SVY4T05EQWt2V0F4eEdicFZz?=
 =?utf-8?B?eU1DU1N1TWx1MWN1WnRyNERNWjdLSHdaYTlGNXJMU21FSGs1VUg3TE55YXRL?=
 =?utf-8?B?Q09saG13NTMydzd5d1ZDR3JwVkEyeGI1all0M25qN1ZmazNYdEdSNlc5dlUv?=
 =?utf-8?B?eEFLVnA2WHNUTTMySmR2Y1ZabFhCUlIyN2JzV3ZzV1JNcGlaTDZDNXExNTN2?=
 =?utf-8?B?Z0dZeEZtMlZkTlA0dCsvV0ZrTzMxUUpGb29HcjQzSzhMN29VTzdVMG1GUXRt?=
 =?utf-8?B?T3dGZk42YWdEczJhNlV6bUdsSkp6c0syWHFWbTFzYlMxVlFXQjY3WVczU1dS?=
 =?utf-8?B?R2RxSitZR3ViQ2dKSWdGVWZGcVNyS1BZbm9FTWx1cUpRMU85b1hONDA0bnRF?=
 =?utf-8?B?THRkN1I5RFI5ekRVUkpGWG5QT2loMURoQitYNGlCcEpvNTdDY2cxTHBnbnlu?=
 =?utf-8?B?THBTUEZ4Tm1QSDF0ZVNzbVZ3Qi9pVHBPT1F2M3JvakN5OVZnTDZpV093VW0w?=
 =?utf-8?B?eThJY01WMGtXdWVVd1dkZTdFREY2UTEzczVEbXNTeU9DWDI4ZXVmRVlhbVdN?=
 =?utf-8?B?R1oxRFRrRHJjWkJzak5kRFFPTnFuVEZCUXdXQ24vdEd3ZWZnQ0pBQzdjTkNU?=
 =?utf-8?B?ZzlKcWtUc1pCUHc0L1hBVXJ2Vy9YZFdFQlF1YS9ra1NZQjUyclg4SEhJZDg1?=
 =?utf-8?B?bkxmSUp4d29wRExFWnlEQk9Nc2svNkg0MHkxdUs4eXhzam1pQjBHNzVtbkFQ?=
 =?utf-8?B?aTFPNXN6Z29BQXROTEtSSnQ1dEw4L1I2eGROTVMycjRnUG9qM3NUYjZaMk00?=
 =?utf-8?B?dTRWUXdmdi9RcURDS21weFVPbU5nbjF6anRzMERqZEV2aG4yWGZKSUZhbm9I?=
 =?utf-8?B?YmZCblhXRnR2clorbURrbEVrOS9jQkNlSFBjeWRkak96cmcyYmJpcC9XR3Yv?=
 =?utf-8?B?SFd5dnZnM2V3elRQbWZPR1FOd3htQ29IcnhBekMyMEN4Z1BoeVp6RGllQks2?=
 =?utf-8?B?dFh6SUlhbjBnZzRXQlJFc1p6WTdrMFdiK2RnZzRoSTJ5bVkzcjJneTdRSS8r?=
 =?utf-8?B?SC9QSXFmWVBXMDVaY1E0NXU2OEp6akxNSFJzYkdHekxSVEpSVWo3QnVDREtu?=
 =?utf-8?B?ekJYbmVJK291bVg0blJGSjFUUXQrUzVEWG42NDdsRzVzWHRYZHZzQjR2aktU?=
 =?utf-8?B?cE9CakZYRGI3KzlsbkJ4NEhJYm00cXVzSXpROEJzdElqMGNKTVBYT1I0Ym5V?=
 =?utf-8?B?NldvanZqY2tLUDVBVUE0dVV3bWNKbjVoL2tiNEFSOXlLRTdjalNPajBHWmtv?=
 =?utf-8?B?clovclRJRzRqKzNNb0RSbTdML1FGWnB4bWszL01zYnd1RHBRZlhESWdSQUZu?=
 =?utf-8?B?QWZ1K05WQnpNaWowVFp4QnFYdFk2S0Q4ejJmcTFOK0FNZFUrWkdhcWpkZGhH?=
 =?utf-8?B?bExTNFo3eFRzTmxEczZ5Z0o4SlFIaWtxazhnZTZZR2RZZERNVkNjQVZ5WXZY?=
 =?utf-8?Q?1GVhecVe9wBmMMq7FM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E01C09F1D144543BCE2F84F8F47D6FB@CANP288.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb9cad-d222-4648-40ae-08dbae37396d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 17:40:41.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f1904ac-547a-45c3-932d-4fa0466bd2fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTygUoNY0mV+9zRakWmbKK9UJZAxywAs4tc+h5kQbd5h9vS6RaBgFUK/GZHUuEwTcFHzKxXrnTOpd6QgMCXW+akEhkfEILS5wAuPXv0L050YqqM7L6jcUNX0axtpBRHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3P288MB0078

SGkhDQoNCkNvdXBsZSBxdWVzdGlvbnMgKGJyYWNlIHlvdXJzZWxmLCB0aGV5IG1pZ2h0IGJlIGR1
bWIpOg0KDQoxLiBJZiB3ZSB3YW50IHRvIGRpcmVjdCBzcGVjaWZpYyB0eXBlcyBvZiBhcHBsaWNh
dGlvbiB0cmFmZmljIHRvIHNwZWNpZmljIE1QVENQIHN1YmZsb3dzLCB3b3VsZCB0aGlzIGJlIHRo
ZSByb2xlIG9mIGEgY3VzdG9tIGRldmVsb3BlZCBwYWNrZXQgc2NoZWR1bGVyPyAgSWYgc28sIEkg
YW0gYWxzbyBhc3N1bWluZyB0aGF0IHRoZXJlIGlzIG5vIHVzZXJzcGFjZSB3YXkgdG8gbWFrZSBj
aGFuZ2VzIG9uIHRoZSBmbHkuLj8gIFRoZSB1c2UtY2FzZSBpcyBhcm91bmQgZGVmaW5pbmcgcnVs
ZXMgbGlrZTogInNlbmQgYWxsIEhUVFAgdHJhZmZpYyBhY3Jvc3MgdGhlc2Ugc3BlY2lmaWMgbGlu
a3MsIHNlbmQgYWxsIE9USEVSX1RDUCB0cmFmZmljIG9uIHRob3NlIHNwZWNpZmljIGxpbmtzIg0K
DQoyLiBBbm90aGVyIHRoaW5nIHdlIG1pZ2h0IHdhbnQgdG8gZG8gaXMgd2VpZ2h0IHRyYWZmaWMg
YmFzZWQgb24gc29tZSBidXNpbmVzcyBjcml0ZXJpYSBpZS4g4oCcODAlIG9mIEhUVFAgdHJhZmZp
YyBnb2VzIG9uIHN1YiBmbG93ICMxIGFuZCAyMCUgb24gc3ViIGZsb3cgIzIgKGJlY2F1c2Ugc3Vi
ZmxvdyAjMSB1c2VzIGEgY2hlYXBlciBjZWxsdWxhciBwcm92aWRlcuKAnSkuICBGcm9tIHJlYWRp
bmcsIGl0IGFsc28gYXBwZWFycyBsaWtlIHRoaXMgd291bGQgYmUgdGhlIGpvYiBvZiB0aGUgcGFj
a2V0IHNjaGVkdWxlciB3aGVyZSB3ZSBjYW5ub3QgZHluYW1pY2FsbHkgbWFrZSBjaGFuZ2VzIGZy
b20gdXNlcnNwYWNlPw0KDQpUaGFua3MgZm9yIGFueSBoZWxwIG9yIGd1aWRhbmNlIQ0KQWxleFc=
