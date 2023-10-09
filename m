Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF029CA42
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rwahdy1Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX5kwW/tdpbVMnIKS1MYyWHfplwaw4Qa1pPa0JKAFrTimYgreGbveG4/s2xIaZcd+8SVmiLmt1w3ipdrYkk6LN7YYNqj4v20IDfvsEr21NbHl6n3MbbtprN5RINLZe6PHI/792/IpMmSpJRjdd26HfvQEo1nbNSCEluugCCwOB7y6byy15GinwgerwnTkl14n5QBhmQPlKH9BxPK784HgW2sKrc0eKCX/MdAC0uKO9MJ07hhv8RLZM9HDw6C/Ft6f7SNT2qgQKDjQ+ySfLCfEdk30+Z68dTA8ou3CN3aBKdobQqInQgWrlax1jlH7YJNOmciPhzDXt/CNBiQe0BONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL+uvMHiK+G3IxrmrSSlHqsSVu7cibWoXZiegABuUro=;
 b=EsWIPRBz9Q4uEXA1B0dsxrqXK2gxGDBIlVGjJiTrjEFkxqdTNETdBHVqWaOmEca+RJin1+gkggEZwT02qt9t90bfIqbbFrmt8KSQjPJkBJ1veWAD8NPWB5MnGEuz7TBTNTvUbKfU9d9bxpbB6CR5rT48DDEgwhybR0bWVzZax2wfrkQ4LGiptWHgfAa+7NSJcJa1k7aP0dmrL88YINDbu5lFp0vwMKbdFAILNvw8rpZ+L2CZU4q78hE8pXYgfXRCQtlOcbcm1VPmNs2y7+anF3XXbn2VKyKrycFbNkj8gt+Kl1zfvFH8zO17yL6Y/uA4Jyikp7ZYHcgp4ufXaISQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL+uvMHiK+G3IxrmrSSlHqsSVu7cibWoXZiegABuUro=;
 b=rwahdy1QbnR0imrtEjk+Vi4nU7YrNCyBzJRxm4WxxISFkvZhbJpDTtdmRPcmeRyd8F3LSBOzCXGsv59wAMeGW44kRGoWJ97G0upSvdax3eX0A2rGCQjKmA4m2HQLd5i1eT+zc/brhx80p2VoF2mVWzqxBin/YO2aXqlU4OBo9dS3iR1MSxu36LtG7JzjZcG6JVNtoisCbSqpq6/rrYqGG1Z2oh64Xo5UnuMgrptvmw/ebY+OMw36iWJ4evd0xIfERn9cg4Of3oClAjZQJsEHvmKYt/xmRBRBv5w33OeHKvEG0DTHSfPrSAS3wl4I8Kx6A3ZdBoM8sSU8acOKDXgZnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:02:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Mon, 9 Oct 2023
 06:02:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 5/5] selftests: mptcp: userspace pm send RM_ADDR for ID 0
