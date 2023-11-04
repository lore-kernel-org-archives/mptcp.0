Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A115486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/oChLUv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRdirApeF9X7pJYxumeCaF0li0FBdJfosz2TvPsfmssUplJvmjUsGTIb3H+DJcKLPA7xCu7u7z6TSbK5xCxpBLA1n+f8Dt0uLEmX3TslOwGcj3vxkPsVV+XNLM55OSkQPGXfSk/yG1nXiZBTPVmTwf1RAcPqqwkxAR6Os2RQR5N9dxX4vO8/BIZ+HMkMyi3+QCZ3Hbof6oSAevWaGqbzkqrLpMH9Ows/a3BtlA/oDfsNW6RzvBZWAOoJrfxpJVBAVy1ArhgzQQPbQcsTE2gQyJJM8e1JIg9aBBm8e8FUPh0FpkIJ9Dj6TaOsUV8Bp1C3RCsF9Oy8wFXDmNYGw/mEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdchOd1iOEdCbnvo1MAT0wiPP2e7wyTJSOAmLMJz52E=;
 b=Ct9q+pgVhvn5UhcLYSs7w1nICOxWg61eqiqU0puO3xaIcE4MhM4PybRv4N3h7rsrMIBdTM4gWzSA1BDDl0m3g6aVNuk2Q7YfbHlJpRafpTfznThR6rdlosyH/0DQ0Ao4+oYYSdMmVWR5AfTgHFcyUshcEfO87Mstcdn3X0r11aBCdwR6AAZfxMkTwm8rwnJjYD1xvx8ehpgYXNtCrBKtH2kbWLYTBhAKqD740weTlowMx/R+kXsuu9wzyYDuMR+KTT4QxxTehr2pWulVBGjOztEIYH2RWTiQPuJHjmFCPyjW7HiTnSYQcdI62wO2IYvfHt3r0e5oiKsPQJyxARs2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdchOd1iOEdCbnvo1MAT0wiPP2e7wyTJSOAmLMJz52E=;
 b=U/oChLUvCWJS6AzOr77k6Vk8MAhvPo96WlNKXPnGk6jCArnFxgcqq9gil947hlnwnbDfCEpWFuoEa0FWGGsv213mKk44fqTVZettn9bK710k3F5ns7uPd3OAsKOVDFyVFPeKDq+vIjHBzhg2yljcuLidFPFcchN7K1QOr+BudOBq/k2zzRIv+A5IpAdmI0IwCLvgzzDsWQP1xDzeDNb1y0VAQtCxRebKMCjn3j5DyujUmHEQIS6lktCwk7WaxlAZW1d3/4Nrym+ROqXD9yvtd8OfvrYJ3w1LMDA9FtpR4hM9uyNZavMapO4hH8MepTEtZx3JkJB5ebOnT+mhgw27xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 04/12] mptcp: flush userspace pm addrs list
