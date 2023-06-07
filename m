Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C95653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyXZ+/CrMeREXeCzt6t5Luh5aO7JXJf5lRWik9LtlbUm19mmx6cdnYLKXFmFNUgVrbdHTmUUaQGDXVdE8OHjpvBIU5GLrQ0qcmBTfuy0Yk5SWfLDK340yAi3g/xg0UBFS4olNxrEa0jVvnrtg9t8ysbEJyT9EkIaGHuGkBFCE7i08hB15JghsnSa57i3KfhiUXrysD4ERTsIVcGY+tq4dLRdlHQLOlWGx8HzvYAzQLKaQKu62LrHh4zJ74SO2do3cczfV+LWUx/wcohJhgFjsE2imZwQZO69j5ZtfPaKOOFnZubL0LOY8EMp0JiFbm0f82Sp8a4mZFXgv5QudGR00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc6i75klCO2vyKnEHTjCNgf8QeCzy3OoBnF8KA0vNbo=;
 b=a0fwBz0uTVUPNJb7XFlSzA0ccazxSjTPqTLucTb4i4FIJ8eFD/v97ROsK4pIQ5Fgoo3ctXu6N4wUw3iw5yczMdejpCQTUEVby7OIcJ/Fde1oboP6zoPOJQPjXmnwOC1DM4WphcoI3VbvkHc4JdvISNZSoDUIMfQpcr/DX3Oyj+JBin/2toKKgzp8wifvzsOus6zhvN2XhwmpntG4duPYW7mh0qUt4Yp7u+NSASgIAiBVJMnG10HtLMxLdzht265EiFCV1buu0LlbRgQKQAt6npN8EN9OwcV19eDi7TuBHcxHi76AYESj7juj1WI6eGY4E1yL31a1B8YOUBr1KvKcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc6i75klCO2vyKnEHTjCNgf8QeCzy3OoBnF8KA0vNbo=;
 b=k6ivjU6+sk0LwJikq51JRp7hobmEEbULMXnkxCz+yCwcKf6UXV3fptqvY+XFq+rH9akNWhlDM0fOmIpgGFyPKr0X66SDrkd5sh1WKS9wXZbav1t1zXEWax4EmFejU2zU19SdNkVBH9kzlwO+ejyEZsSmQvYt51Y4htgaAL8q1gKf08Th0VeeIcDZ7+2IUHSjFEJTV3n3eTy4GBKoWvkBQ7taXHMNHnDpt5ZAw+EwTCzGCVQ73ouNupVyPpjQAW4RYSG+QUDA6ESGUTTWLVFwY+eyN0luI39YOLXV6VxzDRW2DsxaN6RtxemWhOoozc8Wbb+jBq4c2ajyYuqlifQjFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:39:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 05/19] mptcp: add last_snd in sched_data
