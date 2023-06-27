Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFFA23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S72pRg2Dzk3r5l69xMTus7sLR/N/vXywbvEdJRfdTcQkCp10RKW/EVotE01NtjrWAcIGgFp9Z1elfjMlk3Sx7/FYE/En80Y8D99lDRJtr5Ww647aUXg278sdqLkuMcS5rL9XK2kB9rsA7/pjEZ2JQJMJ++IpfmOFHdYU/aVVxiWb4Erh6eHOkNKCXQSojVbSLzcld+eqRgIVbfn/fqyDwSkoGMI2l+ILCCB5YaQGE4y46lbggUoOGptnnmapIBIhMRKRo9MxWktNFybXcEfn6XYjyuCBY7262g8isknN/jo+w1h9nDT+P+urcboEyK0VJh3AmP49lH7Atizs1edrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ty+L0RiTjb0MHJH+hm+Wu+hTwdHRsyc/pY5ymzkCg0=;
 b=AsMgGygdNl5Nk0ENONN1sG2DRHZ8TedunQ5XO9/FifUff6ASIfzXK+dLahOzJRipTynWSY+7qfb25Zzq14dQD0AG1tb/b6UAWtXdfysVGFyLml3OWPn1wEmPrwZcMWTD+DB5gbXBTyLa5ZlVOWCU+EUr/UEeBq1QhAP5/rHiWx/waCd4ysppci6N7qtxEaRjifRnwfT5bBdtYP8Yxsx/3525afPhoXQRgka61nspK89Kwp+Joe8Hu3o9Ae3LRNii5Lz12TzMcuPA0wJai/06MoQHjdueKfCX0yti3c17mG9yx3L2quumLDSDZMlndvvz1uqPvcQFwn3+3wQrIrHbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ty+L0RiTjb0MHJH+hm+Wu+hTwdHRsyc/pY5ymzkCg0=;
 b=RBl0bZzudpNYjtub1wSsSyICv4jT/Ko83FyNDo41qNC3bNVsNvLtD9/09OIejCDmq49qjwV9Sf4eqQdubOgOPIq3u4Z54F3LBySdDnuackwoAF/AyCWZxjUUNL4TVzA1cyn0U1wkcGUnGahUbnObyY8sP6X8BRfeDL1jE/dAtfmHjL06XRjCfHBPDAbstWOCkKap2yB7vji5gsa+qJZZCfu1xx8ibNy0pMz9LW1Q5eNSNHxh/drXoawLfBouGNAgsc6hfACywiP9ddnG85U1rLNF2S5lXpR4qUFzLBMgPvKMAcRkz7S16rYLLxwcdYnx7tD2tGbYmTjJGKqF1moyTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 08/10] bpf: Export more bpf_burst related functions
