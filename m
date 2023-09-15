Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB513FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g80nsooIIL2OwZz0TQPvyM/fTwXFWKEE9YclEXzFiR3Q6dIvt9DXvUjMGSo7QDSnbP2Zj5mie6hKZxpSUorhEbY6ZtagPN1Cwt4fDeUnJAMCKhQbneMoIw4vNrSNIBljA2p+Z/pkb2gx0vXujoKF88py8qhcmNV/OKcOqvDfWCOQdDylOWesE4jeIVa9g6ytrm4XZ45+2OjEvb4I/YutFebmzpMFmHt5WTrF1mvNgIoOlswfy2qP7RPZeNswbJw3GzKbPvY7F/C4C3PBrkekj+1+Qg1LoUFTNPxyxZTrLkaaJzhj3cwuViyX062zsB3+mC2T/g93MpojuUAAvkJ02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAR0czk6igmMGBlZHDMAiwryixgqEW+X5hN9wMXKYcA=;
 b=oVcNsPTPAqkcbP+aE0ATJgk5wxBzFBmIZ3v5rxPUCTogjueDCQXNzYjk8F+oLPBA4F9I6/ZkbVRvLBu534Wjc+bsHFloy7U+0bkwJE9NAwL3/UHUezE2LMJ002h6kriufTZ68GR6xs7LSzw9pTt2Mr9CvzKXv0WYk1ehcK96p+gqDK0CmIUNyozvbCpDbTnCsofn5LL7JKVZn8898yXjDInRgGMlbaFmB8go8nY0a7R8Q1YmYZ2x6MPh9NCAVDxg/c3fw60dvpXJBQ/Wtt4ify55GruMppnG2bcTIKZaD0lObMSoVbhmimw2VP2ersfCR3AHlsFmLn1ddUWHd8UVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAR0czk6igmMGBlZHDMAiwryixgqEW+X5hN9wMXKYcA=;
 b=bwde9n1fUhzmPqSCg49mTr9ntI0pHMvJxS0HAZ5jZ/So6RVuNOiF54nGlaEEXNJ1XBWEWnM4+zVlIZuCq0T62JsFzzsazjEQYdqJBZSAOisyRs+IwizDDsN8MHJEdagdAzQa65Uo8zhnRYBmhbDOBs25VLt14y/GzDuHcre0rqams71p+V8hj5sdHdfBQ5e0qxfEtWPWgP85eFepCFXrjc3qS8pnK/9KQfItudNZQ4sE7k7aekK1zh8ceeqjUEsh1tsQQgkzod6Wa2lUuaS15rUTWggLPMPwlMjorR70nq963KxZxh8ONkAwVpcAYRG5Fl5xIjBOrgwKaZ7gNjlEwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 8/8] selftests: mptcp: userspace pm remove id 0 address
