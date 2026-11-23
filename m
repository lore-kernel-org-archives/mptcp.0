Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426489;
	b=Xw10grb/YHWdFGkdxSHB+7Mg20u/dEF6njjkHzSWV8A2/ilC3zmB+jJHxscLtDRCRzhu
	 hdW4OjZc5+tyDZZu6UDrExQsmM/aT11JXQWOYjgZnKNRVxT9V2hmCzcMNHO1nfdDPjiIE
	 /Dl4yjVktw8hzPKjvgFgOkSL40YmaoETq5ZwmqTQl1MIm4D5gX2sx/lnBgtb4ZNwpfEhJ
	 K0ix49ztLysXpaHpQ1tUlfTef2yJOwVfYwKT8XkRfcbJzF9fnVYh7bOZcakFlAmRLC9Un
	 ol87UAeW+Aiq8ttg7JjzRVQKvuLU+w6ASx5kGLdrflp3v9osYHPYUfDpjckIuAduz2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426489;
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
	bh=YQzxNF6xtMk44bt7Cj9srJkaGwcdkf5qBldzEL9rygk=;
	b=v9wu2wNySd3QKfvmr380tloJrrWwHg3JZo8JzhjB2e4BVCisWmws8N/z5YVcf5MFG8LN
	 RXLB2E4+DyURm67KRNE7J/BFjHyAv4l0ERMvMAtXCdLJ5zZgOIhOY6JGqExhK0JrnNqf3
	 DBSDeaL2F9zeToRaFs/joCQ5gEg2jCT7pWT4+kmdbupxJ774vTY5YadtIHxfzwhoY4HJd
	 CxuOHWJYESlYpLwkOymqv5Ei9IreJpk0QznjQS3f949eimpA50sI8lv/Y2kdTV8CzlH+6
	 veFP5wCBJGe+gy6sXPBy7TTJGfxuvyaLpOAtot+pltlr8N9YmPeLIVCQ4ThIBDK3aRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=NBbDdkzD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F145606A337
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 09:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F145606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=NBbDdkzD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1ZtLulR68nUMcsPIPBfnjbCGtw+MoCurybCt9/GToSalz975ssTfcFqGuUkQ6Krd9UhfuBjLOHUN8ogU4jbucPxDZMwOvhLKR028cGsfS9D7WmjXB1Xvt1KdWCes8MbHMrX2MeGj4rPkzs2WLICFyhXsYUeZehEInhX1zL56uC8yAmBHcVxDwK5mx9OR+zQIi7rqjgBjxaW9So6YsQJN8+7a3YYf5gPtuWIZNfi3GlmFBIlqGHH+fLx5sjhbmQH1CGvQwPEe7ZvuvBRgYwF1H1D5sop7itGPNIj0E6j87m03dHsLJx4axESyB+ZqNrpz3L2Hm7qq8k0m2q90VSvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=YQzxNF6xtMk44bt7Cj9srJkaGwcdkf5qBldzEL9rygk=;
 b=DDBVi6Qt2W/qD4I78RVisx8wfQ6TO6kBjygZ5YmXrBaLUJoh3Mr+PmR4liqRm2ura42BG8rx8NUjl2qt3wUES5Z2swGVPEWR3lnVgim1j/W67e37HRzTCycVfgg61MV7xIzLbIVrAhnVzGhqJEVSKeRQPRVcgJN3epjeZwXM3X2EUx9LziMM231Y2SNa/Ib17eLWI0mmo9jlgwX8EKhnhdNb12abr5IaRbAIKQTymGnBq/1U9sUXlyvDSL710cdQl4j9AmpEGKi9/Lewaefu/abOnrOXlxbgORp0fQK9Wk8cKQAeoGQN08N4vmM21wLZ38CSlekh7kka2xsyOTM9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQzxNF6xtMk44bt7Cj9srJkaGwcdkf5qBldzEL9rygk=;
 b=NBbDdkzDDq88o3hTxjaDERWO4D8LVquq8R8Nw2j9qbgjGwBxwg5GglHnpSyN803qRoRdR2dg2vHiS29PKK3QwZwtRoPtJ+7+O2W9AW08gQc3Yo5GOrh2zIaXPxpie/kLgoUrmKMo6gwittLSVGaKr9kvnExZR07Xroun5R2kENN5XVd6+VHThGAKcuwh2dueEi8bER0d+nHgX7GQ+CL/3OvS6BtFp1naN6gQC4k7yrbEwXSSEYlWEgklRND6CH6lZVQta8cyf0qAeYbiMo2olHJCbYe4fnqTtAfHA1+oIWJNqKMJRVcrE1CGlBJ6gOwE7XAFc7zptXIYYpQKBR+ojg==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SJ0PR05MB8664.namprd05.prod.outlook.com (2603:10b6:a03:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:04:36 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:04:36 +0000
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
Subject: [PATCH net-next v4 2/2] mptcp: avoid wrapping blackhole timeout
Thread-Topic: [PATCH net-next v4 2/2] mptcp: avoid wrapping blackhole timeout
Thread-Index: AQHdeymp/LQBHf8LX0eGUfjlOHDOMQ==
Date: Mon, 23 Nov 2026 09:04:36 +0000
Message-ID:
 <61910493c920d138cd33da5ae5fc7947a64fba05.1795424547.git.x-professor@outlook.com>
References: <cover.1795424546.git.x-professor@outlook.com>
In-Reply-To: <cover.1795424546.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SJ0PR05MB8664:EE_
x-ms-office365-filtering-correlation-id: 03de979d-a180-45d4-a9de-08df4940cc25
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7XnEfcFlZsmiQfLeX9DD1ZIGYjYUC6uKRWwlMs3WNyEIK8MAg6ou3CkNx+MVMEQxPSn1zv/N7k1H9UqxLHevgzyxkRvylq/fsD+IjtI5a8q9Ans5xBSZLjXUdOpAj99UggBkT2xFBtoLbAo6bA/0iv2nKPP0B9Zi3wN/RNK01hSiQFpljdz8MnQ0Lu4MT9rdP/uvsvCzrHblzzge1c6bZPw84nYKYuhURnbl3H0xalDEHW4+g+aaEe5qOw0ZmoQcLCcCqNaV06x51QmuXs5cOUSPBGcpCDYOkb8Z8DOey09FcnR0ndQBOUKibncn1ZJZ/p+8mCXZb9LrqBGBhSS7EMWtbqsk71ixcdWPrLzZ7PXFvd2VOk1POaHd+xJy+ZbyNZrdHB+u5tEtdedqxsH/udgn7wIhlGwVOjj4gsh6L3qgoCT0+e+PoQSQUNSd3giLe2Fq4Wfn21B65FZK4atkwFR0sj/iUJHhnnFtgw/vbNYNL81yAY3RBgrIaGWuyq4ECKjWQZyvevG+0KypRPLPgd2wbdhw5drts0Tmd1PJKq5czsGbfJaHzWD+TTInqUYy/oyxJZEevSKKYp+X/LAAPvYaAHXtNxTdy6UVlHzdn2kOv04HCD+/ooZUKN9AxXlWgpiaMSv5ewtCKQgiCnsHPBdvqhbm2gAnoRGEgkCNknVzOOUoA4rVvbYFdJ8kM8gDfs8agXTCKlTosQcILM9W3+chtPjVlfpWCNmwpCPolRug=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|38102599003|22091999003|8062599012|19110799012|41001999006|8060799015|51005399006|24121999003|25010399006|4140399003|24021099003|440099028|3412199025|102099032|40105399003|30101999006|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ALgL/5cHdf5ix2S4yOQnPa5KXVv9K2h61AHoaOymYbCjOVKDDT8ilsvmIC?=
 =?iso-8859-1?Q?xExBlfK2B40sBnFQS3av+rY9COxMUGWuynBkugDrJ8obqIVLlU0xQl0pJ0?=
 =?iso-8859-1?Q?vvs2I/HirVhNHijZJXqFX0Zup91xcIq5vGmBavIn57JKkQgxJ85Vz+ssJO?=
 =?iso-8859-1?Q?J2ZlEz9LB05yHoR/9zGYX48VeYGHLHjyXwpg14M68TJYfAF02RBq1lK7jH?=
 =?iso-8859-1?Q?AcfoRGZsxV91dexZk4s4HdZhOx0wzc1GejA5HgusD8L3GQ85pmWSsPk1Ml?=
 =?iso-8859-1?Q?Nf+LB5gFhTEx7aDUh3e0eUet64XlnaPvURrGBNZrFqA8IGSK6KpVJ4hMvl?=
 =?iso-8859-1?Q?d8J4yY/COYlC+6Xzaf/e3ePzfW6wGmwLUxxQaV1J9H90kxwszTqT+mjnIK?=
 =?iso-8859-1?Q?ThmuxGVFswax7Ps/rXsAVgX+jxcKxpOQwzt7PnIVhmXjJH1YVuQ77bGjDt?=
 =?iso-8859-1?Q?4cd48O2fDjQ0MsekvDA6vPFk4E8PzQLOx4yYHMd25Y41qQKsEkfUIZ688O?=
 =?iso-8859-1?Q?2tFd7IWLLVObzH+Oa6QqHIeyKdHJYgS29m/XvoZ9en/PHhfqRLPO4Ufh9z?=
 =?iso-8859-1?Q?wPJcCWyojC9+ga8UdALQ3AHNmdkEw9IRyT/wBw3SxJJE4ibLeZ8gQAMyzj?=
 =?iso-8859-1?Q?M9+cNwOb+o2f+dC24Ko4LoV+l3INf1LYXD6fVUWmKbuWXwM5APOpYmBJad?=
 =?iso-8859-1?Q?Z7ZdL5zeuYX1zrghhTmDUBgWoMw8r3EdL87md14BddfDu+Hj37nOmpHYBv?=
 =?iso-8859-1?Q?9CGN7hmMLatfZVIEttsoLKYR5SI5Vu3kLO3qZbhQhG6o8HK3D1RkkRVITo?=
 =?iso-8859-1?Q?WyU5PGzVVYg8ssltq004lfrfjV1DppChyf5Djmiz8beQ/MTJrDODF93hqu?=
 =?iso-8859-1?Q?fArK7o1w6w1ilGThWZecO/YlOuDyYFp6vMrhv0Wu+SOYvaogGYkNr3jyNQ?=
 =?iso-8859-1?Q?CP3bYki/dtjBm8MYGCzMy4iLX6ltY2pt3XTR/YCcy7nf+16J2dyVyZCCur?=
 =?iso-8859-1?Q?5sTl7N+uvom9C3SzpzW6UnEGvrRYUSiGZnClvFfw6sJIVEDvZLPR57tnZQ?=
 =?iso-8859-1?Q?CatoubGOrvnverAmJPCeE29jZ1Vio4IN3nVB0CCaHBww4984C/zaYdSUNO?=
 =?iso-8859-1?Q?KLvRzJLYmhaRDfIqwvady1bc8sGqsRV4WO1DB7TZniWTUpKJgp?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MpWDBFtkPwzhnj3U/Wi6rt0BRhnFFTIpesHVrl9RhZEfeXwSIrB0t7iEDo?=
 =?iso-8859-1?Q?m8rmHGSL28dgZM4GWNNRKSDpG40Ny5HfOuajjBlPiswIw58uEu0DaiL+MU?=
 =?iso-8859-1?Q?SlyqDB3qaXh+2qq2S5+mJnXa7zu3LptuAZSMBKhp7WQsvsRJorOv89Zelp?=
 =?iso-8859-1?Q?F0tZ8fZU0ey16tG43qMPAihqUFYf308RaNlE7PYXP3oHn/DHNXJJc4z/Cx?=
 =?iso-8859-1?Q?lG/ZIhFx7GbslKoVlOEP9sJ/HkCpZ1T/xS8gAdV16BuAEACQ9HjSkP4M0G?=
 =?iso-8859-1?Q?kWK+6HoI6+7JI6QXZpX+8FQlKdn2BFpBzceLlBqSgcsTLmUJVs9z67mEeU?=
 =?iso-8859-1?Q?2BPdTW4if0NN6L4+LChS+S6xz8KIlctWuOSnr5EE9nMRVrXc3R8EuSsmsj?=
 =?iso-8859-1?Q?A6F8PT+feqc/DBTIgv7oWR8cHrGxYZoJIBf9cc518adtjpwFqron4T2qk4?=
 =?iso-8859-1?Q?DhWD+GaY0BqqDn4AwEY1DZn/5Rtk+Y/Pm26ESETjsjGCP4/lvfqdb8uzyU?=
 =?iso-8859-1?Q?ymabJ0xANqyKCYX6LFgW3TilvxM1Sk3zb26BgUc5E5+5w8elPHveCCOlnC?=
 =?iso-8859-1?Q?v+Ex0BhLplQ5oqGR57D/pX+fyyIIznVlylNwJuToKgx5opHF3iaOXYm9WS?=
 =?iso-8859-1?Q?TcpSne24BqXw/h1IXtFnByAYSjQ+RUo4M29v4apLLCL61xCoi7i+SbKdy6?=
 =?iso-8859-1?Q?co9YPvNDf9LKMsZNTKuwiUwPYkCPGNpHYKGWsDXYW8brZJU+Hk6vu9SStM?=
 =?iso-8859-1?Q?yTw57iAOBeeWgP3iYz5RIDjdsmZ0jDUuGKue6LRE+E2Mxs2dUXNtY5l7ni?=
 =?iso-8859-1?Q?oICl6yEzpJvrDb6EuZ8tNLwgFkVi8Ta+bfcYlWgmP+Mia6HYzx+7GMQkN8?=
 =?iso-8859-1?Q?Du5Iox1mlvJInXIkoGvTDCTP9GlWV4RIESiTN5Nzsgdb36oEFneC3jjS2S?=
 =?iso-8859-1?Q?BEMqaH9tvbLITVMvcFxz6oj4tSxi5C9fOGjCXM6926s88t16bcS5aU5PCV?=
 =?iso-8859-1?Q?vggTNsXPuNCS4gSVQMsyQod9CToeVeWdTZMc7PbTJqaJKs9aD7B23HiNDD?=
 =?iso-8859-1?Q?hlApBaJsIiiNU/JD/nzdwgWqtE/yRbdEV2z13E116fCiO2bYxdJvJfuDgs?=
 =?iso-8859-1?Q?SZ2HqEQNI41VLyPCMROtFswv4v7m6zzXoZxxS1znrqiM7d15BHRLfwnbHm?=
 =?iso-8859-1?Q?6aiyUJ8r8O+lUWNQAPviedimq2L5WqNMfszLsCNeYIIWAogw2MOiCYFJAb?=
 =?iso-8859-1?Q?Yv9Rg9ChF6gVHatm4h5zEgjGW1SKf76pIV53XK9CkMBlwTsfLdpcNp+hZI?=
 =?iso-8859-1?Q?A83Zqycqaq1bR/p82vhrYgFZQrBQe13EgktJM2d+AuOxJF3hqvmS4qj0yN?=
 =?iso-8859-1?Q?9SEoPzscARXYCwVgCrLbrTnFI+DDCHzLZpQSpnVIe1IYDG9auJEN0QoI9I?=
 =?iso-8859-1?Q?kULpEvaQu5U98kMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03de979d-a180-45d4-a9de-08df4940cc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:04:36.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8664

mptcp_active_should_disable() calculates the active-disable interval as=0A=
multiplier * blackhole_timeout * HZ. Since all operands are 32-bit, a=0A=
large blackhole_timeout can wrap the delay, even on 64-bit kernels, and=0A=
make active MPTCP available again while the blackhole is still present.=0A=
=0A=
With HZ=3D1000 and the maximum multiplier of 64, a timeout of 67109 seconds=
=0A=
should produce 4,294,976,000 jiffies (about 50 days), but the calculation=
=0A=
truncates it to 8,704 jiffies (8.7 seconds).=0A=
=0A=
This issue was found using a static analysis tool. It was confirmed with=0A=
a loopback reproducer that induces 12 MPTCP blackholes and opens another=0A=
connection 10 seconds later: with a 67109 second timeout, the unpatched=0A=
kernel retried MP_CAPABLE. The reproducer needs neither kernel=0A=
modifications nor error injection.=0A=
=0A=
Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding=0A=
it to the saved timestamp. On 32-bit kernels, the cap keeps the interval=0A=
within the range that time_before() can compare, limiting the longest=0A=
backoff to about 12.4 days at HZ=3D1000.=0A=
=0A=
Also limit the writable initial timeout to one day, matching=0A=
tcp_fastopen_blackhole_timeout_sec. Writes above 86400 seconds, which=0A=
were previously accepted, now fail with -EINVAL and leave the current=0A=
value unchanged. The default remains 3600 seconds, and zero still=0A=
disables blackhole detection.=0A=
=0A=
Suggested-by: Eric Dumazet <edumazet@kernel.org>=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
Changes since v3:=0A=
- Combine the arithmetic fix and one-day input limit, as requested=0A=
  by Matthieu; name the bound one_day_secs.=0A=
- Drop Fixes, as requested by Matthieu.=0A=
- Leave the existing comments unchanged, as requested by Matthieu.=0A=
- Drop Gang Yan's Reviewed-by because it covered only the arithmetic=0A=
  fix; retain Eric's Suggested-by for the input limit.=0A=
- Move the test notes below the separator, as requested by Eric.=0A=
- Rebase on current net-next.=0A=
=0A=
Testing: the loopback reproducer fell back to TCP without retrying=0A=
MP_CAPABLE, and the sysctl accepted 86400 and rejected 86401. The=0A=
MPTCP selftests were not run.=0A=
=0A=
 Documentation/networking/mptcp-sysctl.rst | 1 +=0A=
 net/mptcp/ctrl.c                          | 6 +++++-=0A=
 2 files changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst=0A=
index b9b5f58e0625..ca00253c8ae9 100644=0A=
--- a/Documentation/networking/mptcp-sysctl.rst=0A=
+++ b/Documentation/networking/mptcp-sysctl.rst=0A=
@@ -63,6 +63,7 @@ blackhole_timeout - INTEGER (seconds)=0A=
 	blackhole issue goes away.=0A=
 =0A=
 	0 to disable the blackhole detection. This is a per-namespace sysctl.=0A=
+	The maximum value is one day (86400 seconds).=0A=
 =0A=
 	Default: 3600=0A=
 =0A=
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c=0A=
index 164f79b9deb0..11472e20fa6f 100644=0A=
--- a/net/mptcp/ctrl.c=0A=
+++ b/net/mptcp/ctrl.c=0A=
@@ -20,6 +20,7 @@ static int mptcp_pernet_id;=0A=
 =0A=
 #ifdef CONFIG_SYSCTL=0A=
 static int mptcp_pm_type_max =3D __MPTCP_PM_TYPE_MAX;=0A=
+static int one_day_secs =3D 24 * 3600;=0A=
 #endif=0A=
 =0A=
 struct mptcp_pernet {=0A=
@@ -350,6 +351,7 @@ static struct ctl_table mptcp_sysctl_table[] =3D {=0A=
 		.mode =3D 0644,=0A=
 		.proc_handler =3D proc_blackhole_detect_timeout,=0A=
 		.extra1 =3D SYSCTL_ZERO,=0A=
+		.extra2 =3D &one_day_secs,=0A=
 	},=0A=
 	{=0A=
 		.procname =3D "syn_retrans_before_tcp_fallback",=0A=
@@ -487,6 +489,7 @@ bool mptcp_active_should_disable(struct sock *ssk)=0A=
 	unsigned long timeout;=0A=
 	int disable_times;=0A=
 	int multiplier;=0A=
+	u64 delay;=0A=
 =0A=
 	pernet =3D mptcp_get_pernet(net);=0A=
 	blackhole_timeout =3D READ_ONCE(pernet->blackhole_timeout);=0A=
@@ -503,10 +506,11 @@ bool mptcp_active_should_disable(struct sock *ssk)=0A=
 =0A=
 	/* Limit timeout to max: 2^6 * initial timeout */=0A=
 	multiplier =3D 1 << min(disable_times - 1, 6);=0A=
+	delay =3D (u64)multiplier * blackhole_timeout * HZ;=0A=
 =0A=
 	/* Paired with the WRITE_ONCE() in mptcp_active_disable(). */=0A=
 	timeout =3D READ_ONCE(pernet->active_disable_stamp) +=0A=
-		  multiplier * blackhole_timeout * HZ;=0A=
+		  min(delay, MAX_JIFFY_OFFSET);=0A=
 =0A=
 	return time_before(jiffies, timeout);=0A=
 }=0A=
-- =0A=
2.43.0=0A=
=0A=
