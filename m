Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AFA956
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 11:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E28Czan/a7JoMApmNEVbmKqT8iTPNTxXwcx4MHgslJT3W/0tj8Vp/kRiejgGD6Vn7Mic0PtK3svJS5mhvr/YLiY9OTr7Gye2EIbMnKZAQPJvqguIGnQeR75JKOgdDZIPKjuEjHyrm2Z6RRjUsJjyPyEp1aYpzLKMJ6nBmKFMBzvlF+L3FaoWSAft6ACqcA581BC0dnwNKeOX+sVX3i8xp/h7HmRRE729KIOsC0r8VaZVbSAK4OWTwnlcMUm1h3nAJdGsFPNDw4gLQZFBUeaMlJFQahRevhfhmA4LkBSTsehyVG0B6xxM9Xqd/o86cLHbMCMUt2KpimD4/Co3oDI8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA1e/lFfKoD2EQHo3AcE9dWecjx54S1+gnqYkS5adaI=;
 b=O2ZRHOnBTTtAaOQ1zwG5MxWHC6LVccg1g8yIXj9+aQ6KeGH0GAJiGJSARa09F/5YZBH7gqF+k5RAP1QQCOan3azRJNfyQf9up1gtsVQGbpdGFMLalYaqVCqDXuB6rRQVi3q2pXrdTJTFfCT20UZCYsr9rSKAWKdp0F6mtILi1gJXo9evxKNJA1imXPAU7VPnRMeUIbrFipqDhbV9YKcr4ylKVISRaW6Kg6p5AYKELW8cYPD1ITrvipgN2cuF/CidwgC06Z/itz0HrifIJ5J4MiAuHqvd4JgELLDVkqmcEigzl3iDvz26tPeMVj4Mo+TbBhAyJVbbKCI//mPEGnKbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA1e/lFfKoD2EQHo3AcE9dWecjx54S1+gnqYkS5adaI=;
 b=Yj+EPtwx5OXVlDd1u+rYLNKjTJJlyylQtB8E35dugbrEEnq367oreeAnPNpNKDMJXs4yb05k2+CXS4PH0Xg6uIFG84Hy4p8gn/80Ac5EX/1yRLXMSok//HpqbT8rtTvyiYbj1jhy5DV1zGB62ViGVzRsttBJTFZEGaeJZHnmDqOfSx25wIOLvqjqdstPYE4aaMewxiS4+oHBzVU1FBiLA5li3biRjDdjIhaVgQPI/LHhj4fNcksrCEpkvFUu7usmqg5+8f8p29HZXDPLgCJ3HlVPUoOiMcv4AAm2GR7i1H3WYJVaMVm1nx7ehBlKojEJ2Z+ggJd8BqZDOFRalrWOsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7901.eurprd04.prod.outlook.com (2603:10a6:102:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 11:04:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 11:04:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 1/2] mptcp: add set/get params wrappers
