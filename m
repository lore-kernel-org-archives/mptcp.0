Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E228F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652271478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHmdZbA5DCdBlzWX5veEwr86/My3Y86pnoae4lrgSQA=;
	b=DeYvXcOofrW2qzjsBUxDA32waTz2+C7qNyM0VJirlwjSJGYvhrJVuYyH75ZxSNv76Awgnj
	KJKpY587xMzvkX7IUmmz2nWlPKk9PZ8VzjKZh65L0oidcwhz700EfrnLMpnOY54ZNkMxSu
	izDNAos8aHHvaqCdGl8lO3RYAGohAQI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-bmmzmv34M8CkPf-sLVk8kA-1; Wed, 11 May 2022 14:17:57 +0200
X-MC-Unique: bmmzmv34M8CkPf-sLVk8kA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqXQVCnQ7vrl+UXj5rQlgKTo7U1RCcqViOrEyNbHp1g0s0Z+vRU/+qLbOJsbA6qJxIk94EW50XNKq4DC6f3q9BCy9FQQ2gEbtmmZnieUQTt1rVohAmJWqy7uBbWSMGJJ+szovyJffMEexyDroJbXJ5LYNyw3Sp51S/N9/jhY9zp+iWePDqBMVbrhNkISuTKr+A57QfSM9pPEYc+0K9UxcwKPzCrSHW2UPcYnjL3FtdVgj2HwOXL3LZbMpw+oZRF6qzEVVcdPoy1oRwReH6UWFGp+6sTEoboKp7Gu096cl71twl9B3sv1ScHVDxlO8ccCraMEM+gs/tPz2Eytc5XyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZqcZRY8VNcd18uPIKuAh5I+0rnteUwv8wMyHXRe2NU=;
 b=Gud5qrtv5LZMZQDcyEOkfeU1ORAQZ3sbXRJhUAdVcIKGP77OBzYU0EMRF/8iXzRNfGD98K6Gl2vnrHzCvEag45BfnUBXsmNSj+mYHlPgaaQsPVpthm8KQbOaed1ResAIzuCVoyUiQk4liNJg9mNaicVkhgV3gEV2sJqqb7vlfEX84YcNcvuTa1TaCgCrJwJc6glBorDPJ9y7eQHG1HPGUI7Th+amw74xVJ6KyqPQmjW1wDXCM8tdDtQwkFzDGcLXvko12/RYL09y9YYjrkl7rN9VjNRQlQ0gAKzK2OleBgJasbEkxhNHs1m1DnCqAQNw+RotzZI92O/hm5RDbhtDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:17:56 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:17:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/5] mptcp: add redundant subflows support
