Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B6628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+ym+gW1w270rRAqlh3uP6m1uNO+NhBqbYf5sptKzA1FieDJWPfAJPNlTxHgmxn4J12l6pZExLBfMdy0UNXjOLWkCz870o7esjGK6EL5/dK31tVb4+B8Gzxm/s4rIxWCjJ7Hw4+X61Hyw9gjbcPqmVCCxsSv1aafQx04Tx2qwDDAkyxT1K6uXtqSkKzgTuVeFwIZtaqBAySRVMTtBz8q2xq9I8v+Nz+p8KjZzY23GOY6uHrZa3gcypujdRowYvM8m6G48ERLjxuVdhQ0PNtiZquOTU6MPLgFQhvbMdrspPY/2sseaz79XmPhOd9Bq10SxD/uu4z8Yq4UV4aSknrL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7yKVIikv+kE5sW6dthGLxap0sFwkK0K2sGK7W/Q4w4=;
 b=XrzMsneR14wJIn6t2y2+0ZZUBnP46KSdEXLpYpo8WiWxexwzZBSX9+uYT5C9RpYOivD6xtj/FmaVbniVJ7W6R+LH1oLU24Zx55qE8TWWEMLMbwE003D6vUOhApP9biwkvJRcuPX6xXAJz8tThlh2PISXZ77FO7+Nj9rSK1fo+11NvpVp6Yj0rjEqjEJPdGjvfX+SEN5tI/gGFYguYXLts/jtRWUKEhcXiLsa2MLATxQwlB8oSxSBI319Ite2iJUIElYgTqdSnpT+zzHS7Zenqh5BLMIz1fP3+U0pLmKopNUnfNzFK15KMExI1ciUIy7WfHjuv6rAEzQJmU6hxiwZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7yKVIikv+kE5sW6dthGLxap0sFwkK0K2sGK7W/Q4w4=;
 b=uhTJPg4dCFx/2/kyxRiXRqd0TYRILDMIKIJ/cUrxfc06Y0Mi0IDxm24VX7x2+w3mLqGqpiCjuy/AyQY0FWP3XajNEMsif6giCUg9YWJnNqKd+Wm9BiwF+C5KVSmizgr+eLDZmkTOBsVVxuyj1b4wQPXtCIENJywnimaaGxCV2cqIEil3ruKnzso/koFMlerMCaWybp7/RSlsvRYTAe/UkfuCQTTiwBVn9erhlcm/Eq7P74jX+hNJOCbytgVn/pg96n0ZTHoWu1rVFnvZdfuYeqUh08lKZiC5IrUJUywrgt/QKYitMIP7y3awl6eXveteWGRE3uZLFGg7RhX7WV9LOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 12/17] bpf: Export more bpf_burst related functions
