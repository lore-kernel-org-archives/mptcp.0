Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC7194
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 12:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpW0QN0j3Id07OX59XXZVNm2+urL+A7BZxiYovzBMvciiGJD0xbil3NMRK3/QJvYkyhUzEbs8LVNuyJuyYBQh0uPDI4vHOdJXeoNN1tQEDMObSsOqqHatIobvkfSA4HIrQukPNvc1/XskjQ7Oi0jej9hLcX8D2eButeu/jlDjhmOS1WeYHx8AVVxENy9JXOLf3rjSElBZ8WTFcouYm1ltOAyBDcdzUmYchq8taNBiPepndetwVxE7sYJgOemugJZfeitj/ui6XXF3hBwWtupaxVrmBdZhSpsasgNCH2ZNueXncXhOFl2iSypzxTx3FJ0KaRH6HS1grV8biaqaCs5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hStRBQms5r9S3AbR8kt9tPQrTr0D90Bye4gEDleyFIg=;
 b=Fk0Y7gwjTZYFJ5t9Ia66cBYf7vZlEEsIQBGB6yVssAvD0fDkO5LfKp7vXugRlm4JA8/Ci3JrLbL9iuBL3wPKGI6FXGlD7/Ta7OKS2fnbHYaT8D+qisYVFAdG1eXOeBWTzSeKUC36tSP4LN1989GdVb8x7U1Va1kzWu92SJnWBGOWeCqTddjdvf5MeFKWFarSLWNeSrMP+uzUYSuEKh1eWBxVPekEnsqBo0HjeuUh6L6Emqz1ocLa5Ae6+eFbP7qLfm5L85g5DMZh3ZHTfdILlHNeVHd5488L53YUev0xJ4/vkUpGwFMF/RS6Xp+A3vJCxSobjOaNumxXyBJcTTJZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hStRBQms5r9S3AbR8kt9tPQrTr0D90Bye4gEDleyFIg=;
 b=M2jI6T7pGVAt44Ti57K0wgsc42Hw0XasK5W420QQNuk7CI1rR3SXasdSOeTBiBbi0wJbGhMNOs/ahLMTt203HJAKRHiFTQ8hmLN9Z4CZ6xD8wXRwNz+qyFSxoyMXB9IK5MftNyNCn9/fN0xZQelXwLP01wKK/9usSI0mkN97Xfj9B+tEdbfLGj1zO9f0wnJ2JAR6JyXvKJKEAvoGB07VV4IJUm90gNZkBWkimHOo1QW2q6DwYXONYscboe1mJlmxI4t4WVO2TIsA4VdMI8SqSluSWKxJfn6GlVvJiH6jHbNJ7GO0PLFIlnaaJIn1unfepUVWjtFrr+GyO/iFbUTmHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 15 Dec
 2022 12:32:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 12:32:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v25 1/5] mptcp: add scheduler wrappers
