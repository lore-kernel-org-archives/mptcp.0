Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03CCA45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/9OaqZNeXgzKvFiY9o5mpIuCIFoAfKN9xxBkD8bHRKFppK72eL/6257B7O9LW7FaI6xAW4qPRNadktXJot5sDx0EyBYvCu/DEsg0tS0rwNMZRjrj/cwiEE8VfPn0ysX9RaS8xDcjAWUiOQ9yKmeSTs0W6oXFVolWnc7BpJSDI5mTiPz8w2MVGkPM/OH23hUpLdpuHfpdUw2woDt0LP/v5ViIaz/t802OjFI6qblo138DylD18YdYVDb1ks5VVYhtyYoI/R/vigO9DVRIQJONKb1sKNryw+OLxhPv2r7b3O/yIY7HVrBy5YEGfsCLWRjfog65PFDpF+zVp1oJ7lBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvWXY+rcygsHpFQ0NjObfWxPO8Dfl1bxguZBZoojt+g=;
 b=YjGGT7UrkJ07UFGiV1AL2qmcDIV+n66rUvNX3tScGBAY62UOZUbDest5Dc8+m/tVrHnDPhvMi2+NJUj06rO1l9iQ4ZcXPSS6VC3NARnfifp6+nLMEUFE7bhoFQTIurvgJnlCaDYV3bswjfLWuoEbLM0dVyKKCg5Wi7n8psn65w7g60J8rAWtU1T5P8tS+rnXi2kP0MEEq/JM3B/5X2VpGuerXtzEOfvkaZmKZuHXXg/PZsy6Wor8Qwzl/sYISVngaeXK3H7DGiK8MMUrDb/Cb95aajPFDvfn1hjR/fY1gFPGtSuX70URTLR9eOCCFhhlnhPozu/tdGG1boErjKD4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvWXY+rcygsHpFQ0NjObfWxPO8Dfl1bxguZBZoojt+g=;
 b=Ymm2qMHhPri6qK0Y5ck5aERJYPRGGKTJVvq55YKvpeMLXkGDjFrHF5b/t1b1oJv2lWB4KQWXdcc5ZJFUypTGzDlDdu1NzxYxhhm+yXptMS/V/dfzuE6OAulOpbIVk60C9YGCC0bWXl4xO/Tmn2o5ciBuMNoI99YQL+rUwSBKMylo3AHXA5FMHbu3Cb8xMQC0leotLPCoR5z8LjiJwVL2qEpdKKCqG92J3yWge5AREXgTk+VecPMeT2SKkvClVR0bt+Nl7uZjaNb1mHiOSE3urfn74emttCXBgYtNOjMUQugdPJUbARtmWnwflyQsH1EnozxddMUMEXKyinudw4bXeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7263.eurprd04.prod.outlook.com (2603:10a6:800:1af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 09:11:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:11:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 1/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Fri, 14 Apr 2023 17:11:04 +0800
Message-Id: <d0d80bd0407f27ae087ad7e37eb2f58b11b7d15e.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VE1PR04MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: c995721f-c8a2-4a1a-14b9-08db3cc838aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wetV4jz72cme24j3SsY3xlFq1og8ZvzmGMAcxjttjd0KhyGGzLbXD9MWVITECGXr2nZfUgBDd/Oxas537IEESbdXvhyDsiJwohxWKawj1PQ9NKREdvxUUHhYBS2Kl3tZ539bRyHb8CuTUl0MeQGab6CaoaQFZ+SGA/HyMP4OcRMYQ00D18qAwYtg/POecQ8jj/HBO0+SpmSM2zJf2FqBcGPr9qCe2U2jYZCwpGD1bBbnN1s1z2Vgdq+Hrp9z4NTFwmMsrp4rduxUcKCxcD9NGPz7zcxrQB0/VIT5s5gs4pzoButwuRYVePtD8dPipOnN+1YCBzIvUWk2igK1zAUT+ydrmyuq5gPTPy4OhkXlxEJfIMvcU8ux0nqf3OGBjj1hBSZRoJH/R+I2aBvewKHSnA+lYiVwcqy2BbIfNaFHV1PsLKwPvOyaH/7MfpkJ098egeGC/CNAd+y30ixb264LcUxpOvJnU+fqS+X86LrZLDizEqUCqyg6vs604d+vjOw/kH8gZsJlul80j1Urhuiow1N2aoMCDsDd80Y9srt5wPXped+XTvks1xcDF6fstoghOtHuhoptj8HtY4FPM/k536UWbHMv+oTekIiPBuozlNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(396003)(136003)(366004)(376002)(451199021)(186003)(6916009)(316002)(4326008)(66476007)(66946007)(66556008)(107886003)(6506007)(26005)(6512007)(38100700002)(2616005)(83380400001)(5660300002)(8676002)(41300700001)(8936002)(6486002)(6666004)(478600001)(86362001)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+RSfOcLcWqrmFIZ4fKkazVogFZxqkQgzvw/4am+PGFf0b2OCInAkuJhFMt5?=
 =?us-ascii?Q?xdXa1iiQj5EYBBJ20/vzH4sDdCxxwYmbD1kdp1H7S9mLSf/mRX3iNpSRIJsn?=
 =?us-ascii?Q?zMsL4vTwNZUBWNIFBm8dSAoHCwJALRJYZOXwFGnohWP3Bu2qLd0/a2FBGbax?=
 =?us-ascii?Q?EEBAiazmjwhY4aKi+3cnEJASjr7jAHTlqDchoh9qLhfPsE1E7EliakonyMqQ?=
 =?us-ascii?Q?FZKu8zhy5h7hDy6CAkaSJ0/D76eX3+5QjG49SXCAGYNEK5QmO+w9DTd2IB9A?=
 =?us-ascii?Q?DsWpmZiHi4ufuUCChq39opeU4QUMDlu0RT+8sarltmBI2VukNez5X+01yoYm?=
 =?us-ascii?Q?C3dDZmhRc8xtE22rTEHEUSrccf7Md3lKGdqSBx0nAkEpErDcQGmxeWtAgLUy?=
 =?us-ascii?Q?7pofZeRRrBEauYUB8OaOMxZaGBy4GrW4hJZVUO5YwfCdsko3PgmcPeTI6Ic9?=
 =?us-ascii?Q?4lsvMgp5xGx68ypI150AnQWQctvPicqel8cuvq0I0SQSiXf0xMcuG+nVI4RO?=
 =?us-ascii?Q?TBV+TC90AkrEt+8tRTWtYobbVLb5sczhIFGSgWlAEGPg8W4ik9p8HE0e4oTz?=
 =?us-ascii?Q?xAFmMJ+lwp/3/nDqsL5j3ZGH5IdGc9fK7JWz9N1iRyVoBdM+S+I6vrAfnonS?=
 =?us-ascii?Q?bFSQyJgQidmhFSMNB+aXluSlQfW/QE9jVvTpg/Jxq6Z5OCetykHBMErhs/qR?=
 =?us-ascii?Q?HN6euf9TRDG6dgfWtezakP7TrVMTZAhzNdyF4PBr5lDj8k5TDBuHaWdRvvha?=
 =?us-ascii?Q?rIALUT+ThzoRCu4p6RHJHnfgtplgGK/uFW5/k3WSbFeqUIz+/T0dKvuT3TFJ?=
 =?us-ascii?Q?VpHrFG5ccGad3YFrwI5NHNPbBxtXqkpFDDexnCL9iAGIjLs66ZMtB3xqWYG+?=
 =?us-ascii?Q?9q6FMKIfYXm8zIEZdjJP9505hOau3MwQWie+B4cSE9DBUY3sxWORWJraHHtq?=
 =?us-ascii?Q?xocoLfTM0+6urx+s7ZU/Y/aB20tf+er7UiJNPQB5lAscHTvwzQzzHLA5KnQ7?=
 =?us-ascii?Q?d34soXBVRyvKDBdUfZqGgozswUBetAXYSh0mk1eZXAziHmJAp/VE1F01XeOn?=
 =?us-ascii?Q?TSVpm4D9HkCbU7Q8UVm2c2gOXhDnnd1pZJKU8JwASWxqWv+rJG4cFn5MRYuT?=
 =?us-ascii?Q?9jCjkaKS4Jy0aZTNIX+1yl2BjH9a4LNiDAX43Apz9qOeeFJQyCcVuK/RNQNd?=
 =?us-ascii?Q?wMYwHzEbSGdU7cHuFSHOhtvJcNkGf/5/+/jT+BP/Y40ueBsP+NV2esuG0f8+?=
 =?us-ascii?Q?vtyuH57+8n3GmM3wQKV2frERlYMhvuu3zF7eZpov1ZIFLh4bINnphhIacPSi?=
 =?us-ascii?Q?u5NrRpIvAJjt9ro/cQCYlby+bPN6evq1wiBMroxkvzKT+jduPldg+6y2xXf1?=
 =?us-ascii?Q?45xIxUZN7Vis2JI3VLKGjhhMayyyu1432Gp5HYTB6TOKsEMzhdAp9jMY4jbM?=
 =?us-ascii?Q?mfcCHHBz2U8bWoPZ+esTB56oiO7oB249dU37cPXVxnMhcDNoYO8s8vsxwkIT?=
 =?us-ascii?Q?B16uRqv+Czw7uNHdZ94lVbSidUiDtdqJIjGBvz+B7y/bM8Tj4T+TMBOQ1D74?=
 =?us-ascii?Q?4UfF5KB6H6TsibE9wPle55aYDsg5gHihBiwwVDMZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c995721f-c8a2-4a1a-14b9-08db3cc838aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:11:24.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F65mg4E4OfGgfqlEqP5+MTQWX8s/1pQ5bKTiDTBcVlX5VYCRG2CM1cn0YcJANWxoW8la6wWHhBffU60cFaVE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7263

Pass addr to mptcp_pm_alloc_anno_list() instead of entry.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..a02822111218 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..4d0e54fab5cf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -170,7 +170,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5a35c77723e3..990c21a97975 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

