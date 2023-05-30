Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9561DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH9bGLfOWFCor/yHw4QPIJHDsalOtpMKoFseAnsp2S8EhPpx2HYtdukgLXItXx8atjdDQv1P1AhfGy87sNS/jEWME3lu00Tuul/GQlFEjKxf327VFyEUTUmGFfCWTAXgjA5kYiiyCuKiA/yI1E8f9pp7woQ4RhptiU3bwtqdFoTpK0ElslqpOD/IArmy3cKu33zPNYYr2nXj/DvzvC3n4YCLuNcox2t7CJVJ5e0xYtQiaOKUmm+lVrqnM77N+7CMKJIlU8odhj+VmYdKenzRYLgU/pcjHCZ8qzszzwlWhHQ77rMoBazOgI7vVZAH3JWo8aIZZPsbC76xWYzVgfFt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMjghRqusHhFYku5Uioe7EFeb30xfqRlHQ3FzULZxE8=;
 b=lA1rz+LTSZ3SU9NqAw3BTjjrZaXtloYV4i4CcwOhljtlsUxB/E3SkgSDPRiHTwrmyxz58qvN0z3aZQe8v8XQKL9ayy2lqE8WkUT+NL+9cFq4RFzi6PCJAYHyubM0xuW+8a4IRFAn9Dk/zaDo2ot2FL+3VBBzumzuBTr953c07iqA+wMiBugvFPxEJCUrLmrIp4z/1P/8M5ury/WmCvWofxEEhRVHe0k5qVv0g+tLdDEJ7uSCsG8oCVvsikAv6j9psWaQade9P73mF4xCipXbGjVyEk1qEmzjKZ+WVaDWEnnp0dK6GIsDS5lezg3Z7OXBPgjvMLiy4/B3NCTnnuWusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMjghRqusHhFYku5Uioe7EFeb30xfqRlHQ3FzULZxE8=;
 b=DqmI2iWFzvD00UtnPWfLLwRZeZbpeVTgzjwGpp02x96CNgvILZivlputPqbLUbmMYXR6LarE9rBQ0OmWcVvdvVvAziOuzGEGNr9c4HNDT+dI+FYb2STsfp9+ofOKT2Uboe+yfddMnvY217veIG6OzLeqf65+t50r68SdIgxYrNWWe+Ax7wBKNykIGB1u+lZLyNnkoAQvTNClhvJ+i0TmZeO5MUr/suya4Td9xp7SfDr5eGQJezbc3n+/a2WUnOesDOl0ivs/8IRCusUn0PM5f0bMo75IIN6lmucm8A4Hwud+ZlqTLHhA6BI39+u41l1ISo09T0oqCJmBlSIZTnhY9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:17:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:17:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 02/15] Squash to "mptcp: add sched in mptcp_sock"
