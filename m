Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265C7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdaGYBGAwv90LgGpdeJ7zOGp+ilYFsKRVp7Fr+WpjUbZ+MM4ulClpo694Q8vYrH/sqirqzIZbcJgb5PNUEMxu4KKZ91qEqhBnbl3zOQQtsPFZiHBvddouAYyXAmn9JnnHp7G8+You1urBMh44MD/yR7rQedfzwd8bON7EzIrbPxcYFAX7S1tkzeILvadIHgZcYF33+tgJw6qhFH9cNl4U0gtAzGPu/Hy7oKIMHqmqmZg1yof8QzEQBrikEWx7er2K21zy7fMq8x64nqurnn8s9ZGefiuDHS9LA2aZPUw5wRBAHEUG7jddViwONxgbRaAd61/lS5pSHFqso6HqJQ/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPBu1o36lwfR5uVG718Dj9BOPO8IuxUg7FoBvkr7R24=;
 b=NVc3OSSLe22j34fCB1iBuaRxtFImF9hCgi/moe0dLeOUN15DHYhDMaj3GSdNBO+xn43jDyJWYGRJa3PQoar8X9TfH8nEGCohciYYNPF6ZWtLg7cDMZ3t8Qh+dmNOVSEPQ/PP8w/lW8OMUGeh/5mVUUoy6iXE50KunWAtufIzzHmhcRAOxb2pFtQg13lxxR3NeY2VNiY7Mh8ngVSWPrEGPJLrc5jSQSUjhAhokpIw7L5LWWdCN2y+UJHXHqaTJzgUA1ocBR+BGia8pyeKMT6LZOnQBmtsAb+PebjrreBFxBKcEQkhWfykgyRa26g+OtmPcz7VITvxIYkX3SN/TWOoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPBu1o36lwfR5uVG718Dj9BOPO8IuxUg7FoBvkr7R24=;
 b=zKpzVntqZpBCQ/zn2fb6C5uXiknEClCii169bzUP7khShQQz5LssIQ3oK4w6fUgRRQz8EBJkqvSN7SkNCpo7k3oBSubMci/wt4prZxs29Lb+rmiiINcjZqTvGpLuh2cr70kDoKHujot0FVVw3VbhiFSytXIyRAGykgJKJK0F7hqfOMjYb6V+2KxLthz/z+lphmCK7rhj1fCaDdBRXjL/x3PUakBj7MYdxfgmFyhSzxkQVGL9dhd0NRFvRS8dIZdYKCcqVYwc+P2NBCOaRWjqgARjvND7dfzqU3OpwO4kOjE7z/yDVZbTuOcDET5M6vWCDIEiLYqkmsmFIMSwO/NxSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:02:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:02:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 12/19] mptcp: add scheduler wrappers