Date: Mon,  9 Oct 2023 14:03:00 +0800
Message-Id: <2d013e9f4cb101e018269da31e3d70b8198482bb.1696831239.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1696831239.git.geliang.tang@suse.com>
References: <cover.1696831239.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4252d7-a9a0-4e9f-557d-08dbc88d5031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	usZROkP1YbBqxvMU71cWqhWbeLOVGyIzW199QaITLqTUAItHqXc/u+EKSZHXmzS2OoztEWgEJ/e3IEx14fHFog+lNUdp0zlYTievtSa2VyteAZZYko2OLOUErEOXXH+m/+znUXTkGF21kHt2CxRMMrDUDXsQaHiR0iiN3FJPMxD59648OUFW+90lhxVDVUweJyDfOjjfUdTrVvCksMkonDh1uZWi5QEhINOBP57v4NcZ+gNBtrSdfLd2MIITloUG7ByR74wWtvHz4yg2fTOMeVjrBFjvsyCddeZmsttvpUQaSWVC8MAg0D0rhK7baH3ZxKXUQlr/rZ+31Bkp+JNDXA3fhqkNWBYTIya5eaK6/ZGVmK1Sj6HoB7+2hdDFEw6vsySIr2qwUP/3HtlsQVjRcVunnbG7Q5RPuqPvgJtv1Z9oLTdcHOgGuslf+A5hmv/ZhpkAimmdMdtPzmzOs+O1unNCQxDDQNZ/RJEG0lganXlk3ZLJI7ZSb7TgUwPM8q/VGQ4DIPfnx8Qzy8HlGI5EwaQS7pjMDkwY5rt8ZgMCyENymX5JQAMSv5aNVsVizqulMig1GXiZ+SKbHsWu+rYB63AN0LeOYC1uDLPRo1wjJuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(107886003)(2616005)(6512007)(36756003)(86362001)(38100700002)(26005)(83380400001)(2906002)(44832011)(6486002)(6666004)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(66476007)(5660300002)(6916009)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gq8lxXKFWV3m0gcnrV5w3IdintffCA64V9fYNJ9CvOvjIPbQovZmDCmNV8r1?=
 =?us-ascii?Q?vT2L1kMhOEOsQXHyQwE4vJjicnXaTRU2J7C6riqYTV7BCjSjFrs4CVxJ2FQl?=
 =?us-ascii?Q?HdbB/ODj3ij0kz6Z5Cm3e0ur6Z+bSid6N6kjq/kTpFrHLNoVqvf3aPx5ZpTn?=
 =?us-ascii?Q?b+Zyy0cbWbRskijvIIlzssW1slT1xKKqwJz9PQiuzHOqDmGB0gKEZwA+5uzH?=
 =?us-ascii?Q?gi72qDQsXAfG+ngiAmO/OyojbBLEY1jDxJVgSLaiQgP9ASrcpaVPfwnZSnw1?=
 =?us-ascii?Q?lVVMRlCYISlHl2ms58XPIIGdVu+xMbHZqu0h9P7r/vnJH2T0e8WPYMS6zvmt?=
 =?us-ascii?Q?vKOpPYwnKYsUoag8fFT6/TtwbIPjEXLwtQqnjEQwhFCMYkSv6kHgJ28BY2ST?=
 =?us-ascii?Q?Dud2KqD6q4+U2rGux1F/l9ypUXYAC3Mrg/N/2OvuhmaKR7boOEZsPnzflUYc?=
 =?us-ascii?Q?qbb/dueG2nDWrolrnjgbVLeYm6YG6t4B0uo86H0LzGkzNFG9QMiPV/EldjWx?=
 =?us-ascii?Q?rESNxZGDExiZxrXv1hpFaaWBgoW8RGLAe+l2NP9KkCo1bUJStHR3rH6NiNKh?=
 =?us-ascii?Q?vd5jouPMB5Zh9zmtO3tYHoBbSlyXZZpXPWw45TxX+pX9EqDX1QG6JKidjfSO?=
 =?us-ascii?Q?G8gfAcpUDKXCJTlXRL446K1ZtKLJOGxVm5/6+V71opw6ANSr96EJm5oKuQbj?=
 =?us-ascii?Q?8R0kW2lfYSiB3WCNIZH+4wuc5cKB6VGYk0KOJqjPw3Gs2tBPJssjxOjQYBAU?=
 =?us-ascii?Q?FxcFOPAL7NeOsinF9kWuWl0x2805QzmeqvA7nD6h+8zNq69wl/8Tkz0mMPYE?=
 =?us-ascii?Q?sPmWI0Lma5CynlpEo/Fxx8KnSIs6D0Mp9J4BBQrvinUn2+yCfPY46uG4p4fl?=
 =?us-ascii?Q?q2A9oRJ6KrpfkoooOMHMrkliQQ+dlloofD9nW7edJwZ59gM/gNiiVypKT6b+?=
 =?us-ascii?Q?QWOplUjQi6fcWFVwWQNJI+x8Qq8xGB9dy40EFX+bM4SCiDsJ5Ms2TgMpzP6R?=
 =?us-ascii?Q?/ZRinV9IWcYZTdw8/G51wAzCgAn4qV+4A13hpQjgGIB8qNmWbvyW7+4DR4e3?=
 =?us-ascii?Q?n/P4WZd+4ckoqoaD2pXdCwSyVg6ChTeNv9hKqvQykzJaF8G+d11pjgQfs3eK?=
 =?us-ascii?Q?Ps8byLXeliLfkojMc75OsduZpDanEw9tGseloHf5Vc4J8TkCkVwPoj13+AUS?=
 =?us-ascii?Q?F6k+Q4mn8KkaS8smk0DV4jnyOmQZ0L4QfCg7jSl/EffnWcOJ4xON8bPrqTy+?=
 =?us-ascii?Q?QHEGWsLOBedL+Iz91YKKXIqvrzHZO5npvwhNSP3bYcOFkuc5WjwZB/14e6mh?=
 =?us-ascii?Q?fAtpxdbBOf2Ab470eHcGArXQrML8Wh3lV0CTOo/ne5v4fkTO/x3vqomtmW6k?=
 =?us-ascii?Q?TaebOo2pl8nfmiADJ1KrH+kXPESue7DfCR9CRXVTm8QOJ14xIs4s5gMLKaMD?=
 =?us-ascii?Q?Quq3L8rY6eHMwCMjcepRNedPn50ZSKTmVzEvgx3+vGvv9RtA1ATmfhPAjLWa?=
 =?us-ascii?Q?R5lEXPv8YdTuJ/hnP5OGsnlIywNc5VVH8fZgbN6mCrAOsoMT0ZjzlAsnu0a3?=
 =?us-ascii?Q?phruJQ/xtw02xbnN/yXYgWffXMjHMzzI6bB3uBJ2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4252d7-a9a0-4e9f-557d-08dbc88d5031
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:02:26.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gQ+3xqeU0cDVeWt70lbbAjO1dMn0Z81wjjIkv+NFmMzaDzRWIY1MsJYwblyVxRYQK27FEDAHWXZFRZUBppjsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d396b290e20b..55aca4e7f051 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3512,6 +3512,31 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm send RM_ADDR for ID 0
+	if reset_with_events "userspace pm send RM_ADDR for ID 0" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		sleep 0.5
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

