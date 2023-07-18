Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE31842
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frH9tnwU3ebkpRd6664AzUr2boghzq6/GRHPizzMj5g7WOdCSrlnaWkVpe+/aPIFslpal8oNR4slAvZjxD8/zhbGuPmsSLQjrSBhP9A45hesXync0GLpynU3Loi8j+eexJLJS0RhJv5xCwL3pbe0CVWAyXtQ0zSh0/PcCUIVVSsTPsQpcB9Por3IN9mGHa9dBr4zPo71n+ZILdiFUZIWQURbW+A1md8laK2ASs3OYwJBt7ln0eMPUZ3JB3ZQKU2zwhpAQU1wKQpSB4LXANWKuiSQZ4FagP+gVe32d7p7HisdZOkXw5HDlMEn2g/kGmR5zinj+aMNqrscvV299c0PQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YE687BerWCqwdvVxpsNy/9sVNdigDjrnVXigbPIT/74=;
 b=AkkwsP5m1ioIi6EIprRV+vxSxDI/NMdbzK6Nnn7cLILPKf8tjkw7DzGg0fwouZbyDJzbnnfve/yXba91BCLgl9kec9+PLZ0CnzechGaxfEYxKeNUj+cuPAO1KCZUao5U6q+HLnj3jF+OpCqYND1Cf5l2B3DPG4M0TP9Hwmi/dRJ/FFtTuOzU1AtgRz4VQ/Kf2uxcSdC6odXJOVSuw9fUMcwQjpgYnu5DYUpdAYaNFvtE/ar8KcO+YS4Mw8FgZeo443EKdHYo6aAY5OilpFvv9yqaUsFBjNk7namyEwbB4LOt3cuOfnwa1CHd0gD6OGbu0KX2GLdhz+PCmpOOKj9/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE687BerWCqwdvVxpsNy/9sVNdigDjrnVXigbPIT/74=;
 b=1w7SS3Lh5sCm3fTbMjf6/Jjeh/HNkX6dIeI+Yumho/4T1rvYxw+enzhVDxeGONZE8SXHUqua1bUcKBiF6WDxFaatL3TmTuKTpLmFgpVpELcWhPTa+OGeO6cIbHFIokG57Lhq0/BAHYd2Lj+PZlVwTBykhb8wfm3Q3ChuLtboMEA0MXCzFubd9jLCIAxOtyypAFYQaamNsgpiLt57CTXym3TOCMDBRBV6jffg/OtkTfjwYEy/5XAfyyHg24v06GS4tJvmRR+aAqkS9zmOT109oAyz7FtwF/8gSrjsCi85Oie78eHDLIBY5xjGTHLxvRiSjXwmA9QhWBW84HnIPZJgUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:38:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:38:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/13] mptcp: add subflow_set_stale helper