Date: Wed, 11 May 2022 20:17:42 +0800
Message-ID: <e7923bfd510f0fad5201cdabc9e0b7a08d7833fb.1652271034.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652271034.git.geliang.tang@suse.com>
References: <cover.1652271034.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0d79bfa-817c-4fbb-902f-08da334847f5
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB571647E051B39A806C347114F8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ts2Hdhzt4U/bWuDqqYNqi8+GvfqRZ+zNQR5HCI/490ggAAizbZ9r5dce0BhczUP84icMNm1uRyy7Q0EgmCBRk3zZlHyCWxB6OvThjbTnf31YLrkEYhMLPXRMoBnLdcsdGgYOKi1TX5CByBEQ46oLBi88ksemaCHTiwfiiWywz973TMe7Xa0Uxxv5c13DyaEz0WpOcJXslNzHdFFefa9+omUTDjhyIQS+49FharnpfNTmBwj3u8tHEgaFkSYXXCxK5EV+SsquwwzXsx8+7d0pB/5l72axyVM7GNpbPPWs4zn4wK0UhlR+J9UT2tgwsg9kCbc9jHhQIZemco5M98gdKlcDUbsa+MKEp7Jq7zsm7BlYZvF7yWTvfEKIov5PubuUjPrTKuZdYsZ2Hv/BXIbZtvsLMIzuMxAEFI5SJBvk3UuHARNSY6TBaJEWFDUosRGZ0fgEM+ST9LJHgrjC3AX+KOpFclwS43ozthBbtbvACK7om19r0uSFpTTX99ZNkD7nLSm5JFh+XMeLLgfaWuw1OadIGIFn/h76WVLdd+VK3/GwEY/naF/lOnDd3sPtio/mG+oTBK//wL9mYbnX3rXFnaWUxSRt0pVPoGnLtWqv4e1FK487DArw5sSN1m6xXw+nxp9tZEwQLd/lvADIbKuhwJCNHDcxSFiUjIay9+/NbPeOrA2WEDOJQghe6uCxweUPtIg+1jXn+8kPXhuzGK4FQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(83380400001)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b8YrJ89tzchCeQ3bFRjedjt0M+2hNs8m2dc5lfrnUedcN6i5/fJYPDSt975y?=
 =?us-ascii?Q?emYgI1vs8Y7YTsdIjDPmbguoeZZ5YAZ6xMU6jS6abk5izu2QKbrl9aorrrX3?=
 =?us-ascii?Q?h3ND9AGMyTnnsA+RTC7Cv/blymiZsvJfiIfUz1o7ajZDto0NVWIKi3kCSFw6?=
 =?us-ascii?Q?BNSHJB+mp3vTvCf8DskWLo9hXVGlhVKvKeowvIsITaXENMxxMSxgLkofZIp2?=
 =?us-ascii?Q?m9rDgX1CmO7JvD1UHg9c0kpYMxQzK41zmjwbfY05gUCgnLnvO3mFEdt+dpUs?=
 =?us-ascii?Q?LgSigJQohFNe9i7n/9I6x+u7chQYXrFV2p5cxcR58hj/ArKLXTtDNtWgXzoX?=
 =?us-ascii?Q?FxKQsdCV+CDnA/o2FEncx/3HnrOKQIDd23Mo3K0OhyfvGT6bvvcxJFUEDOQy?=
 =?us-ascii?Q?mQcVak2tTMQ0zpanYrI4b4LkA/CPRVXPXeSwfRyYVtLUIaCY0jBzdifH+qBe?=
 =?us-ascii?Q?DAb2dK6NHeyt3HpqfA7N2tWdKWRIMN5oGmFhEbawF8aoX1vFg5AK7O37PSdq?=
 =?us-ascii?Q?H3WJJfm24I47yd1zbHPyG1sKTX21evq/HTqtUUtpmjZY1ap7GIK2H8rHUabu?=
 =?us-ascii?Q?Q5PJNrT8rakcOxuNW+sdNReNi0OOCazj9jXwY95EqsxN0ZE5fIedz1Tv/2bh?=
 =?us-ascii?Q?GsnvpyzOL02/tfXz5+LLTR6HbnmOpPaVp/VVuJeFp2nXJoTBx+O7Yp8x5Su7?=
 =?us-ascii?Q?9gTgn+y6jmS/hflzMHHAveKJP55BSLnKF1whcUtZnZv7BNM/q9XeTTwLSK+n?=
 =?us-ascii?Q?vfr/nrSbi9jmr4tEm7viDQiGVyDV3DuLkFCdiXdg5RtPdx6F0LMJTcwqrtqi?=
 =?us-ascii?Q?8M0xzBNAA63I5AM5BOAxGUAzlzoQQQ8oo/PzdcK2A8URErGCGTnZYU1bUJnC?=
 =?us-ascii?Q?A+xDYyLdgNnGSXG6CSIye2u8bhGaB9TqjipwRgjqZTfJChIxd/VFN/2QNASW?=
 =?us-ascii?Q?xxQbwgIJvbQw4rvYWTHsv740Uy2qkKzh4MiefKonZPO97ikwnCTQw6KUnzXL?=
 =?us-ascii?Q?KyZaZ6xUD6jX90bR6p6JIybZuFoFPAeCl2iwGz4JLe6o+r1GPCn4w8EkvIoX?=
 =?us-ascii?Q?lE3xm6kyzTp1E9CiYO0oYT5hRR18zkmID8WokCfoDnPFrD/Cdr5oiYYsLKVw?=
 =?us-ascii?Q?r/Dv5x5xfea+zTONjnYj1aBx2Kxfqwiv9zpOa3c+RCG1yrRpyBnjm+SzqDhM?=
 =?us-ascii?Q?eaeVXrhD6YravKVMxvdCegzvU3YXM4wRB8pLDxN0p3+YlCeFi9+wGQyiQrD8?=
 =?us-ascii?Q?qYndxbCodo7Hm99uF7Nn3MtaDv2BaGNVJY9KJ7ndO4WFJXGywnUduokH/qEN?=
 =?us-ascii?Q?iVZIPKOEuCHnOGwCRmkTsUkXPRz3mP1kgm/yxz6nYBVmZTxByPyTkJgffsAR?=
 =?us-ascii?Q?sJEuoCCN8BTi6IK4eazgx8Gz3/eTO7iQSpRHAxCXWgT57BskEbYsuHC5Yqyv?=
 =?us-ascii?Q?LCfT7pG/gyCy80n4SD3HMynGk26FNWvHV3NDOGkbe5aL1yxZFQjbOGjwPeZ5?=
 =?us-ascii?Q?iI7TIh+c8MmqOlWgISgroSU4JAs63KY+mW4e5tmABC3T8HWMWTm3QkO/Ipmk?=
 =?us-ascii?Q?hNdW6g6RNUT4Y/ZDo0hnkBjS+Uc8UaYkhWJhd81pvyvPzpQQVEGTR0aIt8qs?=
 =?us-ascii?Q?MPoAJMr1piU8DPE2AfL9yTtzPzHb/mKqfP2NUgA/kQRnHTprmsbEyPNHwIdd?=
 =?us-ascii?Q?wdWmBIIJwSFZF+lHXF7I+6xhZH8pplzh0xcbGnI6Gtuyd1CeuVvfeCGeyw3W?=
 =?us-ascii?Q?P2O8cha+OjRxx6awC1KVCKIqsCbc7KY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d79bfa-817c-4fbb-902f-08da334847f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:17:56.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb9LWyDf+LdfKvz3o8/XMceJeRqVYIOIIbI1R+WcOAuQiCNr1t2ZOzCyz8lNdrznCpvyxJjRj03vMQe5ZvuPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