Date: Fri, 21 Oct 2022 19:00:04 +0800
Message-Id: <6165639e655a7b13a6843528c9b1e2a3d7d28b97.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0225.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 3557da2a-d81d-4635-c9e8-08dab353c35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p4F7OzzcKyoxL9JoukLQ9Jmx4gsSaq5wRfTiD/7eHZ+uwOEx17rfbsavveAe1zyFLuSwfTtdAY7iQduhel8/OaIo2FOQqAHixYavF/l0ZCTZYszYa4ZSpexaVXY2bgO00fLouD3xPz+dOZ+aU0x9Q1Wp6AinysLJoXfHz/murAPdGw56XLEaIzQlw2Ho+CdyQR526Wcu5Ko2EPIeAyYaASs053r8Av/MniGymS315QOIr31/rVxf2RHWme9y9hsvt3+QZNIwu92+XIVIwxKC+exI4I6r64JdvfW5pAEIGMk57nBwMuNs6UoorSZFx5kGSt+OvS7OrHZeWb6Mq3/fwneN5fN5ps3/x7mLgszzIEMyZLRLBV2Z6vYA+fGhzUO3o4EfJba9LWEXCMHqPn3jon9ze70/57os4x3Je3UjI1Onnf9UqXjMTMJZ5dTkjjoJN3wiDg4fHYPX0kxQYcQtDWc75HIj2spqv9RgbRHCu3/4DFZ+XQ8zw2PaCPRDXHbUUqPCRz9BqPAVunFOWuoSgLata7RNbWdsdRpFlWrLFOGRNl92rGP2bFIV2eJcskGJ6eKxN6ipgfjFQ9/VW9JlIRjAzxhK8R6hpI6k2pSAPQEGQUvzqw5FvVsKYfJIl0Db7KVbiMFqXK2ztSVqcGykeG1zTLPqahDmSjewho09d6MqMtaiz71HvTrI3gxPpcvxcCAFbBu9zFNDQ8fAI8zk0n9opkzhaeryzdA3owjGqeyYFPeCYAjnCDqI9OY26tFL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(83380400001)(186003)(6506007)(2906002)(44832011)(38100700002)(86362001)(2616005)(4326008)(107886003)(41300700001)(5660300002)(6666004)(6916009)(26005)(478600001)(8936002)(6512007)(66946007)(6486002)(66556008)(66476007)(316002)(8676002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6O6AIT/x3W2Qn0aSXAxxoxwy6Rk5Agkc4Bvkuh0+3Sb0R+mfVSao0tJEhcRr?=
 =?us-ascii?Q?lnwC8fu0kpgdcNCXN7gheN7zkJdfDneK9cFew2thHChLZ6uhbE5gIXIZdpmI?=
 =?us-ascii?Q?UQZDxO3X7w1ZMTEoZNGV11rCEgHr+E3ol8o7m1Vfx0w5hUfEoq38b3v+4uvg?=
 =?us-ascii?Q?tVX33y7D0H2o7EfDrfSxIZbY+7dD6/P07VJ3VprZOQ9WtHdf2to0d1grJPCh?=
 =?us-ascii?Q?M7WIe4acQ8l6nIwld7adESulQDs33mq5MrOTmgFu9Vc/in7CUJeIhYHH55lK?=
 =?us-ascii?Q?9H8uBrg7970zLK312RBG2yt9OgxVHKwu1ArsVe/CwzHNNppAZSZbhtmOInPp?=
 =?us-ascii?Q?8zB286zGS52xDnW/EeSVrWytoTTVnqA+toXkYOpOmzPAY+4PK+4YJ/spG+Et?=
 =?us-ascii?Q?A3CBUmdQWSvWE78ANeAmefC/9drvuAb5MXRPNpPjuizHqoe4/j339TAtDuuT?=
 =?us-ascii?Q?RuBFq4+LLb+lZQmVibAeU3V8HCIqMb14omtBtspCO4RNBC9u+8NQ2XwILpQs?=
 =?us-ascii?Q?kVSSxasKKAxkHH6yVfyqgNyyp4Ef4PA0anEpvmd2YMwoxSx4IjurB3x1iCyt?=
 =?us-ascii?Q?+0lgVCc0bZvSlIYs1LnDKczhe3vUJSQBjIhuYBb0HjnhWzjQwsduuG2Jsg/j?=
 =?us-ascii?Q?2VgHZBKbW34O/KwsDgroNv22IZLU9BDDgsAjeITbafynRYlWjM/3n2p68tlC?=
 =?us-ascii?Q?0jVuJii5mNcsPbeubJr4xLSNoaHZ27mwuVv8EZ54nm598CLId18uG5BbBB0M?=
 =?us-ascii?Q?Q/YA1DN5Atjvk6tbrBrag+GzJk1+feVbSFAeORCnvPwebvrMbd1DRlnVKyRK?=
 =?us-ascii?Q?yOcHN7laphW5zlSTXUR/Vs2qND25X8Bds3NvoP1lTPzgMOPlfrSH2EfuXoWT?=
 =?us-ascii?Q?LD7qRBGocjd6S3LdKyXGoH2nKLyH+shdvLxkPs6soRZEQyLNu+cFfThfgECn?=
 =?us-ascii?Q?EpwUv+I1ceHFQa3qShrNBr4YdGpLxJJ0OMSd9Sm1a0t34+Y3QW0LoaABVTOm?=
 =?us-ascii?Q?ysLl3/d6rgz8197bK16Zj9GuTfKWzuuhAsKWmeWsamnO88LAdqRZpTXepkP6?=
 =?us-ascii?Q?zOUaoq/qNNcG+pO0ornp8a54IDjBeSB/b+lSnPhr0fHcUGkM0o3PzVRyQVjZ?=
 =?us-ascii?Q?8P/gtqB3Wyu7I69ke2fTTEciQ5bVAsk/NvoLyyECrrjeg0SbkrHPtx5dumxG?=
 =?us-ascii?Q?YsGeaVFEOsIE/tTCX8aSL7jah9/8+aVYMOSzXXuRLDsjLZibmc6ht265LYHa?=
 =?us-ascii?Q?IYavH+IJFwDm7oX8WJ7XUTXSK6zWhpCG8WejGXu6ozoCiyv26+ln4KJdrwsv?=
 =?us-ascii?Q?zvuZ/NP+j1dvF+4xPz3MsFdQpklT3NvQ/I6xSPJ1VD3442FdfmqzWefhmE16?=
 =?us-ascii?Q?DH9zBQ1GLFzx0lbea1J6K05KyIRH8NUObzOIIKOJUx+rzIc0fBjusmTm4dE4?=
 =?us-ascii?Q?sKDjr9DCni1RZHLiDtID3EY9wqa1U0JStdI4wShQytZXWAaT964QFMTF+Qzb?=
 =?us-ascii?Q?5rwydHvp2fVJthmQjTe82wNBOuIpvKxyIEe4bDCcxYBngBnaAMEyx0/K3Ftq?=
 =?us-ascii?Q?liKPNsaOhxNGVoRKwKrHUDNvct9Y1CXUdqVCvNMm3vsoi/mc5CFJI8mwtVST?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3557da2a-d81d-4635-c9e8-08dab353c35e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:02:37.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIbPvjovVkE28zRgs0Uq4rT4MPSGt1etcb/4ToD5iYNO+tdPBmFymlmW94qwL5l3+FhiECL79Ug2N5Tp2xIocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8245

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Move sock_owned_by_me() check and fallback check into the wrappers from
mptcp_subflow_get_send() and mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 14 --------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ea12a2e1f96..c55e0fff6a18 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,15 +1417,6 @@ static struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -2228,11 +2219,6 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e3e113e7f957..74e4097f9ddb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -639,6 +639,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 500ca89f6424..83930a9b9059 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -124,3 +124,46 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
+	if (!msk->sched)
+		return -EINVAL;
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched)
+		return -EINVAL;
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

