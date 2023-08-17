Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9491097B
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 14:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dALc18Nchh0eiBskB05viqNc96IhY9++vfiF6pMyasstdkjYI2cKdvOxCQoHSLkTK48497+FOJiLZ0pHiZfKn8WeE46lmV2ZcZ4eEhfWPh01kBfbw6SW5Eb7SKwEl7lVFsZuBCoOHO/QMD6B3FQR4TDBy6FppTtnEeFn/8N/G9YtqlnJb34B/k+DDpPEUtUnAoEfmGQ0Wpt3ccKRcNr3yuLj+d9ZuKeikGL0pFGhP4vBf3++Xnr2W9LAgT1/vHC8c92nZW872PD9NfUzxpPghsJlJp5jQayr5TXhsEj24gOmmNTxQeDhIXYCV29ahXrQbeAVDkdbcVbWPcQGu7prWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGOtSTJIJGCqd1RioqpUQcVhYsnxs0ehNo+hY5q50yE=;
 b=QQZmHmXrI75Aos8AL0KqGl+GW+ib2ZnVEsImEEHvjSJNYFRhpzb/EUq+t+LvSKqlUFT2B3L1QJN2cJczZoOmf6Gkwt65HJDpyPpH45U49dByQSAANZ7ttFc4E/Y6IfGDD7Ugl6r6fTZPQPbcIZdCPmaqECwgexn3J4Umn+1q4kfzNR23X9z8Uvp3F7SHhSvZk7Fmtk+84xhEDNGeWyDXWRyicqyzC2vhmoP5Wm01HvJj4/qLh7MAI4xUKd7+vE9oK01MvZcQdxnyiXq2PGJbrwe3w/xijF1zkSInkPpJ7Go2cR3hcaTskAYDJgMDq/wFfzQjTwh7E/hdzJC1Xi7XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGOtSTJIJGCqd1RioqpUQcVhYsnxs0ehNo+hY5q50yE=;
 b=2y1opZVPu+4dEdze/av1Rs/NIQP43aboC1F4HI2A/SvDN2wWv4Sar+vCvy9cIwygn81fVARnn/A6Qak3MK9aGGldAjdG1zDTV7GD9HFXBInIsLtg27ceIKn288cACRjzqRUbq+5bnkP3BrUaVqHDxk0r4qumEJ8k1/SXFpNUiZgwdoKYdaCN38W4NWKKf3kFJBFJgWrAjVzQvyW5jdiJB3R7iYg0vGEEAp/kGDSGGU5tLiBVD8vdden8yG+MgnUd0zM6ny65mvfNibYZHJWK5VGaKj+SrLoQXfAPJaYZQ5Sf8nIjo1Xur5MaXayvw6GsVMYegA42VM+781cE8Tr+Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9057.eurprd04.prod.outlook.com (2603:10a6:102:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 14:11:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:11:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: remove id 0 subflow & address
Date: Thu, 17 Aug 2023 22:10:49 +0800
Message-Id: <4d399e6564e6a4c2ea3fda6f6f4f7ca50dd6c0ac.1692281317.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692281317.git.geliang.tang@suse.com>
References: <cover.1692281317.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f973829-d681-4a5a-a5ea-08db9f2bcb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M7G09a27JA2JtbgtZvJZCCcAkkHsyMv2HJaayXMN7nyoZXP+TBpFC+7cB5bmuJYIk/EtcgLxPixGrnVCVoaBL2dHcDfWMSNolSDR7MexyHFS6klzmYBtZtp7PUWPVRrzU8b1KLklvlIwtHOFETfd7/l/I0993cytWOCYJcZmoXNOiJnf/PNd1uT+Jm6JAc4HhIBjiIIn0n3WK2PEInhlr870PuGzjfYp8ehJtnG0ODsrA/CVelJ1wKRhkmEfWUyYl57eC4gW9zjb9nTKxmGo/6EuknT6OgMPYwiCSmA1xsm8QoU0uD+S87PIiAFHA5D5AfKrX8Id819HWdShjn3tEI02sDhdbb1AvXXdN+HPsJD/s5XYq5MvomskAkV13BUIoXT9UTrlYehRA9ukv6yrUhLp1KroKBYacEdT8QN020AOSpN3tL7jxreP9U8ztZngKIjEHxPLj//qMC8Uk/9jrdT5sDYN79j7UKgKccmLfY2u0TLIPqIxzGMdLLMj6XIv46SMd9DGYfqnt4D9kuiFufDyg9gXOXWHBwOXVY55IuBaNtV/R6rsrF0OZfAiwhd6SwUpKtfkaTqmdV5FO11tGgLSrv2ow+CU1FJnZFhdGy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(36756003)(107886003)(6666004)(2616005)(6486002)(6512007)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXhHhArraZ1WFyMg0UJI5JkJq6EvB+gWo+mcEfC+QKFpGxJCTTWQczofLeg9?=
 =?us-ascii?Q?TCafMeETsy4JYIYnPBgqsf+jDw7+RBF+0BVQuhtBeOtNMrczxNWrDyjb5z0u?=
 =?us-ascii?Q?ESynTXgAxjuq5WuoFaJSmbQdC03l6jxnQHuQz5Hbv7z76Q5MNytQq/KOYV0y?=
 =?us-ascii?Q?zE0NrBnK+/bTBsAe/RCBxJJ/cu8kUpqN+v3ZC2YfLUkTEsoChOPIWlsG875J?=
 =?us-ascii?Q?UEor0Thdv38sbmNEBuIn0TX8u4BsUFe5nhiyR4srLUcmXNL8FoAPzAoee7Hh?=
 =?us-ascii?Q?mL8BWk4SlbE9+7j5REkzjzLbgY4UQfZsfXmbmD06uEBhRS5bFQis2JUC3Mof?=
 =?us-ascii?Q?yC2mI1TKBPd6C6w6qDP5FVQ0OR+iUxG11amUVbVgWyFp/OOo/ObsadM5X8jp?=
 =?us-ascii?Q?0/pr2iilDE4iFcab9wSPjCB+7UPvu8zM2csRor9wtSpy16+ZiP9Mt8n8DK9v?=
 =?us-ascii?Q?I/Udk+uEOwxrBOViv/xZUWaZXcrVb94zK0XedgHqSq4MsdEDuKtGHlHUGT2G?=
 =?us-ascii?Q?WHvLINvs2H44AxnEjFoJX0c1IyTmE38AnHUGQFPDN40vJn4F+R7CL35bR4+4?=
 =?us-ascii?Q?HZ0xr9UZCfggEktH5bySfQhNG9BkzI6suoxGhFS5COURQu2I7hNwCwyCCTAR?=
 =?us-ascii?Q?C1Nerl0lFvId8ewEIzb3cQDCymVJ7+jC+xAXSViLAxY32BK9b7dvMghiO2Uo?=
 =?us-ascii?Q?VDmtz/blfzjDXA3PLNEyvhxHS9jlvXL2Q937mtMGEAT/LM9CQ4EwyyhtIyqR?=
 =?us-ascii?Q?GOw9YhIlthjLm6w4RxkM0aUFnq00GFrqCSNOxB55/V0PpTZPzUCe6F/WVH05?=
 =?us-ascii?Q?4cQ+SWVK+AFza0613oJZsJRGCaYp6XEPFEciqUw/tQMDMIXDY2XPPijpQhZY?=
 =?us-ascii?Q?WI/rurDSNRjrOa5biUXkgHZQtR+HmGQyTn4dXGQRwTIkNfVUKieX9L+J+db7?=
 =?us-ascii?Q?EVdPdCQ4DVsS6g/yW4mOBQe5ynowH2kCjvEIxuKNEhLpuRQZwRB0O3WF1lFW?=
 =?us-ascii?Q?sqCPgmXdF+3LiaEzpsL0N3cvK/3XerojeKfR7pDCPvRQJdDaVAyrr5ahsleX?=
 =?us-ascii?Q?9khloNsCJOYBP4GSDn95defnxVKMqsnXrEgDdkuVsN94LyNE+EW1njNDFxTo?=
 =?us-ascii?Q?zgfp5K/l3WtrbJ2yQpYaFCLX8KTOTE3h33YvnMC5NRXl5+FzABMlOPVNb9sU?=
 =?us-ascii?Q?QYolrvfieSkdbMZa+wQCv6n3HtHQghXNYqsuX7BgjvWna6im1mLAPfyJIPwM?=
 =?us-ascii?Q?Mz+b7b9GJz5kNORWm/I/KMCLD1zJSTp6tEAbvIy+NaBQc6tPgRe3QRirAYdH?=
 =?us-ascii?Q?PW9VGohcYfvt/mqVlpJ7VclFE5CDsE7kdQxdeipGiDB4DrULRQLyyUO8wWtq?=
 =?us-ascii?Q?xG66bcH5bu3PxuqPMSZSMKU3DnPY5cD9RsglguTqqDslFIAAp3WFiwDXjgwj?=
 =?us-ascii?Q?H1pSsU7WeMOOBAcyONg0ilWb9JRK1+L5HGjLgbgjYlqrban5CPphjjRgy8jy?=
 =?us-ascii?Q?3K9IRA5qedrNd93Yh6L+xGiHgMIKm5Z6vo+bXPULR/7Du12GTedJWM3RiZIu?=
 =?us-ascii?Q?rjIpwTggST76hjQ2Xv0mR9TIj2O5rDts90NFD7Ny?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f973829-d681-4a5a-a5ea-08db9f2bcb43
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:11:04.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi0uvqw4/b+g9EQcEcn86gYn73lTwQ2F2VLF2ELhMxS6ujMBawjOtpVq6F7JlUxnBe/x99oN3o5+TMABCSVrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9057

This patch adds selftests for userpsace PM to remove id 0 subflow and
id 0 address.

A new helper userspace_pm_rm_id_0_subflow_or_address_ns2() is added,
in it use

        ./pm_nl_ctl dsf lip 10.0.1.2 lport $sp \
			rip 10.0.1.1 rport $dp token $tk

to remove id 0 subflow, and use

        ./pm_nl_ctl rem token $tk id 0

to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..2d7ac76697bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3320,6 +3320,26 @@ userspace_pm_rm_sf_addr_ns2()
 	wait_rm_sf $ns2 1
 }
 