This patch adds the redundant subflows support, sending all packets
redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 74dc832a9d9d..1105c8ad670f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1559,6 +1559,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 	struct mptcp_data_frag *dfrag;
 	int len, copied =3D 0;
 	bool call_again;
+	int max =3D 0;
=20
 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
@@ -1586,18 +1587,25 @@ void __mptcp_push_pending(struct sock *sk, unsigned=
 int flags)
 				lock_sock(ssk);
=20
 			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0) {
+			if (ret <=3D 0 && !call_again) {
 				mptcp_push_release(ssk, &info);
 				goto out;
 			}
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			if (ret > max)
+				max =3D ret;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+			if (!call_again) {
+				info.sent +=3D max;
+				copied +=3D max;
+				len -=3D max;
+
+				mptcp_update_post_push(msk, dfrag, max);
+				max =3D 0;
+			}
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		if (!call_again)
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1623,6 +1631,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 	struct sock *xmit_ssk;
 	int len, copied =3D 0;
 	bool first =3D true;
+	int max =3D 0;
=20
 	info.flags =3D 0;
 	while ((dfrag =3D mptcp_send_head(sk))) {
@@ -1646,17 +1655,24 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
 			}
=20
 			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0)
+			if (ret <=3D 0 && !call_again)
 				goto out;
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			if (ret > max)
+				max =3D ret;
+
 			first =3D false;
+			if (!call_again) {
+				info.sent +=3D max;
+				copied +=3D max;
+				len -=3D max;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+				mptcp_update_post_push(msk, dfrag, max);
+				max =3D 0;
+			}
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		if (!call_again)
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
 out:
--=20
2.34.1

