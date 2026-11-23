Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426490;
	b=Upo4k4a2sp71u2NzzXnM5oJ0PC/Lf4/TPE/Wqti5foHM44YfWEjPXBwc+Jx1ocF1B8cZ
	 MIEEVXeAn4RrjXhAsBD8HEoyEuZLqv/s0EPUtnjcf6ltNpTq81L5zdrHBAjbxUywSFel3
	 Y27G5j6/ZWODLwTHo+Cykr7ugxYNw3o+62ejOEzmqgqRJwO/gCOUNl0CyOzbYrRupHumU
	 LL0GjZ+rX0b20QBD417oxTGZHFP3WTGNJmg1nbqTJ5qJ2Qsnl0tBR2Lwga8WOxJEjQ2zV
	 ASq0J5RFfW/R2TTL86/Sc23YVcLRT9LB22ixjQdHPw1yw3CWXN3KfUs+yA9X+HC+06Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426490;
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
	bh=drV9wELZzCMv5wWxkBbIj1Ajt4YMUf/uSqo/wLY4HIo=;
	b=MFr1wjD5RWZ7e1pKfbbN0KpBNl+6kqcBDPgiAnteQRvncqakMvjbVFpunPDucIIBFMS0
	 N4emp+yrNuULpDvK1ijhQOGpCzn1cZ1XnGBmoEw9M/2XlqoS+FeKPadgXlrNKMhw1Y9PY
	 kiiDugi5YXWpS31T+rKQMSbMxbqUYXj2Tra4vOnEfEFfYMI0AYavVmLZgnmbr2flZTyzm
	 /xE31EfxjYuKgcr0W7T08YYeRnk6foo/fDvjpgaZ5OFCR9WioOHzA7GxiNO9DIkOEUppb
	 jwfrY6uCvo7/QPfz9pW2Enbi56xlWCLxWtYCG9W1GsmL+TS8+zAlnha2unA/X8VA0XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cosjtf6e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E0606A33B
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 09:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B35E0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cosjtf6e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/XqyogzZeXrCfyIHngUqgIIR7+/atlx7v49DY4CsEABJpR4e5EttrBIthxuOGCkM1l+FMqQJZrVhUVf7rjN2oISN74iJeTDXfFH34fUxa6CSRkzkNJglrl4P3G1ddvL8K3ZyF5Fgz6X+JaduYYCsJyq4gQRT5JUxHtna/a7hQA6eD9fYUqpXDePd7y/9FF8LO5Lg1ILFEKsIA3o+7D2DTwEqByAuB0+0HXzxaLYaJ1qvwuI01N8Sn+hMvKTEVuoEXnmK3ylwI7xFT8uimkn3jFcVu/c8BBE0hceuYtQSCtIjpncwVtUWCoPBkNOjKxBMGSjyZz5Zq+y1/5wZruT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=drV9wELZzCMv5wWxkBbIj1Ajt4YMUf/uSqo/wLY4HIo=;
 b=hKrNmQUDq9n2t4NatKl9D0GznAbP0sRuHOeNT2Y1VJ/6leG3f/SDV1YSzV4AmGNu4VDMfyGcvYgRyq3q0JtZeyJ6xEzqaSzxvXuptEBMSeLbiYYY5rhUhsaZAY0La8XZUwM7RQzpIElUc+0EBuw4zJmYzLwd6eWaWbWTDBDoS1wjr4E89w9HZn36/qMGee4mxIUM9TNI+SvHWZPBNrBgNEByeCz68UvVta8bawc7GaXustDggySrY4rm2pdJrp9RMhJNssor/rC29ygkkeZlU5VSWWaRTaupN4H3NIyUP66BDCd3swqB4GOni7QJX0N6BsxLNrIoYop7pJikJ7K4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drV9wELZzCMv5wWxkBbIj1Ajt4YMUf/uSqo/wLY4HIo=;
 b=cosjtf6ePSEGJBc0vnMW4gpeyWtMmMHYdA796dcR2JQpDUxUg9b+jN+9fPEcm1/vGq1gARsJ2cS3frZCD4Nd/exjNQCGQXrnDvAufQh4JN9Ax1Qj7KMpq4Q0xLGZaoPClh8wPGDgCBbOE+9YOCLPMeomQFFHmzDDGuS82uHnndQYkCxQ6k8oPliIU6oMA/ETEyGycOxJmxWEnLba2Xi2FU2Gl49bZfkTNv/69ug/L5IV4//A9E2ELEZCXlgrHGLD1aQHpFnc5IPS20HyZ8mKZPtsGUPV5qV3xyyjlD1MAx4GEQ7VrJ4aMX55rB032ZGI7hfc/7+jkpaMyqCcFsiQZw==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SJ0PR05MB8664.namprd05.prod.outlook.com (2603:10b6:a03:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:04:34 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:04:34 +0000
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
Subject: [PATCH net-next v4 1/2] tcp: avoid wrapping Fast Open blackhole
 timeout