Date: Wed, 23 Aug 2023 19:04:45 +0800
Message-Id: <c49b9788e6d296343d0f08e28c57d6976c7f4ef9.1692788531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692788531.git.geliang.tang@suse.com>
References: <cover.1692788531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c20da25-d8c8-4f57-3add-08dba3c8b8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vuQ7bwvDe6ATUzmyulnNT2VJH1C6CIx6jPCx7ERBFRSdGMs5uQ1cHExBUfKueBZeNl4A+znB/4SnJPm22SCxAuSFFxMecn2Vo0g7sXmiDCUGAPLwDqSC5DpnKBr79LDYw/DD5V0mXrzw8SLp42FUCj7IubMQ5U78ROK6D6ZSVNt5LIdPACUQyrzGMlXjWHT0HD82x6KT0YEs6G1qWMYPiGxz7ShoSpVsa+kGHpM4fhvEdGqES4a1ysf2o0llhmdkQqSmsWEbZoh9xgPM/TMWyoXDPAjUTM46X3f713i7zYAWCqLkZnnjXWQjWKxUzz/mHQ3WksN9aYgFRVWrZ3gDRMsC/MUuRxf5e9kS1bKSLRBjD0Z8Yu0ypb0tp5fiyzp97Edf+UogNeo3nKgKbTm+5VSrISAb5tnh6lGSDTQKd7vkxL7HFivRcDc/EN7tSsY7CnwRyW3d83rPpIhKo+Y5oOQBKeHAw4o6wpNy7cRVPIOSM4BaDIisfUCjkcw2nTp/r1j2wkl2lePPbOCeOxfhrtk+vK1jofibwrGPTFA7bz/jImYJ2dCSdJCHKY9UBM1Yl4yFXnxNvbZ0ihZNm8ZrL8aU0VWfOJKKw/HxrTiO+QfL6MEwJsOJe8/Ua/KyggODDYWV1xdveTaDTSgMFXReTO31rDjIMv2cvcH/LnmfDFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199024)(186009)(1800799009)(83380400001)(2906002)(6916009)(6486002)(316002)(66476007)(66556008)(6506007)(66946007)(6666004)(478600001)(86362001)(36756003)(44832011)(5660300002)(107886003)(26005)(2616005)(38100700002)(41300700001)(6512007)(8676002)(4326008)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfwDWohATLFQjEq6FOZys6h1cgVwe+At1JrmfF97EIjYqz119qiVEyghfBK6?=
 =?us-ascii?Q?xMDcMDHLze9Q+VqghjgBWgoaQSMVS3HDWmT4BXlNsOVXHHNB7yvch7+Jsu8N?=
 =?us-ascii?Q?7JdHeOhqWxThmMjag2vJqJEn7Tlj0N7X+iG4Abd+AuTigWCGchjBe+h+61mZ?=
 =?us-ascii?Q?hy1HwNJ/hhkA5bJ8SuL6Q2NUSqzNmeIgqY2876NRW3UrBn3w45GdKfr3vQbt?=
 =?us-ascii?Q?FtrPBRZg+Gb3iKBSP0teeuFGTbkgdhwU3q/P2V3QULW3tQtKYrPZNRRwcyC9?=
 =?us-ascii?Q?SP7yxZk5B0hR1UoPQ+p8x9W4pj/ucED7E9QO92I2W5hk3xuLghNE9URS/5I6?=
 =?us-ascii?Q?RoAr8ZLUaI4t4n8R86BSW/cEqIfzgQlzZ7vvpcv+io8EDI7zP6KkKUoBXfE7?=
 =?us-ascii?Q?D4u/PetqYn93InOQf2qPcUsnmaofHkj3+fVqKEElHBNqK9mhusHk5DRw94es?=
 =?us-ascii?Q?gv/vFNN+nhzOfeeEyf7K92xBnR7WJtMZVi/po1oWB6EILiuD1e1lAitKo8ba?=
 =?us-ascii?Q?UoXsktY0sRn2dVAsmMUNP5jsCY/yoUKtm5G9Hep38kPWoa00GGwPsPYXzQe/?=
 =?us-ascii?Q?OTMQkzmBaZ1934yFUWRJbwF7JRUQeRbDQvxqMrICFil3aRvwjIX6LOeDwFcg?=
 =?us-ascii?Q?u8nmzAAyWSmUIP329vlhm4QIxJvpbBI0iU3iW5Dn5jCG5LnTEyh7kAPZGPsU?=
 =?us-ascii?Q?8L/ybgALaUZln5WR9N5OWx/VyYDy+wrIA/O7aJjgtJIvzUZv/V44w5++pNYl?=
 =?us-ascii?Q?hdUqAJYak05G2NgdMzbIg6gInWLfaLMCgdZX4ITzNp1AhDi0PmqCiUjSmqHj?=
 =?us-ascii?Q?2nxkD/73wsigLsOBKQ4zCa2r1Q8gC44ko4/L39GLASPlSJBFI5zSmRFFQ9lP?=
 =?us-ascii?Q?3Qvi/lFupYUDQQBdtHWyS6JLxL4fKakswDAvlSPbMpxY3/nx32CNWijRw3aP?=
 =?us-ascii?Q?4gtvCJ8qypDar7QtP1ts+4NhOi8PEuMd1KPLebHFf+OojJZ+x3nyDyckUgI5?=
 =?us-ascii?Q?jf6a87iRy68ZjI1buztZbkHnRMy/muIapHB6AfUWf7suAm619a1iCJnRKPdR?=
 =?us-ascii?Q?m3i87yqCIA8eYdDtvJrRTn+aqhfXr1Cnoeocg6ZIjLr3P3d7p/rjD4VnSRcl?=
 =?us-ascii?Q?aVPZWMvD+Ne/trhk8XzSPRemAXqln8gTn8oi3BMgN9CQOS+2j/e4g7Kt8rWM?=
 =?us-ascii?Q?teI1H+zJEIE4kZgjFUyMroxO3oU2iFHAfMEh4kGWB3ZrlIrFTZ1+D/+tGbHR?=
 =?us-ascii?Q?6pBuUYMK9vJyc79UNjpj83MrKmccS2sLd3mXkb5PzOZfmOBGVbEvaw2/hv23?=
 =?us-ascii?Q?cE0EQof+ALf6d4pGt1MPgiJFhOrRGYJepSvmDdizAE3+qVKHsSJmS9sVWKr/?=
 =?us-ascii?Q?j2R13G2L0BJ8kZ4U4drqVYYKlx0LHsBg6a+1WRqEEHNgI8ky0OWj8d/t31F0?=
 =?us-ascii?Q?jVamXeoU16Wv1Fk92R3kglQR2wrqQhO9/AhpMg7dB9AW2p04GE8HzdAhzS7d?=
 =?us-ascii?Q?J0/XXHeGo2ol/auzFS7RPkbcy5YMBTrEwENMRn1Wsoh8nuE0k1b6ZWLm+AVG?=
 =?us-ascii?Q?LNPSNOI4qpkj1c/y0OXxzfWsdMmLQfufsYR4J+YQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c20da25-d8c8-4f57-3add-08dba3c8b8c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:04:29.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Fb6OKOu89csUEEJ9pXQkXAU9+TVLM/bWVsy92Hl2ZO61aKUjAXkkIFsstapyD5XZgQ23NJ5fRBBGYtrIs8kIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

