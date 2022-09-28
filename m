Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BFEA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzd2cNTCUUFh3DeH8+UFq0JCE6ZspIABUsL5+H/xC5KV6miY3B1lbCeMXovq7WoOTp0xJbls+iHnojnGx4f+aIkLWRFIyR0iSn2POrhtoIUYS5bg2lI58NscZdLyyppVYvXzhZs0PeziaUWXfJDVf57yEObetebsLPBtBDPJep3sijCTzIOEC53/WmBhWsMG3E1xfiAgDB61d82aA2yumQxcf/6e3jNHIfMvqu3gqOO9IaKv9RJ1jw4f+DBWSq8wW/klBph4dVCGQSSLUFgQWFzaNSxYQOtnPVAti9Lh+1BHXNdu5o+tmScnhpzJ2hp777v9sNUTrlmzCtJGwvagBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCkuO3Laf3lD8xSPXN54B6Us71k9k8EWkgrouJt1/VQ=;
 b=jc0g30AjWAknFyGIkE/Teil7pA57sMUxNYHOKdU4VD4C2fn8vM6yolyVolZ0piIWT6R882npHthK3ihzrKHM8+4+DyIFnXGuEoKB/BYy/f9nQYLijo/ku2x5CnOWKrDbrugOXbEluTMVi548SA01f+rAD/QuVlYc2gRWzVVHPuevhRCR3fOF3beN2sqFJOIuZuR7ZUU6lx3i8xuQWBvTa26D6tBZ/gXB6nPbnknv3DdU6JMELbeh9whf0CY934rbpcRD9KEItTEvhr9+RsP7lapix4s1g43AXiBY8FX6zRdofaLuoAFDnwZJPYORL1B4Eot1v7hgb+93MqPp3bHttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCkuO3Laf3lD8xSPXN54B6Us71k9k8EWkgrouJt1/VQ=;
 b=P+rMH9C6scA0jgtK/S3MzWHf+fdPKRwUlWUvZl6knECUZv19irS6M0o1w56CLtIx9WTJdUgCCKo5EjlscIWUyWoZJ79eyY+ahBhWIsXRk+DuVaBMAUEHH87lVcoLq1QELeE3hecCeOdcw5QXUPPES8tkoRF8RBlUEwDGKVpcCJGbDRxJqChPhKDJ9lvBH3hgo8W+YMgVnpLZ0A5sop0n/TWUcwApzpe0XmaOkuWyy03FVT2OZBISmkgJ98uSI8ZrvwN0EilViJiuiczq22p6rZ0mrj1UC2a9uJEWlz60CZTCi/YS3M6Oqln1rW8A72ihncpEZORvhCOtudZdDKWx7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:47:43 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:47:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] mptcp: add do_push_pending helper
