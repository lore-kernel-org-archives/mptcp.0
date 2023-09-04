Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D97E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDnOnjVSIqgYWtKc6igHan3VzxCrJPemSpsFaXxs7LHANLSJNmD3boslCXajPmrB8AhcUDdE/VlqiO8DQeec6xXowVZjE8yxa2slYd/nKTXu48fvGtKR96xNWP0wQNEYAmSuTMoMHz36+5zXzw6MBAMhm+DAS1TlhENeHQ3yBU6if/DHDhFj2QaqOhO3SI+dmsE3lv8R1bJ/qPOJ1eKSwCFjUD+ZVBrolLOMtMdwIR6HMusxrev94iCOaR9p443QUGshbJKONmG6VAYymcBRIKLFuSiDyYB7lTA8gP+KdcJWiq4W0EtbCE7anR1Ke8z0CZJbesSE6uMsj6c86xWAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZqvXTL5u2sNltPB+zWCVB303+8dgtQH+TObBp5Pgzw=;
 b=BgceU6bcnuNIBTZWTHQG/EJR7f1RiqlrUjExBSjr/9ZvuqXAS6kJV8nTAtf11jVJ1O7WeQ//vEmk9FM4FffbfIxAwowIia9BVOIypP6j7qGGOHg28XIfN9d/anP4JqlT5816qZ946ZjWY2QM29jT3vaYOXwZMZwXHLDdLh+DkBsEyF79NqopG6Wtv+uBhb+3uhX3PCZvXrAB++lvXK5X+4LiI7XOrrWf1SmAKJh+IbOngdEzP1/2HvUQ8CHG/zBU/QWYYtUSblfjeUub5Fx0L3Qa+Cg/7fy51+ygM16Nef7c+X7IadGf99qPKl2CWeA8FoGwzvM0udkSJS0Wtm/gIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZqvXTL5u2sNltPB+zWCVB303+8dgtQH+TObBp5Pgzw=;
 b=51dhX6bVRbb6O1zz9rRWFQ8TsjZRLpxRQ7ksnE7CLEI13vT1gbbsdQS/AuxUlLQ26JGNIv0hgvaeW0YQsVLT0SxxIk5wsurYb6jhpB14RVfg8qyPH/rMvFY48YI2CgzDp0Je4E3dxC9SBGwIMbKU6lOQULfiysAvoIlUZPt/OB8k+KFy75wGIUobgteAyJbMfMEbLyHpZN1G+QSYLk6a1af52Q6P32EUtW2F453BfZQRTsNiNkEmZWVHeb7xO4FYOYhnMFTaoCEqywCC10fvokn12UsaVLCe3M1hSZjC51tGrw/bsBS+577dMQlH/SPQZ2ZeblDjo663dC+DnWuxUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:39:24 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:39:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/9] Squash to "mptcp: add sched_data helpers"
