Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116C72
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 14:36:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="217083507"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="217083507"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 07:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="447570359"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2021 07:36:15 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 07:36:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 07:36:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 27 Oct 2021 07:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6wR4xXQYWs7XffP7d8tKkMOBxkzzZQ4/NiCgIsCug4LzNmmMkPGgLSQI1xcEY8BSgzFZ7qq1YoFV9DwocPEBgsIPKKHtdrpIrlHLu3ZZ1UVBp9Y9Yd7Lb/WIFKl/akLoi5ynaKPX8DCD1+TGy5lM7O1EXY7hja7jjvg98eoGji3jtwLmf6NKT+92D+fQnj7A96pVd3q0gZ5gdjvcASM3nuy0Yhgb+Jt6rYbgyHFty+h2WTu1enqrgN6aihjZKhrf2j8DPnMpYmtt/GbEuguFlXAwb7I6hD5M48Fi6eke+vIho04dPaKou7peq8RvsmUcl8Ue5QC8BIxXHRo6Q58Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvCRiuhk/RSQc+kprKY0v9l8UfS8kETiJDCuH4r+sL0=;
 b=j+O2YOjbaditbXNx7vxGmOdUZfeMY0bKCix7nRY64B5kYEImFjFw/6Uoz5O6UcXYmm0c7X0jtddg3fpEmTW7aDRdCbGrp++bgkmOB9+vaenY9TkzS1SPxJjly8ui1S2hvAcF3TuLshTLTzxvXXe2pRX3qUWFKDDATG8GPoDbqmhJ4y2pbOaTmXjU2VoUWpxdAHZCvGcILgDVekjt9VAaECvbS4GoeRVTe43+hOFmroRXcIy9HklsA3d0m52dzrbvSsUugETbbgoZSJY4zLp5xWgxuFIljdyW5zX46T/QardrlfPv6+dW8fF2UBhG2OSl1gyswYb/jEwhILEef8yI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvCRiuhk/RSQc+kprKY0v9l8UfS8kETiJDCuH4r+sL0=;
 b=WgYPRKdjqlzjLhNLprrEfmu+NumE0D6ykQGGAzwMNnFrGCNyL0fO2A+2e+TbobnQ98mx716y3ja40sv9DyiGriGDKKcT9B1yfNMXHPQlUh77eZWYwpWoPY8mCz2dtTRIF/LM/6gU/1QB0sQl33Lpe6tcAbL4j4eORxsFd/w9ibg=