Date: Thu, 15 Dec 2022 20:32:39 +0800
Message-Id: <13b7ef70bf5dda8f5a9e14b180716ccfd2f67f0b.1671107241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 508d1197-476e-45c1-3ceb-08dade9878d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DA9e+PVXH9G3FczkeH2sGvrnSotcWXvhilBBwLG6zC+oCxAx5G8wA/MKOOiCqllH0YYpuM35yRE1CUv2pR5yWZ7dlvxqfTP6xdNUlXdVaU/VTI2skUDs+K6himBP0lzsHPQkEq3MxlMv7pnzXZjb9CuaY4IDey6T9ZNPj7LSHzFm2+210ud69I86KC+v9TmImMbKq2UcLvnQP1VhFCrYRED76LGdzxH9GInaT2UtXgBnuYaBag8zWSYsbkJJUPE5xHcIZ96PtUvyxZ+7ilWaQEWvCnkQTtN5iwI14zS3+9Yo0AiEqsW2v3lN/EOgtzzR8WDnJ4SABUuEgHY2ouOloqbWtfELgKLwjzhdNucOQUXoDxSY9oSmjX9QWBCqGjYqqcflMXKiujch6lURAiBGBgu0/qodZZgDfr2Z4wD9FMQX2QVGWTLIX1h4KlGGsWTLcqpQiU8siNNFESJZRdZpu25iun7xyrQqMaaFvNyOLm+q+lDA5eGJCkDNOPO9GKfoPy3yq/Uvww7ayRwyQgdnxHpaWxxszLR+1ZbPlQBuocL8vZsySsPYz5Hvy/747QACgFOZptt1xjy5xTAfw7Y3YLju89srtG9axPcu6AdfMPbRYBiOUx6vgg40phy92ErqZ0JIV2pr/D5pTiWMC1vd7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(26005)(478600001)(5660300002)(6486002)(6506007)(6666004)(107886003)(38100700002)(6512007)(66946007)(6916009)(83380400001)(316002)(66476007)(4326008)(8676002)(186003)(44832011)(2616005)(36756003)(2906002)(8936002)(66556008)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2ATNpfCg+vO1zgrwzrsbyc8vdY5mi2QveGJPOJTXtcfmPQWGkno32imnn+k?=
 =?us-ascii?Q?1PWySRhr45CCfm+FkTtRf5buvTT3zh/zRWybtedtvf27Jx5ZSwwbVMYX5v76?=
 =?us-ascii?Q?rug9sFEvZF5gQ0Lu7buxAk0VauuThyWO0WCPWTc7zqO8A2Qr2xiyRRAwBe8d?=
 =?us-ascii?Q?zYzguZ7yGSE53D9+08o3LDiv+Y/KKtTkg4+z4YUyAo42D61VVkmxRYa06/u2?=
 =?us-ascii?Q?GbqpOWOVFApFsvsYpOFOL2VZic00okNrO6FgXH67eFCFUth92pJjY8zIslcr?=
 =?us-ascii?Q?t7gY59QZseFa9LlUARaH3NTs4KOXYPcGF3V7m+1jJcFqTzruWoaH6e2Fvg2g?=
 =?us-ascii?Q?6X2N8xDXkhQFw0ExphfkF6DYNzMtqn4RmAUj2/mWrSX7XiSNGS8LKy3AVmSY?=
 =?us-ascii?Q?qLy3BoXXmLodNnOV7ZaaVnJQdyOux6YGVRpASKZxAD/w4o47Opd9147pI0/p?=
 =?us-ascii?Q?qHwGCIazHJnyI0QgJIfgvvI2PxX39n+rcuw+fquvtQY56jV010ZJfUxWMM/S?=
 =?us-ascii?Q?KZS6NFsiw4+mtnvL2NBCtT7l3RU0E+/9rg6Cwp0NICOlphClmmSGL1YT49cR?=
 =?us-ascii?Q?8j9Gf7TWh/yF4LA8vuB4m6+EO8pTXMDjyL/N+deHbjbwreQS7lh9YcWspJYj?=
 =?us-ascii?Q?OMd+kLD+6WOtp5ARzSbZyXXtaO48zCJxSSoivnGWdKXCw8JLUdELz2CNPtGv?=
 =?us-ascii?Q?kKL2NBLEy8CDTX4D+apIGVfisVBWDvO2PS0R+lthU3VYBRcYV3g2WJFCnY92?=
 =?us-ascii?Q?AZXuGOD3+wUvl+c+gdWVpwcA9zbBkj2j/Pd1oh0NmPQRwiO3CvzVRMnmOBtz?=
 =?us-ascii?Q?ajJbgRtqsenhUpY3GqclTYgLHPrtyCMK83ZpzLhq5aDr42x5h3ETIIZ5LMhS?=
 =?us-ascii?Q?u0LOuFahReCcYUEc1vWsc9j4r44fBb+zsyp1TFfygpmrOkShNyfEcl2ffWRP?=
 =?us-ascii?Q?3rtPfCEmMJg9SVEh3UAuo8ojiuZhy6P/FxxgbIUgNyENQKXIX4+LG8tNLjVf?=
 =?us-ascii?Q?x/NhOWIHij8hpEC7m2inCx2w8DGcnpp5OkiIDUkv9CVHgVO3zr9nDvPI/99E?=
 =?us-ascii?Q?/pBtW+BwhcuZW09C/9eucIjiIlNSPFksIsyKbfhiu1YBJNxPyz3F/FXdhMkE?=
 =?us-ascii?Q?S71HFivlEYuf7O8osjY3akoXrHelLT1IgWjjUMCNkA0pv9706P41LqT9BfJt?=
 =?us-ascii?Q?3RYbAtFzWpqufQJ2WuS2WtK0QVb8+sTbDyi2zjF+BoEeh+ETndpDTXBkgQaQ?=
 =?us-ascii?Q?N9GmJVbJ/bw1DraEOqmEalpi/E3rc9ZP9jHG17yOGyGSqBjAqPmxpV5KRPTq?=
 =?us-ascii?Q?Et11WawyQZORZCIeIt6eJ3srZ1brhz+RIOSYfGHZsOPgYjfKGGop0h7yyI0d?=
 =?us-ascii?Q?+SXrwmqhIukp5nmbm/Mjp7cEpkGpRArUUvaj6ZDslH9uSlE5wJrkVBcAYDzd?=
 =?us-ascii?Q?XJXAhPUregKYl9r7TP79qgHFlPkp21fRCvr2mWr8fFQd+VXKHfc25dbnyt1O?=
 =?us-ascii?Q?roCxQN0kg0l0m11SH23MF1AEWQrdV/lYS/y0Mav1AHiPA8RzRssP9Ys/Br3E?=
 =?us-ascii?Q?w5qMWEr2HFftE+9Rlmt/8M+HqYJkHiA7+VlDsVWDobPuQCYtuL8sMV0WwntU?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508d1197-476e-45c1-3ceb-08dade9878d3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:32:47.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnyKKM22nMXn4bfSWERr6MPQQYw6Ga6Ab2hzEtepizeQowpBoUhMWHrzOKhZUuqUMqj2GYk//LKEeHLZ0AdVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ee39a16d9a8..14c69a519898 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1396,7 +1396,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2216,7 +2216,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9ff7028fad8..ecb94ce68ea4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..c4006f142f10 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,53 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