Date: Wed,  7 Jun 2023 16:38:20 +0800
Message-Id: <99c3b06e6efb76bd236f589d28e6d878866714de.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b131f33-d691-486c-e0b9-08db6732bcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMhgERuHBh5YOWHOwzCfBy15at32QBLsOdVxMkwlj/hzvAxfrDUxCwW7K+qtF18Q5gI+vFnBF0wv1F3FtQeNXViEFS5lg9QngEDr3I5791ThM9eUVbj2nbljdzRx9uzdzeNzBDR70TK00J4+N+Zey0JR59GUv12DMrRI1UEKs8F3ngkoPE0xm/RqdMpQckE9ML9veM5L5O3Y07QnaBwp8Gc7c0FH2Y1D6UOqAxrLZcAEp7BKagkD3ozrxNYuqdVmtma/PWdl1/MVN4jBKELyNkx7e1gxQQwIXVWamNQYEeYsAncFfkuHKQEiZxJcqPdKRlWw47vDyPnO8KWV8nZROvyWqvsbady4VvpVQeueV1gSzv+BZ+/R5HgqZ6u3k6djKdBuI5iYoOgMksGcey4shRlsBhQCAWfC4ZlYb2uUcchoq/F4kTVDd50/TjuHemo1Lam9QkPuIv8sjGW3lXM4+5w+KdbnzbwGtT41AX7VFN803B4Uy7S/XZQv88sJNRZEGPX8yBLcQf5+u+hRkQ3sFyggpS2LRvYr+Gy7t9Jg8G7mRG/djj5A0/wOcX/fIX5C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(4744005)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TF3kCuKx8B7S/E4g8T3p+++Gy3nkbYpjqf1+KCNISAG/rw+2Hh+lzv4mGj69?=
 =?us-ascii?Q?64jpoWVx68flDdHMR21ih7ze4BXKNFW1bhrSveI4GB+lwAx6zyZG24e81H5L?=
 =?us-ascii?Q?/o7JdYqVhNFkaEBm1KOW82xPCNyckpezNTwJmisFprGdPMhx36c3f3/+xh4/?=
 =?us-ascii?Q?Nf3RhboSZ/1RvD/rlnMfHEbfhFZHOI2MZIG9W3jwJj2vrVo6x+IMnFrXP8wD?=
 =?us-ascii?Q?buiTQQOWgnGhS4ANB210ABlB+UNEiAv4KyN7CaX/cxBY/BIlfKirAfSyjWSr?=
 =?us-ascii?Q?NRE8GBXk9Z+7/o0BKa51De6xKvNgU/SH5ZFo7OKnhSUwcDArNBPewyU1ecrk?=
 =?us-ascii?Q?KMYHs0I2EWi0BFuoe90R7KD9vNTeYrP05NQ0ObLJkij8fQmNaes4C9KvFyOW?=
 =?us-ascii?Q?bV24pJPxSBysU4cK1YiMLzDfOMw7lu8y2as2Om9TD0eaymb5o8qBE0AAVpPH?=
 =?us-ascii?Q?hnZdBE1IEX8do8yI+iISdgWV32fcn26ZGBJDM/x+aKPgVaDVxx0oT2oqiANj?=
 =?us-ascii?Q?YwPZz3k+RNS4JLpkDyK+BrNLdZTGpMZGU4vXsvb8WNFXLzkKQkv9ru+wbJO6?=
 =?us-ascii?Q?tICc1oRTv4/eUlUhjfoveYE7hmx3G+vGVUT+FGvIBGjME/3A6y+6KfZJPpzq?=
 =?us-ascii?Q?s5wC1neypbqfZo3i+1xmUo8hniQ8mwgx/8BDiIlI4HSKr9w0r0xpKWRHDTAV?=
 =?us-ascii?Q?AFirFRLOfaJPSG5vvUXTlhEf+/w2afvevmCnCDv8JH0FsbWxiQuchfuZkYyj?=
 =?us-ascii?Q?qyQDGbkyHFkQVx1EmG/YmSG5XPD0MnJNNaOl6AAZTPsJupTRmp9Z2+9SPDDn?=
 =?us-ascii?Q?eT80sLdUvvDTxNwwB4LOO5gzVaysNKjobfrVFos954LC2fJOl4bYMpEob3RP?=
 =?us-ascii?Q?bSSpV3s+NUKky2+FXn/MtnXLsjvCnz9D5Jz/JW0UD+Ct0kjLgzQHXgfV0abk?=
 =?us-ascii?Q?C5z8zs0eGsmzXq7IR2sYI3erFtfVDv2h/YMuSBe8pgJwnhfZb7YCB/tZfDAF?=
 =?us-ascii?Q?qGzf08cU1MEXaUCpRl7rgDM1rVxzHfAEw4bVNqsWZWw+jlvcUS1ucRiv6MMO?=
 =?us-ascii?Q?Pwjm/w8384KGwa7thamUCvb+bQRrqBjfFSlqgBZ72CNErlTTNW5y4wkhaiIS?=
 =?us-ascii?Q?7/qSrYmkr5B0bI6v5SHhuy8zCow+blqsnL1nYpUDtl5UCM2UTJ0BWL6ub7UD?=
 =?us-ascii?Q?honGmNSJT8EgeHghK9xdpkdAhF8e5ulSEpfYSE/xUvpXOcZn/6HYV8reT57o?=
 =?us-ascii?Q?jvEF5UqqixRnGvuDi84vj5Da/7/LwdLd9pJfa/Sh2JMPOZglaGVY/pKimahL?=
 =?us-ascii?Q?33jjCrgtHALHfU1a09kg1Kc7iNUSYk621I9PsPN1gs9/SNAZze55IiQVIHsd?=
 =?us-ascii?Q?FPkh0KvzmvJZGQwz3WvbPLvANEYbbf7pML4UWZ+/edNONCZFQ43US4H7VT1Q?=
 =?us-ascii?Q?UcEk6hL+ZWm5YvhMvcu4Xv/xyLZnMPF0ACHpDY3GrGfq2WHjgCVc81ENBfKF?=
 =?us-ascii?Q?g6fohbERd/BbVuty3d6sJltwJw6EwoVwoxdMsbJtIUEz/r5ACKkNXZstpxwi?=
 =?us-ascii?Q?Yb3i67ZLxsRXMhD8s5KWrtPxix0jxScxwcHUAFJ+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b131f33-d691-486c-e0b9-08db6732bcf8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:42.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEppc9ajcSWFuWStVv0XUbAaOxeKqH1gqG059qK9q6x4THAL0qcL9JsRexqViMogoY2w+/xmnOdyko5R9tVY/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

This patch adds a member last_snd for struct mptcp_sched_data to make it
accessible to bpf schedulers like bpf_rr.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 1 +
 net/mptcp/sched.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4bba29c99172..d52aeb8b4485 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,6 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5438a86e897a..2babc377cbf2 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -89,6 +89,8 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 		return;
 
 	if (msk->sched_data) {
+		if (msk->sched_data->last_snd)
+			msk->sched_data->last_snd = NULL;
 		kfree(msk->sched_data);
 		msk->sched_data = NULL;
 	}
-- 
2.35.3

