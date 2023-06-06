Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF89813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZWReUry5YvYil0aDgqn8IzDn2Ct4qCGdpUuFsDJdrBpIJBsqljJNjMVaCVmpPxNv7IWLGzWvDqJEeuPmMeB6Mc2ELPmshhKkJ6g9E3IbHSXRzDSHM5BZPjEh58R1ySz/TT/rufHzFS2tXwKZ87a+UhmLTZmt4IL0LFaNxE4Y2zXT6b/ZoLBEd9Hjb22N0jDw54pLKkpESnjQ2vL8IrrSkk24zKdslPNdCmZdrJJHOIAyP3w5MdRtgl+UQ3BD/muMMRfTxuN8TADGe3ssawtBDNRiOzcnTxk4SwoIf2iJyix2GOci0gvPunEvNAYHxQ5gicGRPhqjHNiLaVbXlVN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0gv1mvFKUIMpPvc9tNX5nkk28CQRKTkvJcnOwL4VHc=;
 b=JJvc91sJvqdEhM+cg1d9tTfqa8MWbwvsm8zQPzJOK839AY+tvxJx0V8Wo2Y/ClTUIJibC2nvalaLmi7EeAstXOCSjun2cQFcuKjolzBV5bzgoN22HM9TO5xhCVFvwOPJ91AY7HVM6JnlGDWwaYVNCUWtP48bD41X0W3HkPBMlgAw1vLlJSmG0oIhpxnz9OZxitf35AHrq9/qzBpMe87EN0oflZbNJOIqksg/GNRFehEyJauuN9DLMy4JN0Vl6/yFNv6R3+wardVK1kF+KYnTKhVVQ8KlzEGaVyH4hweM7VyeJcU8z3GnzSFQTgIcjM/8CKqLRpcOJN0tYJ8zyLjLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0gv1mvFKUIMpPvc9tNX5nkk28CQRKTkvJcnOwL4VHc=;
 b=qWx9oENr3ATD9po+V0l4+P8P+DZ4FqvAOtmRANFTOTzoKUODiIUKVSu/REHqzWdGOiF4mOYA2mvZvxV3HkigKlUraXRfnyPAFK3dIqAO5JcQkPj2zsHqL9nHNGhYYIx2VqlIPreIvYYXfhM4Ky+tgddg8P+qk2vy4odR37wEPknLZSfnCFFPczi16QjlL3kwpNJZB+FcbcEPpR1ts57QY8SjIh372FuutuB+kdwlilbmTIciljJZmKlgypHL6WS2qzzuDGUETqw82y66NG1bypaIUN0OuciDYHNnrOyLyrH6CFet/mPRe3nGp/3TyMWLkLJ/9WyzmQ1/CVCQGTqnKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:45:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:45:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 05/18] mptcp: add snd_burst in sched_data