Date: Tue, 27 Jun 2023 09:39:29 +0800
Message-Id: <b123ce780d733db77d0821d4e9d7560f7439ded5.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cfa9af-2663-44cc-b0be-08db76af86f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iGSJ70vpTSRJKZUiwgvLIsvjNS8tNYMVb4Omta/xUKpUjyABYkkDziTvNkoT5YpVc9fNIJHgl3Nl9f7Liay0Rmi4oDvFCOLxtaBrKY58aWeBwP2RaQlcBqiqR8+Lt8dAmL49g1N0CigH70XvG3xX1EXG/rKnu0PzRlDp7JC1vmpLFhtFt3QCkYsCtg/QoBRwu28iu38+Ruc469MHMdesyUGEuxVhFSIqsyXIHUUOzlIqBxWp2DKk5cGDEnI/+1JzP6mTfnSaslrVsVlEKut9wH1/ZrowyFM1CVFEKtaD+WZbQ8yw17pxZHIN5OWOh6q5BNYd+N/rUjGnKXpaovFhp63a9ObZQJ3FmI5EMHCN4Bw4zyInGT8Hb5BWQiGRS2NPJqqKvm9tYes9ZGnBTFSZuOvT8UZMsrc/dJO5xfdv/28zxcnud+4N959YSUamYW4Ab/Ct4BDzT2K0G1znfQfWmEDhqTyFNjP7/3J5sNQR7YdOkooW66p+ecVgOeZOjfwZL1SNpKY7EjEz4IK01lZk2aKmEuNnbaqIK4GNg3APUhzmMvajHhUcYUr51/GiZrSs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzksB3VXxtiS68zUpPrEug+Gszu3Tq9W4kX7Axy+M2nE/ED70csN8kCsPFbv?=
 =?us-ascii?Q?Gy+xZXhPBRbU1ju8M6MmD4NNRpqxxHn/6pyhifMjo/+Bwx0Y9VBLhcs6LfDw?=
 =?us-ascii?Q?Vg+wKLOoWfBMBcSAbx91Ykj7r9JXA77pCfrFYoQth4T14o7waDwY+dINUcBr?=
 =?us-ascii?Q?ayfTSdH7P+QDn428ZnWGqjaeVniFl9OcENZZdHlfC3UVbKku629Ll3GkIgl5?=
 =?us-ascii?Q?5zWKSkCfMfh6LrPigwpkn9KRgkNWaL9PFCQknNe3Rlp66prdIqNjuCUMbBZl?=
 =?us-ascii?Q?TzVvDKktJGKzqCDEU14bXpY9Nyqk/jIU1RVa5NXXk+jcK5HzyzFcpWdk6BY4?=
 =?us-ascii?Q?lUjzzcJAEP4P77FE5tzuf3o4zelVusfhY7nVLo6Fz9xOw61oaXIk+Gtjitds?=
 =?us-ascii?Q?L51NF+8aIikIOTR+BBOaj8sAM/v6PT4ZPQsTbcGFTjHvcWvkTPlRww1qHJ57?=
 =?us-ascii?Q?gGx13GDqx5oMA9bXHBfdSer+6ezKqgKv1twt7S/ZpsabHFuiCcOcA+nD2W0L?=
 =?us-ascii?Q?jn+W+B6tFEJTouqZSgjLIRqElJmbwS/FBjP91a74POquiH4T9pSojlKKqgjv?=
 =?us-ascii?Q?d7phYk9e32Rjqlq9/BhhQ4LlUkWZb8BoYfJ6vHyiyK//Lo5NIGDtwXhMWeDn?=
 =?us-ascii?Q?SZh1QY8Xg0a/a2EU/ry6q5TLeeX33avsV041DXxjkfTq+dSgmK+6aF68kfqr?=
 =?us-ascii?Q?ymbvgUz/QyQkrKSGvQQ2XfrSqq8Hw3DZsbXJBEViPDJ8NIK28IpKtsaBm/Wz?=
 =?us-ascii?Q?L01wbqd2gmvu7KWRW+VyaeDLbCAGDe0tETVK/W+jZ27AiMi8nTme9ruBTRa1?=
 =?us-ascii?Q?HwrGkZmb+qXXA6Vfcf8e1ydScv0jG12WYfjUxnNnEpCbXIoqp6rP4Es/lZFN?=
 =?us-ascii?Q?4XjBDknmBh0gVQhsWHuYnpdyIARy9Eb22+GDHmO2tIareKzL/QGjxwGec8oB?=
 =?us-ascii?Q?MvFOggnWP3IcHvLcUEgpsLWE+5171eWj/0nShgjGUm4rtJbfL7XRpbzgkmac?=
 =?us-ascii?Q?rc0yKGXfE4j7VngCwIJikVZ5CsX4Q3zRIzuTi6mS00IcmuDYiUDh5IuTz512?=
 =?us-ascii?Q?iYUxZ9fq56RjkMJYOcK8m3xgmvptelmpMa6fQ+ePneDyr/8qI3PhrLXcTNNf?=
 =?us-ascii?Q?XPuukdWRBgls5NkDYBcuScMQaJgcq4E5C5Kxiv4L2z77C382y4OE/PeoO+Zl?=
 =?us-ascii?Q?hkxnGAXjeUCavvqHR9LdIvZ6hk+15MXFYcVDMbxMMXsEthzfhcpJTZcED1Np?=
 =?us-ascii?Q?S1FmjRJS9HPoxr0rX7DYwPXR+RGecFaT0i6agJ4F1k1WmSDUSCA21maV1bk6?=
 =?us-ascii?Q?XIsd+4eU4MENOaE7SXLSByO8Cc8y63cx+u3h8p29aFdVn4FJS5XWgL8xcLLJ?=
 =?us-ascii?Q?ofwCrl2HvV/fCrtDm4OG9xXyinr1Zili9MZzofwia8rwdpWwsxu61kftJpwR?=
 =?us-ascii?Q?SV76zs92zfMw9at3udrN0xv/C+5m5ku0Z1gzi+4PrShm85BEqJjkiXkz1mP+?=
 =?us-ascii?Q?F/znNCVJRjBmc9yVf9SuJa8UOWDKf4I8NEyOlX1xB0i50fwWb/+SAXhRBSSe?=
 =?us-ascii?Q?M0eVGgPJtDjbuVvgCneBpQyH07BIXezNb7vL7ToD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cfa9af-2663-44cc-b0be-08db76af86f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:46.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ42d3jNsJ4q8agoRu6kklBsnnOiG1RRUuT26VeTZ+uDSoVlw18pkiJAxYhwv/m7YFdALmcDoRNhC9w1sCrMzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 16 ++++++++++++++++
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c580add9c7f1..a1c85605ed39 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -171,10 +171,26 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_sk_stream_memory_free(const struct sock *sk)
+{
+	return sk_stream_memory_free(sk);
+}
+
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_tcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f9f046b2124..84a82967b009 100644
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
@@ -497,7 +497,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-static void mptcp_set_timeout(struct sock *sk)
+void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb4d50c8c398..58a634fc2fcc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -636,6 +636,10 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
+u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+void mptcp_set_timeout(struct sock *sk);
+bool bpf_sk_stream_memory_free(const struct sock *sk);
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
 struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.35.3

