Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDF1105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeWzLDcqty8dd2eZPVxRd9UP8mCqWJVEIoTFlbb0RJldz63u9flsRgcUeH8r7gbMSdGHqmF1n5eHCE1+iJqykdaGlOwOpZ7BBDD0M9+K0Xq7L472UEEsZp6JsZcd5xT2THROZ6YCIJu0CEE8QncwNUkQiR7JEsAmdmeHVNLAI0Os2oOrNZrQvIOETAgPJFxb9vYdo2LGYVK5L89/vIK9OnX8HHJ/eaNldw6RS9brBzw/vXPpfpiSND1R1hj41Zb7dz2Uu2Jodt4gRR4w2M1nf6viRJPhhhDUa+/KrskqKM+4ROdf7YT4Q3Te3Rs/PBgIrEzEGljtlkn9oFQdTnpt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI6ElL2xjN11D5EYTplE7+bIxpKKHH6XehTsvkmzj2k=;
 b=G9cuZ9dfkbGzT+ZsNXRs+qkFKd5A5/GZj6D4yw5mIbTxicLRSqpnBja6gRw4BSql6lBgxIpfqI8qY3Tb9mIITtmMOfPVuhVuJbivclm8VltUqKPuw+V7oDvZ7/if9Tv8HeEo+N7A8/y6GgfLedgTzXki8uJevqLXGSAD0ZYc0TAg6mxotbsiTs/eucdpRFF+BBvtquHQXbwZHb7hHZ3lZ+8uJaeTGEVF4Ixgxiyrzqmizz8Qbmj2uQNyGE9k3yDJ1uqebF54k857FHKJqvSmDKacjlpyAfV/0ZpbWqMBzw9ACW0dkUqerX1LKlFuHhFEdzzc4qKWBOnJIt00EegErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI6ElL2xjN11D5EYTplE7+bIxpKKHH6XehTsvkmzj2k=;
 b=19xhtux4RVDgJYiS4gWuE3BHrEZ32yYo06Z83cJR6etPLBOHyqE/lkqjVwUxUAZ+WvnLJAupvV+6g/mFIXW+nJvu68u/BHpq5Qi5hMuqxKBZMKh1U8LqPLU6HCr+o58XFbe/Xp6ypFHGjjjdM+OLeqHqgCCIwm6oVaeNk9gZ1i7FB6B2kwHY3AJEYCNLRCJa+k6XO9fPRDFVUc/okVlkhdUMq40UaOtqpNIrPQ5Q8uFLrgad7w4CTV+Ys3AAViKkGaCVHQuJR/BAS5N0A089N2qILP9Y+9lVlZMVNsubcX3m068CFnd1PTZdvRRH0+jfZrhbhWH4aRpylOneMTC12w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 02/12] selftests: mptcp: update userspace pm addr tests
