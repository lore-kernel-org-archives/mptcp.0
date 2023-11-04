Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B67472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GWVyMtYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERlYn4keySQ+gcznMLrEZQDekjCeBXnGhTWCXrGk7UJDZIhRLWg4LjzAALkPW42Q/o7r0IuJeeAdPvmsHPCNUjWmW7uWZ1/0dKwBXgFMz2gVJz89+oGAkevbIXGqnU8xTDV2luvbn95o+YL3WKv6ma7uSAM2UoYtt6S46y7UBpTwW1OjsJhYe7UjsR5CRVqqoajvV3eEn58wPie4pYsxegyXWfFDiCVteJewv5KLA2PgrM84KBLY6pozcPY26UxiV0FEocoriKlE0HhQMaS6pswnd+pKRHXn8UwTvt3h7C8aV/sjpuFQqhjHJahzCJ5A0tKZpUTMfKD5R08r21uKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9+lkh5oxHyyC0eV5D23MvyvmQA486hAoDcMsCbVCUo=;
 b=gp5zQX8sqX/+W4J8svcFEv4vBCI9GM4zSjvm+mXF1iyWSnB3eaKGf8/URMeu5R3OMkMBjArTW9Pi7ktsS3XkFCGh3mtHwWG9ex2sPj3CMXPzRyzdZcSrK8VimrLq89jsg83vLv74aZmbLeOdtEN/wsGYuInu1gXcJpwxdy1yNp/oTLoa+gN2UgxlHMhIJRq9uK2NNX8U/5LcQvUohqEE1sTYSdby/tzZuS2hCoZ8kVnrkmC1yaOweY1W/qYMKKy1XTxcGRXJCTDNjrjktqKOg0F+bGTEECndHIQdzpYNe4VNKjRMIZvXiPtWL79gTZO2P4xkqCB8+rCEPnYb2BHngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9+lkh5oxHyyC0eV5D23MvyvmQA486hAoDcMsCbVCUo=;
 b=GWVyMtYP40NUD2HoHvCr0z/+MSVsTCf7C9CjwzzEw9uaqzdvN5AdkxDoyA71Wnemf3E1z26V9YNIdW9YtqgYB4bdj3Yg0IJ9ao04BAfQ2MviEi0LJiQ5Zy4kyThu/KJeS0JoW94L4UplTtd7RulpEm/JbFaPKDozGX4YdDbdRtKV8idP6jluXDWBN3c/06ePcfo9HsaFO2ak2+MRSCAT9ytRERyn5c502VYGbkFSdFGbgwm8rDYKQoWSFQjhlvvEUlQs5jSqSuc6WE8mOZQ3lQ7nbI0uZdKCrLYjk499LlLaPLkQ3r+gXHMNbX8d+rxFOwp47LpUw0zBT3bppbK22w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 06/12] mptcp: dump userspace pm addrs
