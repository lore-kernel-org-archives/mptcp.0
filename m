Received: from CP5P284CU019.outbound.protection.outlook.com (mail-brazilsouthazolkn19010009.outbound.protection.outlook.com [52.103.21.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB444A3F1
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.21.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382504; cv=fail; b=fsiroO5W/B60cx8tCPgpfbNn6t2ig/DmanPZMTadgcAwiEhLusN4edq77poVNdAXCDslBuvit/W5IRMhU6R4qINdmaEr4zCuIAOiFHBE9hQvC/7BXWbgS5+0+3RP032e9bN/frFqG9NifaOGsGJfWS1EjfQzwzbfcjoQjHTSYyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382504; c=relaxed/simple;
	bh=ZNkpI6nCzAk/apN+KI5VVwgQzpcg5KbKpW5ZVAGlI0Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jtyYReY8yVdo4X5CHGAA2KT3l7snIPUVDnvB/84NeWi6Negknm/bpo5XD4rXCOH3IBJcgT9tVtbHUrOrcVGHvzq2XPcNwJIW5R+dtwi2DT91mMhwdCDNpOutxpT3jEVoCPGtCGQK4ORAxv9R2HEHs9WJ7n95GqHBnh1kXBiKjjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jGXbDSf4; arc=fail smtp.client-ip=52.103.21.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jGXbDSf4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPN3Qm4QEmdnZDrDFIlznHgdoEABZohYNj3SI711BtMLwgnHChHGF98mUNvWCCTvelHPShTd11TGIQ+e6Lb4JGqy6uysz7i2s/uXevKKet7A7z0A7A9M8h32oVkqT3G8SdvlbpJdyiU9MKNi62IfacLH0zG0bIAepFrUn4wn4dRqAr6jszDL0vjYRzwuGHxb9yarjBLimWUdpqGbXuAbVorEr4kH3BPuIc97VcfhyP3Zm7c7TFOBvY8V5sJXOTaRVWLdGod/O4zQOQTM/mhaVXiavJCapHiYUJuCLB3W4Rg8JUaxOtTV0OFFCBj2gX2LUMdQbU70PRZ6nB4FANCVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7LRmj1FOfX0lloPQQ8AFt9SUOHLBIRMR0Zzv9Io/Xo=;
 b=dUHug4owUsZyx/L1rs92sXiPbley7raXDXKh/ZoMDS6XADjlVkoBVgfTKxwkEM2AxAr8uLe3C8V89AdSALWAXCWY1b8Yb0h+DIcGzc3TC0YAdC3TQEgZc5QL8dYW/+tyc7d3YOsUWqWRFyN/7sd+HY0pC+bwM5Y2+lGzVXdeKobdVagWEPAmS87ag9sFW22fV0YiZlfu5sMa+vPY8zsW4jxWEdXGykHPjzHfJwtWwjg8AkI4pGsTiLySFLdCtUGBYCqUpiE/+fM4lr9jxYvkdtOb87doqldR9BbKzEiaNd06K0cDTb0rYw8HYbwZuSxWOe/doLOZl0blh4lA+krrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7LRmj1FOfX0lloPQQ8AFt9SUOHLBIRMR0Zzv9Io/Xo=;
 b=jGXbDSf4Y9HZdSDpaOW+L7YxxEszvr4vQzbzB+0QQ3sGWZDL4rCdDCPYmHckfybdMjPQcbcYkBl1qa++GRgxaOUXzKzbtYpstonDrFgDzoybqsCf8miDDs4G1fINKSSVDVvpHa5TNWI82JogCo2Hy0sgsfwO/yti0orzMVho1A6dZEz/1ERcW2sKg5D0MpppmyRhKsMnRWKzPww2AYX3QSIgqeimOyBT2sZQTNu8od6rrrER7uxfgBmCIWLuLo3QW/F7dwNmIpeWu8IDHx+9msrAkwOoyX/7rMLyYdhkXFUIDHVDY4Kcn+2SFsuJmywukJKlSYHUutvUlClAzzCuCQ==
Received: from ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:92::8) by
 CP5P284MB1600.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 04:01:36 +0000
Received: from ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
 ([fe80::d40b:6372:7b2a:8e83]) by ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
 ([fe80::d40b:6372:7b2a:8e83%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:01:36 +0000
From: Leonardo Souza Silva <Capleonardo12@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, "mattbe@kernel.org"
	<mattbe@kernel.org>
Subject: mptcp: poll(POLLIN) on a listening MPTCP socket never wakes when a
 connection is queued
Thread-Topic: mptcp: poll(POLLIN) on a listening MPTCP socket never wakes when
 a connection is queued
Thread-Index: AQHdX35pMfv/6CeS2kmGBVk+wgNO3A==
Date: Mon, 19 Oct 2026 04:01:36 +0000
Message-ID:
 <ROAP284MB16279B4CA8731943D0006042BD982@ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ROAP284MB1627:EE_|CP5P284MB1600:EE_
x-ms-office365-filtering-correlation-id: c4bad809-8b4d-42c9-08ae-08df2d95abd4
x-ms-exchange-slblob-mailprops:
 laRBL560oLSPhlJ95/U7v6W/AahuugGaTKmQmbVKSB1uDapfhwwhjKAMh5JsIJLyk9WYJv2u/WQGQyFepKLML9wp013/uCeSnYv3jACUQ5IsH3kYd9Y7+113nhfo9q7FPPAcL6brGkXdu5FcEA8c95L7/AGYVXgyJTzVVau2D0VXABvhX3pJG/3OhV3fIIW1S8GD7ILFm6dGuBIjxGBcYK2SK4N+TiPNpQAds6T/EM2mTWY1xSS9zkFffseZvLn2tZVOHZyzcj2sfTi8Xy+Sms4oNDM/mp982g9UheYxceOniGKLZNOXbBoVq9C2qaHSMBWzaE1wNGVVqaqMs3PcKS9LpE+B9WruBgrZvPkAIYoi5Agm8/+OKIHC1CK6tDXmEjLLz5J+Fv9sQEI4ffcMxJGmPmrt7qPg7mryh7JJdy4KQzWLnBfF1evW5aRy8sq2jobNBxiHOgHsCN8hmUDladl4UgB+naUBsgbqh6RQQWy+LU7CGHFSF7fGWG+lQZ5cRkdMXZHdgGPf4jybXOAwLrN9gERZMfL+pRWE+9tdoaAS6ZBpH/wBZQ4oMj92qPlhbtcWrjAeVGBwJLM4vC/AH+3vN/5hKo7qRbsMNWRHdPhi+UPBWrigAwEjxWMvxBXGn/LAiMJFH8u0Kyw1miHqO+gBSUKWoT5eCiL7Cj/2/JYOEiUCK53SMO64OgQAUBR/P+jTtfKQxOys4pyxLFtbfCh6JBO8fsz8fQPDRhQW2QACJHP2Hmg0+uWsFgVlOXg6WcHEzn/zWMOw1BGGHNCV/Z5mzbgqkY6y
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|31061999003|19110799012|25010399006|24021099003|4140399003|6092099016|15030799006|15080799012|5062599005|16041099003|25031999004|53005399003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?p+K/pFuV+mi8UDvf7VcqVLtqgxnM+pRR0B/CC1+xRKP54/i9QAtcts43lM?=
 =?iso-8859-1?Q?ubcNBVk+KND03+rM6nvPt3TFYXfbvTlHK9JDT5I6Rd5vKu85XqbgXC5jNn?=
 =?iso-8859-1?Q?gHPyZXr/5JMiZOzkLJ9sx8eJqSjrrRug4up3RQ00059CkQ6V+U3K0rPTfj?=
 =?iso-8859-1?Q?EBwsaTkfwrWoxqZ2dIeQDhFATHhK4S7iqGR0+oitZ14SvEopDy7OHRhnfB?=
 =?iso-8859-1?Q?GodmpxCpF23OOWmcjvaMOgfs5DtnLwz0w9830z3gdce3CeS5PRFPHYHjxU?=
 =?iso-8859-1?Q?PGl1WzW595JWHZYFwH2oI6VdBEpGttGI4ldjjJ9YiGXzVGuOw+o/CufCQR?=
 =?iso-8859-1?Q?JrVn7zIBQq6nr/6WO/dZ0hfNbqj1apF9wihFVOlJ7HdhbUvE8L8plpUCE9?=
 =?iso-8859-1?Q?VQeVXK4vp33SYbQgXQmZ0LwoGDxZ+CcgC7Fv/3YLViOZcNJI3Ybf8Dmn5H?=
 =?iso-8859-1?Q?zjTFmuypx5OoOcOiknWDMzkGB0K41r8leG7QWeb5wls3MdqRdjv1kg3IXw?=
 =?iso-8859-1?Q?jFrtpawbU38yDA3N7Pcez7PWxI7DbbQSZPjvHvDZNZDPdkfD7LifO5bU7F?=
 =?iso-8859-1?Q?Xcgy8CIQ83jAXDTPrDfv6vnpi0imD00Dmj5kcH9bHzAjQoF49+Ol54FuQl?=
 =?iso-8859-1?Q?LoiQKf80rgSZdt+jGMte8F4RhfK8nWGgjVtjdq3WHcjGG+HDaRa59/UwtL?=
 =?iso-8859-1?Q?cOk6Qi1XcLLZZTnYdmejp7hxG6ughTl7kKINMHNYtRESJ3G/n6DdKqGoNG?=
 =?iso-8859-1?Q?RUCp23OBd14FLRTjEyRPrFjr5usRigrt+MDg3WhTurAuyaaGqEsYDMfPor?=
 =?iso-8859-1?Q?Dhy6zmOTtzrGGtIj5jtH99q/qnHXwTTk0X/zvRS9ZbfTlMfyfRPHuqsnw0?=
 =?iso-8859-1?Q?mJDi0+EfJpBI92xvnfq1zKf6I7xROnQwwX0Pq5Xqd9UMT2Js7SBWj56QRw?=
 =?iso-8859-1?Q?KDxQszMSG1Kw2t56d6e9BM3nW6zWZI/tsUzYfcfdXaGTmdBJSZgDSPUo17?=
 =?iso-8859-1?Q?dYihCqf+0MVDieKyYiOvjkYS2iQwKvcd9sJGfJKtlwFjC8NLTo9OB867lx?=
 =?iso-8859-1?Q?W9sQ0+Txd9TJPAcRJbCgCS0PkRSnzdkeyWv/iHqwo+X5a3tJEzzhViSyPh?=
 =?iso-8859-1?Q?NL4IBM5EEEU+qFLhFC5AI0KCp6XcM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+WftTvOF9HXXLPumWxP9wOGlx9NSKXfpYv6N2yT3VCVgT8TZ5qiam710js?=
 =?iso-8859-1?Q?k72Nn8gU2HKDjZHNQ9wfrKTjzeskLvsnSsTt0kYzGMiqH1YRReEMhdI6Lm?=
 =?iso-8859-1?Q?eHfJrNP+DlJygE24Tob6V85X9Z9j3S9Jb+xVVxJ4jf1Quzg+r9ASiex/Sm?=
 =?iso-8859-1?Q?juuPwyAYZjtO/T8WnjJyQX4Lw04vJjv1WXFI/UHNIciY83EUcH3QIJ60OK?=
 =?iso-8859-1?Q?ZSJTSFz/IMaJeIXZRckNCgBOIRhmJkFtDp5XeDfAKXrJRomx8WZcuIPSH3?=
 =?iso-8859-1?Q?5nYx2dZbIR5Ox7lfgI5zN5hXv5gbeHkpwiNZozskxCg4d4s3A9RaDxmX13?=
 =?iso-8859-1?Q?gU5tHSWuBKlKE4gtLR+QYixR1EsTEhhkvLSlS+iRUjuYLKVzsXPsHOz7Dg?=
 =?iso-8859-1?Q?WmJ/JejEvknsTA12C7au+SZljfWNEmmNOFxSmpjNX9f7wXJtlEzq9lT6Bo?=
 =?iso-8859-1?Q?awe/eS96AUhKMvFKsPBQq2KBOIk6uQPq+E4VADwWzvXigFvXyWJrgXN5YZ?=
 =?iso-8859-1?Q?XRQBtOPzWt8hRd2ZMHitcQyl9/xKhWxKKWI2LG3+bzlMYziOGR6s3T69hQ?=
 =?iso-8859-1?Q?rmAkjoMwok+V+eUiLKAwcy0i9ZNSwuULff59q1BbrBbDu2HLbqCMTircS9?=
 =?iso-8859-1?Q?EDrbGQXdzRt4pq3Bj5gpIuL19SQf/93l4va2Pa9eeox7kexHIZeF/ylcrf?=
 =?iso-8859-1?Q?KmD7yrRMAmRJV15UdxSnvS+krSadx7YXipH3meJreND7PQp2KuOfhkvPO3?=
 =?iso-8859-1?Q?W6fhk7Sxbh/D4np/kff5BoyVf/jR8zUC9vtz2FbNFBvXjp7Iqz9nAlJbLL?=
 =?iso-8859-1?Q?Qqxe+Y8aXQu2cMajqEE7MkR1tF1tQmF4F7jhsCxM1ZorhinKawo/XAgmVE?=
 =?iso-8859-1?Q?bBOKxnIgCbLrmB0Yugqs9uTzPGiVf4lmEoQeP+17RvzC+2AzPv4/4X5plS?=
 =?iso-8859-1?Q?2z9O/avsOj/jHKfDFjtuYE56MG0o6j/Ws6EfwOrbBwgPxTeMx6Q1GHrBYl?=
 =?iso-8859-1?Q?sCyUd8VCtLWVLxzEDGB/FMi684b47nJjxNAkEIy3a1W1DPKe/XFP7lISqu?=
 =?iso-8859-1?Q?B51usc/XquEprfsf3efBOe1qCG1lPkiBtINxqU6cBVfj4YRWfXPbAUkSt6?=
 =?iso-8859-1?Q?3LHgpLsKx/z25jneuM4Iy3ukdO0DDU+m/FoRP6VXsxpKbfx4b0A59IdHIJ?=
 =?iso-8859-1?Q?3bex2eg1CeWjYB0Y7Rpk1JRPq3Uv+56Z+KVndZCz/oC5M9xRNyzmD51oRF?=
 =?iso-8859-1?Q?PCn+lkujCNQpEEmdQ59L0S9F4/BAnActfej73Ch6mpIWR6cXaeYuM1ZLW9?=
 =?iso-8859-1?Q?Je7EeAOz6IO+zS5fYvx6Q2+Hspb0XgcvSKcde+T9GPrtVOM227GLA3h6y/?=
 =?iso-8859-1?Q?DuLf+LAzjs0dQbcR36XA7qJ27gNfj8XpJDyI8XLWvb52VMFcrIJuFKRzFI?=
 =?iso-8859-1?Q?PAJ6sxpPx1b1s7bO?=
Content-Type: multipart/mixed;
	boundary="_004_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bad809-8b4d-42c9-08ae-08df2d95abd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 04:01:36.5615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP5P284MB1600

--_004_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_
Content-Type: multipart/alternative;
	boundary="_000_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_"

--_000_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

While stress-testing MPTCP on v6.12.113 (KASAN lab), we measured that poll(=
POLLIN) on a LISTENING MPTCP socket sleeps its FULL timeout even when a com=
pleted connection sits in the accept queue: 100/100 connections each incurr=
ed exactly one 100 ms poll timeout; a subsequent poll returns POLLIN immedi=
ately, so the mask computed by mptcp_poll() (net/mptcp/protocol.c:4229 hand=
les TCP_LISTEN via inet_csk_listen_poll(ssk)) is correct, but a task alread=
y asleep on the MPTCP listener socket is never woken when the connection is=
 queued. Plain TCP listeners wake correctly in the same setup.

Impact: any poll/epoll-based accept loop on an MPTCP listener degrades to i=
ts timeout latency per connection (100 ms in our harness; the workaround is=
 a nonblocking accept spin, which is what our fuzzer now does).

Reproducer shape (kernel-to-kernel loopback, MPTCP over 127.0.0.1):
  listener =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); bind; listen;
  fcntl(O_NONBLOCK) on listener;
  thread A: poll([{listener, POLLIN}], 1, 100) -> always full 100ms with a =
queued conn
  thread B: socket(IPPROTO_MPTCP); connect(); send();
  compare: same code with IPPROTO_TCP returns immediately.

Verified on 6.12.113; the same mptcp_poll structure is present at mainline =
58161ead2 (protocol.c:4229). Happy to share the full harness.

Leonardo Souza <capleonardo12@outlook.com>


--_000_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Hello,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
While stress-testing MPTCP on v6.12.113 (KASAN lab), we measured that poll(=
POLLIN) on a LISTENING MPTCP socket sleeps its FULL timeout even when a com=
pleted connection sits in the accept queue: 100/100 connections each incurr=
ed exactly one 100 ms poll timeout;
 a subsequent poll returns POLLIN immediately, so the mask computed by mptc=
p_poll() (net/mptcp/protocol.c:4229 handles TCP_LISTEN via inet_csk_listen_=
poll(ssk)) is correct, but a task already asleep on the MPTCP listener sock=
et is never woken when the connection
 is queued. Plain TCP listeners wake correctly in the same setup.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Impact: any poll/epoll-based accept loop on an MPTCP listener degrades to i=
ts timeout latency per connection (100 ms in our harness; the workaround is=
 a nonblocking accept spin, which is what our fuzzer now does).</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Reproducer shape (kernel-to-kernel loopback, MPTCP over 127.0.0.1):</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; listener =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); bind; list=
en;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; fcntl(O_NONBLOCK) on listener;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; thread A: poll([{listener, POLLIN}], 1, 100) -&gt; always full 100ms=
 with a queued conn</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; thread B: socket(IPPROTO_MPTCP); connect(); send();</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; compare: same code with IPPROTO_TCP returns immediately.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Verified on 6.12.113; the same mptcp_poll structure is present at mainline =
58161ead2 (protocol.c:4229). Happy to share the full harness.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Leonardo Souza &lt;capleonardo12@outlook.com&gt;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_--

--_004_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_
Content-Type: text/x-c; name="attach2-mptcp_poll_repro.c"
Content-Description: attach2-mptcp_poll_repro.c
Content-Disposition: attachment; filename="attach2-mptcp_poll_repro.c";
	size=2233; creation-date="Mon, 19 Oct 2026 04:01:19 GMT";
	modification-date="Mon, 19 Oct 2026 04:01:35 GMT"
Content-Transfer-Encoding: base64

LyogbXB0Y3BfcG9sbF9yZXByby5jIC0gbWluaW1hbCByZXByb2R1Y2VyIGZvcjoKICogInBvbGwo
UE9MTElOKSBvbiBhIGxpc3RlbmluZyBNUFRDUCBzb2NrZXQgbmV2ZXIgd2FrZXMgd2hlbiBhCiAq
ICBjb25uZWN0aW9uIGlzIHF1ZXVlZCIgICh2Ni4xMi4xMTMsIEtBU0FOIGxhYjsgc2FtZSBzaGFw
ZSBhdCBtYWlubGluZSkKICoKICogRXhwZWN0ZWQgYmVoYXZpb3I6IHBvbGwgcmV0dXJucyBpbW1l
ZGlhdGVseSB3aXRoIFBPTExJTiBvbmNlIHRoZQogKiBjbGllbnQncyBjb25uZWN0aW9uIGNvbXBs
ZXRlcyBhbmQgc2l0cyBpbiB0aGUgYWNjZXB0IHF1ZXVlLgogKiBPYnNlcnZlZDogcG9sbCBzbGVl
cHMgdGhlIEZVTEwgdGltZW91dCBldmVyeSB0aW1lICgxMDAvMTAwIGluIG91cgogKiBoYXJuZXNz
KSwgd2hpbGUgYSBzdWJzZXF1ZW50IHBvbGwgcmV0dXJucyBQT0xMSU4gaW5zdGFudGx5IC0gaS5l
LiB0aGUKICogY29tcHV0ZWQgbWFzayBpcyByaWdodCwgdGhlIHdha2V1cCBmb3IgYW4gYWxyZWFk
eS1zbGVlcGluZyBwb2xsZXIKICogbmV2ZXIgYXJyaXZlcy4gUGxhaW4gVENQIChJUFBST1RPX1RD
UCkgY29udHJvbCByZXR1cm5zIGltbWVkaWF0ZWx5LgogKgogKiBCdWlsZDogZ2NjIC1zdGF0aWMg
LU8yIC1vIG1wdGNwX3BvbGxfcmVwcm8gbXB0Y3BfcG9sbF9yZXByby5jCiAqIChJUFBST1RPX01Q
VENQID0gMjYyIG9uIGtlcm5lbHMgd2l0aG91dCB0aGUgdWFwaSBndWFyZCkKICovCiNkZWZpbmUg
X0dOVV9TT1VSQ0UKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVk
ZSA8cG9sbC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVk
ZSA8dGltZS5oPgojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+CiNpbmNsdWRlIDxuZXRpbmV0L2luLmg+
CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CgojaWZuZGVmIElQUFJPVE9fTVBUQ1AKI2RlZmluZSBJ
UFBST1RPX01QVENQIDI2MgojZW5kaWYKCnN0YXRpYyBkb3VibGUgbm93X3Modm9pZCkKewoJc3Ry
dWN0IHRpbWVzcGVjIHRzOwoJY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0cyk7Cgly
ZXR1cm4gdHMudHZfc2VjICsgdHMudHZfbnNlYyAvIDFlOTsKfQoKaW50IG1haW4odm9pZCkKewoJ
c3RydWN0IHNvY2thZGRyX2luIGEgPSB7IC5zaW5fZmFtaWx5ID0gQUZfSU5FVCwKCQkJCS5zaW5f
cG9ydCA9IGh0b25zKDQyNDI0KSwKCQkJCS5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFERFJf
TE9PUEJBQ0spIH07CglpbnQgTCwgQywgcmMsIG5zbG93ID0gMCwgbmZhc3QgPSAwLCBpdDsKCglm
b3IgKGl0ID0gMDsgaXQgPCAxMDsgaXQrKykgewoJCXN0cnVjdCBwb2xsZmQgcDsKCQlkb3VibGUg
dDAsIGR0OwoKCQlMID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfU1RSRUFNLCBJUFBST1RPX01QVENQ
KTsKCQlpZiAoTCA8IDApIHsgcHJpbnRmKCJNUFRDUCB1bmF2YWlsYWJsZTogJXNcbiIsIHN0cmVy
cm9yKGVycm5vKSk7IHJldHVybiAxOyB9CgkJYmluZChMLCAoc3RydWN0IHNvY2thZGRyICopJmEs
IHNpemVvZihhKSk7CgkJbGlzdGVuKEwsIDgpOwoJCWZjbnRsKEwsIEZfU0VURkwsIGZjbnRsKEws
IEZfR0VURkwsIDApIHwgT19OT05CTE9DSyk7CgoJCUMgPSBzb2NrZXQoQUZfSU5FVCwgU09DS19T
VFJFQU0sIElQUFJPVE9fTVBUQ1ApOwoJCWNvbm5lY3QoQywgKHN0cnVjdCBzb2NrYWRkciAqKSZh
LCBzaXplb2YoYSkpOyAvKiBjb21wbGV0ZXMgaW50byBiYWNrbG9nICovCgoJCXAuZmQgPSBMOyBw
LmV2ZW50cyA9IFBPTExJTjsKCQl0MCA9IG5vd19zKCk7CgkJcmMgPSBwb2xsKCZwLCAxLCAxMDAp
OwoJCWR0ID0gbm93X3MoKSAtIHQwOwoJCWlmIChkdCA+IDAuMDkpIG5zbG93Kys7IGVsc2UgbmZh
c3QrKzsKCQlwcmludGYoIml0ZXIgJWQ6IHBvbGwgcmM9JWQgcmV2ZW50cz0lMDR4IHRvb2sgJS4x
ZiBtcyVzXG4iLAoJCSAgICAgICBpdCwgcmMsIHAucmV2ZW50cywgZHQgKiAxZTMsCgkJICAgICAg
IGR0ID4gMC4wOSA/ICIgIDwtLSBTTEVQVCBGVUxMIFRJTUVPVVQiIDogIiIpOwoJCWNsb3NlKEMp
OyBjbG9zZShMKTsKCX0KCXByaW50ZigiXG5NUFRDUDogJWQgZnVsbC10aW1lb3V0IHBvbGxzLCAl
ZCBpbW1lZGlhdGUgKG9mIDEwKVxuIiwgbnNsb3csIG5mYXN0KTsKCXByaW50ZigiY29udHJvbDog
cnVuIHdpdGggSVBQUk9UT19UQ1Agc3Vic3RpdHV0ZWQgLSBhbGwgaW1tZWRpYXRlXG4iKTsKCXJl
dHVybiAwOwp9Cg==

--_004_ROAP284MB16279B4CA8731943D0006042BD982ROAP284MB1627BRAP_--