Date: Sat,  6 May 2023 13:08:50 +0800
Message-Id: <668b35bc7252b13bfbc675be47f607068143f4cf.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: e554bd4b-69b2-40ef-c5ab-08db4df006d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HqiuEsU7bN7WS3DyLvTCk2N2RMKYHGQYZ9vSPjo7FdtorRu4niG4+ymUyjpi1XnThtWbPfFva1W9CC0c2zExNCjNsEVmIS+8Luf3E8gIllLKocFYjdKSaaQwVUjRWfujt2A/du23T34aS0IjSX1Sg0tzDduaRI6ny5V5EoK6s71vBW0Re+YWcCIv2AOZKX0KI5ANGpRyjFodcG+OWcrop6z1WrUsMgYaJK4wPsaSZHUoeqxgCM0Ue/kWsDzeE0FDRaVTm3T+j0tGtKLXSjlOT7HY2TQwGmw08xz2H6wO5df+xU7Br21ucc2nZvyGKYorFoLsNpDOGQdY40sZNce38/guKV79SvMMfxmHKcIYSlZnRCssZ9ytAWNY6fCw0VZuhDik6BU8HSW7EfHh9KtG+2GyPfoA+d9i3ubkWn/Ke8f7ZcsIVVjXfjWWI8Vb8jUD03MWxKhoQnemsdpNQWmKPVg869hd4F2RoySg5i9r+6f5xEIOpLv0gNRj3SASjwRQUKDsKSVbjPGmrzlOPO2xOn5Wb+DyE5aSmCoTG5n/mmbzhGvvCLI/AcsV64BeTQRz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(15650500001)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBYQNNF7Qk7KLJnKKHhn2ChbMRRsPIVODNpayt3/MlyV7i7BNsBQov/eFWLj?=
 =?us-ascii?Q?5HR2HqXAM+ZahErDawIE7RVcPp4UrsKK/JBTQBj6zHuB0bq4XYZ03lb5/aFy?=
 =?us-ascii?Q?S9ZJ5BR4XcGWrATZLCV70QTmEknpeTsJE7DI6Nh0j34Aokbnj8Q7F87lEYst?=
 =?us-ascii?Q?iZc4UtM7+eYHHP/xvvn6R58lRB+NFiNdWBpIofxB0gPWogcHpdCmFix2guwT?=
 =?us-ascii?Q?tGaz29oOJxUQgVFieLS8KHjYuB5zhRBSVe7SMm6yrfdlFpmLWFesRRzwsNAE?=
 =?us-ascii?Q?suqI98BDhd9zi4XZ/DNa5bRTx25WTVzhRQqCpAKgMaOm7hFLBy4WXr4lby2K?=
 =?us-ascii?Q?boj5PxLoma3Gx/ejKNirTE7k9LgG1dRityCOMdYnaQk9RCKWwxNMeHCUA33m?=
 =?us-ascii?Q?secJc+dVoHaUfN31TtAXmGDlnPF7Qw5oqmd9UU1rX7z610OPA4riUEPjlQDm?=
 =?us-ascii?Q?DgNuMkG6OLkhl3vwdgnwIMUnnXO4fEOidJucujyaPUuIMF5R0juc10mzL2rc?=
 =?us-ascii?Q?vgEcgTSN5YEDneZc4FBbmyVWRChINGS190BPzdLu8T7nvFjUBTIRoivVFbGh?=
 =?us-ascii?Q?waGfrCmqn2zreh7UTXpk7XckZtR5bdoiKG7gDWFMwzzsBodtflZfeTKVtrLW?=
 =?us-ascii?Q?jgEL54EQVT2/UR4sRSfGkCeQawdNrwAqe7f3405IEXZOzsVh7hdag81DDT45?=
 =?us-ascii?Q?ELmblqrhJAx9zie0KtAp7XpyKWMJXCxpFctHN3+6wjfk+1xJq96EDKfV3Ucj?=
 =?us-ascii?Q?XGm0xDjePBFL7LyBXKgRwXrxVEYaGNalx6D14M3tx+t9qInLtmgPmmgd17uh?=
 =?us-ascii?Q?zLC8pDLN3dSVHz5lhu3nujjlVdlsxEG+uHs5QKMwv+kBNFgQrHaOMzMbIQWp?=
 =?us-ascii?Q?Qj7FzDTTeMg4tqe3UxffgFh0qkFQS5HnBjgOSqhJF7pZfict4cHy+ucoNEbz?=
 =?us-ascii?Q?KaNJVWLgG/OSPxxpsxo8Nn9uUg+krmfK6k1yzYBTpXcKeLMo3+UFXmmMQUMh?=
 =?us-ascii?Q?4r+SYEtpz/mWeGgP4jHAEbvCt5LGKT+fPzKkcpLGPe3QiMgtIv3QH7p5ngAY?=
 =?us-ascii?Q?9esRgKQVWY+eD9pA6vv8oubtuaosJqrcXX8pDKlRvCYRvB7hn+Q/FAQVlIaK?=
 =?us-ascii?Q?24sgoW1BQ02a0oZPZkBlgeOHO2clWWgRHQ07u0FY3XLZL91NjD+w6Ll1fN8g?=
 =?us-ascii?Q?WtU2/5GPPQ2/Mpx3FC6etReej+DhgnWrHCfa+EEDeaD3OLB9P8ESagp85sm5?=
 =?us-ascii?Q?TDUq/DVbIFl4RqmDPmvbSBqnBSwDWiXifF9TLPHpnBBz4ImIJRwr8S0zJD23?=
 =?us-ascii?Q?qRSBBamhLx/wopFja9YmVfGjTOFTfd9hVfkeK4MAJZTaAjdp946NBz8GW+SZ?=
 =?us-ascii?Q?GQMGcw+xshzWTKeq5bUqdBWy4rG90DJxEwQAaz4Cnpz+nefwndw88XrDk4m7?=
 =?us-ascii?Q?JW1HtT8DQ/9ZD7aD0r8IWG8HksQ4DMPAB5FluPxA3I9TEMoC/XHIRaQRQLQ1?=
 =?us-ascii?Q?zSQ3T3ZuFA04NXxQNMtazRUtPJMk87OizTAx7LbdGSMC3xlyxc8jm5eTEGSR?=
 =?us-ascii?Q?lOpGLQUBu3Ro2vbCs5VI4CCNNVVD/WTkQbyQ7n0M?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e554bd4b-69b2-40ef-c5ab-08db4df006d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:10.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1dB7sZpyyO/Td0nuT71+Sc4LzWcaQFV+n9TV6/p+u2Rwc5otb0k2Ydou+SavIB+9wmxJbT+OSk0jGyo9COpMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together after the
remove_addrs command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 627daeb513a0..cb0ae133f5ed 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -864,6 +864,14 @@ do_transfer()
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
-- 
2.35.3

