Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB82182CC
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="o8TldsxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw7bXr6XAuiu5FrA8YHlAKcdshCC2Mp9p+LVFGHDkQes0/MIyMTjFfOnn3IZLgqAp0R61H/CBppUIoxmQNe/Cs56F/519eni12/bddPGSdZcjWDuvN2MMY8DznlrUhUqPaoQo6QgMDLk6dmYYaYYolhmpxJG5wt09c6VCxAmjXtLvP14lQoOqyDj0G/cF8rACF5tdISV8nx3sBwTwQE1q7Duzu/Uo1njqo5W5hBeGvX7Fp89z8Dp8J0OWY6BFowKgdFjQnaWe//fpfXzZvP717yriCer/6nslD5cKdQ9kAl55jW5U2PPtvu+jYZAmb3F45zmt86/uuzx76TTuBgE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0im0IkCW5I0XoILz6MAoEzkSKjdoOiy8AVnZXA8pXRQ=;
 b=TrYk7Kh5RIl/UlBFDm2eNk3XBuddWxAsg6LRoAC2BmW1xn7BFEVQ8q5ihZFnJajyUmqotB23VP2IOEdKSyMQaJO6/h/msiK+6vN1wbDX3hsTBtPIi62uOgUbhnqyQw+IajyeZ/0Se05ZnTVy87Nmf6xpIXs6eXIaiXnqlAE8TO2loXVBnw1gdzkwYMdSjWy6gnZ1GbJkhJ+qb00zwLwRCtndICXtWfH9dnOXpbmBRCucfwJvFQL3ztcSx3puJsMbrQ6wSwFepRA6niYoipOrNiRnlQFECKv71wpiivw80QdSZO7cLO4Ux5Qn0tRhhj6pq8oW/slh0cQbVV59/gLsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0im0IkCW5I0XoILz6MAoEzkSKjdoOiy8AVnZXA8pXRQ=;
 b=o8TldsxIYE5P15k+lUVVgfvyQHsRC3e8NZR/dzy1H0vPL3D1WzHTOH6O64MXFelxoucZvpD4XwCpqkLhQ5QDyDZID0T81n7U46usyxQEMRYQf7mtNw9B3MzFDwqrHPGFsrPd22OQSk7GwQnSx9HK9a2jwNXnrNuT7mvlkN+6KWTwHpps3AU3yO3L6l8ZF2fBuJ75+ufdFYawHsJeWm2h8QIwZQGjuuHFDkyBVqXXUdJJTTkl3CCy7NFmzOn7nJbu7nMJNiVyFVGiZ1hZq00jIxwiJdLV82T3gCkK5B5hOisTAe9nSEnSP/Cyq20GNFDRar8z1gL9rch8BCw8/JahBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 20/27] selftests: mptcp: flush userspace addrs list