Thread-Topic: [PATCH net-next v4 1/2] tcp: avoid wrapping Fast Open blackhole
 timeout
Thread-Index: AQHdeymopn+nzxVVO0mLnbX4ck3mkw==
Date: Mon, 23 Nov 2026 09:04:34 +0000
Message-ID:
 <f16def1cfc888fd26dad40f52e3e92b138bd3319.1795424547.git.x-professor@outlook.com>
References: <cover.1795424546.git.x-professor@outlook.com>
In-Reply-To: <cover.1795424546.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SJ0PR05MB8664:EE_
x-ms-office365-filtering-correlation-id: f2223ddb-892e-455f-2f45-08df4940cafe
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7aPC0o7eel15pxjKSqRG/i5y098ndLT/kpNBi2EbxM5vOxshk7m902ZPsiI0Nlf27OrmJLGIS6cRmYjFQDl8dtTGMkguNY7K7ceXjNoOwtJFZX0MIIbU5l6vTXAxW7wc+QyAP2BBhdpn3XLCGnaPF1XmGGBy5z13l04GicpdYQlarcI+BC5hjhjkLmv0vvTiqS8gue4RpHARD2SYYm2OoDCVXF0ux5PXOTFM5vbYlX3mCePpalQxtFap06f1JiHusA5gBlCyAB35sfcwwPmX2Mqnziqghy7wjk8laKM2l5uoUYkZheKHGSNj5xpragJL7ApYMuO57VhmKsMTF8oHwmUr2ShOCdZ5T+MnSk1lKDS1cdBGucbtwL5jPI8BcyX3CPw/U276NCkg0iAB+pIYVLM57rG5OqcHy/LWO3bpLKo+8V29OWUFr/Xlqp8YzLwuqzm00+RcqU4Hd43tEpxXHIu9cpsirKhfN2pw6lOtzfORY77+jTDMTyJHgR1X6dtMLfYCpd6MOXpxogqW2euIzkTi7f2MOhtmJ+7Pr1FbLKPVGGDLfYB69U+RWkqPNQqVjwc6rLI/+ZS2aW67v+Q+VU/qITckzbN3u3Z2/hXkPGdZwR7ZLX2WSd6ygZapvD8Y8oxfexEQfVqvqHJqHBXSZ81bPDHMBXGUI1hCRgLEvXj39oh4XDl8YtOaw7/s85lZCgWN3JucaoiDypXqc3GxUW5N0euaZ+R64t1yCREsmwfI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|38102599003|22091999003|8062599012|19110799012|41001999006|8060799015|51005399006|24121999003|25010399006|4140399003|24021099003|440099028|3412199025|102099032|40105399003|30101999006|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PGCHxdUwiDYYyoVj3ji9ycNvICTszZxvXntjCUqgEOImFBTaqsjXbqss6X?=
 =?iso-8859-1?Q?S0shybZo3/rYWIgEXk9F3+9hdTur6zndnjl91fOpVY0a3G3BZxxIteC2u7?=
 =?iso-8859-1?Q?6d8bKyS+lVMa+CrFIzjoTa7mwUpOusSfKNuFKjliIYB/Gej0XUFsZAG+X3?=
 =?iso-8859-1?Q?X3GQRPNY71Bwc4OkwQ/hkRrekwsfGCufeqi2oxaMC93BrooauriVaECQXb?=
 =?iso-8859-1?Q?tzLCdf8lB7VJ7+r3JTEeJW9tWDLd9VOoTLSbPoWIru/LBAyQnGLLtHm0P/?=
 =?iso-8859-1?Q?29CvwwSwcEl+4teakJYB5OiznqV9Zm0trLzAHz2jMi4ztxvrclxcjE6OFd?=
 =?iso-8859-1?Q?MDZ61Mgq5idJQf33xEA8aVcvjWbpRJqcoF3gTO+9nLTrjjZSeBNzUcBDuv?=
 =?iso-8859-1?Q?AUxlCCXKCeNNcIdncoHAQsgxwV1bOMPAb6/4BrLfvuJGS8PWaPUCuAj8HP?=
 =?iso-8859-1?Q?imellsG5xim4tiSPl9QoRPUyQAzyDtw4k/NhmIfnEveHB7JMMVmxQAOXp7?=
 =?iso-8859-1?Q?vD902lkG0lvzf9IZPFyOKF/s19O5XC2w/irE99/Rg1Jmm+wJ5tMqEobv54?=
 =?iso-8859-1?Q?6Nx2vvynT8Nfudfim6GruqIiFKmUIYMae9SCsI1ELdzkicj1OGIlcEPK+I?=
 =?iso-8859-1?Q?caSpOFU5GZkOGG12xOwTQ0UsRtkzvgC6csc7xTsVoIJoJzQ6q3qFQjfT1D?=
 =?iso-8859-1?Q?huNoNeDzQ29KwVoq82aKZsE9FlPPLcec/rGDVNV0l0it7Ijo3P7TIYK0u+?=
 =?iso-8859-1?Q?8fhj3wZdkRoOHvzImSNGwwOxmbnIOVGYZLC1aeVGCVBwiy9vrULWOXW8w8?=
 =?iso-8859-1?Q?c2kZ6GMgc40f6BBAgIG3sfy48nBerBfJupyowtTK4UaNhs1Fo4QFIXkClt?=
 =?iso-8859-1?Q?RiyrFtFTNKrzibJQUqxR5vNmYTXiCKcn2HSPxTg4iM29/KSHa+VnOtCn6X?=
 =?iso-8859-1?Q?EdJRz3GqbQ9IKbFYObwvukWeyKP0yVvjN+6FQeMHwelvyAzYAEkkd1hRQ+?=
 =?iso-8859-1?Q?Zn6sfIkcGCYHZQNfYPDXGHAiyabdhEwyz61gG6JEL5d5E8DS1s4oG7Jmpl?=
 =?iso-8859-1?Q?D9/6ETnYniLFJMWyc4T/Sxd2kDLmeEdL5MW82IyE2zMZLqdOMo40jwCXN/?=
 =?iso-8859-1?Q?qxgbRXv05ul/kcATKzFv87mAFAxHNZDct7uGYDh6PMKeSsV2pd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qRUuw9ScNrZOKW+3Ria6M+BdRBEkpKoAJ5BumEfWgXJ0XLn3fmDjDGQRnU?=
 =?iso-8859-1?Q?Xs611URwrukllVrSpjkvMJzm32iniC3/+qoRCMc/qy6bxjsEg8zaQnsNJJ?=
 =?iso-8859-1?Q?Z6IluanXpJh0hcJ1+jwdy0LBVCiBzGYWbQ2FZaZR4C0Zu0dzouwxCqM4NI?=
 =?iso-8859-1?Q?91lDnDv40ocsXhT8RQncX2EACZCDoITc21V9c9YBYDWIaUg2mjI/hWoQlb?=
 =?iso-8859-1?Q?fnvSeTlcXl+jSlWyZsblPxDro+pSmXs9vIon8HjnMqXIawwklz0ghu9KVv?=
 =?iso-8859-1?Q?vQtD40D4pg0tW0J8T9CLpB10HJyZnQ51BIOO7f6WiYl7rP2rHbctL5rYDs?=
 =?iso-8859-1?Q?LeJqHvf3YFvcBbihyn+CHuuvLC2zyw2H4zYmzGDlFwa2fEPEQV4LoTxA2P?=
 =?iso-8859-1?Q?tR/R0Ot2Xjam5ZS1/qlcOtf4c7NAETYbQrlYOKWYit94UgTxMywloZnnnB?=
 =?iso-8859-1?Q?TSQAJSZfLrpA3xCnr3pRBQQLpx5oQKYdmDwNfPG4MXkbMfTZJvyBmDuRq5?=
 =?iso-8859-1?Q?dDty930XhlZJePWR3KoeBq+m35GekKLj2YJG3omhGcI2HLHQYJ+QXGDM/1?=
 =?iso-8859-1?Q?TKIprJQi5GgzGgrGEgDeKCZLrMwrhCxbLbmWVyOzRxKo3r4cr6LwHjyQr3?=
 =?iso-8859-1?Q?uP7HxVdsMCtrCzkbgZtlazObUWicSFni0u0fKmvix9m3SYxGLR0khaUHYM?=
 =?iso-8859-1?Q?W4Wihi3VLGrKN4+aa/0OTWefqVqiHnZvj/3GzPnWoVglpperUPh3DerEIL?=
 =?iso-8859-1?Q?vjxZe1AXOq7+otMkETyr7pRuGKinnof8Bj9+gLgyt7iBJz+harMbfUiopC?=
 =?iso-8859-1?Q?ilIEgTtT3FsMlQINdyZPkq8/htaL+39zapf01lhpt+yHRbLxhWiabPDT3i?=
 =?iso-8859-1?Q?RXSNyIl/pwJOXGrk/m+50Ko0OTxOu/U/WDcSnakOdz14B7LFo++blXqQNk?=
 =?iso-8859-1?Q?bxA17ENSUb0gpJmqBerVCunwyTOVYf6o10oWCJH4Eaol2krizAoz0jl4NF?=
 =?iso-8859-1?Q?T6zywfDHNB11Cb/hsSNpdaOVpLSXFq4c07qC0dm4qOCIT/gQMqBsbF+grQ?=
 =?iso-8859-1?Q?AyzfLUckjTVFJWAin2QvfqboAO6tNWxokQu1GX5Kiq16hBiuo/dISO4sA1?=
 =?iso-8859-1?Q?jcpU7Hkh85RumeGLpM9hjLeydfVma8zu/EytMbRzwPtVlxWQ0Xq5rAakcE?=
 =?iso-8859-1?Q?M44yjZOAJb/KJsbZXga5wgBeCV0OF/5Ho/AYWXWfvdB8LC8GlPgKu5yodv?=
 =?iso-8859-1?Q?w64ujgPJA20mLTnHBQ8/62jFbKwvYcmYOp6CQQV7YX+/90/11MbibxuZNy?=
 =?iso-8859-1?Q?/gNxHtSSWNwXnpjKYOfYwUIZAmxB1x3i00fOXLbt7tji8rBbI4uaB4/F9F?=
 =?iso-8859-1?Q?CSoevENDIjzKSnfTCPtdDxcBrGUIbpOOZmLhtjxOy2lbHF05CeZD21/JXr?=
 =?iso-8859-1?Q?uuRW/EBh68QTibeS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2223ddb-892e-455f-2f45-08df4940cafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:04:34.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8664

