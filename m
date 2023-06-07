Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46A6AB9
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW5JUE3rs+9HMfNMmZ12f54KfSDt27g+a6Wl7+8l6kFcc/9mspDsBTkp6tlLdLJQcXD+xG+3AFWovWuSeqKygp82RryV66dYtbYBvosiTyWPvOiWXHN9drLM4461g+P6i9qX5rkHHUVhqE8jQH71VqvuqqwG0ZsyGTTlmHshoGEAS5+iesOojGrNxrr6BnjDjsHSzCwbdon3tk5CIcnaJTiu8BC2XYY3KMwDqeqrKoQ7jgHyBB6+iSboS9kgMupliXE6aVlPWx7AaHwzywJcWTd4Wh7LnOXZ2ztDvLrrgIRrx4aRgK0VN8c4rnC0kNdEvEQqL+PElxnH0RG/UqLKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m20yF3wh6KBXEb32YgjXcC+Lg3SoapdROLjwzcgoG1k=;
 b=aYGYeu22jKhm8X22RAya8xH8TGslHqtiWbVUwAnwqcG06a4RIwnTym0QoyIWmdY0LAOR0E/T61i6mvOftUrOd1w1I5hHWlarfYTyh8LEThHPmrYg0h71GqtA/Ki35qgqoPxsLLmw50GUI7IUU3mAuK4pjuYDYSO1rjn0GqVr2X8j4AeXZLTo67YVW9d8rXwPmh3b1EdsQUDPFEVLfvPrq8p7tYqxQUx49NduX/FRjNMThlpJ7STwgIPz7rM/BYZIkd/LAMEheUbzrNgn34bGuGrkEN/hHLysN3pgxSPf9U65G19TdwEnbsz3VhCXKJwpGhhLuJfK7DXBw1tsEDj6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m20yF3wh6KBXEb32YgjXcC+Lg3SoapdROLjwzcgoG1k=;
 b=q9GEUy0JvByJJAEgYaEFHZTaAzBk3EBzBTEa9HAl6lxlKD05S1cNXlSNJpXO+Z6E7fF5Q3RINxiW9b32yLnDOxm1VTU7xPZRgDTcJr+2+71kS+FIg12t9uoVJqZ31H1zoV/8WidbYbU7ghssomRrokAgTwl8Px3/woj6+1cCcQQObw3nrdlKdRpQkwRZ2GAA47DO+fXvYbvuKmqM2WdzhQDR2aH4/lGx3wi09pyXv4wkr6m2KtPiq0Rs8ujDekZBxTw0uTdSdpY5Jib38wAnnz6Ef4QIwwnJ+2Qu21HeZlCRz806Hcm/yuw84LNw1BbPLP/cXyj4LcXeBKld7iTfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:39:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 03/19] Squash to "mptcp: add sched in mptcp_sock"
