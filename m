Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5E7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rej5vDdaNqrWmny/8Foms65BpXmdAtlakv0VYMyre6Q7sScqXOH9Dmvyjg0dYt1/wohVmEBzYcUDHi543G2iSfTdH935m0IYioDmG0ljbXvb8p6k7t7YYSlI2kHRND7lgdm5uC4A124WSfnrYW7CbVHFI1h/o2EXfY1B1IDKPMDKkgOs1yyWoqeH/ZEiud6HgKVcTZ1G2aCIsMYlseRpPnJa30DRbudm2qXfO8yiZvKq1mgMeAT1lmoD1F4UlyBQPb25qxJuEKrSXKT7advCtyU/N1hqROtk9E/Ab98qrmoDAXuiznnVdZui7T8al5Fk9Zjss1Q5rwiUWkmWsWI3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewbOjV0YLucOG848gtJWkMF89CkRNFDwQ43sSm3nJCo=;
 b=K2zOOK4dRvjd+0ZShC4XygE/yc8/M7fhei+Dy1gkmey8v77HHvgGTF4LZFIXrdFQ8nXUR2QVvYaJgIsdQFF4Omrmb9i+1Kxa5tfrWkyR147V7aTs33+1iWaR8gxQmlk70bQnMC2MpPKMBgVtKQWrxjYds3D+9Ed95xD9FvI7jayF6eJgy0brr7UlRNEW35YfWfJRY/gXmmPOJcnuw3VKhZwW9czCeXJJA9DQV5AJ3NdJw7tWtyKDlY5pVu+R2WmuZevBr8q02oh6fu8q9voUMsUhyTxJYc8ov4hiKXMlYcQhc0NGWHUfC4cAcN2BwNLEgJsMiA7Qk3WIKW8iFoMg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewbOjV0YLucOG848gtJWkMF89CkRNFDwQ43sSm3nJCo=;
 b=vjwkNCiZkRLNoOhA9hcmt0EQa6gJHTYxNvY+fq/mRVwhXjQJ/lE7B5OcJy4ZmoZzXV8jfszQMAZRvcWPQjnKTbkBtk17JXxd+HKxhSoRO3g6FHllViJJjNTVMSruGBwm5vzbklRHX6sd3HT8H0nYsGlskoGaVm63PFUcSsF5yvPkJVLU/STn6ISeSKasz4I8MUPsdP6P7xLdRKpXXYUYAPJd24Xj3JGQPy8B5IxRXi4ksms4j3vILRFJ2+nn7nim0S//f8F1agK8iIkjvyUCNEFj5An2MIjXlbrQYETmkjXHeUoPoGXHNSuPD9aaRzROQToGvHtrWC6JVNbGAraDcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/12] mptcp: add snd_burst in sched_data