Date: Tue, 30 May 2023 21:17:22 +0800
Message-Id: <513e4ab9e97a6afe564fcb31ddb8af37371d9547.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:404:28::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4cc019-3310-4656-a91f-08db6110493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LgzEgqO+lnS/KM2AtbEM8FobRAs6D4VFe7YadRkkgoHZbov42kCYQnxZV+miZQq6IgggsNzberYrO9HobVDo3IRx/b7bgb700lmYXbvD73sRZvkzoRFgDNMLhVwz7kmyggM4ty9iwmOSFD7SKh2n5CDhMNezC5+ADiLyi0RKOdCwOwKKALnYMS/1cdizfHKjeRrbk5yFvi9B6X9w9gWXv4nMeK8WbzoHFTpLU3WjvfxqK/AI0HIjRS+Zlci37XfTMyB9hkU94PeS3u79d6TzskyEgLGEPuanc7MCWHfXjpbSGX4o5dP+kAp+HS8l3LhBbu8RIi74yzhoBDdqnycrFTTBlkSFnvrVrzlTgsGZxKYZdMhmbWGM5G5Bge8A0VLUJG7OVkH5Y68ff18EqBYE7kcecNs4lV2Y1ZcZWq7dCtM8hQL/z+8yb9mes56ebqCuU9HLVFreZwQZ7+tzIwRpOLPPP158BPbbTrYxflx0ks/gWsVm+jupKiIBt5U75qOuiEPT9ByEER1DXPFSpIvXgQUXVjnICscumyE34VhBGkbjGYqeftt9bYsIlV+irfHw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jc0UZwWl20C0kLYltmt0j5NcKou2FrsR25ae7hS1yAVUNeUqD/BLfbidjj1m?=
 =?us-ascii?Q?TgET8sfhlqEVs17YGl1oEdwh8qRsSnSh/rde2/vt9gIwDfD029GvzEcJgX9o?=
 =?us-ascii?Q?uWPeVk05cn75uxChWz5rqtVz8+dhk/hUXODCzP90xVj7kt6yAY+w32F2QqRq?=
 =?us-ascii?Q?vQAB/j20bkWENkkHmPUDFs4V/wLvD39+dSWdsQvOKFaE/4X1MvBujylTWMZW?=
 =?us-ascii?Q?F5Hvq1AaWD7BrDReXq2Ilw0HeeGTn7wDXWv1peOVAmZpfSySZwtobx4v5K32?=
 =?us-ascii?Q?rcfa9y9sNSH699kjk5fAD9v0NrlryVQcqiASmVDZklJGXLXmZiXFXQ5Py1cC?=
 =?us-ascii?Q?cIeFuOjDr9OJLJ38tFJGg1UB2/TTv5U8s/beig2a/BxG+bSaZIFnzPek4u/L?=
 =?us-ascii?Q?VYixahtYK6/1VvrgtPt43stGZ62i+KSFstYEyxHCv5GRKSAENYWS1pPaW7WW?=
 =?us-ascii?Q?7Q600dOUulxaOp8H3eUePcIaks//77AFdwad3UZCO+YT1RdgYkLurHc+P0NC?=
 =?us-ascii?Q?w51HWEzRkC2H8DYnn1rnz4KHLMrEbeRMaAetNrkhySYif7sMJ/t3QLO9Jhcc?=
 =?us-ascii?Q?mFG592PcyyR33+1TO9cRlWAJbjkIFY2zW0ZaZri9f+mJWaaR4wBq+Rb1fg8h?=
 =?us-ascii?Q?Q2f30zIU5AvJ98Jc3aNpABf89DrxBMrQPm47CW9sCGt83x0r0T4CUnkcov1x?=
 =?us-ascii?Q?IM1WyX77m92cdkCJAglGLtRlw1pB6wlz1hwTFdlzYGOEBodhGN4VU+X7MziK?=
 =?us-ascii?Q?YN0P14oWid0tKodZXsKkqEk7/Qy8g1jTWKfFeg5SamhGp+opPj0xNbj4EIW9?=
 =?us-ascii?Q?YkMejyvpHseSkDofB70Ya82Abb6aMTD1hq3YAFinJA0F1Ew5hOPQQBVX0zTR?=
 =?us-ascii?Q?c6ds+56h9oatUapq239DhPckJ4QheMneSuTqdWv5dppFangwjsOEPEmDTmqo?=
 =?us-ascii?Q?8PAAdquGe9qvmYVwQ9+rtQlXvpou2h20et9ciWac8P78Msqm35HKcyVWCiJt?=
 =?us-ascii?Q?GGVGxD1haJ/l/YuKsYkNTWlTwM7MIlXpG8oBCBEERhMkpJT3dpzC7GHONgG7?=
 =?us-ascii?Q?fkuAUze3G+zjM2Hv++YvzPahrRmlw7gmbUhf7Mv1b3t2bSr0MVEqP3Dm/8GG?=
 =?us-ascii?Q?/Mqs/5wvZ2rFdGnA5ip+ksUw6DKnWjm/Wu+msWWJ+EsMMidx60iK0++W+Eu5?=
 =?us-ascii?Q?gWS/fqYjLDMWD49jboXWOW0bUxEcxqcpB0oG1aAuHGQQGg4tv+OovclQSdTm?=
 =?us-ascii?Q?1ZmCBYvEhb356bVdwmF/2eW8V5juubBZMpe3tY/DNIDT6RwsPgJIVFlu0nZT?=
 =?us-ascii?Q?eB2aCDO5c5S+bYivEx3BgESxdcuV5lu2IVcmns7vK4VvSRGdyKyIcWawLKkq?=
 =?us-ascii?Q?3T4AcjDN7ANZrRkBPdKM3026MeMalPvglx4/PLV80F/J11dJ4Xy7zS9FTiVW?=
 =?us-ascii?Q?AKGBt2XISmCpf77BQMYp4PgUZCsN0RP2egdKO/n0BWrJTYOoZ0QwQuxUtPl0?=
 =?us-ascii?Q?WqiFxsDSx+giFxYJRukeSrHt9qFShyZfjgTngD8lWnQfyl644tMXDNVJY288?=
 =?us-ascii?Q?viisFV5RdbXvqy8XG2X2YLgf3yj2Z8vvCRjbbAu9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4cc019-3310-4656-a91f-08db6110493a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:17:58.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8vGjw2X84Q7a/i2aRuUbwgbWdXz+eYp3+sPrLHZ57zInE5V0gkxxMlZsZYZKX7JxNg1AlEX8rtXcFuvhl1yAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/sched.c    | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 763f709fd5f5..a2560813bfb5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2813,7 +2813,8 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+			       mptcp_sched_find(mptcp_get_scheduler(net)),
+			       GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -3204,7 +3205,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
-	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched, GFP_ATOMIC);
 
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd3771c7d79d..88469590eb32 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -311,6 +311,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
@@ -653,7 +654,8 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name);
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