tcp_fastopen_active_should_disable() calculates the active-disable=0A=
interval as multiplier * tfo_bh_timeout * HZ. Since all operands are=0A=
32-bit, a large tcp_fastopen_blackhole_timeout_sec can wrap the delay,=0A=
even on 64-bit kernels, and re-enable active Fast Open too soon.=0A=
=0A=
With HZ=3D1000 and the maximum multiplier of 64, any timeout above 67108=0A=
seconds wraps. For example, 67109 seconds should produce 4,294,976,000=0A=
jiffies (about 50 days), but the calculation truncates it to 8,704=0A=
jiffies (8.7 seconds).=0A=
=0A=
This issue was found using a static analysis tool. It was confirmed with=0A=
a loopback reproducer that induces 12 Fast Open blackholes and opens=0A=
another connection 10 seconds later: with a 67109 second timeout, the=0A=
unpatched kernel retried active Fast Open. The reproducer needs neither=0A=
kernel modifications nor error injection.=0A=
=0A=
Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding=0A=
it to the saved timestamp. On 32-bit kernels, the cap keeps the interval=0A=
within the range that time_before() can compare, which limits the longest=
=0A=
backoff there to about 12.4 days at HZ=3D1000.=0A=
=0A=
Also limit the writable initial timeout to one day, so the exponential=0A=
backoff does not start from an impractically long period. Writes above=0A=
86400 seconds, which were previously accepted, now fail with -EINVAL and=0A=
leave the current value unchanged. The wider calculation is still needed=0A=
below that limit, as the 67109 second example shows.=0A=
=0A=
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
Changes since v3:=0A=
- Drop Fixes, as requested by Matthieu.=0A=
- Leave the existing comments unchanged, as requested by Matthieu.=0A=
- Add Kuniyuki's Suggested-by for requesting the input limit.=0A=
- Move the test notes below the separator, as requested by Eric.=0A=
- Rebase on current net-next.=0A=
=0A=
Testing: the loopback reproducer kept active Fast Open disabled, and=0A=
the sysctl accepted 86400 and rejected 86401. The TCP selftests were=0A=
not run.=0A=
=0A=
 Documentation/networking/ip-sysctl.rst | 1 +=0A=
 net/ipv4/sysctl_net_ipv4.c             | 1 +=0A=
 net/ipv4/tcp_fastopen.c                | 4 +++-=0A=
 3 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst=0A=