Date: Mon, 29 May 2023 17:17:19 +0800
Message-Id: <2fb5916782cce004936fc35d88ea79831ccc2f2b.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: d05395ac-a2d6-48ab-1a6f-08db60259f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pFPPkUp5B3bd1vQyJFILHPlP8SMsHIpdk85fkFY4tOdlXHXcU78aFajPJY9bDUL+j0DtOV3w5/ixGoggtzpO3AR4yWcfQZkPY+iGTG+UFuxZIYOgBUWPcThIaIxJcr2Jhr9qF3l+aM6EStU03F6LtLdYmqEDJDb4zV9AbY1++dhASGYO3xhi4gFLMwYtT4+PVTjcq07xTdlIZpDKELDxJHhZ8TPP72h7W54zP66pwt0IrXeejs7IRqmO38Bw5moSYAyK5f5FQYo3IYKyPxiasQoesqjTSlRbZejJk9Y8mZYameVtqvAbDHLd3WZ0Kr6mfhO2cz0X7iweNMCSbWV3OFWHJeHDqaan6iDET+3wcA5WitnRoCH62UFnjvQg1ROkHrWksRMcZwIdzIep8Pi7s1W540m84GMWLVq6y0PFkl8LoW11vp2SfR7ENBQ0VrZsSXjenRDOoQFHFAlp8GGX6UasRU/qauwvczVg6Xumnqcv+OPvw743/Aso1UqEfgq6+48wqCM3YrALdKdr3PyiYy/6/hn9IbjMbIvtJg/L41+G0TAxkVNhuWOH0FflnvgG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIHtN/rvF5hvBPkFTNeBWbKysPzUN3wjgce7mtPKnBDp2eGF3PGwIiQ6bv2M?=
 =?us-ascii?Q?WvRKTtEtIYLG3cKatmw0I85G5YV9Jy+sE/PcgYNeULSf/P0pC3K8tbLcjjTu?=
 =?us-ascii?Q?2xoTEaW/uS5G/Pk8pmj8/ogveJVVsLtVHQYnRWwyMstuaAHfBjRB1hbiF/+T?=
 =?us-ascii?Q?5/aFI/ySpM26ndjboexbDm8LdSeBZBo7K6ByocQc+556P9FmuPj6Pbek8sYJ?=
 =?us-ascii?Q?H6c8Xdb1jOl6CCwtvfZCQb3G2QUt3m8XUdMHhWM312O2h/xt1AZSrQsEmAwa?=
 =?us-ascii?Q?/g6GF1prSEVt1BtXmTW62ZT/E6BD6Im5jOKL69ZcymvkN0TGAZEAzobFJo5n?=
 =?us-ascii?Q?3gwqoIHMJd6Ov7G0bx9lE1gmhgOowmnSSXwTQPI8YDXNCuRjXnqGsI5uLbHU?=
 =?us-ascii?Q?+ICGEiOhUm/rEhGn2tlXiyIjVuBhmzs24sgw7vOY1g5R5LznxYR4IKJpkwWR?=
 =?us-ascii?Q?dsoFzgEuwJKn2pHDhPqIjnYMox0ned2c3Bxp6a96LXAnH/RlzfWp9MCIdKzA?=
 =?us-ascii?Q?PeRt96bKpuK3lR3vzJNnywxtkw37g7ixSnZxqmyYdGyoN1oDaBBg36Ef4ery?=
 =?us-ascii?Q?zin32yxskAbkRazQz8GQA9Nc+HoLlaJopmlFNer2nCNHqmy8oCHAZmii3tr5?=
 =?us-ascii?Q?khZkPfwRzImrk2B2ZUoiJgOu9SnqxYHIIc4jR0jP+XkcKOwFh0eOc5Be7Xu4?=
 =?us-ascii?Q?kssZ/ENC8N61gPasonBpn8Ea/ONO8dkdE7CqX5FetyJ2uzVodJKxLBjzDZs/?=
 =?us-ascii?Q?lKrhfQAV7yIBjjR9piqpvfA66XUkNE03x1odqIG4QdY0zvlqaXUKHbN9aJca?=
 =?us-ascii?Q?LNNdv6S4amgNqU+r2CMKnx2IwpuR6w7H+a3a7SNPrgQ19OHVE2FuvnurAmZX?=
 =?us-ascii?Q?ty7Z2aDF3w4HHGWZcCrALdLcJ52JvP8U3IOVXGxTO8eKTSI7wHkTt5+slP8/?=
 =?us-ascii?Q?2nQCMUCkjtKpzN4jHHOw98ivJMJp22DG6Kx8ZY5EUXGCak30snyupDRsAxfn?=
 =?us-ascii?Q?01z4KG0noJFAWGidi9b+v6X7W41D29G5m+wlihbqWZfc0GCLYWUwpgFkPBAN?=
 =?us-ascii?Q?/xcEwBCRe5FxCNLfimjZ9UrLqHYeyVXMef352IqWcIybxNAoh+HqgQqVX/qG?=
 =?us-ascii?Q?dZdXvI/uCWLL1EKgeGmZZou0/ACDK89nCZjmPQZPhApw5CyOl3X/Nt4duht+?=
 =?us-ascii?Q?TbZV6WD8vJ+FcFAL1mTD3OLiyoOlO/c3pm79ISIi/Uo8TRIvBQF41c/C/uBM?=
 =?us-ascii?Q?BZ8/8Fp+wjGBR8VKx6EL/JBwkRsFZjVrvffq2LSjbColMf1MysFXupMe9CJ5?=
 =?us-ascii?Q?L61ednBWxyOKEHt8v2TBkAaCLvTV/FVKADjAb1ZMigsU8RR3bEsPS2TMUVCF?=
 =?us-ascii?Q?rIr47cwK0EzVh2Ur8kvFN7X8S8d2+Hy6IrfLiWBe9t6poOERIdTz3azfRtb0?=
 =?us-ascii?Q?Uw8uuJf1o/p75Mmb4xn/UtSlDxQweLd/IwXHyaJKMCfxe0WnT4RFTrffSYS+?=
 =?us-ascii?Q?z6pmBK2GTNmvlFHroB+LVQmQIY3Uwj51zsLbuivl6rzWjkephvF9ebBr9UhC?=
 =?us-ascii?Q?B5hy9NR8+BIPg13I0AgQ0S+2Wl81gNJu6jlfsGPD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05395ac-a2d6-48ab-1a6f-08db60259f9c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:11.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37AvmGE78iQcCCvxVtBEqkgVgnug17RvemEyd2ktFVaamYe9gJjqKxWQdExhnpXs1+e8VYjN11F+BO1MwENLmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

This patch moves snd_burst from struct mptcp_sock to struct
mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d52aeb8b4485..fb4e6a59afc8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	struct sock	*last_snd;
+	int		snd_burst;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 356f8ba1e80d..c523e394307c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1416,7 +1416,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1486,7 +1487,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1504,7 +1505,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->data->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2349,7 +2350,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 21d59b0875e7..760fdd888e31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -659,7 +658,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index af5996a1d3e8..81cf278b0435 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -146,7 +146,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, msk->data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

