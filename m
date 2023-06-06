Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF7813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1GRFHKgjmVIS/bdzD1c6Hcc9iZhgjqcpjoWy+vapozfcjSVKbE4iZBWx3nxQtmAl+Fn7YQolAwxI9kk/6L8DchS3amPOx1lKTuYpli+sEhyRMz11neJQiZuOqj4Ixsee9GIFvdQC4fASCu6kkL9MYQi3D/zUHO+EqP3hfpOJa/IIcZtHrJ7aSz0mWcAALUW7eTZe/r+JTBJrPY+Gs7k8vyykTWvDheXzH+AOEd7dTVVaXWa7AtbXg6CBWPWFlLqD3KsJkRryuAEaxaOEDBi+mSbwAPpnJ4octEw4/ub8B9RCRw744s0s5FsO/5lI+Iue7wXutTs8xeppxYkmKkrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChUCjRiubFR03LB6GTb2pMI9Y/Bstw8T5WguBdon494=;
 b=TMJ26fQMIPIXlvQEovy1ipuM+WKdbr2A2zNAdnfKxAxs4TXeXEv6EZgU24IT6J/8p6dO99aWXiaj5XBqFl+u0S/kLj5mBOkRhUv3PWfWsD5XFbPP8D99PyiOfhtaI5orgXwngcKsdPfPA0UMhrSoHi+1DH4C7C0qzj6ue/X7eb0VXU0jbnalek8EvDfWrZZZtbKstzbmeEwTSZ1pN4Nmid9NAs2LK8G/8H1hqo0YKRcQqujiIk5xgLeWopJ77ebcOXAG6khHr0614HVUAFf+T4pdl2qonnBLPkL9Eg9G7LtWw/OP7dJRYfJhS49BjvoLjzwodxr1LmBUykB6wFdkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChUCjRiubFR03LB6GTb2pMI9Y/Bstw8T5WguBdon494=;
 b=rFLtvqOfEe353svx2FmEpKP8EYm1df0pXe/dL+JuoB7xn9MFTehA2JECI4H8faZoPLeILuEBbnkCrr2v1lzieD+bvvnttGfuEKl1XVAQlj6xY4KkqBiJiTqyP361GTKmtA3VxRgcnLbcozwPJJuKbn2pTo1qMJPpvTjuYcwLzEctT9DdHihZzJKd+qn5Otntek4+/TunwO2HmXuaCwwk/50h4IvOglYvmH/iNM6Pyt8vHnpom9YYdEVUkMmXxr+5ZeNqUhvrWzBLh7/j9z2EpKDU6dwbJ3nlzxSMVPFjJB3dB2YFry1ZbL1mdWtGxT62xT/ryK7+s7H04f+oBcucfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8330.eurprd04.prod.outlook.com (2603:10a6:10:241::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:45:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:45:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 02/18] Squash to "mptcp: add sched in mptcp_sock"