Date: Sat, 18 Nov 2023 22:28:35 +0800
Message-Id: <dfa712367a337aeb38e268c92e6cb154db09fd87.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 606e9c35-8a77-4092-58e3-08dbe8430e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MoPq2imd9o+i3FZADESMzdw4q+aKu+UVT9V6pcLLQqZH1wnNEusBFC3E7eegH/yTNSBoRRnQW6+b7Ap+efCmkBPhRYytNn0SjJcpG0aM4X8/pWnH+MjoPaWmBhZ7rGoiURc8CoVX0qAB4cHhT5eePOa3HLlIKxjfkAZNRK+6ywwFUm9n3QOesTH/JICRXdNBQCaswpQNoyEHUUxZSdGEdQI06nz9RBcWSyvu394JYDwj73cx8NfXhldLeGU7Y7iDW+AXtazTqen9QW1/J1Otcm7yvwmIVECItotIhxI262sQl7LrPP5KYvj4jSBF2m6S4cAkSGJcemwlV6f/QXeYUzWW/LlZwfHm9WN5CEbVAnL/TXEDhah8EYVEkoiTyLJZGkoXrxstvL6jjmLrRKG07ydWCL2suKAFbUbVyvX4rL8TGkWmbDwIT1/xCfuLSWQU9jx6GIR/UA/QE41xghXtYZqAwBtkRa8Yd18FGdSDC2L/0zvcQCIgA0WKKwRW4SA6vCIMUXF9iaAFvQS+D+vYPJCWNpu4mf0JzSJ82MyFBVFFyOeCuU72nzDWGe23LnAys5HvWkWXVs6GnYwn2w4JynZZCWNBephQvKUkttoTgxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COPdZKsDVADu24dMi6nOSRo2ky99criHnAUvO6vON142kZoxcXGLooIhpZFB?=
 =?us-ascii?Q?R5aAl5f9c8AzV/P50MXby4sy3TVVYRVG6CIfQFauSor3QXYU7UFfT2ze1cFl?=
 =?us-ascii?Q?sefJFUtSAoqadwvuw+RnE3tEqvVBK7P6KW/sf7QvjC6VLoMVO+pbln6JQmms?=
 =?us-ascii?Q?jULxLmhHFLwps+j21jkOXbegnVflGsmnYsXegNqLTM7f/AhGMe9tYUgEwDNW?=
 =?us-ascii?Q?w8uci0JKrRN6I9EapzmCymmm4b5Ztti0RY3FYFBtGWx1+1Z4hG1NUcAFRZ+E?=
 =?us-ascii?Q?UdNgYsmzHgHmoRNwTdPO2kjYaKKJ2HftznVD0ryEpB/nvCHC3Uxh0ptXB5ow?=
 =?us-ascii?Q?M4iMegSRhvRpS73YDEcMhfGKsfbvOBcuDUtSaezxUSXfFm5z5W0oMgJSkAaN?=
 =?us-ascii?Q?Bmc392bWxIh2kSTUi7SSmeV1as1N3dCKoAz3B1rqB3x2uVYbAUv9FxFCXCTG?=
 =?us-ascii?Q?XSAaeBD1PMV+gS35yar69Cnj+PrK5Ohg95J0AZlP17nXFVl8FisRCFcLh1QP?=
 =?us-ascii?Q?u8xneDJxeOaPdzxZ3Ev7kEogL32ZK7V0utIpKZ1wKqTAcdFoaCNxNubFNj4S?=
 =?us-ascii?Q?DLcxGy/pVzyjYkDk1o3R+doOKj7GgP1B85urJNUlD45O+eNif5emlEg8NbT4?=
 =?us-ascii?Q?KoowmGYiI0O0Ql3tQVlID7mHxWLcBsJT+1WO8k9UtvhkUGPBAOg/l/6j47bH?=
 =?us-ascii?Q?rIvikcFxG4M36tM0J/ALxphiK9iYVJ9l6PqfbafmlTklOjnvKCjuWANq1HMk?=
 =?us-ascii?Q?2dDhSpl6zvq1aFalZO+a+fRBxvmtjxhlTUTeBLooYBf7M6HFsC3FMXCH7YqQ?=
 =?us-ascii?Q?HNAZPdHZjOQyu4ewDAKCfSE4W4/JwbxfEW0iPgi1qsNcIThT9/PCbcZHoDpX?=
 =?us-ascii?Q?sWcHgwtDwNjeq9+/EWS0GyFCP7BK1bkaS8jI+7Sq1A/XltjnLsrCQ2/+ylob?=
 =?us-ascii?Q?H7pHRGlV0ZHocHcp7/+zVb9r9s70H/4tkzdc/ccjmNdpFWHTyGEE1azvOS6N?=
 =?us-ascii?Q?/CvxWMfSvNenua2RXa7onORl9vxJ73pHHZmk+jOB+AypvJG8XKjVo8ymcnf+?=
 =?us-ascii?Q?B8bzSTfrhdK7YrqMy8GXjdVNfIqOpO43Y1r//LIwrne0ob15iSCpnaqLjf3f?=
 =?us-ascii?Q?VPg/gdkYPtYs3DATrb1jfMwaDSY+4mhJxQBTmQDlzEE0hiPIpxTn+ggKDdro?=
 =?us-ascii?Q?xXh9UMXSjk/++fvBfT/fzuA0LPswFCLEIOrhumLu2QCESnlJq5DbfsgDwLRi?=
 =?us-ascii?Q?uJvxlaMwJy/Is0uqtyfzYb+N4etyrrKVMnWykr7QzFvpoePskJXISK/AQWGx?=
 =?us-ascii?Q?7GWgSrexSg2O+ITQedOmwu4EmDPFcJ2cFQIrtub18rII3L7vS3fyBHRpBuyi?=
 =?us-ascii?Q?2NmQ6tspk2RkZmKFhm68tsCGL4W9X2c1dDN14ZDf8EM4VFrPSuqIbHyUUzQS?=
 =?us-ascii?Q?SwoMm4bXqKlKknLAC2D5w6ZPKerY2IvpzVJPXuRBIpH0EUsTUjmztrVreFI5?=
 =?us-ascii?Q?LfjYXrhSFamttW3/u1XUIpL/ZpSAXO8qvMery72xKZ5xXSLgZgf3VLAkGV+y?=
 =?us-ascii?Q?x4JePARN42lhadf2wfSxVyBDe68pBbkgvOW+Of5vOItMTpv86UCcgKVeQm5S?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606e9c35-8a77-4092-58e3-08dbe8430e77
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:30.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGajltTnJcuc2nNy3FzNpJAJMmO7IuQDMbfNe+NZ+hpXmeRKKldGOYvLqbL+o5r90x1YUBurpR7n7WohqMMAYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch tests newly added flush command for the userspace PM. Add flush
commands into userspace pm dump address and subflow tests. And use dump
commands to check if the userspace pm local address list is empty after
addresses flushing.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3281cd321854..0b37f6ccfe53 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3514,8 +3514,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3531,12 +3531,18 @@ userspace_tests()
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				"id 10 flags signal 10.0.2.1" "      dump addrs"
+		ip netns exec $ns1 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
+		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
 
-	# userspace pm dump subflow
-	if reset_with_events "userspace pm dump subflow" &&
+	# userspace pm dump & flush subflow
+	if reset_with_events "userspace pm dump & flush subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3553,6 +3559,12 @@ userspace_tests()
 		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
 				"id 20 flags subflow 10.0.3.2" \
 				"      dump addrs"
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
+		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

