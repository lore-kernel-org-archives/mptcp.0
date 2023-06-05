Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BE5684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEWleJEWNU10trarpSReMjD34OFywY0xsFLxVN8K78fBY9yyh1ZEoRFjH75XlfaNj13G99Flcvsm1ScPXKizXLlVp6MLozwAhKXryQxorjHn2/fJuKQCUd239z/lKXm1TjYBDSYKTGZxL0jf3+Z0p6jJtyn5hm5Cq3G9L7hOddIIA53fBD+SJw1y1rhWhC1qoGZUfV7dwX+UCrp2xCnUuXz1EUHEy4yiQAnqjlyJUA2n9mCY81u9LVIW+TBkzWvUelBw8cv36J+YHs9Ke1mfokV7xhyrZwAW7Mf2tu2lF+IMQU8LfXcVKd8/6w4nO7lYIZgFKXa34LldyA/FV9bfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChUCjRiubFR03LB6GTb2pMI9Y/Bstw8T5WguBdon494=;
 b=JNMnx5hZrGQBybos5HI6h6x0N+6ZhhGfB/Ss5R+IHyosk5T+vgTB+srGivqpgrSyGc8yPgyl8LcMqTiGbVBfLSLPZwyCVno+oPI8+cubHCgAXAEVfm5WTwAS2yFZ8xSg4mj12T+EvFcvXDOmRzBKKJS8CqfW4zIxWunXPHyq62ncVQGQweJfhlHcpEnHgKqLQFGZsJ6Qrq1CVk4vTTkl93MPDOQmIx+WJHhSIJoWqEiTzToIeQfNvRcGY8/20O0Kdn4/c1uCRpJPZAViVOVQrWWEIO011ColRnZHegugJZxaeXLRafCCeEUG88iQrTVJgOnBpNHlTyvniHkR55n2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChUCjRiubFR03LB6GTb2pMI9Y/Bstw8T5WguBdon494=;
 b=bg79O5D7scZWxOO0RlQ0pjrNox3fECvD7tHCqOAvg4gJafI/CEs12IZ1C4imDqBASqVClCvJHVLeY1sPbgkpd+us8+6f5Bsjqjog2LsQMXgOtIgvMLY8HJ1zyVwkct4BUh6m6c0/ljNTByoHUIFrHfzo+L0R4xT+L8H4Nq8Rjnn28XBXE5fu/r6brDLzb3jLFujjtny5YmIF7GcUcLmdV1KY7X48JD81KdykvNFi7jFnrgDrb55m8MO0X4n5Kf+sLYGF9ClsoX995QsTNILfx9ImAqMPXE5LYCxb8AhM7AdAQ+sJPCKGn0LSA3q3qIGAB5fC+KVP1VAMGfrBXGRLnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:04:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:04:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 02/14] Squash to "mptcp: add sched in mptcp_sock"
