Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C523BB49
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4/dV4n8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCifD+JyhIKKNS6prGZNNgCOznxfY+eEhpLZGc9d41MnogGCAizBBxwXV6viwPcUwnSJhlC3TI2dOX2Ex1sgYegDep88y98cpK38nSUSdi9oBeA5kwScGrum3ZPywmq6KklZX5kb6TZkHOhEuXvYbhAI4HhG48szvkXJD1/+plreQsxA48PbBKkuEdheP26WAvkI0oK+VUSsgTkUbU0l7ZvpOP580NHIU+YaPsMuCGGi+AbeXiAjdHFVsOKv0KZraF/H+KsS/mcGefPwO9R0DWWSpTc8NuOLGSMf5mWnCs5IK6u9qnKT2Kgqpmoyf4uzhPyt9XadFow7maF1nVXTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI70D7SROC7m5ZxU9wMumEUgLdE1slM2yKP+UoKBM0Y=;
 b=lsaC7h6iqJ4pZVvzBVIZuXJ98ZZ8Mvwg94vFchx/bKMCfVCTwqVXIZWj7+/R6/wpSDVL8Ejy/93I9dPDq9nK3YIp0WIEte0jRibwwrwfA+Nh5hFuompaRPVgYphgGplIG9q68IYfiuJygexan658NRvurqX5+2AOezE1OCn4kDTf2FbFW/N7tBzyps33K2FL8+5oi6kgx6tEWpFVPsGwp9dUeTatVzkUQvxqFWPCk27LM/jfshHuO/ho9z/LHIhSpTXHE8VZNohvB0fRELNeIGHMt3sNH86Fkczlft05AWV/eLbM3NL38b13kSthVpkWtlRcHbyNft0rifNj9tQYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI70D7SROC7m5ZxU9wMumEUgLdE1slM2yKP+UoKBM0Y=;
 b=4/dV4n8zbyzfKX/SR4kUayN1zma1ssHnyUm2fQixIAyRv37jtzXCewP3LhIGaSA3mZzSry3M5OQ2eii334hKxt+Ejb/wAZw8hpuEm2YJT+0eP0+my3goPPbIEwObHwhT/pKE31A1a9isgDZ77a7uaDhYJ7Npc0MxIx/Bg7YIu97UFr3lrbp1RcUOiprTh2Ku2uuzmoXVnF5EYaLExrMnnPjo+HjYHf3gnQXViSPenZGyt2sssZ3ioFV9DgHJmJlAgDjS4P5vcyfZlehRfHIoS4L2rPdMASDtafwyaxU//bli9o3brFHJtXdIUxrjwb9AfrnpDpfkethBBvrAb9b6Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:55:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 17/28] mptcp: add a prefix for free_local_addr_list