Date: Tue,  6 Jun 2023 14:45:01 +0800
Message-Id: <2fa14365a52e6b9f364ca03da86edf14df342633.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: b5404a18-7fdd-49af-150b-08db66599ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8lkWOUhXqQ4DHWZM4ZNLhOey4lOkdvSs/S0lhlQ6m5jhJZ9xY/w3cIykJZBoRIP4Yqj77gzOq+7hwKIdhdEw/Dx/ZMZD20ce/8MDmWLpRFrP9gpp02NFePc1p5C9qsTmN9f/mcsVWsJCbN7w8/1kPxBbSiS870W4eQEknuIftpl2MQMDRQ3VFb44A5OZ8WHAIMkxKekCDmZ5di35/otUE1riIhwWbTbgXJWTwqKDbg3x8Zt00y0urZRJLKfYMBYKPD6ghcoBPG/3UqQa/WcA22lMuNTUWoY1aBL9lrH1tDkSJjWsr5lEfmXpnnfDfHU8e+0r4BlOie8ST9JxXkR1qGYQV80WEG6nPWr5LYuQW2OLW0VGqKXq4FhejnIlWJ00KliGd3tvj/ZHqPpmeraUzHtRqbPDKodL6RYrhDRUJgVqpJJB7rbqpR7LfqKbfmPQ0dCtWE08gQ8OnJyTSpAekYCgKCyIRqgC8nvvfONITUkjCRmBfA7for1MK6GKOTFRjLK1/mtLNZEEw8VFyyZALIzMyvY1chiF9D+8fD3BGUskQ6jeaI0XEbj0XUOENw8L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(478600001)(6916009)(38100700002)(66946007)(4326008)(36756003)(66476007)(66556008)(8936002)(8676002)(44832011)(5660300002)(86362001)(2906002)(41300700001)(316002)(83380400001)(2616005)(26005)(6512007)(6506007)(107886003)(186003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?snJtSBWHiqTimgJfyve+MNn73eddTPsMCQ8fqYls1sqn2FwBVXcNufZgSNAG?=
 =?us-ascii?Q?5CnByLa1aeI5HMQuGPXpmqMaG8djHPFKvYjDjeqcsAns1Yya15Ziaet2oTz1?=
 =?us-ascii?Q?pOrLA8e5o8MvpCTrLAS03EavP4DB3RBQnbbP6ch4JbQwXh5o0A2bxFyPSh/V?=
 =?us-ascii?Q?HvaBrr/c2oCSoZpQBYgEhClddjWQT36eKghlQGizj4u4rolWqu9QUS2JlDWQ?=
 =?us-ascii?Q?iPMiaabrpEcOI5/70vVH9IWXNOiBAlhp2gfU9PoE6OyYSRnBYZrQOQB29uxh?=
 =?us-ascii?Q?pW+meS5p7qG0+6+o9+sX/4pTYGtH+wTwe739IH6J/1cF/FAivEVRh/4e2W8r?=
 =?us-ascii?Q?pm/hof2stHB4F+xZ23RKeRv84eiWB6/OE0XfRtdP+uxVyWah+X3dMUO0GVXz?=
 =?us-ascii?Q?aYY4FZN2g38oCZHGL8PZhTRFqLSC91c6rakyGC5XLz7TUSgintreS+GZpoyD?=
 =?us-ascii?Q?sSuxrvXefKyKQVp5bbgvLVBTQ07yP8rYzWxKKFIv0zDr2ZPUyjT450Pr5ejJ?=
 =?us-ascii?Q?0NRNSbpgGtNpjA4lJ210bJpPWvkdo3e+DbdMZzY3AYzJ9JzG0+ANjKr0VlJA?=
 =?us-ascii?Q?lKC/9uq7WsY0b9hR3yqifusIYYXTfDOg/RsJAoEul8RZA/G+QYf+63Wv2YfK?=
 =?us-ascii?Q?b8u49R0b8MLye/iMB7o4azIgD9aRkP95yaXVtSruasmfw+uijktWHjaqTMQO?=
 =?us-ascii?Q?OKKRSpRJuyfumgl7NABjMPYlsRcN7N8jE29U1pJ9iDX0THVa0s0z5+nGQ4kk?=
 =?us-ascii?Q?SiY6TVGY8di7j0We99zWhSRLfppWhY0294n7tmuwMHnc/39HzDFhEhkAfUaX?=
 =?us-ascii?Q?pX50HnlLU8UnsflHeyZMZtjlBIJCYCtp6XwcMnxel3gaK6Gn9KFtrQ/NZPQm?=
 =?us-ascii?Q?GPKMvSNgjK/rAvfHYuJb5kthffhvbBfUslEuH9DkJxVskpvye98h/yLr41sf?=
 =?us-ascii?Q?SFTo5ZNycKT1PEhS8bHIcdSbR8c9FonnX0pe6eZ413w1Cjizu1FWWhQ99yKi?=
 =?us-ascii?Q?yBHL+WupqzDrY3KC6hnOfXElJFXtDrq545m5vWCxdzClDRgPh7d5/pXbpL9r?=
 =?us-ascii?Q?hMXLhAumpbyySP/ugWHkJ4+CMdlI3MOet+/afD/dBPTjotdLeZhFw50W9ZQc?=
 =?us-ascii?Q?TdMFnEf2Vxa36MWDOcu+d8y10HVE8Krv0i8hsM21y+/VyiSZ64MCAD0Foovo?=
 =?us-ascii?Q?dCz1RMkiqB2b7OXYAQ/qLNQxz58hWFbljdD3rkY1OTMeWiKMz7bVEK7c+vFg?=
 =?us-ascii?Q?0j1Hxm/o2G2FIHffE4/Shsss93v8/kEBJyrpjcNDaFIACIvIwVwgQ/6R/kDg?=
 =?us-ascii?Q?KZnbe2PVrEKvrqUZCggGAp/658cMZuxXNfUlV0QliSrL91oqyi9RT0phFbdh?=
 =?us-ascii?Q?yvhmuij7teeHHTf7xQxFnFFdnP3rPtWR1GY/DJLbqqmQ9dNecbVEdL8A8dzf?=
 =?us-ascii?Q?gaYYnHAFsEen/RsbWApTNuZfBCCJUWxQAxWoEKPYdlS2Ido2sFM+ocD0Y8bi?=
 =?us-ascii?Q?Ae+Q7UkTVa6CzoBFfwG+bHfWYQJa5RZ+1/8XjpGkciV7Sg7AJeoBieUsre9a?=
 =?us-ascii?Q?CYihwuykmAP3BkaFnoP7jB7qczTganC0M6RHCgp3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5404a18-7fdd-49af-150b-08db66599ad7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:24.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTrOY4bttgSpVTyjSaMLVzhurda+O01iBCSyYTu5Rvm5Pdl6Rj0fn101z9HQFi7aBzuiNQSFzr5P4aJLo/udTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8330

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

