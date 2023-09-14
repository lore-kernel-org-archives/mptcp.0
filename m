Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F928E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHVkjWP/MA8aYDUHJo/sxvqUQlG9B+OqTL8xoIIlnabbCJXAIUYjUmJmY5HTox1NaZMzAYB5lRFc0A0znpqZup3h7gZyiKhQU7HH5fYTPnjednx0ikfceHHJWeNM0aaYCKusulZmApCL4qNW15QFgbB765x9j9AN22FCUXDj7unvEWIgE/qmT0etCULneu5idWzBNtOT4woJkXcn5Kw2//+3YKlT8WBA9yn5yQq+wbOr6Yfr/Cu4CfkFdr7k5DW0FPhJQ0MiBgwwFWbSsUKDaEgzIm1Oag0oDfmyMDNO9Ne5PM8mwmDcS5s0wA3+gnfa5VTE3p43dbfpXos09ZKIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0DYqzz0N+Rak9gFSeNmDEBzmUjeMmCnW4vyQESgfTM=;
 b=LF1ovUopAfidbIbv9p4cahssnhVwgp7SVKLJQkkB3bfYvL8JpU4fAcLBFd/iCrkfcG5CLr/iUrJSo16rJ2LW/y4WC38kBW8GI3l4HMiIa4yvoVh3l2wAsDhfsRhYB2cue2fcgm4XicoDW8tRGbwsczcVtMU+YV6uIgc+k9rH90BEM//WZmtY/ekgwa22mi+kdqeOfWCFryMjCI4CxVErVIRtdIkBdb1uwhgu1gVlLpPfLmu8R0kq8f+qZPJFMNYgOzKBaq5FY+oOHrWoB54SoYlqsOLtTkquxmYZ9374/iRBqPjPMPzoCdrqspWzFWh59lWN01DMaNYvBIK3MHH1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0DYqzz0N+Rak9gFSeNmDEBzmUjeMmCnW4vyQESgfTM=;
 b=zaFehjNOKmxvvdAwosVqRcWneKUxbD3rLPSGEzaJzlB8FPAi6jEzNwhPLJG7BJ2WQoWiiffQMbNlsUF35VXoE8mUatTletzWq/iJV1n73focfnL7GJjQb9CqwdKd/BQ79V0yZSmCABzRx7BRVnSWsZcjKnjj+8gaVdPgCw0Z4XKQ3AJY4TFOJA/DBO3QY79Jep3wWNqca6bkwBJayZ6P6k4wUiLWPzHeB3mH4SRe8jT5ZM0KsE2D82YUnBAJIq6Wwdf9WQCvHXD6JjdxB3ghB19PyD2nxepdSiPFX56AL97i9db+/RU3XmclanaaAt7SbjrfAwkLw2IrFvoaMroC1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:50:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:50:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 7/9] mptcp: userspace pm remove id 0 address
