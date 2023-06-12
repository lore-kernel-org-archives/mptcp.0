Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508820F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iihv7j8PJjL9JQhUFSkGHVIJn32wFLRgJi+RZUbexaZoAQW4nKGhCawoUiwvlVfKtCPQ0KrszwOFGfa6JUC4LuJa7Wk/ZC39NaJCcGV/tIY+glXdw78xUKq17IFmLw+QeTVT2nbA32OlHsKpL0zQzvfCBe23JQ8QePuwsAvG0XJsQBFOXfs4b3Kt3llTTY+RrQy9LJAhDuszgcNrfrbJcjhBLa1RgjSZpJoTvOZPb1sgDb6TVU/CvXpmAovGsOYBQZc+J38D77PJroP6P0qCJZeJp3mEjT5Z54Hqjd/FM/B6anThIQdh6O+4YtGtSMrN/K0NMDvtCm6oLqlAUOzeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=Oi3PhW1e2beLXoB5Q5YgLCyTbh01ecD5aR538UG1tKx+EquGx4E35+0CuRPEXifd1mJM/tuGzNn3SEjU+ZztaJUIWH0yOqUjPzh7l9q2aRgIzmNxGLHSPvXERfl3UGfHlzoFp6YMELqlZ5XVuYAzKTJzZII+EUg4GXjoZmRAdnNxE3x1qKXLyZaU8H0knfjTky78ji8fnWLfvTNY0dHfjJCeiF0ZSTRZrnbqme7K6D1EGC/BRVb8uQkolgh1DnkxBM21DKkGasKdk7ex0oGQLVq6WFcnfMOhToQ9Sk44y2+ncIbTa2bb9IhJU4OxS3F7LRvzbnTFQAb+TKm+i16h+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=PF1IMhKnuJiSAdwl5pgP67zqnjr2mWhFa4WyayN9X90d90vMscztPCuPsbHgX4NhZ0n+Ypzll1h+Krf1Jskky1bpsQ994dgWqXtCHNqp+QYrjvTtghqBprboZjTJISvJyMWwISj/LHOUCJqGYJAd200PZ9A3zOmsxvsCYWOY0tEyGnhyJ6pwoS0Vhh2nEaF656yuL5rYKWgSPiW/skM2NKrT5AfWt4Icw6TFUMp394BvLywLdUFHnsfjYKGNebCuS83yo+87LSlXMRR3qpwPgIb//w8T3HSwcZ/F/k4nDbQPoUkSXvYX5sMSApDXXj3ukAMzsFdaH6joPXv1CTydTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 07:20:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:20:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 1/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Mon, 12 Jun 2023 15:19:40 +0800
Message-Id: <c3840fe912690b920e46f1eac9f920c26479e610.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5bcf75-2f12-4adc-c5a0-08db6b1579a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oQs+xbo1D9VvYKktx1mTQcN4F63F1fC4JHDxmswWJAlMZyhJdGeqaZ2y0v6VBqeOUf33lm8weWa2YB//i+wdopfZRyJeTYmhxQG6ZGycK7X9c/dcrDMK2aDou9y+2PPYtFU0HhC/s3qQbXRgPAGKOkyImvyYwDHcrtTCz62pcdbsELEIG1qfEd4k78ZgxIfg9NWQGxT810qPZZEbLMSECdg0M2/iaEO1i3zCyOxOKc9a1+xuqw7cNobvoYEJJSnBIXvuBkeuMzHZS65LgcBB5lLU7mcz015jFM2WOctmLaoLBc/1w6V8vVQHv7Kn1jHnEhv2jb7Eemi69P7BEd6WUXAwlFxQI7Yru/tWPUTJIKt5EeWJqx/CgkipQR0Y6Ho3X7bVjVGhLeD/6bd4q5EhiuPeDduoYV46JUmixSx1pQxGYjBlxpy20MbFBhctpkgbRntvTnYTy0SJ5zb4kzUet1bmYTVS+qiQe6J50+kdw6tgvtv0xc7jBBwU7a3AE66asiERh7GBmxx7utaCQb6T1cj90B0Rd6kr1kNXEMKIPgU3bGKcqio/xUZt50L0eicu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(44832011)(2906002)(8676002)(8936002)(6486002)(478600001)(6916009)(5660300002)(41300700001)(316002)(38100700002)(66476007)(4326008)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?leTeFR4w0ID17ekD93vy0l8uWtt2KRUifG9xZoyCjoAz/80obEefmn25Lmye?=
 =?us-ascii?Q?Zhm/j9cvmxzoY7YEs587fQ/0W2Q0n1KWBpTP4+uZasSK1m0saZ1/A++8XIUz?=
 =?us-ascii?Q?4MPvGuWTCp3iGkkAzAM8RlB3SR0Xb/JVqfbzmMleH/hGBwK2M8OuKUzsm4k7?=
 =?us-ascii?Q?5a7H+XD8BaIDaYa/fJBDu51qJxWuDHsaFxiHDounQpL+1Z/jI9vabX9hzopY?=
 =?us-ascii?Q?U9M1FrysvYtEjKd+5eCTQnyOx37WHcVVMW4qtdI0Ya0LDH27xNSVmks0yXpC?=
 =?us-ascii?Q?jAvoaxwV1joKeWibdjSGfx1IOlzHeeWki0i/OlSv3TWCJckukHn2AcaZQps9?=
 =?us-ascii?Q?tiTzqrlqrtX1yllrwV31/J01ywkuZQQZHF6Xoc8jn3SjEJ/y6r7mWyHNlLhO?=
 =?us-ascii?Q?1aqvbmPxjtwIPgaPOpenYnFkiKITlJEcR3QdqLvAsbrMMc9VJB6v7tcyV6CW?=
 =?us-ascii?Q?Ds4OT2NJRo8EfyRq1iW2vZkDsyW74810oyF6r5K4GvBDnVSffscH1dgYbmwk?=
 =?us-ascii?Q?v0YcIGaEwJ+42oF3rM+1J+G5w0RQdiVa9g8hxAf3q8w7jSLHz9e97UYXEnEf?=
 =?us-ascii?Q?ZsOi1nmteaAkYREQK1wNOehfgFLlo0LDkHLF3gcMuBiQwFRHpJWMQ70iTD8G?=
 =?us-ascii?Q?W7apT5zdyf+1WJQtzFCba8sKs79SMp33nGZlD+l3PAIU80P8Wbhfaw3TYK5j?=
 =?us-ascii?Q?l1fbViltNEoo7Oe8+78y9nm4Jyb75aeNx6s5F3bxY3hK+U2blb48LzZqMRhK?=
 =?us-ascii?Q?rSvHM2Awfun04GScqJ3o8nWFO8akSPAaFBsoCBWmO+sCTsilohqIwDhfxz9w?=
 =?us-ascii?Q?YUD75e0htUBZw7z0jow0Y9jW8hLFcgkFtH6VZiainIEH2AtabA03wEaUcAW2?=
 =?us-ascii?Q?oJ/PSsz0aVeNUdG5xNpRS2pkzBV8a7YrRvXSd6hb83e/t39WOgo6NGIqXUv4?=
 =?us-ascii?Q?b9swMJ4oadr5n/Tj2T9q7oWWYZsJRCO2sa+unbYj4ml7DOUD9GUT5hnAWVQM?=
 =?us-ascii?Q?DIe40iXrVNtfm1uUgAREXG1RMlOpUdxH0GfDmDHQjo8SEEV0aGS8EHsMZuB6?=
 =?us-ascii?Q?LtaoV0iYofimsDVuPYRnICZzgjxKWIjUGLnyn4WrdpRet7t2fqiQT35Wj5iW?=
 =?us-ascii?Q?mZI4ZaG+bQR3eSz4UHHbplTOVew1wt3fJB93iJoaQRBV2Znzln75Jq6E/3/Y?=
 =?us-ascii?Q?WvIxQyxolRXo2aF8yBKS0o1qy9r2FtyuJ7BcW4HfAZ1Ebx4FiC5Tf3hglSc4?=
 =?us-ascii?Q?TRl1avZrQAnjMv+maKd1xFr7iaYvaPNG6rGn/0RRJQeyQkD7IaZqEleRf9gJ?=
 =?us-ascii?Q?ojpVvO9kr+omq7NMhcxgMETUrXe2OTpyShv751booSW2RmzZe8djeClispyq?=
 =?us-ascii?Q?HW1lCS4PuhlHbG7FlRu6o2UQk6IlRRMg4F2mCKFxi4GMZ3ZyMj6ka6B2diYe?=
 =?us-ascii?Q?dBPTG6DEGMXXffAhYhp6BxH9RIkinZz5J/3KaUw/4knWHjLylLjmenhLLHbI?=
 =?us-ascii?Q?uGXoDCv70fy6Jch9akK+KAXAOnk6AbZZwLmpTXF2hVhcaF5Aguxr4gKdO9qY?=
 =?us-ascii?Q?wlfpICyiEOzrLuzyWzBeZco8oh8eF+9kKfnh6Cm+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5bcf75-2f12-4adc-c5a0-08db6b1579a7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:20:18.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F73VUon5TIaP1OwamMMefONKaQe0zFWSPp9FJ2fKpfAxf+jk10IwFQijJgXHThkrUhp5EUpO98hA08IZMHd/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba1406e601e4..724b652876cf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -341,7 +341,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -349,7 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -366,7 +366,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -573,7 +573,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 47a883a16c11..b5a8aa4c1ebd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -193,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..3ba62f1154d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -833,7 +833,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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

