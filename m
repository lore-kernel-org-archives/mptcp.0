Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB85196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5w2X8/z0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhJfmxgZH+FD5QjrKPFauZNMC28TPakED0tIlH0WzptB3y109FtRWedRDF4kwBRWXjqQACOjXOikwwJSi9SSXueb2/kWkPMfidFhwX/G/zMCwwSk/hkGuLexFvIdLPeTW36EdcB86QtCkxoZ00s/ndXE2h9+msOmorZ7QqvS6LB6ideq19p1xgGqxRph1wVU8fb+gmfIj7bruORvXTYDev8sPtGUy4wlrjS1zHs8Hblhl4SW3yCx3UiO+57T7tSSUx77wCtKIbgEAKRRuVqg0xOXcggPjIBSCTfOZ/puLaDwk1ifpOBLv/ucQf5nZCX4und9sZNkvzj2QPY8qEkJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmlG2BtJ5D0TKRdWHuiNmNkxnLq2LDl1aM1UXtI2uQ4=;
 b=gQq0n9cXSfbIYMb1ylIIIDyqdNq3o8KM+qPpeKLTFYu6ZcXDFKk1Dlx6XMDyjhMoBNfZz9pMVkUWjqj6t/TYpAhA437TL8412bf9XAqa7KJ60HheliI7S5A8lEbB5GJ7bbSJ1mC2Z1xw7TVnOxYyrX4S1aD/i97HRWUh2yxyUXJVz8xYDO3wcp5fLQjmY2se5Y2kLUnuR7rH+0RGYbdpNAtxXI36tISBHkIo1IWYVY1NRT0gEimmLSEDBUqoIkW33Zoe94IIHo5JDEBpluxyWRkOWj/Fz9R6xp/zz9fJ3fjNVa8lQzHvWSi4NzD0qG1S0h8YzLpxDrq86TEcd6kFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmlG2BtJ5D0TKRdWHuiNmNkxnLq2LDl1aM1UXtI2uQ4=;
 b=5w2X8/z0vJV6X5LfRYic6+LFWexV6G7pcBKNkyG5Omuf/hWiyIDqJbJoB3oxRBf3yL8hbxubmtJVPE29aj5VKVr+VDLnq0rzkM7kBRwL0tr4kc6rQXXQNdEx5d74hYEdqFR1eN88zZmwKknrpV5wA0bgcyDuKuOykCpPtstZuhcZywCZSsFzkHwy/2uS9mFNfWI4hnLEQg6VFKeP7PlYT99SJ/pJ5C+yyYx2iVvPdL+YjjTUheqgmQ4LPmnIms9kg4kP2dB6OHNOm+qxslfuRm985WCq0I1m35LOZkqKQDD+6wp2UmH9zXQa8W32Tjv5UHfRQ4t2MLnISboKZFJM7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/12] selftests: mptcp: flush and dump userspace addrs list