Date: Thu, 14 Sep 2023 22:50:22 +0800
Message-Id: <66bffc6434bc8d29946710187b684611342a83da.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: fdba279f-171b-485d-d3e0-08dbb531f96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gr7/2lxnNszLaMEz1DIUagpsNNzSWlksdZp64yMMAyY4ZKPQ04PzhHVBFa46Knp5Xxm10Crj3J7Atr8047amldDKSPMO57TD85qYx0kxsMCr55kJQsXyae0cHNeomRxOVWfAYPG6IgSOmTBiSU/SkHe9CjhlsicrvTf0mr97gZb5Rsd1Nw/MrfbI467Dbr4CzWxFQlBQSWP2rSR98kELuxih9X4lQ4H6Gct7Pb+2mEo/Fts1RwFs+nsStmDQ7xFMaXwlVpqhpziiBUvzOxrwGNiglvoMkrIpiKBkKYNmYZt1IyKZl8EDkGk+YZL9XqUAoGGaNbIA/HDCQW822ePvowgn3IU4AHm0dR7R3D3tyCLRiLn+PRTFTBJCp4RrywaAO3nxYxw4i/2tQxizPv+IclWWup66l83nZqQJKIhwpx7aiQwAsgss4MLks7APQ4Wtn2/TGaRgTbkBYk0MJNYOsUHHNX/fMf2F7X4V5EnCZU2OSF87jUuCOFf8mVTUZaAE4KnG3jHra8IRRKqIEOCgAycyuo8N9aik3/3XjSTFhJEhOkIiNzwnf6/5f4CdOD0priX+810cTCDuaGp5C8Ibwav7xd+90WFwxKmml2/zKDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8676002)(4326008)(8936002)(44832011)(316002)(6916009)(5660300002)(66946007)(66556008)(66476007)(2906002)(38100700002)(83380400001)(6512007)(2616005)(966005)(26005)(107886003)(86362001)(36756003)(478600001)(6506007)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FslL2xa/GqQRALSyZGTRazDH/5eFLD2g/QkkkyLsZyPsjlz5BkMMTrDRWan3?=
 =?us-ascii?Q?CtAMauJc1CMCh8dYjCVcZi8sgNkNRPgWsgNfCpNkg9MidyRlzU6l5bz1UYLM?=
 =?us-ascii?Q?mACzldgurhGXhUprrRvgyQlV4zl5kN+awu2Grb/dVNhuvKbfm/ZkgUEQpqxb?=
 =?us-ascii?Q?MOccLl38FGykqLl3XWUbpwgKdmIpdFFI4DDZezVgjIb6bymwteeJHy/adkIN?=
 =?us-ascii?Q?kMXRRHHPTGxRLmzHA5HPfXaOkaEhKH6IKX65lVEN4tUcaa3X2bgA95fO9CtP?=
 =?us-ascii?Q?WMdzE52Z4hFeSIYOotSBLj8OYZWqbQ9ULELiUEjuuXMlV09dUxAEKscHTvDz?=
 =?us-ascii?Q?aagjBmIzUzQdVgi6UJ3wE+CZ/PSlzemXeHCDW7qo0cEooYJ/qc1Hjo9bUhLA?=
 =?us-ascii?Q?OpxxO9WKQmGvWSbI4EDb59kE6sto/YJVJwMjIWjTLyKX3Ah/2W+jBYnyk3/V?=
 =?us-ascii?Q?rhGrAU0PuHSrw8E1f6yReVvb9RWisiG2OzPo6CAVAHxXYfK48nfB/3XxUpl3?=
 =?us-ascii?Q?hkUzyWicOvAe2QfoNQtfhNwugTxjYpXS8gJlboMad52kEBiF6iVG81rqvDaj?=
 =?us-ascii?Q?DqDc3ei666P7qCuEgTQktsoDk6OwgQ/RbharcHpTDWnsDRPCOluqZIrHPyaO?=
 =?us-ascii?Q?CIdNJEB+hGhPKiTCZ6uSNiCeMUqfsFR4eBxEAL32k/67mmqKlnWpI5CglJHu?=
 =?us-ascii?Q?0Lm1MJ/uT1sZknDKgHvLJ3+U9hnLPck3QbznqLEP6Ty3C/Pg0McEtU/p8sfM?=
 =?us-ascii?Q?Mh4bvfJkDwQtWfnUKkqUKCdKQg+dU2GTralC9M6Z/MoYx1to4KqDECGBtYoZ?=
 =?us-ascii?Q?OHBjG4YEWw+o6CV4L01PgVVTgFnUlk1Wfrq3ibz0zz65tDo7A8XYwKKS+E4G?=
 =?us-ascii?Q?Si7fXSPYVscGUsxIKneiEprIn1zCYeSzCpU4IrVfnLuE2IAai/pbUngvi7VU?=
 =?us-ascii?Q?feU0874iFS7rI0nWPtNs2ElJRDIKc06qEZgxTb/3tO8nLGO1gpr4jMMBe5c7?=
 =?us-ascii?Q?mKyDvUGM7JMGSdJABVMJj/HDq5BaAbBXSHBbZ7PffwHpnW8f1/pLfAAkz5wv?=
 =?us-ascii?Q?Bff5O5heKuAr9GCHwhFUfB47EnZzRUdVRZRQRTHgxX3JUDGgbvv5HREsiVfQ?=
 =?us-ascii?Q?/LEmmdN6lguyMbxfqgszSUN0JIiiERP8wG4EmvNrVOUaotskTg5UKJLP+pL1?=
 =?us-ascii?Q?k8WMmokWI5dZigXSJj6R5dAB3P5BhoG4tELFLx8ZjFzWO29riV174cshQSPi?=
 =?us-ascii?Q?7fxhnNsaxJnu8DMvadH/jc2o0PVW9CefE1M0qMIiPXInZ0xhBDd+QF5JSDqF?=
 =?us-ascii?Q?ryuhOLvyElMFMxpuS2x0MnlWqLsIt5OhGh7M5UTZYLYR6vB1GXEn2SrqcSAq?=
 =?us-ascii?Q?zE5aph5SB8hkoxEZtyFmyIl3SBY9ovgmWmINp/UJSwnjPNYyDvvQ38SNvuJa?=
 =?us-ascii?Q?/YZGJiwZH5NMNssIlbPbH7ai38yxUibQ/pkmWAC6eUgaoVnJsJwA1klxjnfK?=
 =?us-ascii?Q?uMjJyPalKrhXXSwbu/qcXJb31FmCaQItNHznEbLO3tZIycXgXRzimX4wy+ct?=
 =?us-ascii?Q?YdekSgG+zlD40vYwpIVG6yU9yvfX1t3j1o6O+00zU1BJ8MnQmMuQHT9C3ENv?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdba279f-171b-485d-d3e0-08dbb531f96f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:50:45.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uezh/s6aPnjvSWM5IIK/Ps3JivB/sigJDLs/Wz+aE5/26PkRSHvjJGQp65wv6u+7ezB9hUZv/EMBLxXJvUCoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..7bbfef98b6c7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -208,6 +208,30 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct sock *sk = (struct sock *)msk;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	if (!__mptcp_check_initial_subflow(msk)) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto out;
+	}
+
+	list.ids[list.nr++] = 0;
+	mptcp_pm_remove_addr(msk, &list);
+	err = 0;
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	sock_put(sk);
+	return err;
+}
+
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -239,6 +263,9 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0)
+		return mptcp_userspace_remove_id_zero_address(msk, info);
+
 	lock_sock((struct sock *)msk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