Date: Fri, 15 Sep 2023 15:45:18 +0800
Message-Id: <2e4ab346b47f4f36a9f6e29d2decb99ab00043d7.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: c06f42d0-cf14-41fe-357c-08dbb5bfc08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VDYmQJ0H6qsZxbMqt+sVSgLZasJqwuT9ui7EN3WC2z6+OpmweF8ZsT2LwVj8iLKgJyfcHaXGCFRhg9y7cIjxhbE8T4Nr2J1cgAg8Byg9g88NCX/avh8tWXg15nlPj4jkxmfBTYRkqb9Z9JxrdaL0Egc5KWRRBgo/xjAoDt0VdbHKdfstT3Gkn16B9vLnrDiKtArKjCeekF67UoRsLbyfrZIAai8wMbvsO/HGZWJJ6McIs1JRTOmtLNML/qBmVkjaUpzKWC7I2PNQWlcyNbWmTE94iDcQxAUQ+Bhg9eVXckPzEb9VyoKthr7WQZZD40mahp2i1LbgTzWxX0m0Vos3zhwB+4fjucvcPG6n6fOndevmSD3QHC6AeSVsWqaRG0GrWVjvg0qnUdWDmhwjEZT5Gr2SsT/B2sFB1xqvCyWAUNSPBIS13GNXm19mZgb/fGG+HE6a1NeH+U2aZHgrnXH+NWl8c5noydiGJHDwJfle3ZmxSR4eearxs+qjL+1E668+kAEk4S3pES3+lyupzkVZLfsZ2TlrcwuxESQCIKX4AnvRtjweepOU8mcndAK/nbaHTOERRkP7AsBHxY292sEgJolKFF0PoZZAuPyQA4KEe+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBjU3NZ8ltrk9m633spUZnePrm5losPr0thFRx1fZfJK+5ivp1dy+kQqilr/?=
 =?us-ascii?Q?V7zbrakAY3s5jqVtwnM+C5sLtWxcQn7pO/ria6wLtDupO+g0ycHvbKRrbxnq?=
 =?us-ascii?Q?DZrLsux87jNFhhhZcj/CWkeuQFDEnvLUI01R55ViCCFls1haRzJgvLvuSAXh?=
 =?us-ascii?Q?/ah2KMwugEQcjkSdUfkcFkwtmZai0XqdlK2yW9+7kDSn+Muzar0WDhfCiOmJ?=
 =?us-ascii?Q?mgYOawqU9GbfO/j4+lTdRX1NxRWGiUAbabq+bV9w8ZbAKziM5tMMfaN7zUAi?=
 =?us-ascii?Q?UJM44E2u82znE9VsKoBcA/oedt5BeVGKP4R68DBPuqbPUkwTojuWFQ4UHlNu?=
 =?us-ascii?Q?OZ+jx17UsloL+PCqsZ6OJumcG9J6ihTHcI8/44Nj7WESBiHaJ72XI2EsqWdH?=
 =?us-ascii?Q?u/XlAURlbkkBcGqmaNn0EZ7Mz4VzwLkyW+bxwSmqQ72nxN2jEm0HMxWGHbsb?=
 =?us-ascii?Q?GxOSdZxLy2mxQkfFEYSvzmk8LrTwKfA/MvWdEh2MSNxYe53+KSY33h3QzVrq?=
 =?us-ascii?Q?/mTJYRUTzjvN6ygAaBcW5TzoLjDzINhgIjVg3y55J07YXrqnpah4z7DHoEsC?=
 =?us-ascii?Q?AhpB1cgZYix1WLw4+U9UP7iPF7028b7Pc+9okF8t9oP0dLdfV58O0xVV7pvy?=
 =?us-ascii?Q?quhRxD8FFyRfdWSJIP6ag3bCjZIr53qOketCwZ0BIGFp/3dj/Kw+6ktKHbSF?=
 =?us-ascii?Q?JHUGgDwuZEOJhJDtGtPqq5skoG8j3QM+vc6FBslX/ttRJZre3VVyssMokUoB?=
 =?us-ascii?Q?hlhbdf3hq1ofpXd1SU0Pz5/EeazZOD+/z1YT+e1m0NAfYZua2RxlbZgzjfeW?=
 =?us-ascii?Q?7tzp++d0eQjr48Q1ywn1/ZcDHFkxFlxKaHu6amPtkWI4c3BeCpLOZJRobNwR?=
 =?us-ascii?Q?bKHEohCkHb/iv/w8IO4nC8W6H5xHTkJvGE9Z5bBg8o9b+rf+s/VaE+Pb3efd?=
 =?us-ascii?Q?XurJvBdjnY2Fi6LbHWVDVYoT6Cx6ojNDorr0Lc0LOfOyFXA9EQqTHa57dTUn?=
 =?us-ascii?Q?gQlL5nBZqOps3waqeB0dVlpS/ce6kb9BeVOCkJudw4QIOfav94emt9+X2wnX?=
 =?us-ascii?Q?57ocnVkcY57lcq5GtvdBmmyYHlOVd6JGSxTBrwL/PPzbzER87TeHby3Z9rMT?=
 =?us-ascii?Q?aJifuEpcr7J1r8Zs6K4B8NecIV7gLVpRXrS+MKCJTDtlWbFOFRFMjpIJHjzO?=
 =?us-ascii?Q?g2k+Jbx5OvNQP6cEqO+rSmatjyDLldyWaGtPv8GLb8WmeZkR1DkjKQEEPNly?=
 =?us-ascii?Q?7nz5yB0cT2pDSknUBGz+gD738CIJLOg2lGnJAjAJw6/FtDiPUUiTcxLykWba?=
 =?us-ascii?Q?C0S11bNubYJWpwAzSNGuDqnQgoBOJ8qeY60emZF4fdzV6GRJsUcoyYm0VKKv?=
 =?us-ascii?Q?3SsyY6sbBr206BO8Cst3hEUWrI0BI9b6FReh5v4wVrzwJUa2Y9A4vFYXWbGf?=
 =?us-ascii?Q?xEpqn5asMdjmynKOkFfo+VvCCytTYMhMiGbMR0s6OwIg032CsQDvImU4YYOJ?=
 =?us-ascii?Q?GDYTSPMZiNq8x7x83u19nXZIHXhqsh2bs3mJ1iONuSKqNg6iFiUH4ABNdbon?=
 =?us-ascii?Q?+ulnOGsECa7VfH0cOJeWwyoaprJ7eB4RPVMq1o33K7QzvofBCuAX56ijmFJI?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06f42d0-cf14-41fe-357c-08dbb5bfc08e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:38.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJE1VqG764aOoXdMoOU7pXJ1AIM3YIAkFStgvoBK9KYTjLPtYECerezy6FMPSYO3Hfq6qzgHR+6dWO4zzz6IbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2d5815ce9095..f25231a8f32f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3502,6 +3502,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
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
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