+# $1: command (rem/dsf)
+userspace_pm_rm_id_0_subflow_or_address_ns2()
+{
+	local tk da dp sp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	sp=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+
+	if [ "$1" == "subflow" ]; then
+		ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.1.2 lport $sp \
+				rip $da rport $dp token $tk
+	elif [ "$1" == "address" ]; then
+		ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
+	fi
+
+	sleep 0.5
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3434,6 +3454,32 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow & address
+	for type in "subflow" "address"; do
+		if reset_with_events "userspace pm remove id 0 $type" &&
+		   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+			set_userspace_pm $ns2
+			pm_nl_set_limits $ns1 0 2
+			speed=10 \
+				run_tests $ns1 $ns2 10.0.1.1 &
+			local tests_pid=$!
+			wait_mpj $ns2
+			userspace_pm_add_sf 10.0.2.2 0
+			userspace_pm_add_sf 10.0.3.2 20
+			chk_join_nr 2 2 2
+			chk_mptcp_info subflows 2 subflows 2
+			userspace_pm_rm_id_0_subflow_or_address_ns2 "$type"
+			if [ "$type" == "subflow" ]; then
+				chk_rm_nr 0 1
+			elif [ "$type" == "address" ]; then
+				chk_rm_nr 1 0
+			fi
+			chk_mptcp_info subflows 2 subflows 1
+			kill_events_pids
+			wait $tests_pid
+		fi
+	done
 }
 
 endpoint_tests()
-- 
2.35.3