index 3cc80d9b024b..c2b05ca14ff8 100644=0A=
--- a/Documentation/networking/ip-sysctl.rst=0A=
+++ b/Documentation/networking/ip-sysctl.rst=0A=
@@ -1055,6 +1055,7 @@ tcp_fastopen_blackhole_timeout_sec - INTEGER=0A=
 	get detected right after Fastopen is re-enabled and will reset to=0A=
 	initial value when the blackhole issue goes away.=0A=
 	0 to disable the blackhole detection.=0A=
+	The maximum value is one day (86400 seconds).=0A=
 =0A=
 	By default, it is set to 0 (feature is disabled).=0A=
 =0A=
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c=0A=
index 9df93ad219db..fb0f3124836d 100644=0A=
--- a/net/ipv4/sysctl_net_ipv4.c=0A=
+++ b/net/ipv4/sysctl_net_ipv4.c=0A=
@@ -1152,6 +1152,7 @@ static const struct ctl_table ipv4_net_table[] =3D {=
=0A=
 		.mode		=3D 0644,=0A=
 		.proc_handler	=3D proc_tfo_blackhole_detect_timeout,=0A=
 		.extra1		=3D SYSCTL_ZERO,=0A=
+		.extra2		=3D &one_day_secs,=0A=
 	},=0A=
 #ifdef CONFIG_IP_ROUTE_MULTIPATH=0A=
 	{=0A=
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c=0A=
index 7f7eb3cc1c04..aeefd605414f 100644=0A=
--- a/net/ipv4/tcp_fastopen.c=0A=
+++ b/net/ipv4/tcp_fastopen.c=0A=
@@ -613,6 +613,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk=
)=0A=
 	unsigned long timeout;=0A=
 	int tfo_da_times;=0A=
 	int multiplier;=0A=
+	u64 delay;=0A=
 =0A=
 	if (!tfo_bh_timeout)=0A=
 		return false;=0A=
@@ -626,10 +627,11 @@ bool tcp_fastopen_active_should_disable(struct sock *=
sk)=0A=
 =0A=
 	/* Limit timeout to max: 2^6 * initial timeout */=0A=
 	multiplier =3D 1 << min(tfo_da_times - 1, 6);=0A=
+	delay =3D (u64)multiplier * tfo_bh_timeout * HZ;=0A=
 =0A=
 	/* Paired with the WRITE_ONCE() in tcp_fastopen_active_disable(). */=0A=
 	timeout =3D READ_ONCE(sock_net(sk)->ipv4.tfo_active_disable_stamp) +=0A=
-		  multiplier * tfo_bh_timeout * HZ;=0A=
+		  min(delay, MAX_JIFFY_OFFSET);=0A=
 	if (time_before(jiffies, timeout))=0A=
 		return true;=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