Received: from SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13)
 by BYAPR11MB2885.namprd11.prod.outlook.com (2603:10b6:a03:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 14:36:12 +0000
Received: from SJ0PR11MB5182.namprd11.prod.outlook.com
 ([fe80::38d8:c4ee:c9f7:11c8]) by SJ0PR11MB5182.namprd11.prod.outlook.com
 ([fe80::38d8:c4ee:c9f7:11c8%8]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 14:36:12 +0000
From: "Othman, Ossama" <ossama.othman@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, "mptcp@lists.linux.dev"
	<mptcp@lists.linux.dev>
Subject: RE: mptcpd and (default) routes
Thread-Topic: mptcpd and (default) routes
Thread-Index: AQHXyolxaxOiC9IIBkym3wamA4zb5qvm6YUw
Date: Wed, 27 Oct 2021 14:36:12 +0000
Message-ID: <SJ0PR11MB51822182CB6F3BCB4D536BEEF2859@SJ0PR11MB5182.namprd11.prod.outlook.com>
References: <8db4b664f4fe0e102df6da03e57459c3a8c61677.camel@redhat.com>
In-Reply-To: <8db4b664f4fe0e102df6da03e57459c3a8c61677.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31cb531b-06a1-4e2b-1c30-08d999571fb0
x-ms-traffictypediagnostic: BYAPR11MB2885:
x-microsoft-antispam-prvs: <BYAPR11MB28855E5F33A85327C99FD87FF2859@BYAPR11MB2885.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFcJ6T31jpz4/UkA6p16wLJ+/0QUeBk/ibGJI9H74C0m6MQShGy3F8b7fh+Dth564g646Lrhaivo+s6TtmcGi/6bmejYjOpqs6C4AcyPo6OU/S/DEQL3ob2g2r4t83vR/JE5ggkj6Am1QDz7DeEv/PAaUKDeVQFRCtG23fAKKFPrEITycGfodOXQ43uP8agj5u2GgsoAzIlpAQ5orbdxmxoFjohnGOhmygmJs6yMRJaW45iA+ON5ug2x1USrkIm2xqs2Dt8eaCCTQC6EJuHoMaFteT2zzymuOyipPg9AE7xNc+JTdXj60f8YHGZOUU6NSqZ6cXyqzkoTClXZhK+1vUA/n6eS0nNpJrR0eWwRChhZMkwRIlSilwA0z/mLhXjMp2SkrIQQkFq9Rxf3Dz7eqfAf86gnjHEIdcdTeNIDSW+84OtI/tKrbtK/UUcROIdV9UiinLkAE0r1R88ZJhl2Sfb2nD9Hn2oCmTpLjK/qt1MTgttLbni/6q5WbCEg3lWuN30nhRpjb90HL9NGFGuwTUwSKYP+iAxbBB5ZLlY7NlQjldgUk5W0U8C3RkxMcO5m8JkZmL2xyBNG4vztqjk/T++4ofbjPeKso/3bNAp6eCMz8kTIZiHqhMJlr5yxO2/K3MJkiHYMh5l/cQWSIHEugHIjO3uZ7fb5+Y6MOmF8msCilDL4lAa/j6dUjEMO0JGYYFAZ2DxSCH91SaAHrM2gyVyBJXEx8dwuxoL3gHOyY5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(38070700005)(82960400001)(9686003)(33656002)(186003)(71200400001)(110136005)(55016002)(4744005)(5660300002)(8936002)(86362001)(66946007)(26005)(508600001)(2906002)(7696005)(66476007)(8676002)(76116006)(66556008)(64756008)(66446008)(6506007)(122000001)(316002)(52536014)(40753002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dzVGZQekcycklLWlB4SHFmZHdwQ2JtTFRpb1JldTIxczVKY3RWV2ZiSjBM?=
 =?utf-8?B?UVNocXlUN2F2c0ZKS0dEK3NtVlA2MnF0Y0E3amswWVd1NlhaSFk0V2dYTkRj?=
 =?utf-8?B?dStyZlE3eU1QaDk3bWFtVFlrWTFtdzZ0M1VJSnBmN3VjKzc3SGNObGNwZldL?=
 =?utf-8?B?dmt2UVU3R3k4ZmlHcHMxSXhnSXl1dEtYZUZoR01uMS84cHZzd0FVTGgzRWk1?=
 =?utf-8?B?RVpyVzJZYlUrem42cklyeFAzSjRKSjVPRUxyQWVpTldEVlVxV211amtnd2hm?=
 =?utf-8?B?WDlVbTMrUnpSZ3hDK2lZZzFwcndpZ0VMNFJUbml4Y2Z1UEtOdHYvZ1pHeXcz?=
 =?utf-8?B?eGJ3aG1JK1QyaEUvaThIUWdyZnpDaElCNU9ORFBIMkpuOTlxODZ2emtnRXk3?=
 =?utf-8?B?bW96YmlXZVZDeWErbFA1djBZWFBiVzQ4SXd3TkdCM0R2dGJDZlNyRDVBYlk2?=
 =?utf-8?B?aTk2c3FCcVhzaFVSK2lHM01ERmExYUFQRDhoaTBBdDZSL0ZYUWp3VmlKVWtk?=
 =?utf-8?B?blFLM2M3ZTlXR21RZElHdHcwc1BwREY0Yk5lenA2K2RxNFdQZkRmRk1HeWhh?=
 =?utf-8?B?YldQckoxU1NqQ3pRSnRmOW0yNEFUTXA4T1VpTi9yVUVRT3d5dVE2WVE3NFpo?=
 =?utf-8?B?VmZEMUJBVVp0UWZ5RzdjWXd3bmNrcnJoTnNBNjJMajd2OXdpdUU1Z1VlMU1p?=
 =?utf-8?B?QW9JTWMydVF6M2lPWDQ2RTF6TFJnUk5sK0RaNmpRYTJ5b0p2cUI0YS92ZDNu?=
 =?utf-8?B?Nkpmakgxd0h0bVRxZ0ZnK1ByKzIrOUJFMVpnLzFEdDl4WGt3ZlZUdXhIZWdm?=
 =?utf-8?B?NTd2Sm1rVjFHZGliNW5zazNPMTlZSUozZUt2RGpOcFRRNmpRZ1VrbnNUcmtC?=
 =?utf-8?B?MS85bzRkZjlBUlk0Nm1ZUHhzZ09aYW9lbGl5K3ZKM2Qzdy90c0pyOUxDZ0V1?=
 =?utf-8?B?dmgwVnlDSFdBYUJqV0I0UWYzd1FDSm9oMmNLRFBYUVh6RHRSQjBvd2pOYnQ4?=
 =?utf-8?B?UlZOb0ZTQnYreUNDaFljOUJQdWtCbzBtR0RFMHpnY2IzK1l5bHprUHF5N2lZ?=
 =?utf-8?B?bEJYNm9jZDJQR1FFMWxMUjJOT0ZsdjdNOFl5WkEzcjdRejRsTjRiM0x0SDFF?=
 =?utf-8?B?SkhnU2VaZjVQQzBRM0lTaEdYZlNvc3JIL2ZmM2pTeU4vZGI1eVZoenIwOHZa?=
 =?utf-8?B?YXgrWTl0SjFMSXMxMnRvWWJrVHU2NE5FUS85V1FWZ2RUc1FEeE14M1dKVmF5?=
 =?utf-8?B?amo5dklhdk5pSnFaMUlWenhPWmhFeVdKdHVhU1JVc3E0UHoxOFR1eGNTZU5D?=
 =?utf-8?B?NjNlU0kvTTZYTHFPNzlnZS82bEdQb1BweCtPcnZqYytlVUJpcU0vUVIzZHJv?=
 =?utf-8?B?djR3d3FzRlNabVhnNGNOMFBWbEhjcFdhdUpWcDZlalV5UUJQbGR5QmU3SGlX?=
 =?utf-8?B?dmc4d0VGYnVrTldQbld0ZVFaajQyVEZhc0p2OFUwcWVUNk9ZcDVqeTFlSDk3?=
 =?utf-8?B?MXVERmtWM0ZyQ3NFY0hBUFJ2ZnhjTzVXSVhhQnZ1THRHQ2FsWW1Zd3dnc1RT?=
 =?utf-8?B?K0F5YTNGRksvM2pGTjRPY05lSmF1UHRKelZRejEzMlJ2ckJzTks2T09sRkUr?=
 =?utf-8?B?UjloYU84ZGtIbjJ4cldIVlRuUERENlN0SVYreStCUFdEcnFwR3QwQ3J2Zm9T?=
 =?utf-8?B?WXhyaUVwVWxJZkhCM21jMTNwWFVEQXFxOEFEbkNyS2FtZkRQNzhNdkordks2?=
 =?utf-8?B?cjM4aDdhUklZZWhQQlZpWlhWcW9CRjlwUzRYZjIvM0toTVVodncvRWRuUUsx?=
 =?utf-8?B?eUt6V3IzdTdqSHBSZ1I4cGV2L1Y4clpOWnV2ZGNBOHNtZDlHa1cvUC96eThB?=
 =?utf-8?B?NnNXOENuMktscVRzMlowSVlKK1NMMHhMNW4wdVIvalZ6MXF6QWJ5TFROODl2?=
 =?utf-8?B?bWVQV2RmVlgvS3FJOGpFMzVTdGIxSWJYQS9sQWlnVy8yanlHUk9WSzd5L1Bu?=
 =?utf-8?B?YnNtcEh3V3lVY1JsUUx5QjUwTndnWWViRUpQb3praW93eXNzVUc4TWxYdWVQ?=
 =?utf-8?B?eW5RYnl6VzFTK1czSjF5YUlSZHFxVytYMitTQ09vM2hMa3JCbzZwbGlwSk91?=
 =?utf-8?B?VnBMN25TTEI2OGdOVjJMZld2WUNuS0JoczVsZVRlaldpVjdVRkp4VGJQckdi?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb531b-06a1-4e2b-1c30-08d999571fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 14:36:12.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thTArtAYnTz14/kb/aBb3hzOZlePfDmgY0SCGhUUa37BlEhjtguio0BpTzlKdi+setwMmsHfuz7EB0j2gpy1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2885
X-OriginatorOrg: intel.com

SGkgUGFvbG8sDQoNCj4gQSBwb3NzaWJsZSBzb2x1dGlvbiB3b3VsZCBiZSBsZXQgbXB0Y3AgbGlz
dGVuIGV2ZW4gZm9yIHJvdXRlLXJlbGF0ZWQgTkwNCj4gZXZlbnRzIGFuZCBsZXQgdGhlICdhZGRy
X2FkdicgcGx1Z2luIGNyZWF0ZSB0aGUgZW5kcG9pbnQgb25seSB3aGVuDQo+IHRoZXJlIGlzIGEg
bmV3IGFkZHJlc3MgYW5kIGEgZGVmYXVsdCByb3V0ZSB1c2luZyBzdWNoIGFkZHJlc3MvdGhlDQo+
IHVuZGVybGF5aW5nIGludGVyZmFjZS4NCj4gDQo+IFRoZXJlIGFyZSBhIGNvdXBsZSBvZiBkb3du
c2lkZToNCj4gLSB0aGUgYWJvdmUgY29uZGl0aW9uIGlzIHF1aXRlIHJlc3RyaWN0aXZlIC0gZS5n
LiBhIG5ldHdvcmsgc3BlY2lmaWMNCj4gcm91dGUgY291bGQgYmUgZW5vdWdoLCBidXQgd2UgY2Fu
J3QgZG8gYSBnZW5lcmljIGNoZWNrIGZvciB0aGF0LiBBZGRpbmcNCj4gYSBjb25maWd1cmF0aW9u
IGZsYWcgdG8gZW5hYmxlIHRoZSBhYm92ZSBjaGVjayBzaG91bGQgc3VmZmljZS9jb3Zlcg0KPiB0
aGlzIHBvaW50DQo+IC0gd2lsbCBiZSBxdWl0ZSBpbnZhc2l2ZSBmb3IgbXB0Y3BkDQo+IA0KPiBB
cmUgdGhlcmUgYW55IG90aGVyIG9wdGlvbnM/DQoNCkkgZG9uJ3QgeWV0IGhhdmUgYW55IG90aGVy
IG9wdGlvbnMuICBZb3VyIHByb3Bvc2VkIHNvbHV0aW9uIHdvcmtzIGZvciBtZS4gIEknbGwgYWRk
IGl0IHRvIHRoZSBUT0RPIGxpc3QuDQoNCj4gQXByb3BvcywgSSBkb24ndCBzZWUgYW55IHJvdXRp
bmcgcmVsYXRlZCBjb2RlIGluIG1wdGNwZCwgc28gSSBndWVzcw0KPiBldmVuIHRoZSBvdXQtb2Yt
dHJlZSBrZXJuZWwgY291bGQgYmUgc3ViamVjdCB0byBzb21lIHNpbWlsYXINCj4gcmFjZS9jcml0
aWNhbCBzY2VuYXJpbz8hPw0KDQpZZXMsIHRoYXQncyBjb3JyZWN0Lg0KDQpUaGFua3MsDQotT3Nz
YW1hDQo=
