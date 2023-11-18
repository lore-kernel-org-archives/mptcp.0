Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE32154A9
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vQfJ1scr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFUFtHzHHduY2Z86CrZUS2Las7Pmrfh4RN0VYynsyO5ljKCJJ/mJleyV4HvNK8+U8Nn2knAMw2mERq1ugDr2lRyw+ZGQ3IKMf3K7muqlmJ6zqDf9Z2Ln+wsiKSWppx+9h/RR2uq+AnHgwrRuhd7/JTaKFyhXvB+RDx5W7Bm5j7FpAAbACdIt3IKY2B/JZv1UsRCmq+FZk7JEd58uvZQ69w7cdwuFqHcmJYeTTUHW01jv9RK9QShz/RRZlAmuAhQ9cYKBa3kadsGHUEdzUtOKGOjwIXZYigzq802MyY5TPLCRR20X9HPzB5D0pGBe2V72Cuu3fW0bePS42HsLI/e9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKizeRtkCNykYCfh/WDRPcfFnyiocCES1DS0PtuJJwA=;
 b=YZb1cMRIi3lgjCx8GqCnr7FJs4Z/yIJpZx9Mgz0/SGv1bE0RDVbQ+Mokzk42SG34lgm2FaHZ7EokyI0xp3Bv0r/iSWuNA/Xp8aqcjgUGThvRHyhDLsAHMK5tVuYn/ydeaQ373qTxmLzV0iaisKzPrhuHWHXDPHbT+e4d+TavDMisTP/DO9PHrW2TAmyrAfSSk5iEqppaFvttfIBYf0emoboyIyLPgeysNfNBbYQYyJi9hDvFpwzsucaLH8YMk296rC7SlsRlTnylyRWbANUS7oHtw53S3K6CklHRLkGNiqpg8oa/LkZwF6Uj0qgzp+5+Bm4wwkuZ03rilp2eWMCo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKizeRtkCNykYCfh/WDRPcfFnyiocCES1DS0PtuJJwA=;
 b=vQfJ1scrF6VhKvtXuv2DF47kXrOOuOD8nyrWObaNQ++G20TktHWWInRx2gQNco03FHqFo4FS3UyiMLB9ac93E45v15mzctWy2v67A+5L6zRc55MWjpbeWtM2HVVEPFe52bN+eyhKXiSfAjQ1H/o4sKrtPv9c5FV6AMqPs7qUubAcW1kdrlRGsY5Igv7wjh5ZabV/ljUgzwExzH6w8jZYia1VmixyjCPfKzLF0yqCKWnIXMheG0jZ8PChX5et17vGXlWmtB99qI5Y4rccuaRjrKDdY+4wjgkqSeFOv5jR1q0Zf4+ELFtE2A6R7M2Uo8YsawwciYHBv7I81RDvIc9/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 16/27] mptcp: add a prefix for free_local_addr_list
