Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716DD305
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KSaocOnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl53njwqpsAw8IVl05qG5V+urnuR3DbgDE9mlchy5hHMfj0TSJ41616+p1aKol/++nKEKSeasrva4fIt8v8UUEy4HMVHveIpGvNykc7D7pgeVPwgm9bWD+jPDAk3tihq+FxOqslhv9slF4OgO+d34BCdF1wO8aL4V9n0NdfKu00R+2DHLRuXF11LeAEy20KexI+y4+Bff8nM+Bzlb9tlZygDlmcH+4MDPxZuYvN4PPf6bknur/5/6OgA8IMcilzm/tZsfHU98Cn6qafnuIAlE+o2S/IKrYrwJbIUvPGB3t4x23U9W4cV28x9yWYIQmrL12ICRkyP7QnxRrh2gqNFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GR3nsjtwdeaMr0JU3lyXNzHgJ/EI8+BTyuOmAWKbgo=;
 b=fV6JhbSWJnItScA3IBZWGKUKlj6Ru7kosCgHPegQY1gmtWYwmGCP0HoCh1OxRjF3J+ZyM15jxuh8WaYdpEIdIAmawPXJHDi7FXssmt4T9qTiLQLpAQ3eZT1pHa9qs6OXCWf0vBrQPRVZDHbrwTR37DeF6S/gHEcbYwb1G/HLakM5p1TFCo4yOxvAMimMYdoxSzSs7gVjC/bTijGTxp5eTXhwcbrt95/M4TkoNnyIBhGwk2ZrHvV3U6/zFVUG5o8pGh4l/KQ6GLWOdsMQ8CAR3P72E5KhVnb+e4tqTWdPIlJU5jWnvzddB1PDXE5RUOl0JwhZynF5ZTm7pXODe5CKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GR3nsjtwdeaMr0JU3lyXNzHgJ/EI8+BTyuOmAWKbgo=;
 b=KSaocOnMeXhizjj1AmTcSXzZ/a9M2y2W6I3eXoJyJqEQHYkdUa8ci0tvFzhVpMi+rnMXmcm+MbzB1H4s6jERZT3J9fNMRPOyMM+3zXb9gK3KxNcIxpWrwLZ+oyfeQpJsVvPUQ9GJfCiZmEJlpE9RW8KhBLD4mlYT3oTuWeuWQ2N/9eRfsuKaBXpdMGrIZR6XHuxEqRm0AGzHjqHve2yMa6OkQznsP/rlVe3DZH3kdbv/200B9BTRCuEr7qGaExLlF7QOTatwrcW8aYxHi6ZqUbfdIKny5cK+oyTOIkS+Ohc2ieI4WPP8xE880aBe5eRJ2DCq1Ae4+g8wUTT4nUgnJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 11/26] selftests: mptcp: dump userspace addrs list