Date: Tue, 18 Jul 2023 11:36:45 +0800
Message-Id: <94b445b3225d4f91e2d05cab0338c4367ecbabb4.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: d09f9890-13e6-46ba-cf70-08db8740663d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vAavYEnB+/6h/ToDCXI1I6T5m3dFscCBuCs7n5kac4iBBUdy69/4g/O1JAAs84FszAqHZtuMKtHaoL0Jx/USybZ9+6++x/c6a9L0to+c89iKl7vw5RL2i22n/5cpP2hGi4A/5lVlF6EmKMy9s4EEdC83Xw5csd5GSm9fY/4qrl/Cu2PwSyt86W2wpghrOcE/bwZR+hW58isj8cTdMxW3jnqHSKJ6a54EZbvj+GqKGxJiivT9tbD8zZCfxB0ej5CippcDPec/LIDC5dlbDasP8AMx8ngWKWICuV3kwoXmDQyfIZ1xaNpuzVZBYh+ereQXCLbNlDjqpLGaP8LdC1DuLRtyHCI2dy6Pd1HdBGGF/bPwHuUQu7u+frg2hZbQGJrCxXbnUniNIafLY9J4k+Bm/yJSx3Qz5Hd1jZK9Gbb/V/LRrCGMvRh0nLs8G5+s47arCIr3anNZkp26/RatiMrCLeBQ5cUWLyt+NjA7iJoUscePqafk8yCw1uQiftOdE/7E0J2HKXEvX68ZWj/MjAxXPVcOWA8Nuh8wYU8eU9CD+YM/XOC5dArUl6nhO2r85abmh8qgXdIimxLWmM0/DFDjLk/dco0n713XBuJ0uCa7SgI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPqeDu0bzbhTLHL9bS7EgmfglGnG2w4fnEZUUzdCYhomfgb9GIj2mUJummSl?=
 =?us-ascii?Q?mcWPfWSAbgwNiG8dCVDrIIhEpBU/XEtgRYe056YtYaGm/yvChpoVwx3DWJa8?=
 =?us-ascii?Q?Lc3pQug5A76jYOcimvvulvuJqTbBvFbfZztGY19zMGDqwLZrA8yesdmSN6nO?=
 =?us-ascii?Q?g1i6W3vQ8JtxD8dz9E93x+M1j/U6j8yQfBsngcXhhuIRl6H3OWDpkbqaqHSP?=
 =?us-ascii?Q?5r8dQpp2MFoDEWbeH58Enukmm/YNESHWaLrQBLCLXn/9Fl1XesLS+kJhRqav?=
 =?us-ascii?Q?ENI1lk5xg/38k/2ctO5Xa9aZRiyas7A5yXbG5cw17fk5fqNyJpW/zreCIb47?=
 =?us-ascii?Q?+Z572rGOd5Qovk7Fug7ydCyCzTaGZ8taZehWWgQPtKu3vzlR7V5SaYUFmkw+?=
 =?us-ascii?Q?1EqdlNx0qVno2b1OLph65WKsIgt0zhw1luWQ+BKEw95vxr2wIyUhWFecxb8i?=
 =?us-ascii?Q?Nc3Blb/ehNAajGxmaO+sAlYgJmw74MDduyBbHnjzbL74Wo6acwnNk9x4/6HP?=
 =?us-ascii?Q?lpES4qxP+rTvDkSAk6B/Xd2pR3qSKEbtoJFDcwRRgAB4z+GXeTtPkY+I8Ive?=
 =?us-ascii?Q?nvq5paP4uK2AjYt3Xu1DtN0w81F/My/YeL3YXRxxbDnMph9BK44xyD06cuSI?=
 =?us-ascii?Q?9FQpjCxEdFeG3LPRDvgYwi+WW2esUyD5knjQMrCOlAz4WP87gKIQAOepNi25?=
 =?us-ascii?Q?5/HIWbr2IpyaNzuiYVmnA9U+qN3REIu4FaaTJWzTI7sw+JSq6L+p3NB61rlN?=
 =?us-ascii?Q?Jea3YwZHxh2pvixoNVkYZ/pVD6Wiw/Et+u3qcvBE9GEvwiIFNbgyGT44GsIW?=
 =?us-ascii?Q?KXL7zUpuAAEXAXjPQNJxqlnpkXT/NCf+8vgVN414OqNKV3WcRKXB1103Wk/V?=
 =?us-ascii?Q?naEgPCeKa+C0Wy0A3t4pifYn+PQccHZWjfwz3RiGN9yvMmc98haN9HeYw9ZL?=
 =?us-ascii?Q?ZZPOGBDOabc227TK5mJjBsj9VUXmfWnCAfBIheL6xB8z5wnxNV5SSDUCF/NN?=
 =?us-ascii?Q?hmUxdmpMy5qyGWPHQgvHxtnOkfTjfgmwJWaN31ISgTeAVYkX64BemNr/7MYq?=
 =?us-ascii?Q?8orAu4/VQN4XTkLW1FElS8kA17iflmXegb/n65lfjUVTNDzwTZbMAmOgvMiJ?=
 =?us-ascii?Q?mL4eJ7MctReE5y5MxGGbO8BAVwTTIUxWdx2zNkIxPsF7NPixmrSgleOgN7R0?=
 =?us-ascii?Q?LFSkrqg9JwEHcs66yd/rchlTQPsOmg6O15spRbkWUxzUWG2Nmkzk02lAojT9?=
 =?us-ascii?Q?i4hov6WcivHrKRJiTZbmrFC978vylEbxloFPIDfODu8CgdTG2v9fwDi0m4eV?=
 =?us-ascii?Q?WJRh1gVu/ZY0wi7IqB995/FCCOg8akUlA7up2nEC/wvljlT5g1t8wGgLwsGY?=
 =?us-ascii?Q?MHo9e2brWsjH7hBF3+L5VVLa1Yg5Gbg9LzntqE5fDlXRCuaaIALRSPrKzKH9?=
 =?us-ascii?Q?+rLlN1AFWYFc50falc0oKRd07VgmYo8bXrlMt00v/+0u+2a8zNypougIKPjt?=
 =?us-ascii?Q?noYETdStev4DoXnExIfKvkTEQEFkEFe2AE9AvbvUqGOXo1bjLsCOcuMkUB0M?=
 =?us-ascii?Q?+/YW/FpYzWKuM3LWq4xyszm407n+yE0VvPweOtuU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f9890-13e6-46ba-cf70-08db8740663d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:38:06.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baJljy8IHyojDWTOl75i9QYg6qg/NagRZfBP7ogLR7TOQKvJmc+Yu12NmGwTI9+IzsauZX2lrrYzFwIGgLBkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Add mptcp_subflow_set_stale() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 1 +
 net/mptcp/protocol.h | 2 ++
 net/mptcp/sched.c    | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f388baf08d49..e6f94d5e22fb 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -146,6 +146,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_subflow_set_stale)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1b4457c44fe8..78b3beeb7d7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -662,6 +662,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+			     int stale);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct mptcp_subflow_context *
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a80cf0481edf..3f361e75e38c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,6 +127,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
+void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+			     int stale)
+{
+	subflow->stale = stale;
+}
+
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data)
 {
-- 
2.35.3