Date: Thu,  8 Jun 2023 13:46:50 +0800
Message-Id: <228808761f487a44fab5e7b0aa4239f16c3cbbe3.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: e6db6cfe-987d-4b2a-9165-08db67e414c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D8Mib5sNKzdpVC/S4j+vMvAPCmulKtAyZAc6biRMYLzKv3rThw3bf4CjLO/2UjQn2Tjjr0gzi/JMBq6tfrBXkBSZ73PsyiXZ55kke9FFNARyzn2PZjbYVgx//DSErtL+rhf2fmw/F85taQeNfxzHrJO6byFOhnV2QvMcb7rb6dJVe5+MmZjQWsVN+QAKxNltX9FhwZ2YNSvFJN4+f1+zRkamIuiyUPbHtycNqOOshQCC04t6lXigZxFMSECcbx0Uq6WZY/B3wvOgLp9PyT5riYjjWbJTv2bcq61VlscgT8rW+sMBJR2nQ1UJoThlFQBWz3mym47ScMTIVsUrXB9nqNxl2ZgMYVC6cUJDfTZjfEajDTVWnodkjzW+C+8wKs1HrkrARO80JuAmNizeGNhka0noSQsF2mDmXPa9apsYl75574SkAixhZRy0GBZjV50yRm/lsw6Ew9jS4gnbHsZMmtXxo7jWHABjGW+XolsGhDlMaUiaPCxCNjRAZtFUwbRngMG+VKKJ4XabibMLgdztZcJmPxPsRiMvo2W6bKJ74N91iIdqjKYz0DrjZuPqMmmt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0od0lbX7H5E2WrAf9V4who7VD11DFOuYS8GleuBMzDd19w0A6qVkR09I1wY?=
 =?us-ascii?Q?iW+W/9UVd07p8/H5qXVnIYSQ9lYUkIqodgeTeqkxPHvf1tiJq2v20UTV2+Oa?=
 =?us-ascii?Q?XMpaANE+X4Ra81n1/YegUpXudi/klo3iHefQRdBbaR6D+lYtdLiQ+uLZvy6V?=
 =?us-ascii?Q?v/RowDlbIdmZh1qs9kMA1XgzjG6DjgpX26IncVuDEwqsRN6ka57ENwaQcXcG?=
 =?us-ascii?Q?T3xeFp/PWU3iYdw2U78s6rV+hLTsVgLzg4F751J+sYtYigOISiUEDGHRVV82?=
 =?us-ascii?Q?C9eXlc2QVyKIDH0khv2pUrsGdL7dcj58CbPgcEvLlAxNM0J0/zWrWcRVDJBU?=
 =?us-ascii?Q?mWMk6a2jrLBtvnPKM/lfSSnibroVXQPJVdIvCtFHyLGrjXoVULCBEvQWkefP?=
 =?us-ascii?Q?drQ60xAFqc0Uok0LfFWPTlWD4G0ZrxuhLhnJQpDUf3wSKulxRrL4CcZV7ksG?=
 =?us-ascii?Q?B4vBdLMG+dPMBoaVkIoCh2FkZXICpYnClq01ec2/lahqO+N/7Brb23P3irhz?=
 =?us-ascii?Q?kSrs8woHesrUSCgoa9Wmo8VGLo/EYJbnN2u8+SuZTfaWlrUmiURABVm5Mgn6?=
 =?us-ascii?Q?6tJqcQizgVovOCjpqZEjp2RvNy1JeeZ821xoBlHjxzqlQV7A0j8ElcL6fvEJ?=
 =?us-ascii?Q?0T6rXT9hRTGQYNT/eYKmSJXz58zGYQzQN1a2hn1gX/V4cjRb7MUYz4tIlyT7?=
 =?us-ascii?Q?XT/Bt9rwMOOgr+0T/0JBn6ZQ03A/J1BsI5mzceJ/M1K+Zr/KmURVUfc82Jhz?=
 =?us-ascii?Q?/+nFTJu8CZe0HzG4oH1HHkp7MMn6B1BA1dEGMe6sjUvi+LkBSjf87f3JHD6p?=
 =?us-ascii?Q?ZSvTpNmZj6yaVn6qb3iyeio4KNXKwJ7jZUjMgZi4+atpvbtLr3MRPEEcyb4R?=
 =?us-ascii?Q?IQcW/4rJC3Vk+vlkb6UuUt02eGfPhDMVojzieg7X+GZZ/SE7hzvw54Ta2CVq?=
 =?us-ascii?Q?l3rhLXxwYHXQFeRpBgFfBsXe5F6aDpX2AAEZneDo4IdsTTV/r9/DT7EwZQIO?=
 =?us-ascii?Q?PfsbVtiTKBMhmtZMbrU0O4UDGQXxMK0Hm3yf6hJAgkkSK8vt7BqER541AfJo?=
 =?us-ascii?Q?izluNs6BM1h8klveV8Q+WNK7u4wvm1OV9xDMqhx/5KWo3LzVQGNtQFL3dX7R?=
 =?us-ascii?Q?6nbFzvk8hT7I6dKVNmNegTtYvpiMY9ec19rvZsOlnhZzv7rZSSsO0quJy1VU?=
 =?us-ascii?Q?H0xeb3PLQaGQ6Mw4gcQbO9wJOjYCIx2yfd4DqUq/nWqzYdB3G3Y4AlCWuq1H?=
 =?us-ascii?Q?b2GcwKDZENhkurJysIj1DwHi4gA0yP/VatYoo+Ak1kW39mt8OK2J3Z3fQVCx?=
 =?us-ascii?Q?GblgSCjg29p6U/HMAg/ZN/2k356825FT5Zh31q+4mnjE4LiDK8PekNv5yYq1?=
 =?us-ascii?Q?1sCu/PpZhXl0ekpZ2cS363Lwolr6/xge9q9HZ0OAAB+9uPcSO8tcBtwhTLQE?=
 =?us-ascii?Q?fwe9cIxp4Jt9XFtY2/OHjPrIfcWK+i1vXVAQZ2HeEaDwZgC8PqdbI+r4K4qA?=
 =?us-ascii?Q?4rPTciMZ1lfnpUS2Z01KrRfoztjq3E9eFxea5gkVEoKY04JdPmXRDqY7SPAs?=
 =?us-ascii?Q?ZRlCFD9XnKn+Us9nKXf/zD2Y5cQLT+/kQ+eoAXEO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6db6cfe-987d-4b2a-9165-08db67e414c0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:10.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 034u40WOGgL+0034dd1WHnAE9JesQXq+crqsf1UDcL/WYldW5Tza4P6uu3NG7l2zJSKfVt9DiBjIvGZhaELfHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 6 ++++++
 net/mptcp/protocol.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9c52b2d4e609..4912808edf5a 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -188,6 +188,12 @@ bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_tcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a0291310d71e..065837f803f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -498,7 +498,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-static void mptcp_set_timeout(struct sock *sk)
+void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
-- 
2.35.3