Add two sched params wrappers: mptcp_sched_set_params() and
mptcp_sched_set_params(). Use these wrappers instead of get and set
msk->snd_burst directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  8 ++++----
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ab3aaf6cacc5..7c1e72bc5576 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1436,7 +1436,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	mptcp_sched_set_params(msk, burst);
 	return ssk;
 }
 
@@ -1454,7 +1454,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	mptcp_sched_set_params(msk, mptcp_sched_get_params(msk) - sent);
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1507,7 +1507,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (mptcp_sched_get_params(msk) <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2291,7 +2291,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	mptcp_sched_set_params(msk, 0);
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 12d70ce24843..dbd1881f8f28 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -678,6 +678,8 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
+int mptcp_sched_get_params(struct mptcp_sock *msk);
+int mptcp_sched_set_params(struct mptcp_sock *msk, int burst);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 2ae3f33bd244..c78ed61290d2 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -199,3 +199,21 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 		return NULL;
 	return data->contexts[pos];
 }
+
+int mptcp_sched_get_params(struct mptcp_sock *msk)
+{
+	if (msk->sched == &mptcp_sched_default)
+		return msk->snd_burst;
+
+	return 0;
+}
+
+int mptcp_sched_set_params(struct mptcp_sock *msk, int burst)
+{
+	if (msk->sched == &mptcp_sched_default) {
+		msk->snd_burst = burst;
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.35.3