Date: Sat, 18 Nov 2023 22:28:31 +0800
Message-Id: <d6c8bd3bc2f5363246e62f7d668e4e189f982f8b.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de7213d-fe22-4580-4b9e-08dbe842ffcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KCtDtl5w++Y2eWzOtChugNgoQsfmLjqzwYx1g2i9j96XKHJ4dGoQPCkcLmGCNCxDFWbfGAxd3aK/q93i0i7NMMyaI7rtB+7bddEXqyFhmPzpmeE8ZXCld/EM9h+PoWNBarFJdQQFoU5O5eh+BYUaQxg+jogX1OV7LEpkAKmrxJXk295JpUxQ/J9pr6AAqYgkANIYxk4qgQFeksvy5+3LjFFtaReoPkRfKktP49nSiRThd1yXX3pa0xSTfKEw7+xbfATHOvRbwm4vA/blIN3OZabbaL+ooQgcbL+u3+9EbsjhH2CvUJAeNvOuLt9G7gxaI7tkT/oId+bwYtxbEekUQbuC19xjF5ihl/MfjsR4mHKP6I83Wj003XBoAF5UZWr97oPMSWKFc4+r9rD5n2GQl0Y0OTyqePei7f8fvuJjS4nWEDYL2LsjJMi8s6K2aJYwTaX3mSvjot3x8tbYfO8AsY/0Uz/T0G3EbgA2ezJxC4mcOVGzPn+HeEb4bqIhEaY48DGO3XuX13Mj0vUqf0oeb/b54Iv9edVLvNZWM5+YNCTvWaK37S6qbmCKaRz477lXF/kzOEVwLDVSQXK/ecrbYUT7rPcHJgimOAaTlMsSih4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptaoiZ2U0HXs9xpGXutwlrTdA8p6HUIDwvekM1n68sw+mPQdM50lhNEQWpOn?=
 =?us-ascii?Q?/K+NwKGC2Njdy45PtHbdd5E3f+joxvTRhgVzTjWEUaHfGaQntx7+QIMfWPvb?=
 =?us-ascii?Q?a7ZRSgYYQS3/+jr5vqWOh0XQj+hHW0BCBCunmfSivjyslKZrLBYWpYGEIbpc?=
 =?us-ascii?Q?28p1W845LE9TLj98+wvYB66omXH4f7qoCbPg+ktyTTLNC81S47ac05nfPnwL?=
 =?us-ascii?Q?2ghdcy2MT3IuLJMYxKZfhkS7dXmWhHFtjqj0oBva0cLrKqmrF0qZAXGS4XgR?=
 =?us-ascii?Q?XrCKZDbo2p6xt3QB9WJkLTWY2Aen5019/2I07N9OYehRwdkNXL7BRGKlFFvI?=
 =?us-ascii?Q?N03WsZ1O21g+X9AmhA0yDHEsZ62JjaWArch2QFYXZM4Q4KRInd1IM/SsARVx?=
 =?us-ascii?Q?z5vzUM2lG18oa/G9yHbTy8/iWcLzqg1jy9RXIdSQxiqms/mncXG5AXMyQRhs?=
 =?us-ascii?Q?I8rkuCAOrLakrVUZt8R6HKicLOp7MoiRS5PB/D9hC8Tpg3FZpBkTKDqnmFiu?=
 =?us-ascii?Q?VY1pdy6XB6NvICmOlGwPs7OX3rU7I3KnZ44QD+qa5cYjCIpVtp7ZKcyYO0vQ?=
 =?us-ascii?Q?cUqHxEGJDFW1tb8r8iMXfUkvsC4actgBNrXW8p1XQdAT8nY4x8Nk2km0gBbO?=
 =?us-ascii?Q?U7rGecIyy+J5TnlQQJUWQOQcTRZlZF+1PnCA4iLIELXIjU/3uGVqQmhj8jN+?=
 =?us-ascii?Q?ZSOz3jWOgldH+EyaqYPeqxGe7MNAggqzP8mWeuufAU3Af913Gwvfj9DHlUIr?=
 =?us-ascii?Q?LvcsduNv4lz1bsljrHs0knNEvSgZw9AdFZwxAe7bC/W7Z3ASO+4cDf7ZQqgp?=
 =?us-ascii?Q?/kdFkQfNxe4hv6ATr54K/6FTh9wAbLeL7U16yc02Vn90YDmQUqk0cVxFGCxg?=
 =?us-ascii?Q?tEv7+om+qvlJXddrE6xR8JQ3RKHQu1iqS2eI9r/yDMOEOsdM+Oet8aVjVAla?=
 =?us-ascii?Q?0AJgWmKOdPnr3ky5uhn5Y3ayxo1LAEOPjnfWJJtQM2EwKx8zFc0ycBhCqIYh?=
 =?us-ascii?Q?yjYVPUcs3iF2Nhnnymz76sirSUA3UfjfnwsqyL9pNJzw9L1m4IgMmoL91hDf?=
 =?us-ascii?Q?1F51V4bwQHahgxGoq1w/rcClLRHbTvUAq5FZcYLrI4ymN4vvo7kG4tJj5WsI?=
 =?us-ascii?Q?oTODLBl1qAv+t6cSTDTgyi7cTeVOC0l5WoksnCmtrXq+dIUMlJbe9XaMMR/0?=
 =?us-ascii?Q?jGsw+xqZpcJAYfEIssFMc5mJi20SJjRUV7d81IcxuY2/XO6ubx8pMX5uS03a?=
 =?us-ascii?Q?+4J6Yhp8et2SCjTdznuimNHJ+rQ2LSvr6EdiuBgW5QKddVVJ2KNeVgUu+m1A?=
 =?us-ascii?Q?yTtOCz7pU9r1mjySE4U5iyNoIv0UhFGkGq0qdfx/cWTRDbSQD6dK1H+138qN?=
 =?us-ascii?Q?jE6Q9uVwjBdmSKsAs0qn1yEve9xeZagknBGcTw+DVNXqxCtpnDAoFZ+I3NEY?=
 =?us-ascii?Q?YbzBm/1SpHTlShfghVrPYkLdgPkDe7GSz03JAAZM4EsUS8z6cU5WfhtKsXo/?=
 =?us-ascii?Q?qC8RtG/PV4VB2y/IYNlEFgMOWxDiG+51g+YcfMZ5LtxG5bOhBIRdn0PO/eeL?=
 =?us-ascii?Q?bsMk2yEBMLqSPn/5CtfNKjtzD1v1Cza/5NqcrCDEB5oi6eReS+S6ndxua7g1?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de7213d-fe22-4580-4b9e-08dbe842ffcc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:06.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwpekAricQC9HZ3zhGdzlmNrFv8+rrgxdzMTsDPg3i4sZC7o82lE8knmvPajmYAuVWjCiTT24zrNfYMJB6JlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

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
index 0460cb391ede..4999bb6241fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,7 +944,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