Date: Wed, 28 Sep 2022 17:48:04 +0800
Message-Id: <7966e127ebfcb2feff439464845d9608861f8eec.1664358100.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664358100.git.geliang.tang@suse.com>
References: <cover.1664358100.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: bf464105-bd6e-4f5b-4be5-08daa1367dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eiI+i0+edBVpBsMV1dztMpEJynE2K7UZYKgWCYuJC4ASTHY30SF1zDaJEeZYSr/u/PZSqifYMKnKvWPDx96IWiWrLzZ9UJxMGt5eyClbLhVmT3cUzKgQcln1hTjZ9FJU2UuzKoixtREnK9kuRULVa2iuiQ08CQYTRgRrr7uPWDzDmquZ8Puf4ejLowpiom4P5rJdP3DcLehV0MsoT8J3oma5HnNaummEWgem1rTuUKUFePs4b4tbVlU5BEJ7bO3OlHcks659wcE4383Vv2vPT+4s6ubao02Ke4zQ2ZuiLEUn13PlrNrXtJcmjlBWPTtCxJTBWmGuGPWMm9hEb8A6pFtF3AJ7mEhvWpaXP6Bf3Ixiqr62UsnPBd/uzMENmsni4vn3kNR0zsq1dKtpvEzu/YCAhxlSprYaCzr+JPUNSjpDgNOXYkC7XbHUY5XUI/xuyRo/6rFb4RyXjdefhyIxZAdRwsifRv22xkRclkba8xbIoslJeBzqtPHiuiZakxW+e4Y8/lFHoflGP+pR1X3899AoV3OUvajW2Vd9jnI8Etza9s3w+eFrUSH5YayvQt02XTOGHjvxoTvNdrO0BCTo+mu2pWnKM6Ljhre1X+OFjHHn7Tge6P9s51DUwmBpT+eOdXMWCiieG8JC2tlr/CO3aZsFWEzaO2IwutM2FKxvWsgX6xMkCdRImP7AH4vQwEBTvScZ6t3DUXkv3Aicxq+kMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(26005)(6512007)(6506007)(38100700002)(8676002)(6916009)(66556008)(66946007)(66476007)(86362001)(316002)(36756003)(4326008)(478600001)(6666004)(107886003)(2616005)(186003)(8936002)(6486002)(44832011)(83380400001)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VzHZtGAqaKNdO1d0TFqyR31MtxXimcmcY5xJEmnF2OBEuxJkGGkH00+urCc?=
 =?us-ascii?Q?sgK3xi589RPGEEtTpDNeHwME/FD27P5wUbWMWI8St2IMCKa1/2+3X4WgIchu?=
 =?us-ascii?Q?sNu942Vu6XrAKqRIJGwF3+Pv+w5DOeHaWgYsjjenxTrAXqG7SFlp9df/9Bfm?=
 =?us-ascii?Q?hc6aT+HEcCZ/XFAwWqlk+E7VawvF2Gn4FvsQBIVgiE1njd/upKhiSjPcUefq?=
 =?us-ascii?Q?kRLaHm6dXfI0GZFRYf29DFlK6baYiVv6m4zV/fi3/KQiyJM4CdfK1DkOJcXh?=
 =?us-ascii?Q?UfuxU23LtYDWhi0PyZ1Rc3AFMd9AcS1i1lvj9g6v3HdQD/ivli0rGWJzFkGu?=
 =?us-ascii?Q?IeUP1WhT7aW1hBf0ogTXDUAikYt1oTaF0knwCQiKHgUCFlbhh7+vr17588qF?=
 =?us-ascii?Q?HSu77XySIbcH2bz7SBNNuOd6Qtjf6vFNUnPNF3ght2dEPqeddTJqV5x3fKvu?=
 =?us-ascii?Q?Lf2Ay/ekkyiEq8b2fqJIsL1KuDUS/Kft8L2EzW4+UtY1eUFwYPL/DZUs83DF?=
 =?us-ascii?Q?3p9Qyn1tDB1wxBXKdXHiFlyvxF0ip99vN4bkcTiO+k7JngcQNv40QAAPn6P0?=
 =?us-ascii?Q?9EiAUwvLDEyF+NXcAluYcd0omqKq7zuB0j32XhaL+fE32vMq7Q/u4YBvAJLB?=
 =?us-ascii?Q?Tgsd55IEUp1mzZ3rD5mdmRVHO/uwUaPl5kMeY+Ln6llGvbphB1EzG7BImR2E?=
 =?us-ascii?Q?wZ+jPgQSva5Ucc5LRwi1YYoFksXGX60A3FkMG40+CvH3ny2x1IoSisEMbfZu?=
 =?us-ascii?Q?GVAcUjft/gpTyAgWkqqIekv01b/fn0ZkImclbHGUEnXWBRsuYNBO8qg4xx3a?=
 =?us-ascii?Q?wFcRe9EfWdzDUjzimI+WIqokoILuGwcEsUVkEPzeRp5Eo4hb55YymYWUxdtq?=
 =?us-ascii?Q?GABkiNu5Y6ixmaHef0QldaGDlyrlJ+qtLsQdSRp8IaodYxzcvHgzD9VK7Vt9?=
 =?us-ascii?Q?fWBY6vrEh4M4HEXuHOzLzcCB7OVJJg1qQX7tjgHO3M1AaJFkPx+/0DsfetVF?=
 =?us-ascii?Q?UgfCgU7MJ5s03CxvlJcEsJPYVP+f2BdTBshd+rmEDvmfkC1iOd/wI6EaCA0f?=
 =?us-ascii?Q?Qyl75KTj/UYQ9FGFCuNRz6FbRyt8lWnKWJrzjxpizU7ipKS4w5TAC9Shuatu?=
 =?us-ascii?Q?aDyNSophlLa7CsoSowrlQQcOYnGs3Yg3avwhm0WjNXGq3p5d09Hi01I8sGq8?=
 =?us-ascii?Q?aTtOGxrFHbgju1i/2UFnyRQiA1GpKoz01x4ZYYr4R8Ry+z9+SV803rHX5ZWr?=
 =?us-ascii?Q?4ZdKoWVPkE/8xykdaU/1m4jVgMY4u2awqHk7HdEztaOCVBKUsDtuJo/JLznW?=
 =?us-ascii?Q?KCSg5si6lcJ/v9Dd9agPk6GOVsiv50f8014Qt5l/8gZ7AoNO03PQQ0UZxQMv?=
 =?us-ascii?Q?EWK78a5gmIOfKZ/YjoBJ44HG55fn+TQtvw8TmYlLOsiCQ0FEvgDNLmx4Ck9x?=
 =?us-ascii?Q?270Mu+UdNionvJTVgpAJ8A6auMeOS1hGySpqFM53x3a4QtOdcOYjj53uRJqC?=
 =?us-ascii?Q?NDlk0gByJ+D0qGoA3D38ds19bD8z5NSmWFRzRSX2tjht3hBc3fI1xQnB6EMD?=
 =?us-ascii?Q?/vtUsWFhNPIm/LJKK4Qe97itjuU4h7pcjv2qgLMk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf464105-bd6e-4f5b-4be5-08daa1367dad
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:47:43.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuSmUxSj6DNL61Wvk6wApK0JTz8QIkqsjM3QqAGIsFGFMylQZABvJarTy444kcBUB5mANXUZgOjvfn1S1lgqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__do_push_pending(). And simplify __mptcp_push_pending() by invoking
this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 65 ++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fc972d56926e..6a20a000622f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1491,12 +1491,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1528,43 +1522,29 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
-void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+static int __do_push_pending(struct sock *sk, struct sock *ssk,
+			     struct mptcp_sendmsg_info *info)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
-	struct sock *ssk;
-	int len;
-
-	ssk = mptcp_sched_get_send(msk);
-	if (!ssk)
-		goto out;
-
-	if (!mptcp_send_head(sk))
-		goto out;
-
-	lock_sock(ssk);
+	int len, copied = 0;
 
 	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
 			int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
 					continue;
-				mptcp_push_release(ssk, &info);
 				goto out;
 			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
+			info->sent += ret;
+			copied += ret;
 			len -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
@@ -1572,7 +1552,34 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
-	mptcp_push_release(ssk, &info);
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
+
+	return copied;
+}
+
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sendmsg_info info = {
+		.flags = flags,
+	};
+	int do_check_data_fin = 0;
+	struct sock *ssk;
+
+	ssk = mptcp_sched_get_send(msk);
+	if (!ssk)
+		goto out;
+
+	if (!mptcp_send_head(sk))
+		goto out;
+
+	lock_sock(ssk);
+	do_check_data_fin = __do_push_pending(sk, ssk, &info);
+	release_sock(ssk);
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.35.3