Date: Sat,  4 Nov 2023 22:16:18 +0800
Message-Id: <2e5766a069c038364f9759159a2b237ae891e25c.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c12f8f-4ddb-47e8-b452-08dbdd40b6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EUJq21VCgzHeA1XyrMXV6gaORqVXAS4OYhs8zN8CUKtGZVCkO9ruAQ9PMDaOF3LmtpmZjIlxWURfK7wRsW6f9GSOSMkSzSFpVNVma94IC1cfG7WO6UBLK6miGoaN3C4v5Ns/T0OxegjPY+DEl+ip/5SZpIAuHZs7ERpArCzD4vCTGG72Dz2G6XYg6bOaXMN+Oa2NNiFoTBCGsHQf9H6ACYGiZXElipfQOdDYU11ogumt7XRihOYSYy57xLq4WWqCSl1Op+1/5LLWKv+BBv80AcvbmC2spvF/ZJwCJWIzuv4Ad1vO7ZoDqoLjHXVN2Cmtl6HIt943d+eZO6FVPawM7U5/WH0A7UohgSrlUOWd80CctMVF5tZZLlr6vSxa9eOWIzyGTPunATWBGP0WI+0KrfbkB5Lcvfyh5TjgWnxG1fbL2HkJPuFOhanwupoUGUHXV2TXwB8Fs+KedXHwIatnPN909gWl8MH71OLWg5TNNzOMiVTg4DeaZf4EQvRXssjVv5v6x3ixKcO2M/qMSfukxSfNzq4xGiQnWWlZpgnHwcQcoFWicV8aucAqDpHlOv3IjVYrik2pi1s2+OwjoCxgKrICzv200/rkfzwAXxwXBDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJJ4KzajkdOBtLoIvNC7u8x+fpH3UugldDm3mweEwPumnd7epLeLo4QTbiUr?=
 =?us-ascii?Q?142gQKaP8MUevE9HatB76O3j6FZkfAo90YDwGqpPhGhxVSf4jLMyTwjxpgdr?=
 =?us-ascii?Q?Iw2SsvrlRs7EPkQVpdws0DzrYW10/6ftzWhxwInKLRHkUiR2OJWlCSZJQUf0?=
 =?us-ascii?Q?V3kaUdf7cj8yieHGtDQp5q4XXSDvZCYvrfUK3EtOwfYHOf4G1BnqOA2jw+pw?=
 =?us-ascii?Q?XFYFIjki50BKWEHenVJ3skBweTXA3vq5x1e/wWyayPfguq9mNRdqGT/8TiUp?=
 =?us-ascii?Q?KNrchhW4ksj7VGyNt6vaxDVrahzG0LLXKMksoKQ1mSR+nt8+xeb4lx9gjNXN?=
 =?us-ascii?Q?HwVO2BMs0bgeyK0hOhwGubbwIQTleTCZbBDgPiIdCRFWvvCdir5+/CjnL8FD?=
 =?us-ascii?Q?ga1tdMJ44AGEyaMx4fj5IkzrxyPDUsrrBL05m+tJkwdv34pl3eFpgUCgs237?=
 =?us-ascii?Q?6lnEiqeRBjgSYfn6Q0wdIw5VTmZxZBlAea9wNzKj1seLaoM7vQ7Ke2iUCn3b?=
 =?us-ascii?Q?oftrM26Vc/OojbOy33mSvKk90mJsp8uJgkcCRyrEm+8RG1XA1atzP5mAIwT9?=
 =?us-ascii?Q?Gh7VSdvZjWlUVa7tUIlpTm6rbjPJlOmUkXZAFBA8Zj+Apqf/OBVCBvp7lhpy?=
 =?us-ascii?Q?Eez8tUUHcsWcVj+lwjQwazOvbNojUSWDPZkdNkIHw87xROe358qe/OeeIc48?=
 =?us-ascii?Q?7L65yfWyuWim5Kzc9zyyh9acSu8Ax680er7M92gvJSx0+Zp+Lyi20EuYpUiY?=
 =?us-ascii?Q?bWNBJ5xuC3TO1kdBnkmN/Z/Hg3zppGip8lYTAHwkS261ZTK/JKkCxAFtG5tq?=
 =?us-ascii?Q?taQC/wmyenN34nFcLkxbk2WQwU+MNm08NLtp81LremKp7WTLchG2kgXX7+XN?=
 =?us-ascii?Q?2OVvJ/z0iTIXDARUys0zpQ5Q510CmyyIZaEHR2cLd2A5BKewbipXXgDFVEyb?=
 =?us-ascii?Q?pLBBmVIGgDgTWU7iWY5HlJ6b3pwUP5wVsRsqGhm54Yg/UuGMnDFF8wu04+KE?=
 =?us-ascii?Q?fwO/zqrM1LDR6NtTKn+ONVmxpJCrSsgud0WWXTcHf44Mcfv/mnUVJ8p3DMgC?=
 =?us-ascii?Q?0C4RsVIBqf2+/5+LQ02PlktqSVtWkTjBDnGbpj9rGRDoRpCcibg8NlRU6hXN?=
 =?us-ascii?Q?bHHKOpNams0Y+dz/Lqva77d7lU7IWKBGL/oO0iiwwAnp4UCYYG9rRgjX7+6K?=
 =?us-ascii?Q?KTLTXLq8W4vTnobqPWl1s+7htQqyzdH0ujIZ4zuDHJ3R91ipKhDwN34rVZtI?=
 =?us-ascii?Q?iObkpBrmYgq43mRqIjkxF2CzzM//hcbQgsW3ASOueV7A9To4iG0aNDQlYvR8?=
 =?us-ascii?Q?D2A7R1Tc67bqrAvuTHBwMlmI6LMGc7Y3WR5kLkg+By7Az47XgICH7+INOSak?=
 =?us-ascii?Q?tjovXxM4efdS/BFmy3t1h6Bowx9nYipvXwiLu4Uh3OqDYX+JCQR9G4OyirDP?=
 =?us-ascii?Q?WY1dDMgeSnM0VmddBvZk276+RqufVlGFi8p+AtgdiznLBJUKggILACV/aGNT?=
 =?us-ascii?Q?dlXI7NazvkrKrTkt3jgIN20zYMG8nwV2KjezHNtoEcCYNNYvX5Dc+ljl1ZYp?=
 =?us-ascii?Q?ovUdkQB8ygpF/+ZA2Pnolmcqa5f09FbTkZE/B/Jitw51WMC2K0dt0HPUV8xu?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c12f8f-4ddb-47e8-b452-08dbdd40b6a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:01.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7KJezvI8Qq7bn8C7HV3VBHx5SxMxyrE1sTyFGbMvCbNDoW6+XwS/VHJVTtkeequY837gWeSKLMo2FMiR2eLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1dcf104d7a01..344362ec17fa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1598,6 +1598,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 577b6ff0e3aa..8caf968cd08a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
@@ -549,3 +551,26 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 953632ba7eb6..0014b6b542a4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

