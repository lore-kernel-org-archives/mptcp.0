Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D51B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I2xkfE+OauegVyMOVSItd1hw2TumPX4MunGXE9uzrA=;
	b=FDNzY/Jm8kRKBZFcKE22JRE/GXloA79FS7WKgeTbSKU6vACpApejzLAlbCQSbMKcF5fqbO
	zv0gv1i5d9CwL7wEU9wuXj9x7ILkxi0qdEdQvWXpTCVrBcVN8h4LLeUaE4ARp8JBlZUTuu
	kZPviNynl1ncQ96rnO66NsjqXOnFAUc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-GvIL9ZiRNdOrmqyQk99hfw-1; Tue, 15 Mar 2022 07:58:37 +0100
X-MC-Unique: GvIL9ZiRNdOrmqyQk99hfw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUeZo4/Aqf4Nt/B1puVdMjyOZ20l9HbnVY0Y6tf8wTWVgVAHaxQSzIhhG2NOjShMbCuyZ2nK+HRZ/mHezdTrXN093ffjs2ePdzgI8BcJxxi0/+Ugkitu7QqIId6eiDvZWG0B9UnDYUfLlenZDY0wrQOx/+5NNm5jCNmLQQlZbSjH1JDOAuXf8P1A3ecvWFht9rXb1uxCXRnujBGx26fwAdTPLxAXD23+AOzbtHquorSn7JMmmKCPKLC661xeI7QlQfprBvimrC0SEvGSyOaVcSOwQf0X6ZmI15kcQWhDVkciBuCj2gmx9RJSWS0i8f51h0FGZF5Y1ZkX6lkBhmRmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43+QFT2ekMs6H/tsBTApdMzPWZi3It8WuVBr/ZnQF0I=;
 b=TRenbw4fHzbcr2rAEBI6krDkbjJ8NCQBv+JGQcMRuQY1M35eA/mkPWvUO2G47HmhUMtr00aJ4u+jTKFkGVLSeyNZENLqJan5q9rZcw7MTfMbR2t2ROcCcG6G4wg9zcfJBizHKDEl+h+J4G96rfi5XPpKcSB7+gX2RTNmcpUiR4+m0EcHDEqj+hVhPeP5IblKl+lC93X9VATCfKExI2wyWTDYnhWXEa+2DmQEJpKoiYRgaqvqr6XSe9rxaEYO0hwg/8iIWQwYG6iTkeZCOETiv4K4ls0db89KWf1t/NnEPJ9/+EM6XNnCd6pTdTFUUTNImDQ2u0ArNFnMhTRW2UuZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:58:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:58:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/6] mptcp: use mptcp_stop_timer