Date: Mon,  5 Jun 2023 18:03:57 +0800
Message-Id: <2fa14365a52e6b9f364ca03da86edf14df342633.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 583e7436-8f65-4069-a3c9-08db65ac4238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7bosxhgeVA8N2q6h/MCtb+gQ823gzapEHoEFX8e+MGi7i95AOn3PV40wv49jWSalrN5bAy+30DzOOxsCI7g8pi1v9BEyX03l7VAK1VNKQ+n3qYWuHjQ4JOLMS9fLxeouzYV6JEPZ266zFaAx3JBJ8QGpoexiMxyWvA3JlMCUtzoEL844XeFap+h7XR0xgrxH5weGj09h47vZdvTUJ34A9xjuBtH2P26P3+07BzupUVUNfmyl0dKN6WYzOnzMD4lxI7WTA2WcKCyC09nzAT1Pfhkiv8JAD9Emz19t81TWud+khMXi5dTblxAVV++t7J7TU6aJA3oUunPEfHc/37mMhUzhH1+EhkSPoJ1fxbHYlXRjTq/vPReFnJtqfg9/EPzH77PnRES7YlTUFSO6WwJdrzN2iOD9PpBINGLCFBQC7byr2a2FflXTkFfp4R9zRFw0184MLukxb6ZXicRpk/pEeTwVDo389wjEnevmuk1iSvY2Th4iQmOHY9vo3Jxcixo7PY7t9GBi1CAPzc/l7gO+Iku2ydZR67q5GTytzv0Xxl8IoiFw7P9F5EPYs8/s7Ni+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(107886003)(6512007)(6506007)(26005)(36756003)(83380400001)(86362001)(38100700002)(186003)(2616005)(41300700001)(44832011)(2906002)(478600001)(66946007)(66476007)(6916009)(4326008)(8936002)(8676002)(316002)(66556008)(5660300002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4iHkPtZMyPUXWWj1pswVPTGKrJKGZiB+60ciECM5XtzuyjsjfjvHln/OokEi?=
 =?us-ascii?Q?OLvgfDprFwLbN2I7mu/39Zbl0B3tYL0poW/UZDmKQVEi9KEJTJ2u3pbwla12?=
 =?us-ascii?Q?tot+7KEvt/ZEek5m70CFLzvdo+TwqjCRf/fNcqFVWK89jOydCE8h2EG3ubIQ?=
 =?us-ascii?Q?MB7jfgzhru7KtfzL5qzZRba9tDZs4KqW9lheLvQGrPliyOXbgpqpp1yqQHKl?=
 =?us-ascii?Q?jKAAlCFNJxe1Ya/Jzg+Hlc3HLg5f5jjn5O5otwCzT/za/RkBIDEJiwUCX1Cr?=
 =?us-ascii?Q?FeCbrfvYdSznd4hv8cLDRMHdgpKbFXjCcn5wwAbr+2RuW2IyA8rjtuu1NZMN?=
 =?us-ascii?Q?3eZZsR3jo4Us81fayzovRYXt1Ar1nODADVduqkDXCjNxq2JNq0CLc7ZgxlgU?=
 =?us-ascii?Q?ySOx6HdEi/ijMStvC9wqN9PnngS4P3gdgbkKdNFp2UL3Dw25HVfTj4Z5vqCR?=
 =?us-ascii?Q?QHGe6ASOVSXwfoHaO5vz/P3jZK0wTotGJD0CkAPpzatb2CUwXJX4W/6cgAv1?=
 =?us-ascii?Q?uo5rAfrlP+md4xsUr5j5UxlLfPcKRh2Q0qbMOGrVH58b4OCm9sSxFHeklPKB?=
 =?us-ascii?Q?C1kM4V3L4jbriTM9kOFPfRH1zkdU9lLgkOceS7vURkQB5FeVR80Q/aIQxYcr?=
 =?us-ascii?Q?0NnaC1d/asmm3XKFEqtvx2oUhmce2nhjkjQyg8ZQAvzZgFomqKgdLz6ccAux?=
 =?us-ascii?Q?RAdSot91usnsMdlmv1UmHU8pYQyyob7+6xv5sNcpCPlc/iisp30/AXUrPefc?=
 =?us-ascii?Q?Cm1U8fMqKqJbPsmPSwer0IS956uZEujUyOIe3OIzQ5OZNVJdkJz9c+xPbofK?=
 =?us-ascii?Q?bHonP3L45iuFfR5FS8bJruRzcFqEVUv122cIHEA87KDFS1WNHHXEZEhpkhIY?=
 =?us-ascii?Q?Jo6v1xp3qHkbsavns5SJQSmio8W6/X4KmFd7l4hj/dkYWWHhywoONpgL3n2p?=
 =?us-ascii?Q?H+RTarC5SFILgo/LxMwtCzIfrKCveryL2VwuvIxkqC59WN3AJZZqynxdJxoa?=
 =?us-ascii?Q?KQQlKqjyxaMhywGGDIksdQLZlRvmrpV5z8weYoQvGdX772MNyEGCqmAqCN4d?=
 =?us-ascii?Q?EUi7XGoAaflVii4uA2Pi+FhPDL+qqy4yv9/pVsLlrkVHFOtYjjbypdRZspui?=
 =?us-ascii?Q?Xk1DtMAn6oesFQpf2WfvHMRiYrSTq+OJk3GozRitK6/ETEFTt/GrTOKFVsU5?=
 =?us-ascii?Q?g5iuWAtq1X7+CxM7A/plX01LCD0Jxt6sWe6jGzy+ufCDdXPKGeS/VVcGesTu?=
 =?us-ascii?Q?Q0wUUITDjS5jxp/NLWOQYPg+VLWkTcSYK+AiDh8T/NFPcJgABY/qGmbXRbHF?=
 =?us-ascii?Q?8sDexqzcX0jNTc7mL8ZwrO6g1OpNHlgyn+ChXipmGJdnfia9L5NsEZ752TU8?=
 =?us-ascii?Q?U5MJT4uIXyfLtSdTf3tT84yq6PfUjveRNVdnM0lbdxmuQ10j7Y8wWsKELbX1?=
 =?us-ascii?Q?i9VjT8NwzstcGka+Yw0oP7LPvON88ZswgUNhe6BwyEHf76vdnt0t8CEE5BGO?=
 =?us-ascii?Q?tCaKS74AY8nzKSsJ6m9RMuXNbdrTNe2sZ869Y+09ZstdDIY9pJg+RMcJ3sg6?=
 =?us-ascii?Q?354CfwU2U3il41CZGksDUCiGbMm7lTliXMwF9KLt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583e7436-8f65-4069-a3c9-08db65ac4238
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:04:32.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiLcx9kf/KYgUyYgGqLlAdx1nznWnPfes1qdZzCzhKEBHo93DBbAh85XHJe09OTr8jz5F4DT3EADB43leumAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/sched.c    | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cbfa4c3ddc3a..380b7335618c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2825,7 +2825,8 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+			       mptcp_sched_find(mptcp_get_scheduler(net)),
+			       GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -3225,7 +3226,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
-	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched, GFP_ATOMIC);
 
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..ac05fc317689 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -315,6 +315,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
@@ -661,7 +662,8 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
-		     struct mptcp_sched_ops *sched);
+		     struct mptcp_sched_ops *sched,
+		     gfp_t gfp);
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..a053a9504dfd 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -56,7 +56,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 }
 
 int mptcp_init_sched(struct mptcp_sock *msk,
-		     struct mptcp_sched_ops *sched)
+		     struct mptcp_sched_ops *sched,
+		     gfp_t gfp)
 {
 	if (!sched)
 		goto out;
@@ -64,6 +65,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
 
+	msk->sched_data = kzalloc(sizeof(struct mptcp_sched_data), gfp);
+	if (!msk->sched_data) {
+		bpf_module_put(sched, sched->owner);
+		return -ENOMEM;
+	}
+
 	msk->sched = sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
@@ -81,6 +88,10 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->sched_data) {
+		kfree(msk->sched_data);
+		msk->sched_data = NULL;
+	}
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