Date: Tue,  6 Jun 2023 14:45:04 +0800
Message-Id: <3b72e88150e9189231ebdbd81b09fe4c65a1c5c9.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c616cf-bf65-4bfa-926a-08db6659a849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GS6P+slyFvJ3X56IwMwHu/FcUgmXECuiPqq5KEDncdYwRJmD2RGLpBto02eDDMVtAFEamDCophbKdnTNCMFxDKI+bIObV56hdmHVLAMxE229O1uG8UG57Fd6wVfbNV4o06wpDirR2nfzOSSiBZBRjpqb9+FePne0m2b9j744JBFbB0qiUMHH3bWJexFbfM/lnoWE2oNpSvjNZZhY02F7WrnFPayUa7/qrEybGSBUhmAQ4yDPaRs2eC2sV4u9BZbYctb9NvlOrZu7FL3GLlfxLCSsKGO/I0pqdZa9R1yv520G+YNkAMYcpAgFc1MjAstl/R9LL/rrHmSzuqaNaRFeqCpDRx4F4bInla66KCgCZ+z2yTwZgVCDlxkjRKk4tpCmwNtCd5fHqAu0+mYJqvtdQV74XvKRIPJ3Y0Uf88ZAUU4d+iG/2SlIqCoTpoSHvC2jYPTZLrBEXXgWw/iem9RIvEN5M1G0AroeLQwSU0aNDo3rot2XMykvze/ZfYN/lym5FdAGW00/l/Ej6emTjRDYc/e/SnUhhLRCE/HXzVULlcNUjgjeJKMdJqomkjcWYqie
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FeRnsKsJts5tujy5dYZ+ekwSluHU/o9m/0xGYb6fJcOfjjfKaUgx4LmczgyW?=
 =?us-ascii?Q?9XvycrSonSD3jWzLyjKrkMPFcUPdhCC14l7MhZGjiq8+cVh5hJ2nMuZ9W5WT?=
 =?us-ascii?Q?wcE4TzsOKwAp9CL8MlNAaJGHRNgGNWEdfjfhKaNKnBFdSUjRT1OWPpg0Di3e?=
 =?us-ascii?Q?16v61hR/9k5EBamUnvZKYPZgcykvjTPdHxbXM1N29NrrXRQokiO9z810Xsxu?=
 =?us-ascii?Q?A2G6iJ+44P4mWmOMSuB3tCggg6WcoWSAB0lCAtHIiKh8f75I7iy/eV7QA+bz?=
 =?us-ascii?Q?yKlIFn5K4ChOq4aR4bRy4UNpDgAnJ77pmhjfYpV2s0dxKFZRDa9+eJVTZc1a?=
 =?us-ascii?Q?ZqkEQDWpkH9SmSn30ZfNe7QRBxHpNdmHEGa4m+OyKRBwD4xrbvKLRTjVx7Y6?=
 =?us-ascii?Q?5pEyN0pM43yjbKKKxxU3gZVWGaV221lHGSz83e+jOYjr7dNzPWr2m02mgO7R?=
 =?us-ascii?Q?ipEkN+EHeZXqj2Gz1ibRS7K8WldnYUHfihKXwchYEbNqzph8QUV6DDqHc8SS?=
 =?us-ascii?Q?XhRcNVUqFgI4L91Uk4dDdtKwgoe2qhodCvSRsY+DoeZeOhUiIT3GoYt3FKVr?=
 =?us-ascii?Q?UsT558FyPlix2AuADAds0wv0d0iM+Mwijk+3f11mmHHKfD7PeOVFslDNnWc0?=
 =?us-ascii?Q?ZhMjngLMWuYNQYeQdg9FWL6RHdbZUI3Y/NZFMRMwpo8mJtLB0cOb1fMoJtmv?=
 =?us-ascii?Q?ha4xc6I03xGYDIuIbyGD7eHI2JGXXoSLjaowxGPqNwA5hoBuzJ+oKvrgBJhp?=
 =?us-ascii?Q?jn0N24anK4GUnOvZrQV9+hhVd92+DNL5GBSGAr1Gp/n65vE7HEnYEKkL6ERN?=
 =?us-ascii?Q?KhYu3jJsFfKVx8O+8XzhJfyHP4IprWNEO4pgRVjputQxIg9c2Wg1AO6h4+SP?=
 =?us-ascii?Q?xJ22fubg1en38QcgsfP7g3hQGxjc0ZuXODGhdIAQn5lreL3rq/Paufwtp4P1?=
 =?us-ascii?Q?r7Fhi+CDaVNeDOqDbORfZxWpOyj1Eo77lROWemUxcLhkaoLWs2bOob+swMDg?=
 =?us-ascii?Q?lLGiyDIUVl48YcG/AWcmUEVHScA83xOf7od/IlOu7ePcMvAvd66W5ThJf3QK?=
 =?us-ascii?Q?/OVOvBahg6kzPW55OEDZL/wp9tWnTRmRLFLtQ8TnGoBanNH3v3xZZYwNMMKM?=
 =?us-ascii?Q?9qOER4mbfS+jRSchlJpTr8aotPEwoe4EfIQsW84tA5XcAlZoafDIhr+xBs2L?=
 =?us-ascii?Q?M+Q7M3bEtIevU5INiDZwbZWq5f07N8plf0EtGEPyqNdhy61oSpYZ31AjfLPp?=
 =?us-ascii?Q?O6JJC5sZG0kFuQVspxd5DpXQmfLjojI2VnYmGmXGzC1PlpNEXZ1kNi5kgL+E?=
 =?us-ascii?Q?E7sqBfBGl8x6Hp6Ohb2nbgEnieBOpUjvlQtXnOR/z/741rI2iBSjmDMaAGdM?=
 =?us-ascii?Q?VAxjkd0tzqHAD3AUv/kp29VSXxzHk3AhUmS997Zi0c3fRr7xBqfjbDNVCHSS?=
 =?us-ascii?Q?8XUMRtsNPCjhH4gxhuxDOKf9/jytcH2hbff52XL2mo97a0iP0KRZoRJ2prTc?=
 =?us-ascii?Q?O5GVbTzU1djOSOFXJagK4Y8kY/JsqOp5p+CLiKvn49h3qfIb/yTi5t5v75bP?=
 =?us-ascii?Q?BfxmV3nELbENUq3ApIkny5x2tzAGbun/Ey7+bgJk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c616cf-bf65-4bfa-926a-08db6659a849
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:46.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN5deLDT6/8IPM/T2NeS/1HTTabD4q8wyOIemPCeGAsRVHiUCsUD+tYdaniUziB+dSkC73bw2OcfY/eJ6ZI/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

This patch moves the member snd_burst from struct mptcp_sock to struct
mptcp_sched_data to make it accessible to bpf schedulers.

To make mptcp_subflow_get_send() adapt with MPTCP scheduler API, it's
necessary to make the msk parameter of it const. Also an new parameter
sched_data is needed.

With this change, msk->snd_burst should be replaced by
msk->sched_data->snd_burst.

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
index 42adc14a073e..27feabd92b3e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1414,7 +1414,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1484,7 +1485,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1502,7 +1503,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched_data->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched_data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2355,7 +2356,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 949f46d4c710..a4db0f8f00f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -668,7 +667,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
index 5438a86e897a..a6210ec4ba5f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,7 +149,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, msk->sched_data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