Date: Sat,  4 Nov 2023 16:35:41 +0800
Message-Id: <153f06e46d440f83fa04e65d485fae03350bd6dd.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 995a30ec-d1b4-4a3a-9fb0-08dbdd1122b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eWxKbA9qMGdzz5IIVCD6QHYXFy7Xa2kZf2EOIk9GoKE0b5aybsdq7mM4kzp3SacclUd43bQy4kyBeSdUF00uyB1n/BV6AkKopxCASOm7LJH5iXY6RWfQ3K0Zr2VpXcEvqZGSc2jhAeuweRMupxQYN9FGex40S2/kdc2rDnwKoU7Xp2sDfQmR+4zwuAwkxhodxEQi0eW8Pcjy+i+lHlroBtdigl0Ww/r+wPDWza/Lf5GbYnEgjtsVzsny5l19nAdUqQQ7L4d+71LBwQQXr+1g4LxLuhSMgLfX/dr5v/CIOZPEEEqknTWjE/x1nT5fommTU3WDOdA4CcRG0R3SXl9vpqofccKNPGVALNKt94NQpnLewVfXlG8Fm8qiO0G15wB6TLAN2opnnOdVdW4yWlYMXi3vI9OtCliDexnHVTGKgRCOrTGolwRjpl3edhdzjF4Ze3lN932DmvM0bDhbaGU78xoZWlGk36cvaBm0bEcB/vDgpzHqDPDEMBSDeCnpK/Z2vF0IdrQ9PdMoIVEfn+cWBkaI8q6uRxZ6IWUq4J1DrAZETqxCb43BWPRU7LrcITtQPmNNGNL4QqBGzBtVoiuLr0XQZgmR3TpNNsx39n99V0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUBUWoPQVkhc8oXoqT5CpzaAeBglOuQmq77z1Ban5bMwpNCW+qkqDVkjVWsx?=
 =?us-ascii?Q?3oKxmsxmcmfLf7mzqN5FB4tag6ZqtxGd3EfdW34uGe4lzxlSgv0LdCBbAbyr?=
 =?us-ascii?Q?D8TZ6GcCCEICPikqs/T9PBaYC2wOUWzY2XmAVBgo071PiG2f4yzWaasVtRRN?=
 =?us-ascii?Q?6esbp1KYb5CKN/XvcU419o2HZRpd2zm15u+sR7QalXBeR7M7Np1UrOVfdtv4?=
 =?us-ascii?Q?kTmx89pWOWGGaLho+m+MvtRIqigPUSDL0JgK7XDhTMaXf0UOPsbY0czoSZHE?=
 =?us-ascii?Q?3Tzc0OAFCtvIx8+N/q96RVfX33wg06qbdzLOFktPeg3ntY8lXIIF+ytspchD?=
 =?us-ascii?Q?5av8FF6Pwi/grq13JQftvuyYnQhwXIqzgmDQ/jZbeMgOpyBDtYXkxLq7R6/s?=
 =?us-ascii?Q?XsiMRpRfc88OvFCoWly9NpbGqd6rxWBggF0Q8lXJJElZtlKxpGcbgYrZbUfk?=
 =?us-ascii?Q?LFuyC3LR5tYJ0QjAPAUA/o+Z7gB5b/DoZV38C/P/4nZ++pest/vBhnIx5zuj?=
 =?us-ascii?Q?WB1jrym6GuyCX4oOtey7fA0Ck37oV7JGDQcNRzEE7TgotCwkEdVGxOgABV38?=
 =?us-ascii?Q?hAQPLMyXR8UPk4/Dd3Y87gRGWdnhTvO5ll9P3zsdeR4wcDd3651EqsRG2gZd?=
 =?us-ascii?Q?UN5G+yrHyuKz+Npxeb1qITzqPPAqCL6DsFEEhCTG4CbhXtJZwQtWXUOqJ7SW?=
 =?us-ascii?Q?aFym6cwAhMUw67ANDMMnucLWwFU6TEtnUbIFxfzTfXt+PbLr5BN1hpZNyaUJ?=
 =?us-ascii?Q?drHLDi+Vjp8E3vK8yN3XNfdwyLeqJoIa85F4HjOY27/1cql3QKoFSxyijoph?=
 =?us-ascii?Q?r7k8cItpjl2+mUlk7dJV6oWO2q7EFu5pQEk9FYXMnfCvCgnJ3Wxx0Sh5XP/5?=
 =?us-ascii?Q?cgdahcT4AG70yVYyWt2sTSgV3vR+ZsKK+QeZ84ADF244kchD9DGwMp4HwwxW?=
 =?us-ascii?Q?RJdI4jqNSfUrIPrL8FTsGTU3NhJdhc3LxbtdlGrJ+HJ9WSvry0SqWuUTSEt2?=
 =?us-ascii?Q?5CzbQeXZdruyDq5rMBr9P+eAbiisNlY/dly7M4JQ2/GaS3orEw2G667NVUZm?=
 =?us-ascii?Q?T2G4deEuhh/O16MmM8TYFLm2iP9/tTncbtYCAU/cfqbTcR0KO9aVj5LsvKTo?=
 =?us-ascii?Q?APITbWqMIhS32ltyIuaki2c3mafj7md1cC1Wecm2ka2dU4+KbVt2JfndVfi3?=
 =?us-ascii?Q?oph1Wb2CdTncSzvCxdg47lwHCrHv4YzJWzL1w/5PV0t21G4vdi215/pNa9As?=
 =?us-ascii?Q?pvhPgjT41O5OLlxZmtMS813Bjn8dIDPcVMFo0HtHKSjmjMe1CVAD9YHsxiwA?=
 =?us-ascii?Q?RQZ4HMECLspYArhGm29qGQlYNyXgma+ALKoMRACt8byyDdiVtFHL9CamuF17?=
 =?us-ascii?Q?rvJDsVTwzXokxFtCVpLtdlC2Vg37sxcQTngXeX7o74Vw3sPE3b/M7L3e8WhK?=
 =?us-ascii?Q?osN30vS9OeACZcw49wygwoC1xwiz6C9xK8h5p047bnnrc3J1chvf1LPxSCgv?=
 =?us-ascii?Q?B4QoWlTc10w/U2LxTR+6HNMdVtcd0HE3U84w4w1xBgJ5TQm1rU79P9aMLHY7?=
 =?us-ascii?Q?1EhS3V0xsJWLi94gCTuI3FaxAcsPXzkSQTUwn0waTJhOYP7BbiXNp120kcAQ?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a30ec-d1b4-4a3a-9fb0-08dbdd1122b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:27.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83FSHbo8O8JCj+UBLwak0XIxcS7P6b2HDGqUtnJ+bvabdJ3oGwccgzF46OLi5oPOLxtn8NuZt1Y0CeG1qhTL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  7 +++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 344362ec17fa..e21ef13b5ed9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1708,8 +1708,11 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8c369cd77e2c..0e65b32cc073 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -577,3 +577,28 @@ void mptcp_userspace_pm_flush_addrs_list(struct net *net)
 		cond_resched();
 	}
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0014b6b542a4..8bfa9bb0552d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,6 +1022,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