Date: Wed,  7 Jun 2023 16:38:18 +0800
Message-Id: <bfc6063cc04fd19a96e9427b7b6e34ea3d3afedb.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fe4e5d-0425-49ce-d366-08db6732b481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pk6UhRRXJ2p+YsA+rSQciT9K4LoUR/1U0XyA2sCqG3fq/241t6CEQcncFdBzcqKhBZL37+iGlVdYcFV4EQTAyjj/Fjm5/G+fuPFq2Eu0eYPGB6bvFqP8cjncL2AVB5+BaCNE49Vvm6DmjfYBdYfeXQ5YkI4cKu4DOASBAErxWIvdaTbsmuIeXDJQbaQw5FlLZhGU8uX+qF4qFygr+G6eCzUDRgCL+J/7yrDzaWkppS4tsKUtHrR9/uQzJuqc0uxQrEux3s2LKB5fsuwzbSwJiepLYfpMkFoxh/Dj15vk7yg3bDypzXedHwDhsPjnXxockeJ+d8MXC13OY5aVxOf+5mow1rzbnywJjqFL+vDFMIOSVCg0orNi84wH3IdaxSQ+JfX8yjtPOafouEKHaN1L0dCKbWhW8x5D0IvlMWLc8snRUJZUbD5HCuRSK5cR5v2j+FvpKTKRkEMYg7rhnTneOKYZXWJ3vKKHGBJxQqVagHBUzdRHfCDRJKRwGOIvi4sT5W+Zzqp0YzLEwZFMIOQtECcg6fdGjoQXKruag+UwcLpJk6pVsOxkit+g2IO0m8ay
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LWyAm9aHSrXEkuIPhRArjekDaoC8R+TBNcr7WRT1qxfsEXB8lQuxeagC169a?=
 =?us-ascii?Q?btgCP4YWpj73y96V7W76uwl1GFm//SlT1gPRlC8OBv3LXCJcTLkkPtwEQyGI?=
 =?us-ascii?Q?P8MutPA17JL/PoZEysUL28MiR2ixx/V/U9ksIrfU0wHEcx6/+EfOMPcHtX7U?=
 =?us-ascii?Q?Nkd9j/0ikIWhJE/lfnupTHOGmwD3v8dogPoPHz1XyEX4ylcitlE+JnirxzKi?=
 =?us-ascii?Q?F8adwtegkh8xSKUMeaKdEhhV+RN+VglToc0hUTq+gGZyprvh22aLnpuPOXuh?=
 =?us-ascii?Q?MHVTG/5buRHW9ng7TAtXz/nlWm6lfzbWkFaF0UJQDIZYRdbueEQDrdR/sXmB?=
 =?us-ascii?Q?FtTBotj3QLWOp7WAuD54PiG0AkMEBsvqWV4zzOMduEdASZOki7GwHJt5RyQz?=
 =?us-ascii?Q?jul4v2d8on89dagriTOINw+u52UEI+CdT4sq8diSqdv8bNINN0sL/nrhZsbE?=
 =?us-ascii?Q?IsokigSauea6b7nl8fvTRpUxEhEP89evuzXPRIYHSaonwOQFvOnaHEEib0bc?=
 =?us-ascii?Q?k7Qcn4OjAIIhg4F5ddUc5fiyDvPbWd4KT2aC3yskKLLPkq/Q2bIzXWD5k+IB?=
 =?us-ascii?Q?w8TlD6IcJsdXQebFbhlyMZ3ZbAk9AsMls1VA7Y46rndfy45gGrtQU7sOyx0L?=
 =?us-ascii?Q?8Qgk7l5CipiRazTcZ3vLXaI44+0WTWX6x1srnhsbz4ojn5Hf0WjPGtB5UqaC?=
 =?us-ascii?Q?ewHiNUDV1LqBAs0eeXRpZHZsiPJCheYsWz6Sb7uUIM+rytiIU8Ti6YLy/2LN?=
 =?us-ascii?Q?OrrrZGtsOns1DOwCXH3aQP/1geGt+2lnUlESUf7JH7BWAcvZKvNXO2px+7LH?=
 =?us-ascii?Q?+FgaohDE/hLM1HKTfPJiFGVCr6BX9w2xEIekeAemY7ph0LhrGAsmYsdx2yg6?=
 =?us-ascii?Q?7TYPlmhPuwRmkdtXhOO+Rl3vS3a4p1pNYpPyFqabBSTghC57KUmKbl7Eso4M?=
 =?us-ascii?Q?zkP89wuJpCIZMy/eYG4H5OVx8+Yf2a6ZLpf+GBOetY6sBkFa/itECE7mJiya?=
 =?us-ascii?Q?9vGPiUtZAYS/2HXlQ+lvwOudUGeaVJZ/B00x5OE0BWNT1fThzTc9ZXWd5fEf?=
 =?us-ascii?Q?mAfKsNdFYBup86pa2EhgyZKMZwR4MOkb+04lclUtCG948zmObWHSJ+JTJ5rI?=
 =?us-ascii?Q?hUYK56vIO+OwXixcUpx/3dRd0g017vqYNIWtPdLvtrimfspOW5qHJaefq2Ff?=
 =?us-ascii?Q?J10fpmEGkAKrxkcpV6w549QDL4gp5XHs/m2bJcY6Q4o33/9SJTll9WteYghc?=
 =?us-ascii?Q?ScdVEOtWc4cvHDBgqtKak9RPNYVYATdPlHIFoBIUxR2OCEiqAlz6W6RE6ZpW?=
 =?us-ascii?Q?ns386gUYGrmReZAEO54r3tQYanDFAXtCKOpZ2mbslrKEOkg9HU3uAAMC8tdb?=
 =?us-ascii?Q?XrSPqM8avRDzsISRbL0a1jEFu8vT2S03hiJQuVaysXCEwl4laRM//A9F0zZP?=
 =?us-ascii?Q?NWNQUloFGoX/Gncp20ADDxRUPKYl3YgxW/H++AVTsvBSDW8WfRgwPh9CUZlV?=
 =?us-ascii?Q?rvnlGldeJpUYwMuemiHbua0OZLG6IhefG4aSrM7o3t7pyF1nmopXwnbuPolf?=
 =?us-ascii?Q?PTwglSuZ2yOhFrEJVtjAZ3snvJtNOkUn8eLuZDA1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fe4e5d-0425-49ce-d366-08db6732b481
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:28.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE05p6UTzj9/kmukWiCeOvHLoNFVS4fTYKjhQc/eEA5BMQdny/6bCav9KOoeL73fLHKgrasoCrEHmibzwbWJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/sched.c    | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c52f0eb8c261..f3e1a0c359e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2817,7 +2817,8 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+			       mptcp_sched_find(mptcp_get_scheduler(net)),
+			       GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -3217,7 +3218,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
-	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched, GFP_ATOMIC);
 
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 35dd3683f735..949f46d4c710 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,6 +314,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
@@ -660,7 +661,8 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name);
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

