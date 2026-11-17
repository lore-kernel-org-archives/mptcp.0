Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892930;
	b=sP60v8UkS9QpAjnLwLTs0bxpo1P00wq2w0MMvg8mrumqtdEA4HO/3f+ighjDKwOFlh8p
	 smQbKecpo5emQpBLfIZ8QloqT2DBAS0O9YxJcRy845d1gVnQ2UJvq2jyhrBSmPC6Syy/M
	 uQfJ35PpdTBuF7RruDLel3uDX+g36Teh+ttc9t23CDWNfeUGSA/sjxHMSosK/8R6L5/VF
	 cRydlD0kgTk5/aLTWVJJPMUPU7tA+ZoZSGX49tZq3vJhUjRgUVQuxBnVk56dhHLFREXx9
	 cEFkd9NrrASdpgNWRgEj+HPPTYevE0frufEGUShqc+dFbrm1WpaV+ZNvOCwotz64ZwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892930;
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
	bh=AtPXspBFoldQZArR/vy3lqSvE4jnfR+hEQChp3xUhB0=;
	b=hnH2q6MfibeC7CXHDhBKp63NtMvDloIqRy9UcvkfhDFvsTeoWvtg1SGxJHgsyhngYCyC
	 FuYr+37VfrXsfLQC9MHjAhR2QSCtyYuN60rvJvR7TRVR+OyJh0PGhnocOhai7PcWZXXrS
	 W2OrCKDz0M3z/CgA/aazV8YugsnlJB4LPkC6gdrkXEz1OwIB2LVLKuqF0SxGynqOL2ISe
	 kG4FD6Kp6OTnV+j4o11uRwcqeKlnwll1kWYTmRQXxZ4n5fIjUL8RgLHeV/w6NrxevFY/d
	 sifNd1zMuPFaD9CkwOE43k2aNV6ho7Rb26hoeWJksngtEKTyN0Iu6Q7hvgyYfBBA++w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cX+zJYMY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.25
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E22606A32F
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 05:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E22606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cX+zJYMY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsnJePWuU6agyBXKenEVp+QxL4EBk7331OyOYEnDC83qKDO6Mo3UCu5PGJdfA3rWZxEbLPnC/zKl1aMxGy7nI72CdiBDaYAH3q/dxQ+uk3ZQ85tN35Sk5CkdaU+QqNR4+FxqEXqD7IuA9J2GeENXjW2HpcBgHhEOTnv9sH1GodOE5I3rBQDU+DYUoY0cY4xJ9cpUdycvoWbEb1g64PIEemaz7IUilYBx/BWOwulecCO6+KOf8bCescllwYzMK+4JTlU2TMpvuh9W6l6mdk2axGzomeZpRoKNVk1wudcvIi6Oh/90cr3K1LrKEdLOWtnhw6ApRa+Npw3vDkGKcqbtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtPXspBFoldQZArR/vy3lqSvE4jnfR+hEQChp3xUhB0=;
 b=j56kawqht0pIEJE1DvUWtTCknYKDvhVhH5k2gxM8p8q6d1/dbfDPhgTbIdT3NuAvqjllmE6BIGkYaXu4MBkBep6S9o8fHW1XltbN1jufbLSWCps9OL6641tTpvo1i7q2L0M4lUcb4rvCNaOocGzzSm2/vgFYgRoh2gEaiuvJxHoL+ble3SO9d7twNV53rrA4Qi5A10a0BIh1eyn7DHME9OH2BFS3x//1AZAIWu3TsOaIH6fB8WqMEeyDUlwdr93oRpb3OSrDundnOoHH5WPlthgM9yipZn3Di1lJ8e50HO+XmzSq4ZFebpY+kLdakBEJbZezwj9NVGbWHj/JnCIuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtPXspBFoldQZArR/vy3lqSvE4jnfR+hEQChp3xUhB0=;
 b=cX+zJYMY8cDva+ohQfyX1+ZLc0Mg/UO6oqkCt5/OrYmdBkaTHh/qsNhYpV1TKfEW8GjpOquYtYXmVCjvdPeGWBwsfQd3aivzQDeMmiCWtN6IkLADYA8ZjJ3ycCFV1BUtRPddKm1Mi9AoKAyrezq4WLbq0u9g+KmpQsfx2N83ewDV2/atJQt3T1M1itiWhu72Noq5MKqUUCJj4Iymq9RWAN2swWCIfRUdAHUbaadxfBca9xxKgI576UJbGet/efQXrH8/1jtp+Lxu2vvo78Qm2uo9YG2yBJ+DMFaYYTd10TNqLoSkdLkQPBiw6SVERmwg/TJE0R2I/zvfmuyF2qB6Cg==
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com (2603:1096:400:156::12)
 by TYCPR01MB6654.jpnprd01.prod.outlook.com (2603:1096:400:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 05:22:02 +0000
Received: from TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8]) by TYCPR01MB8485.jpnprd01.prod.outlook.com
 ([fe80::a16a:9b73:98b9:56b8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 05:22:01 +0000
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
Subject: [PATCH net 0/3] tcp, mptcp: fix receive buffer sizing and peek
 accounting
Thread-Topic: [PATCH net 0/3] tcp, mptcp: fix receive buffer sizing and peek
 accounting
Thread-Index: AQHddlOSXoObisX9jkWyMmZ84+e/wg==
Date: Tue, 17 Nov 2026 05:22:00 +0000
Message-ID: <20261117052200.1507847-1-llleigoing@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8485:EE_|TYCPR01MB6654:EE_
x-ms-office365-filtering-correlation-id: 585d3158-26b7-45c4-58fb-08df446ab561
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyfJ5ctroE+AnoJKQNH7uyZDOL7zsQ7JQH1carqJBzdpZ6ACa2Yd19WPqzDH2Rs7eYthHcJrw8kSkuLHagXBcZvTYb0G9IdtQoVpmqDgIfjHASePbqvOftdfGBv2z81OAfItOv0bHH4nhwSd2JksKBLCUtGZ92S/96jBxs4Ko8bBhLfYKntRpQqbUgKeCsGT5f2z710eC1kAoDzES2/qlbWfZQ8m5sL9eRUv3Vq+WQpxEcLc/y7unVnJmkAl/db22pF6IHz3uHZqAUuBJ5xA6+uNs8ePR7P3bd9vdi1kxv+nIu1MHZ00KzADcBthGn++j30lk0QsxaIZgymXqBzjKJpdfq+2xY64hqHDB03qAOVLdGP0Ogt2+DP3igi/7AasYnRO8i3zMMt95pRMv7rJGNxMQgspFKtKyK5kjqH9ikjbnQmJYjMM9H46UFoF/4NQi7jpegkxH+MJVZUryTGvqbFn3Np4RIiKoXaVn36PM7zXS+Q9mqD2GbzmickkOf6IByd7GDOBh9BtbmmWV6VmWpAVxcAgmyBVUlGjcZPxaO1aZnDdf5r7xPMiWjZWMT9K0pSI2V7uDFuPOs/jy8+rn5+dxSPQwd/tlXcyYUKLn+bKfHQJSddYBQWHHOxwEVo+i3xlaPYywEwVmIiHt6/Qz/nbIuxrMrdJYL6Lcv6TVAwGsi2N5eKMH9ltx7ok3UMSqTXJQlIubRXcTEjTHJvtUhwTnqNAZakNqM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|8060799015|39105399006|19110799012|38102599003|15080799012|37011999003|4140399003|20031999006|24021099003|31061999003|25010399006|40105399003|41105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0dEOTRYRVRSZnRQY1RHTUZYWFNQQ2tOcFRpUENtVlJzVzNrdHc3Z0RJME9k?=
 =?utf-8?B?ektGUGVVRkJobDRSWDhubWVjVVdKYmYrMkxWSVUwb2tmSlJnY2Vwbm9hU0Rv?=
 =?utf-8?B?V2FsSjNsZlhzUDB3aDNuTmRLMkNrWE54QnZuNXgrb1FOdVNhVFpuM013Y1dJ?=
 =?utf-8?B?N3lZaW83MlNPczI5QlNJcXJjQi9UUTh6VUJFYXJqK0U5QUN2MHJ2eHdDTUF5?=
 =?utf-8?B?QTlxbUFNZ2RBR2llR1ZMMTNLeUZvV0VQRXNOa2ZCbEpJcDBwei9iVTFnK3N6?=
 =?utf-8?B?cHJCdTRJWEljOXBWZHZHWTVBTzdmdmlDOHBxdWpSY0J4bWlWVVF2TnhHdnVK?=
 =?utf-8?B?YURsNmZMU3djbEdDQm56clo0aFZ0OGVWSzFFcCtlTjc2M2pWZDBtVVZtbmF3?=
 =?utf-8?B?TzAxR1huZW4wWTc1RE9ZN1Qvd3hJRnJjU2gyWDl4LzZzZjlhWFZxclpZMGlR?=
 =?utf-8?B?WllmcXVSUkhaQ2NqT3BDU1ZiOU5YYnRWQWVNYVc2ZGRiQ0JaNUV2RGRISWpH?=
 =?utf-8?B?RDhuVGlaS1RaQlI5TzB1WGpSSWZxNzZKSHFUSE4xdzlxenJsTFBDc0VKMkVU?=
 =?utf-8?B?d2haNkdZK2ZuSTZQZ2c3VVExcnVGa29QdWtPYm9FS3NFWEtLMzEyQlpCMm1v?=
 =?utf-8?B?MXRIVjJnT0svUWw4SFJmSGJMVmU0VXlTVGxpb0JkRG5WSlk1QVdGcG5OL3lp?=
 =?utf-8?B?azl2dWQzSlgzUlFKTXdUUVBGdjNyU1V1RlBaZkN3VERjeW04YW9yekRJQ25W?=
 =?utf-8?B?RloyUzlvVWZjR2twcXVBbldNQkQ5djZ6RTFDNlY5QkUrMlp1QUR1eVRPendr?=
 =?utf-8?B?cUVOeEhaMThWSGxaR29jRmkzN0ZSZUVxM2xXanZUU1haWEhjUUtDNk5kc3Fj?=
 =?utf-8?B?WExnYTFjV1hZdG5McVFmRnhxWUpIdDFmbnhHbG1IS3Nqc0FnQTRsWE1Ya0RZ?=
 =?utf-8?B?Y3FBa0RjckhXVjN4SDZycGxOdEUrN1pXRmljR01JS2RrSERNRkZQVlFqbDhZ?=
 =?utf-8?B?cmhidGhMaGFXWHJLZHhWZGVORkRxTXFSdlo1Ylpody9RUkZpU05td3V2RWhm?=
 =?utf-8?B?ZW84QmJBeFNGTk9RcnlEaU9PZmhwbnFuTm5GVXZ2ZG8wRE1DeVJibFIvN1N4?=
 =?utf-8?B?OE1mODNjdm5aenJuL0dDUlVwbEFhR2xQTDUwTjJ1MG83TDF2UzBNblhWWDhD?=
 =?utf-8?B?TTNVYnJXZlpscERsR2dzS3UyNC95VmZRbHdadGNzTC9GYm1JbTFTaWl5U3BE?=
 =?utf-8?B?RWlmRDVHT2tVd2VzV0N2TVRHZDlhVGlpakxyMUtBQmVJbENJVlUyL1ZwZ3NE?=
 =?utf-8?B?MnJ6dFhBUWVwOE55V2Q5UHRlK054UGZvbVBRZ0pTUkZjSkVsSGVnd0thK0Va?=
 =?utf-8?B?VTE5NmxYdTE2QWJNbW9QTUQzbkhuNDZ0VzlLS2MvUnFTKzVzSGpGNytUTXcw?=
 =?utf-8?B?WTRCYytDNXFWbkdCVDk3QVM3WFJKZW1HTnhmZU9mUVZOVGVIVWRETHUzN1d1?=
 =?utf-8?Q?oBw7rA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXFxMEMvTTMvclF0Um1QZmlDYktIYmZ6K2dMN05WMjJwNHRiN1BPTWtDK2wv?=
 =?utf-8?B?dDZlUGVMMTdYWWs5dHRQbG10cnlzTXNsSFJFVGM5cVIrUU04TUFGS1Z2VDh6?=
 =?utf-8?B?YjVyektNMGJjZ1FFdENORmlEd3FpQlJmckVUVzVxVlZBYzV4SXZwSUJwNGxj?=
 =?utf-8?B?Y2dydHVnWXpveVZnalMvc0JaZ2x1WGdVcEJiRFhUbzFVMjYvN2xkZnh2R3Bp?=
 =?utf-8?B?bHVvY2hSOTc1QjhhSnFJa1N4ZWprT01yUnNGbUhyVVp5TXV1SHp5UDdFelJu?=
 =?utf-8?B?MmpzMVRKc0lGaTZGOVNreThwczNjdlhEY1NRV1ZXN2ZwbG5TakRXNjJ5RTBn?=
 =?utf-8?B?ME5KM2VLbDhpWFdJdDlWVFFlQkg5dEJSRFQzMTFXYmxHa25lS0p5c3d4Z0Nn?=
 =?utf-8?B?Z0krbGw4ZE5hTTUwUWxiZ0dZOTFGUFRVUHVwNUh2T2xnTUl1djBUay9nMTkx?=
 =?utf-8?B?azRyaCs1Mmlmc0FUNU8rcTJwS0Ric0dSbTdaVm9jMzE3RWljZGp6UDV2MnRq?=
 =?utf-8?B?R05PM3NRblkzdHRNRVRSa0RvcVFMT2VjSHd5N3pNblpLZ2NWSmRheHhUTmpl?=
 =?utf-8?B?bENvRXZsUjZ3cmZXTXQzWDg0azg5SUdLYy8wTUF4QnJuNXg0TllmSXRGYXR4?=
 =?utf-8?B?SVNEZG42UG1JY1RxL3liNWxZVkxoMDBjdFZwVzlHbWl0YVZabldUSUxCcGl1?=
 =?utf-8?B?amZuakpSZkJpa09IdFVIWXdnQmJkS3FvVXR5cm1xc2JkUk1ZRUZyTUs3YkRz?=
 =?utf-8?B?eDJZc0RJV2Rob21JVEVZV0F5S0ZGMktBZHhCdktCQmxzbjVoUVcvQm1PUkhS?=
 =?utf-8?B?ZlBhc21HblVvb1ROc1N6ZnVKL1kySDBPYWJVeGIzNnNrVDZ1N3VQb1M3d2pM?=
 =?utf-8?B?OFFSRXpvYU42VzJBV0FISlE1aVhqQWNSRkxwOUxCQWZPMXR6UVdKc2M5MFV4?=
 =?utf-8?B?eXJYSFVhRjRjYXRHNUVNdjB2OC9reWJWbzlGOXJIbkRhS1h5bXVob05OS2xx?=
 =?utf-8?B?M1VBdWtTdlhSMkxxSTJ2SjJVWThUdVRBUFkyMWxDME1hM09hWVFvQnlhM2ts?=
 =?utf-8?B?UEtQSmIvRGp0djY2OWZ2THA5b09OVGxEK25qZWVkRzk2OFdWWTNyd1RybFhM?=
 =?utf-8?B?VWFlMVhUZ0F2bTFONXhneHNyZkthYnd6bVF1T29iRHQwemlwVFdjdCtpaHB4?=
 =?utf-8?B?VURQSWpvUmtESVExdXZ3VFBXT3l4SDVrdC9FdExXUWhmRU1PWGgzTVRzSm5o?=
 =?utf-8?B?eHV4am1RT2I5RzBFajNETnd3NkZJWGJKTzZlWGgrUWRuUU43MlBvcEhBaytv?=
 =?utf-8?B?dlhwc1JRSlJQVVFVSE1qdStnYzRFSEkvOExqN3VIcG9PQW1vd2dndEYxZ3J4?=
 =?utf-8?B?RXRrT3cyb0lmTjdmTFNpWU1yYitzWWNpZ21leVgvRWpBMDVuRmswWk8xZGJU?=
 =?utf-8?B?K2UvWC9NcGhZdWg2QXY5dlZyN0sxSjNGVU5UZk51eDNQeXNmWjNUbFBadDNs?=
 =?utf-8?B?dGJZSUtjRVFsY1MxbjE2UUNrZlNDN096N0tlUm91djZtRTBoTHllT3RkeDhO?=
 =?utf-8?B?bzF2bFptL3Z4TWp1SUVKcnp1b1pRdUVoRDhnQm0yQzNwYVhkcGRWczRZRUs4?=
 =?utf-8?B?cjNOTXlWQ2M4bjMreE5TYTFRT0RVOEpNcVVNelJ1M0dQQmRCbnZnUDRuTDNI?=
 =?utf-8?B?bDBqdjV2eTFDQ2JIZW52K21IbW1KS2tEOWdvakxKd3FGcFBMaEdVNUcreFda?=
 =?utf-8?B?eVZCOWlEVmVOVWVMbnlkd2c3VjlqakNBME8zclBkbEN6NFFIbWVLV1dzVFp2?=
 =?utf-8?B?MENRcysrKzBqcUpJWnVhMGdRWEN2QjBic2tZSDdNL2dmNXlydzZ3N1RYUHpi?=
 =?utf-8?Q?b6qwZ3bIgTd+o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 585d3158-26b7-45c4-58fb-08df446ab561
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 05:22:00.9963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6654

VGhpcyBzZXJpZXMgZml4ZXMgcmVjZWl2ZS1idWZmZXIgc2l6aW5nIGFuZCBhY2NvdW50aW5nIGVy
cm9ycyBpbiBUQ1AKYW5kIE1QVENQLgoKVGhlIGZpcnN0IHR3byBwYXRjaGVzIHByZXZlbnQgaW50
ZWdlciB0cnVuY2F0aW9uIGZyb20gcHJvZHVjaW5nIGFuCnVuZGVyc2l6ZWQgcmVjZWl2ZS1tZW1v
cnkgYnVkZ2V0LiBfX3RjcF9zcGFjZV9mcm9tX3dpbigpIGNhbiByZXR1cm4gYQp0cnVuY2F0ZWQg
aW50LCB3aGlsZSB0Y3BfcmN2YnVmX2dyb3coKSBhbmQgbXB0Y3BfcmN2YnVmX2dyb3coKSBjYW4g
d3JhcAphIHUzMiB3aW5kb3cgcHJlZGljdGlvbi4gVGhlIGZpeGVzIHNhdHVyYXRlIHRoZSBjb252
ZXJzaW9uIHJlc3VsdCBhdApJTlRfTUFYIGFuZCBrZWVwIGdyb3d0aCBwcmVkaWN0aW9ucyBpbiB1
NjQgdW50aWwgdGhleSBhcmUgYm91bmRlZCBmb3IKdGhlIGV4aXN0aW5nIGhlbHBlciBpbnRlcmZh
Y2UuIFBhdGNoIDIgZGVwZW5kcyBvbiBwYXRjaCAxLgoKVGhlIHRoaXJkIHBhdGNoIHJlc3RvcmVz
IHRoZSBNU0dfUEVFSyBleGNsdXNpb24gZnJvbSBNUFRDUCByZWNlaXZlCmF1dG90dW5pbmcuIFJl
cGVhdGVkIHBlZWtzIGN1cnJlbnRseSBjb3VudCB0aGUgc2FtZSBxdWV1ZWQgYnl0ZXMgYXMKYXBw
bGljYXRpb24gY29uc3VtcHRpb24sIHdoaWNoIGNhbiBpbmZsYXRlIHRoZSByZWNlaXZlLW1lbW9y
eSBidWRnZXQKd2l0aG91dCB0aGUgYXBwbGljYXRpb24gZHJhaW5pbmcgdGhlIHF1ZXVlLgoKVmFs
aWRhdGlvbiB1c2VkIHRhcmdldGVkIElQdjQgbG9vcGJhY2sgc29ja2V0IHRlc3RzIG9uIHVucGF0
Y2hlZCBhbmQKcGF0Y2hlZCBrZXJuZWxzIGluIHg4Nl82NCBRRU1VL0tWTSBndWVzdHMuIEdDQyAx
My4zIGJ1aWxkcyBjb21wbGV0ZWQKd2l0aG91dCB3YXJuaW5ncy4gVGhlIHRlc3RzIGNvbmZpcm1l
ZCB0aGF0LCB3aXRoIHRoZSBmaXhlcyBhcHBsaWVkOgoKICAtIExhcmdlIFNPX1JDVkxPV0FUIHNl
dHRpbmdzIG9uIFRDUCBhbmQgTVBUQ1AgY29ycmVjdGx5IGluY3JlYXNlIHRoZQogICAgcmVjZWl2
ZS1tZW1vcnkgYnVkZ2V0IHRvIElOVF9NQVggd2hlbiB0Y3Bfcm1lbVsyXSBpcyBJTlRfTUFYIGFu
ZAogICAgdGhlIHdpbmRvdy10by1tZW1vcnkgY29udmVyc2lvbiBleGNlZWRzIHRoZSByZXByZXNl
bnRhYmxlIHJhbmdlLgogIC0gRm9yIHF1ZXVlZCBidXJzdHMgd2hvc2UgcHJlZGljdGVkIHdpbmRv
dyBleGNlZWRzIDMyIGJpdHMsIFRDUCBhbmQKICAgIE1QVENQIHJlY2VpdmUgYnVkZ2V0cyBub3cg
cmVhY2ggdGhlIGNvbmZpZ3VyZWQgNjQgTWlCIGxpbWl0LgogIC0gUmVwZWF0ZWQgTVNHX1BFRUsg
Y2FsbHMgbGVhdmUgYm90aCBhIGZpeGVkIDMyIEtpQiBNUFRDUCByZWNlaXZlCiAgICBxdWV1ZSBh
bmQgaXRzIG1lbW9yeSBidWRnZXQgdW5jaGFuZ2VkLiBBIHN1YnNlcXVlbnQgY29uc3VtaW5nIHJl
YWQKICAgIHJldHVybnMgdGhlIG9yaWdpbmFsIGRhdGEgaW50YWN0LgoKVGhlIGludmVzdGlnYXRp
b24gYmVnYW4gd2l0aCBza19yY3ZidWYgZmFpbGluZyB0byBncm93IGRlc3BpdGUKYXBwbGljYXRp
b24gcmVhZHMgZHVyaW5nIG5vcm1hbCB1c2UsIGNvbnN0cmFpbmluZyB0aGUgYWR2ZXJ0aXNlZApy
ZWNlaXZlIHdpbmRvdy4KCk9wZW5BSSBDb2RleCBhc3Npc3RlZCB3aXRoIGRlc2lnbmluZyB0cmln
Z2VyIGNvbmRpdGlvbnMgYW5kIHNvY2tldAp0ZXN0cyBmb3IgcmVwcm9kdWN0aW9uIGFuZCB2YWxp
ZGF0aW9uLgoKbGxsZWkgKDMpOgogIHRjcDogc2F0dXJhdGUgd2luZG93LXRvLW1lbW9yeSBjb252
ZXJzaW9ucyBhdCBJTlRfTUFYCiAgbmV0OiBib3VuZCByZWNlaXZlIHdpbmRvdyBwcmVkaWN0aW9u
cyBiZWZvcmUgbmFycm93aW5nCiAgbXB0Y3A6IGV4Y2x1ZGUgTVNHX1BFRUsgZnJvbSByZWNlaXZl
IGJ1ZmZlciBhdXRvdHVuaW5nCgogaW5jbHVkZS9uZXQvdGNwLmggICAgfCAgMiArLQogbmV0L2lw
djQvdGNwX2lucHV0LmMgfCAxMSArKysrKystLS0tLQogbmV0L21wdGNwL3Byb3RvY29sLmMgfCAx
MiArKysrKysrLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IGFhNDBhZmE4MzFlYmZlNDVlNDBhMjM3MjE3MTEwNTlm
MmFjNTg0ZDQKLS0gCjIuNDMuMAoK