Date: Mon,  4 Sep 2023 17:39:21 +0800
Message-Id: <400680aec9d85527f5c8e26b69e5f3bfb48685b4.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 77328c78-4ca3-422f-8d20-08dbad2ad294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZUSslVrXgj2TLX1CNJbxnkiLH4N1+GjBM17zOCmqvyKcb/GDzrNzhPkgrKjkZ1FydECddIKHjTGMuzOpsaNuDvAc3bEEvTCJXadLF/IB9RG+4A8Uz3vZEmGlq0g8eFNMRsVAXdpBJnhTzuZAQVmGfv/yoL6NMePnIwV3iZhk5fqZESU2pQXnT01w7aHxSGR+qtKbG+Mq5BIb8wFxG97PFTBW3wkicsQJaBgbsWbYl1ck5iZAoG8MJuGS7r+RsTlgUzP51DyLhA+ACBZrkcdBi5EOmfhcMq4dwtYRdR1Xg77GwaS3t9Ll+cTp7IuRRnHRer1e8iFWovXzlBaE+RqYYwK7/H2RGBIn3x4Jl07uZ9FlkhhlmYehotE+l+QkP8W0Ne5nEkSAjRB05rkDW6t8xugnrYy/1Tzt5XvBDvjGPHtU7Xj0eiH/bsRI5X+1ht6L0USjQpzv8FKh2iQprMtimFJeHccTq3uzkIEGxLhpOC3SszD/kEeaxrLU9wMqqvWgYq3lNoWT8OZbGCijbMj79OhklE6QqPl0Zpp8ckjXkkUc5CySUa/fix6qkZ2wA/XM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLfxYyOkSxUvuAouNiPn2ryFCBcvBGVaq2FYO3TUlCb2nESD+wIva8Orp5ED?=
 =?us-ascii?Q?yEna7AE17u3RkJmAgJpzHohwjn52NXlyWo9mhR5Yrj4vpKPOc6eELFQMR/KK?=
 =?us-ascii?Q?4BeCQrPDjMQV16pptiSDk+UharR73vc4PShD6kP0g5tA0clRPy1sIyLSjKp0?=
 =?us-ascii?Q?+FWVNhrYNQXG2spNPJC76fVRAPa0Omf1MVxG4IHt8yp2AiN/mP6e7m89ISMf?=
 =?us-ascii?Q?ZMnw/MfkoYoAojNWaSB046JWjvmvVRf/wDs5gjgXFCAtR0/kl8AWL8cPEg5v?=
 =?us-ascii?Q?7BzqCbgkCCC3z8l3O8fngU4UHIQnYIKCYxO1GOQG+fn4B/C2ThQIb20puoPy?=
 =?us-ascii?Q?QIFm8j56YwQny9okS1v3IseMjEHuSmEGtruIdsQEhcS5+o0Zz3X5t3NTtl+/?=
 =?us-ascii?Q?PSrT9UFqQfHehQ9dT2h93gpnqNJ6PYzJh/HDer+Q1L/by4fE+fFlJPwnbDW+?=
 =?us-ascii?Q?2XWnRFpGxKO7w9qlpEpt2swy/vo5/yVrpSIlKV99x64elQ8Kd+PFc1YIRsC+?=
 =?us-ascii?Q?oOYml+nvBn6IIz6tcHy395QbpAtYAoFDzpA/Hvz8rXqOZKjCrqgJVYXyR3RE?=
 =?us-ascii?Q?uE+8CaTs1EOnyMKhnJRdLCVarM24DSwFd2o/N1QeshGmt8h5MWbSlMB6DT/v?=
 =?us-ascii?Q?QdsheB1LqNTDDpUTELAc+C+2yNGGkYffHkJ0MO3wh+jfuX+NkS1u4LwmQRRI?=
 =?us-ascii?Q?K1TUtMsy0t2z4HnY3c3oWLd++7BPfMvkQzzbmZq0B8Rjrt+LBhiWwSQuRRj6?=
 =?us-ascii?Q?+xW24qZB6AAWyEGboGPCsRTHoCj8iN+a+eoVgGXJaoNnH8xaZhgjSjZCtiu2?=
 =?us-ascii?Q?EJvnZpo0SIxBTtUO0X3tBOEqVoqirI9uEBVksrW7m6O87ZqAUrWknolqq07T?=
 =?us-ascii?Q?Q20ZLEi9xpbBmaiXuLEnLXEUk1vzf1Uu+sffUZh4T8BuBGT92I/Nroc7D5yP?=
 =?us-ascii?Q?EVyGevVfuGzmCR2BVidiA5/3k1g/7fl35CL4+4IfW60E0XIPLYS6bSa+jp9b?=
 =?us-ascii?Q?ccOqfzYd9oS0RUmEtVku9sqV6crLfsD5wU9g1H+HZmGJgrcx+l8YCfe5PLp+?=
 =?us-ascii?Q?PXjwKmUPS9AnMEFXUcpL4mP6x45VFETBKsClSfUrSGWG5U4TneTElEEN5ONs?=
 =?us-ascii?Q?ZVnl8RTLmL6wJYPuE3fbflgBf0SExnnlzTTbM2s9jucQE4/pACJz9b8ixqmD?=
 =?us-ascii?Q?qjalyLt812kYuId6WyKTXWNguX1JY4kaw2rpZSu+G7eF9nR1kQhKeuYx49Oj?=
 =?us-ascii?Q?zhFl68vCAt8EFSx26ztl4ZzKS0BEbhXEu8XWbs7pZ3Gh+/t9dfH6pBCHLcHA?=
 =?us-ascii?Q?spCZsbcg3+kQRfoHoOKJS0c7Ay90txfTJJvOp7gEn6mIwmtUvFNQw3U5PtkN?=
 =?us-ascii?Q?4BEpcV4L8kAp/haPjX+n+QvsKb65rcAmszhqcWs7XOqbk6dyPklVPA9gDlcb?=
 =?us-ascii?Q?QJXHTRATaxHsPzSvM9EBOnnUqUP2EgGSrN+C2igtMced6KaS81d07g0rNTpl?=
 =?us-ascii?Q?AkS/qGZAyVPNxCs0FfAMJPe8Wnw2e32yi7b2HuWhcX9t2/4t1Myd8jKZzkWl?=
 =?us-ascii?Q?l3aT6JiyeGhI4knHhsO3Czzxs1swpmljACRKlZRS+RS2vVrkaBCDn61AEufT?=
 =?us-ascii?Q?TW3BvOXL5AgDDV9gmiDLcfhaaQ3jNW6UoQaE4Jbd+aPP79a6osHuyIe/ZZNy?=
 =?us-ascii?Q?2qk8cA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77328c78-4ca3-422f-8d20-08dbad2ad294
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:39:24.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5DH05fZ3lLXQm70fYh2YIMV7MyTfukbmJKCkONVKaNXILNooV4uNKu4SlX0IohyWgskb56zMnkybWeV0+0gPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Change mptcp_sched_data_set_contexts as static function. Rename
mptcp_subflow_ctx_by_pos with bpf_ prefix, move it into bpf.c in
__diag_* section.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 17 +++++++++++++--
 net/mptcp/protocol.h |  6 ++----
 net/mptcp/sched.c    | 50 +++++++++++++++++++-------------------------
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8109d9dfaf5e..18ddbd36faf3 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -163,15 +163,28 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+__bpf_kfunc struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
+{
+	if (pos >= MPTCP_SUBFLOWS_MAX)
+		return NULL;
+	return data->contexts[pos];
+}
+
 __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
 }
 
+__diag_pop();
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
-BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 12d70ce24843..ebf7566005c6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,6 +643,8 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
+struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
@@ -674,10 +676,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
-void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-				   struct mptcp_sched_data *data);
-struct mptcp_subflow_context *
-mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 2ae3f33bd244..a7e1c10b1984 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -121,6 +121,26 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i == MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] = subflow;
+	}
+	data->subflows = i;
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] = NULL;
+}
+
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -147,6 +167,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
+	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -169,33 +190,6 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
+	mptcp_sched_data_set_contexts(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-
-void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
-				   struct mptcp_sched_data *data)
-{
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-	data->subflows = i;
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
-}
-
-struct mptcp_subflow_context *
-mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
-{
-	if (pos >= MPTCP_SUBFLOWS_MAX)
-		return NULL;
-	return data->contexts[pos];
-}
-- 
2.35.3