Date: Tue, 21 Nov 2023 17:52:40 +0800
Message-Id: <de785d37ec330c680ed93e5672ed4a213c7b8647.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: d63f41eb-ce8b-43bb-44f3-08dbea77f91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LobQvg/pn4ya7uCoTAjYNI0wN0Ai1wduLP8Z8sAtldSudYsJtTD0isVu6uiiBxSzi131TrRKLPyN/R+9+1fhrmDtbNZkjWAfGmTYqdpWhW7P7XGRx7kagGIHVF2Sixx6ReBePWwXDecF53OK1KsQFxch2vp89DDIPrITUuRytZ6P09RMZ+Gp7NhYhRMD8W40sx5tUtKKsnGNAx09ngHLb6VoczVflACEq6JM3XoDP5ocjoLB9DlEBMqQ/Ntial0o3LkOz8O9LB4NQrgTCdp1Q69bDJJR/vXHLgj3FSeWM9j7fQT3vD4iqIKeLfS+aJHHWgCZh/bS1n9uAlOCilcuQU2xsbxUlgSo8txR5uGwnNcKmsDHxpZV2+NvZixAdXfbwCqVtUwjXh8i2f6o0lGaPDRI6Bwq4f8jY1qX996o7G1bwgXVcb4aFJXL13PqpATJCZZr4bwtuKdMy67lcGsc6GcNS1HGYDHJhRId6uhVTNyL3gxg+zpocx0gePRGutry6vIBW7hRdFLsNHjsvXywItfyBxJES2HXpuXUKrXv1mqEc00p30+mghEQ/JvOjbJG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h51YeoHV3rkWI9sKFu3bab8iy6CSiU8hpBy5eW7C9WaFd3Bfaz3mB+ey3Yd3?=
 =?us-ascii?Q?Ktsyxj6bLXNgs4IRIelL3QL2fAWh1Vv7hSJea+lY7YcsWyWMXsyH2C65nm4i?=
 =?us-ascii?Q?zhNQZq6181meeysxf/oSS0qDT/IIMvdAA2jqX/41JfIOoHPQ/0kcuMS1Fm1c?=
 =?us-ascii?Q?e379mrzAmglnRCg2WcqcRzSTE1cwytEWwLEsDQwDsgpTswqjHCnMw9Kg/5MU?=
 =?us-ascii?Q?mNQhxL68CzPfUi9O0ZEfkv/5fK9lYxIcddkh4WRwmeBTV7fmSSSUJUc2AcAb?=
 =?us-ascii?Q?lle253OEe5etmRfrO4lMN7SMC6CWtojufW6aPfKwlArpai2ec/HNQ8LVpGk9?=
 =?us-ascii?Q?83p/2wRd7VMV1nZ4CRE+o0pCkdbwGmq1b6q+6vSfxqC60sm7bjeHkssdVLaL?=
 =?us-ascii?Q?jqtU8cI2QGkkqCWJ4abKucLocLRNlspm0sdMuiSYOTuzcZQWmtdEOZT+JeJC?=
 =?us-ascii?Q?rF3SPM+Z/QwZAcngZwxto2yqsYwKez9lYOIJbAJaY7IeUMPqGCAsyj7/iQUE?=
 =?us-ascii?Q?7reivy1W+3EtKtkJwFd5MVQgmtmwWEg3XegWblJDrMG1WmvBW7/fechD3JFM?=
 =?us-ascii?Q?V9NWKNiftoSsrf4IlhakQsrr6QKpYiM1zSF12s8QBAKiDmxnG2g66z3WPHe5?=
 =?us-ascii?Q?dq2UL8343i+cPFP8nwIA4zLPxIzi7toj3i7FWCN/x0x/sxHguOZy4ASS3iky?=
 =?us-ascii?Q?RV2VelRSVrmFiPxO/Io6h4JvnVggN02qDsrR1jRSNUC0sptiHJGnZfb5RmyF?=
 =?us-ascii?Q?0c1WNd693Vqa4B9cq8A6c9KjdC4MfKbNo0ITmK2OxZndBxcx3JyWjPtOwA7c?=
 =?us-ascii?Q?MhxgMeKK3z0m48olCSXOt/i2LDVCCuQroxtLgn1uZPtEtk2Jn/v2PPNN6RBO?=
 =?us-ascii?Q?Hxw7V0ARRDNSHULDHa8RQAWbFI+JBNAU2hAGVIvkqNh6OZXwhpxL0Kas8hDY?=
 =?us-ascii?Q?zUhx8p56R+RLa3N0vznzRNVUvAhpw4ZHXxlF2DIhCnl1gJuorV4QhOO8Z2DD?=
 =?us-ascii?Q?W6Fv0Vvh+QioraKxYXS/ADdobCjoIAuFPHSPDerObNHjvQ18gqyg4r7q1h4N?=
 =?us-ascii?Q?xVZZUF0FG07h/xdBv5pM/aFtklWnx3yTdX+vqpHsdL+YZoK+cE7YE7pC69iG?=
 =?us-ascii?Q?K/gFmexrgX+tIIoOujaLbr8oi73sxX+nfnNy+k+2IEN+ga6XQv7wCzSyO53D?=
 =?us-ascii?Q?E9m+kTwyravJNUrzGA6IGpko9SXVZv4Dl+2JeM3DKdGaTo1IAJRLjsGdmrnU?=
 =?us-ascii?Q?whRazUm2jaGjFznfF82k2NjAqPYi+dZepYIu9MJv/cmuXSK3JVE7/16doaQE?=
 =?us-ascii?Q?U/WqBBqU3v+VUjcU/KtpoVqmFaijHnqrwSUa3YlxqShsmN5UzBRTSDsawrHC?=
 =?us-ascii?Q?2YuCi6PciQjEp99BAHba1ayh5o3qITqG5T8C6YADfMCjmArYs9MReZfhrWtf?=
 =?us-ascii?Q?9Xx4Lq5ugntkgM1Te0ef2jgyHnp0HukAtsIuCW45l+j+2e3urlA3wuyinKB0?=
 =?us-ascii?Q?ygybdYMfH3A2eDOuUf+r95b/ePYZEx/hrZQWFUweh72y7XwIYl74qUm2lp0M?=
 =?us-ascii?Q?E1mjwaUN6axvGenHYjYopvoBCbfFLtVN1fkzv39m88HkgO/SZFdfDO9brnv6?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63f41eb-ce8b-43bb-44f3-08dbea77f91b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:20.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHwJWiv5ezucnyjjM5AxNq89Uq7pnS3RgEuTwb9jjGI2Z/E5hhNUVmW5IcBhkitW1wufRpu/OM2xuh/WJdTbkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 489bb0e61118..87cf27dc1d0a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68..f2f0ce608219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ec5557697c11..94126212da8c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -942,7 +942,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