Date: Fri, 17 Nov 2023 16:56:04 +0800
Message-Id: <d3b3b57daf518669ad4f1d4d6469e631225eb79e.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f7d07f-dc41-46da-f862-08dbe74b3a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TJ8/JS5ddgRFEJB9POW5tggbGc3tUKvqhG3OsBLxhTYJbyT33300tXX1cFY89XKmWO+v/fBOzNYcwtaSTWO5E5GT6T8WYNUA4BTTluanmWkn1+zanrppPlgsF9n5AHGSmbjEUknMop/mWyOXHd1BMZZsYaIsW8J2UNin2tBmleogjD8cXevf1mW1DTNXokp4F3ppH2iYvMi2HrOK5LcRe5Uhc4psCc33BwNizh5Bw8BbHiHJuFcNN4JOwoZmHhlrVrPKzQVU+zN/hn5ZSBszzY0fEhe79jgICrAgMdAIxtWQ2be9SPfHSihKVkxhux42jF86kmqfaHla77has+uBD4KtEz0F0wkJcm7rgLwliQslDh1fyH9bhPNaxlFxL4UbaKaKiHUypwgHaft+x9qoXLIOQyvoI0BGAOVi1EMPWIA5kZ6jaMeb2BZOViLgsfNUc1P/+vpootvGJXYpKFce0vr2TAOdFCawDKti76dKztxgic2UIBgh7qQwupOQWen9Xee1ULm7itwwJ9LPmcbJhxonAyLn5fUw/3lWGtDZg1dPGK1HeINyOsF74u/MV4jR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DERjXrsnDG39E0t5FI0X6Kob/SO0ot+pHHexGjPt1YgkIAomO38Q0Mv98een?=
 =?us-ascii?Q?c+AhT5RsYq0rfRMn7MUGn4LUoevpu1kA9k5a+cxIMBXp7tfu8Bft3P7a9jfq?=
 =?us-ascii?Q?lXasu4Upsza8xqEok/kMqfhNO04fFAD4eBtZDLD2PcZgHg/UgysaLhyNPAMt?=
 =?us-ascii?Q?9GdGSonImUp4YpYYIedtOOeuA+LdL1v7wqfH7XNO/Ib/bvUUSkPwmmzN0sXP?=
 =?us-ascii?Q?qriSaHktRtDKiMtEtm93oJXL3Lijpa5A8WGgbDvXOT8NvB4aRhC6Zluqovhn?=
 =?us-ascii?Q?cRcj9jYmaHL9EkSSaNSy3aLwk5uI0/j1vvQsvOd03PFw/6x0FL2CpTGhsS6O?=
 =?us-ascii?Q?3B03OU1Ey8XEBU5nd4glqn8OKoRbYmvqnV3whbjZkPNxnir2CR+d9DbRw9lI?=
 =?us-ascii?Q?pWViz4G12X3Ab09AVMzV0fnnDBqDc2D8CDtRIJxLUcwRFjPAS0sOIBGEHtfD?=
 =?us-ascii?Q?Dpu3Rt1keTosFjvRwAAA5u08mztnpOCaNKuCbJB5xJz9lLzYnblzQkEFiwHd?=
 =?us-ascii?Q?nq1UCAwR+rsmUG6AEVEasogpCAFBO6U7utaXJJu2NPaSvOynrFpYkdlzFUTB?=
 =?us-ascii?Q?gnFDGHLTOLPPyDfNE1KVgsIXjXgoJ8YzCJGvBl6d19dgWbHdMAREtBO2jvmp?=
 =?us-ascii?Q?5Oq5ii6NiOCH3dH/TNPA2adgVcBSfw2E0clqq4XnvGUFB0LEKGqqYrB8pJtL?=
 =?us-ascii?Q?dj2RnURwm04HIPHuxnAfUPzX13JCRtKlUdCqKgKvqc0HcSGahLzv7XO1UnOA?=
 =?us-ascii?Q?rxqqZJOXhNaan4i3myW50ZfGjIBhEDl/FdZPBjDSDZGKwaWln+L+3dgfXUeG?=
 =?us-ascii?Q?9RGioSzMLrko1MCHjGNcj4N65VQIpFgke7yX7zXGoO6oUIoZRj0kKLeeyJQP?=
 =?us-ascii?Q?dOQH9OypeIo/9uoLmZctlcOo710ga+yw97N3t7QPljMMJD5epnIkTBG8kONN?=
 =?us-ascii?Q?2rkluhTKS9/meY0tbJhKk4H53QFJpVnCPAahXyTKQNJx+7W7RkIaslYYLRXd?=
 =?us-ascii?Q?LxrqrtTdn7X/T/+jJO6qSfw1jrvz9lV083opSfYfnfN47jFLU/xo0bxVtWyT?=
 =?us-ascii?Q?YJf6t3EaV45le4TtGSqavT+vO5Xoq71HghT2OP/RjhnVYacpdgr24QHJjn4H?=
 =?us-ascii?Q?ZE7wxka3dKAudB1+ocvdPtVt5kN8mW6vMg/IYpI3xR7kI9ImfyenjCnbFpkC?=
 =?us-ascii?Q?Zg2aUTABqtMzvkShAtgw2vJWyoAn8J5hoMkUTZVPMU/JiUHeqnQvti8QJhcz?=
 =?us-ascii?Q?L8pkz5c5we7f3DhslUUUyu+50+8LKVyEC2MZcsAzbgMIq17mhYDWEa9apQxZ?=
 =?us-ascii?Q?5QDI8cJ6FvgK1UBdgn+ltqh9cOON5pZwce40GMas9k/+4bb+7pDkmcW9Ylto?=
 =?us-ascii?Q?wB07cYvks2HI7+npCt0WKgmN4iaXkqMNeGMLBFBv20nodgUyDdukpTEbm9yK?=
 =?us-ascii?Q?vQl3yB+d/g0WmQpddNHz/hG286AIymxDYiRM2Yuej0h3iwgdyhwrwvH/UPo7?=
 =?us-ascii?Q?5K7ZX+WJUPj2KIsefi1dLVi53oZywhf3oweC/ei6XUU9LoE8BwyO8GuALmut?=
 =?us-ascii?Q?MgfcHm3RMHPHQ4vc2bebPo7ujjtDRrevCMq0xUpqDvNGazQjFfZ2xTO2wSIP?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f7d07f-dc41-46da-f862-08dbe74b3a50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:29.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmWjGvQDOQD9YATdvGeHhzJ2eLvvtxkHy64sh1guQ/hKr3P4ZFJxS/bfamR3/o3me7KjTVD8zOhUYCVs3cNA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

This patch tests newly added dump command for the userspace PM. Add two
new tests for userspace pm dump address and subflow. Use the helpers
userspace_pm_add_addr() and userspace_pm_add_sf() to add an address and
a suflow, and use mptcp_lib_check() helper to check the outputs of dump
commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7eb62553569e..b346631d94d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3510,6 +3510,49 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"id 10 flags signal 10.0.2.1" "      dump addrs"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"id 20 flags subflow 10.0.3.2" \
+				"      dump addrs"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