Date: Tue, 15 Mar 2022 14:58:21 +0800
Message-ID: <9ea45b375250d4405f8b0547dd427ca1f387529a.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c08cd975-b842-4019-eba5-08da06513a83
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB31388E7B5FE1997DC1CF73ABF8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fA4XKxiBwfO3LQnPkP9cJDIN1rfvxCH9WYvaXQbjuU0sW+eDsXBcxtyRhPH/dgB3jOdOUmbZ/02rRUkhi0s9QM6L1/a2LNacxTBNrpywOsM21bezI1n+K1KXhjvLPf+9+fAZbkXWu/eJYcEH/f/WwnmlzMYaPRPgPlvTQ2kjBxAd8VBZWerxquETFQKQ4baX3vVts2bxOjZaUuvCWYnFLRd1FUHCt4UlUgx1YP3dc6ynlpIahrA4sffylP77ZpRKMbXD6gABdnA+ziOsIZcheFZvxQUja7BGeHgwzVDaqgAvGPXibwGY3kCmOwLuWb/buSCr5VkVQ6y2rB3DI6+7VVGrTFD/uTHsQJhIRtdYl+aEgG7MLdjiJ1NMt0MZ+DCXdCnrwiRCzJ7hl08ox9jflwAwyq04mL2j6cD8Gkx8joZhKc4KW/4SL1ffmcpBLpW7u+Ppcj9HeWDENpYUyBdRvveZUslPDXl5Y4FehzFFq4z/WGDzTkzr/eqNmyNreCaq+LakjKWpTFOh1aDPXqw5nwcUdY3Ky+7hdnYRSCT+LBeL92J5ub4HzrWyTgNI0JFOG+IpwPam7tve1j4hguyefLLGXU8iSFjvvH1Cc7cpoIDSMrmzhup02dJpHANlfFs5h3DzDqKSvQ8I8obzNaChKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qqLiUbVhSOstiJEbe73N403NQK7/0Nod2j8z5P4ye1N2JlmCD+COCnTERmCo?=
 =?us-ascii?Q?nHxuptdSky6ZOW0Dg9ThCF+zoYtKsEfUrYGqJ4UFXKyZ68crza8vswVJqscg?=
 =?us-ascii?Q?BrPsspmFZqr9UC/ZJ28UW564qbM3qIMHwz399KlBABMkqBriSCbTiYvRyM/z?=
 =?us-ascii?Q?CwVIYdScRTZEK8xvNhhHgSYriOEx9z10nx4b1j0Jl0qvd6cgAdPKWtNEZrTe?=
 =?us-ascii?Q?LY4WKZm5uBKuuRFa+ZA7uhe5loIXSpwQOwOYqgmJK9dUv+xDOxtGqqoj6jR5?=
 =?us-ascii?Q?J7Nni+pkYAOVhdVmGZinRrheDCPD0tf4XwRYPGH0vVxnsOKI95AhxbooE1UI?=
 =?us-ascii?Q?6lElzqCJXeDJ4whnKccCMMP8Csi9jop6ZnvD4ncY8lbxhstBPCwR0iRW3k1U?=
 =?us-ascii?Q?0tyXPhJb0tcvoAJWbLER0+CxgWNnTcG/0Iof8qe0JDpxdA9pej5cCM3DQsKr?=
 =?us-ascii?Q?rhikHNp2lQ+6enxU2keMsjhsjJCXJeW1OqbBj48fu55BDA0ubtZhkmIsU9WW?=
 =?us-ascii?Q?gHFGzTZf/cVzv71/LAuiNwg+Y5L1Vg4+e/QbNKxZS1QAgZ6roebN12yzZ1mI?=
 =?us-ascii?Q?hWzFONHf+TTEQl+kVnaSMf2OAqx2Ook0loPyk/lX3bak9i1EoHWyn09pCn17?=
 =?us-ascii?Q?xbDP9KcHPHfyHioKRM9z8wHrRTAo7kBuge7LCzufJGqejZKXpL0qLN0vnAck?=
 =?us-ascii?Q?anJ8TCNT1wp7ZCRZAlcjOq0Vt0FEJpmbB4QiXRsj5Ha8cbCUd4bdaKcJC6/2?=
 =?us-ascii?Q?jgF/INndTA8nxpjRX2pY6jRwvNT0rZ/0EG+dJ/BqgdEcytJQsT78CLlaqTWD?=
 =?us-ascii?Q?xfcMkdc7fj30rNZ9SpO2WnCoWyM/BhWkVLQJyNK4gj5tdrmnEi2VGK8UtLF4?=
 =?us-ascii?Q?u/jFwADw+XiEtmv6V6Dhzjl4Xno2QeHq/KMH4fHdkmAEPED1g9EdCGMqp4pV?=
 =?us-ascii?Q?5fGQyuXWTvn0L9MsUNSankdssbv1AkIeaNMhPVrxmYK2njIyyOx8QvQDFrYE?=
 =?us-ascii?Q?zSjgHjIN9lsSM7sWXz6P2R5UrfWTvKLaAsWedTDEvcOhzUsqL7ykwXbIUZ1A?=
 =?us-ascii?Q?U/1+7a9VO25Lq+6VqirONoTbc4wM5AtaceZzUOA/hfFQljZFM1k9qRot0wvR?=
 =?us-ascii?Q?3AcsejdvjPJwk5t0kuOzsUuOvgeCzW3GaZq91z9cgd5bLXZMRttsPL0LPf7n?=
 =?us-ascii?Q?untoKy8k4yDWYT8Da0Q8007wpSiCouL1Gywy8aQPYC2ghzr3xTDFh4t2QXJF?=
 =?us-ascii?Q?dJ0Pw5Nko7PgoVKt1x/OStJy3equ08H0WpWgTIhXWBJnMh0umkNZFk77qaF5?=
 =?us-ascii?Q?U5Hv9upw1vCaQsxyBvncddmiMA+uj9Rai93f4+2QpButCItuSJUkN5xKQv1J?=
 =?us-ascii?Q?Tmn3PBdPStk9AeoYxsV54e18cDHzTXzvk2xUUfwglULGsideAHgwN/Xk2uLh?=
 =?us-ascii?Q?qzUgU/fvFNdYbVHAz6NF9ltVjqM+/p8hVR08UdOSfrkfYGw8YrpLluGoiEOr?=
 =?us-ascii?Q?Qhec0/Vk3jKHqDHS1WxsMqpXXJDSzHBr1hsW+TI8cTGuMaUfbk/ZRSJyAg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08cd975-b842-4019-eba5-08da06513a83
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:58:37.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpHx4nUagUsJQLn3Qpa+WZgYc+nW2IBgYysvAtFp9X2eKIIhgwsYJXsP6R/+W5vEZtG7zE/R1wDI2PeTAQz1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

Use the helper mptcp_stop_timer() instead of using sk_stop_timer() to
stop icsk_retransmit_timer directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..90c2febe72cb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2756,7 +2756,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	/* join list will be eventually flushed (with rst) at sock lock release t=
ime*/
 	list_splice_init(&msk->conn_list, &conn_list);
=20
-	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status =3D 0;
=20
@@ -2864,7 +2864,7 @@ static int mptcp_disconnect(struct sock *sk, int flag=
s)
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
 	}
=20
-	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
=20
 	if (mptcp_sk(sk)->token)
--=20
2.34.1