Date: Sat,  4 Nov 2023 08:26:21 +0800
Message-Id: <1c34ddc17a6533d0ba9d097d2c6c6a4d8084a1c0.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a2e83e-2f9c-4eba-accc-08dbdcccdb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nKqRp8zznx/ahu55onuJtaIUiCnZReOaOq3ASrQjSWwQNTF81+1q1pfQUKeDQYEWVq1RnBlHuUZ9DD2Zzjra733By+YKIAORA2Cth60/teckATqsPK/DApmiOkiuypyxlHHFxgUD49AVGUCZtd70DbrAjhjiqLyDbPEkYdMceB8XMH0dViDeCOD2FR7BTjCR66AFSDc9XnbuHrXwcCqRkfWWIgGdiIyWwZLsZKMuEtTijo/wSE/CY0Esxapk6HI2LFzDOlLEChMKZqA+DF4MRo4PhSij+BMYngAVHpqF2dCIzQxKs7GDSs359+jvG9+EKkaQnk9Cz8W7QoCKiyCBu4imwPe+Q4vxjZNE6Y45F7v09vPfohO1raed5/W79BJEANlE1ygde1YoWGU88Lid3luy6cRR/mQ8UvKz6wE/381c4cfL3WgFL4+5HKh8MFPd/+S7lzjMH3B4bybFy26Yl1cY4/jKmjl39g0KQzX/KYVP3qMlUW9IQgLr1svsHMIgMtt2CmJGwHIpNIkJlyo1VUkFflLzAbpRZJCuwTNU0g065kIh/fAF+r5yq6CAEMUjy9puYsGk0gk0aCShIc/2kzvAZO76xf6VGUDNyt29qAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dX/GDYytypyhIg16u4VMrUDGy0W+KxUGYDAEJQILL+irGZNqNkRDibJV1HK5?=
 =?us-ascii?Q?/XCTuX4l96yJc5tNoGB4ujjtNZ4Fmg5/YKujtc3hPueIcPLr6ZmnYZVM3NmF?=
 =?us-ascii?Q?hcyGwlVKK/gelArJiYNzJ99/IYtZhTMnkLJ8C2/k7XgfiV6CSiamch+okt2D?=
 =?us-ascii?Q?THoWGWzKOODoyfxXlAQ1vHiVBVeYQfFUL65ThjqIDiXkk5nAm3/6s60sue4a?=
 =?us-ascii?Q?/2d2IW3LR7YWHwKl0RbXJ9P8goFEUQ7kWSR/uCaOoJP2WjwjDwlZW1UYQfwx?=
 =?us-ascii?Q?RP4H7rO9HRayXzgQf2yT19mQO1OeYS3+E90UNUtagSATjbLao6uhSOjEaTSa?=
 =?us-ascii?Q?GXCTmExliVm5pS7IzQKdQMUGVbVNRA5ZQE+sq2Ky61Bl6AaCfeO6PjEVL/JW?=
 =?us-ascii?Q?4cghO0T5a73OVBErqMGmZRnKCSey0QF4ZZjrndWr+e67uSqoJyKYR+iNXXi2?=
 =?us-ascii?Q?h5WKAhqkrmsq4f5sLc4Gxx5Fr4usER2Qc3fxcV+BUgAwsXrBJno1rU74Gnsv?=
 =?us-ascii?Q?NZMYC/QYBl7xAgBER70Do02Y20txc7Ee0Kr3xtUTiu3rfPMG0oXC03IMlWoa?=
 =?us-ascii?Q?BpPCMBxdP00wQFrPyrqJMMxUXHOq7s3yMdqeMTd4ZZhgHhPj2W5aDZHXzX9U?=
 =?us-ascii?Q?m5rylQe2M87CtzTCmcw8qIa49n5+FwS6vjwtY0E1JCsmHa+KNLleUg2idCaw?=
 =?us-ascii?Q?JTutvrFm30hQIhuCgNVrb1sVbRaIpNAbvPjG9+sMFMr1SYpX3NGEaCs+X4S/?=
 =?us-ascii?Q?66oscEvzHp8SL57gqrW2gcC4rLt65nNFIr002ty2b+kl3xCw1yMvKE4vHCZL?=
 =?us-ascii?Q?EJR4E9iEJS0h7LhHNBH3y1fO68R//sDzefuUcYBFwHLTvHbX0K+iiRxwMCoa?=
 =?us-ascii?Q?/tHj0phNjZHcHBCb5XZXZyu4U3nmNUOTa8+jZGCbBjKCcwhmJMWDI/f91J56?=
 =?us-ascii?Q?Z6WgqtGe9xMpB1KHqA7/Qhy8bRU/F6mzf/HwWZFFjXLbxAFRR75z22ZbudEd?=
 =?us-ascii?Q?Bg+hIHe2eyW+AgWp/EvIaH8bjFBnfFrfMMih8qENaE2qiLWjBR+oNlgHnKcA?=
 =?us-ascii?Q?kL/pr1cfS721/FAZHLiyymkaTWNPpqwaTYKWIEUlwOZNfpYcfzuTlmkMmEYx?=
 =?us-ascii?Q?seVRvDe+E4uinG9UnNaVpl+jOGlyhfdHRqvATO3gNZ8bMfaK/mL064JfLXUn?=
 =?us-ascii?Q?mVKGg97rEq0b8o4EOBhs4cTBW/9nsaDZka5qM3Q/zrkadjlEdffMUggMJLG3?=
 =?us-ascii?Q?JH2j+PJqGxGcMGVcl/22Scek6XTxCKkxBriF2yfD0Cy1zuRc0Uo8SRCTnfNP?=
 =?us-ascii?Q?X9MLedG/t+vC9rBhz5TCNM4ara5bdjb2d2kVtHjEWu/xDZd1xVkIYlfHzlqN?=
 =?us-ascii?Q?DFMe1/I8vdMsdmcOBEo4II5/fjr/XYnxgqPGJ8jDbRJoQkqQW9SufcEYSVdC?=
 =?us-ascii?Q?V2XIKBKMLuhUqJNgd4fiQW+Bo6LX3V2PqNc6FVylTWE9at4By4GUldIIb/jT?=
 =?us-ascii?Q?v/oUqLMEmz7kcVNcf3sfbsZlYePxh4GF2uV9r3ZwsNbDtAqrbvqu50sYhjml?=
 =?us-ascii?Q?1N/KIz6u5O/58v6/rRFgjmamy6jdEMWcFwgiS8fVlbO7SfSkwZhsZ6YfXwCM?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a2e83e-2f9c-4eba-accc-08dbdcccdb9d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:45.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73hVSOt2x6il3Ra3Wdw7WMfEWafPQ7+r8DlG2WQgVIAMJgsqOmZbpu2GcgaEAylKERxDTjSKI9AcaA4GsM16Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch tests newly added flush and dump commands for the userspace PM.
Add these commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 995280882428..b56e141547db 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3405,6 +3405,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		ip netns exec $ns1 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3429,6 +3430,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -3456,6 +3458,9 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		ip netns exec $ns2 ./pm_nl_ctl dump
+		chk_rm_nr 0 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

