Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ECC812
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OomXqahu06+dWI+Vg+ixsd+yRWFdvZ20qXBEe5nHQ8CiFgsYyI4Ff2/gnWnUOjWETg2a9oKoRlAb31pDuQhiUol/GL018yWhoCOtfvbgclAp/G4IaiMzFQNqfbNNIpmhCQvUSxhkaZNtkMeMuydZaNZkZflokstcftQvhKR6YEgLI6IO64Nx/Sxsbq3TJdDZOsCZRpsTdeEMXRRoiD9Nqkb/tfXUpgecXvkj364D0lmMl54JvYVeRB9IuBlbqIjhvmuPXLeBLPatw+IrEEtcZrBH8VKpFv1u1pRNB8zCsEzSwQZFMCBmHTjoH+Tjs9ti1lDdvzX6WxMXk+GcEEvw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CxWt8dJpPtj8t0CcoyCAf5NbbCITkY+jU8+1TgvlkY=;
 b=W1J6CNpDupBu3qdbHLo1p6Swlpx7V+WrlHXjx1PDASaZcISwWDA5AjuVu+B1mluSdx1RdvlBe9c6HXMq4FQbQnQ6tXImhv5TcWonlYmRQdU+x/KSCqGVxDuUoszTVT/7ZhkWQ/CQLGdIv7KsYokVaBnHnHd1PrQOlyg/aXZJUsyc0bG2+Bz6k90zekNYixT99NxAshUFW7AzGLKFkpHqeXYN11i4RxXtQ0Nyss88QUub/0a4LCCJb7hyfyG17NATI+9Gv5mUCyrC7FmDGOnIJzsXzP5O8bn/xmuHQnU3QumAH98EVseRMlGWAdXpBeuK4+8V1h7sKfZGF8gfqoe3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CxWt8dJpPtj8t0CcoyCAf5NbbCITkY+jU8+1TgvlkY=;
 b=xCTAcWY90yQp3yCZdL1EPigY+3GwWRXGnpzS0zNl8inlM2Me4szk8a7Ai5nEnjQ87ieDs3Ag65X1CimguvGSRYF5f4Ciu2VyCRgy+4zh+m33exi0foYv1EBa1wNineub3clyBnmICrBnFkipzdz0xsPCuK87xTzlT+8dFHNHKbBEAFnQYeK3gUqG6Qz0ziPDTUz0yLfuO0cOUEi4w8Yp2uOMQqjJIbT7nY+Xs/B7rGdDfPB3ko+yohGS70n67AWmD49y/2DX6KnEa5nPXQfR1hf215al2YHVgcW6CxMK9rzoIjrxJpfP0sSRYCgKmy9ydRTbFUc5oQNOPx/gp49Q/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 18 Aug
 2023 07:13:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:13:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/6] selftests: mptcp: userspace pm remove id 0 subflow
Date: Fri, 18 Aug 2023 15:12:01 +0800
Message-Id: <da5a9e566a9464a85369fa8fb9f6664a1faa6e39.1692342519.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692342519.git.geliang.tang@suse.com>
References: <cover.1692342519.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3248e708-c227-4f4f-cb84-08db9fbaab54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tnwrf01lsuxMdlXgWdxtAtkWZ/04KgF65sJozjyBpiKc0av08wwWSJlfuqJIILX2YaUAEprLVN0M/pre95Md0WehHARgbCvm78DIj7RWLKVn0cyL31a1nwdJdFGwT1uR3HtzBWSvnUVNV17OnRbAH8iisi+xk4LtzzhxwOFCO9rjTDDtNis/vkioWnITYDvgSD5uTU4nEMbuYEzzKZMLymwwcE7kPMRuYRu6hpc2U9HUhM5RTx09GughZWimKRRUC1Q42lGV1vTpucOL81cjAyfd9vHwE2NMtvCKhtn0+w/w88SmjptB+hbMThEEbBhja7+OIpY+LKnTcbHYchjbT3yTHJA2xgAFpaB1RFJnen0uEuVGVpDc/kmO8m8es/QOItKh2rE3o+f1AhyQIUe0FY06ly4MDjEh1/PHYVfG3F9S6qDIgDrXLIXC3UJTq5YKYwhFLYs8rADgrDzFJTXhirHPeWxdFKkg78ZHqE05mnxvdmNR2Ztg/iQEUovIbKZpWK9WAX8mCpbUSONdAS2iJCY1M7zp2gz7NvB29nqk0oRMhClCRv1ByhQM+ygnXPolH6d9ZRLKdJOhxOC8HqjvcNeIo/p7r0oxxCRs/wJDd7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G1CRmI0vaMsW7RASdUShw4pYl+Uq4Nl7qahBmq4xEMTFS+DVTV3Gk7aCGaHe?=
 =?us-ascii?Q?DSoEuSZ8z2P6Rn95NCOm71A+X1JSe0+Z7pQXn4RC0SSvSEnMhYr99gOWLzjx?=
 =?us-ascii?Q?QEKuFTp9RcuCW1EjF0Gnq5hjD4U+ru4Ur+4N74UKRDaulH2vnuV5+v0MCFQs?=
 =?us-ascii?Q?BQbcvS6vLxaYTIVlNi5vi2jjc+S552AWUW+kvnBHFwQwSU7c7+4ihAOiCMHX?=
 =?us-ascii?Q?QOcMA/3HgFlg72d8tPo0vsaVt5Z1xEZHFdhM76j5ivHyz92CUwNpkWq7DaO7?=
 =?us-ascii?Q?8LLJwGR1pDmwRDW7DK167U24NK2LHDbblegea+9C5UBy4tiWDoQZqbHFOrBn?=
 =?us-ascii?Q?z7tyHAHqki14beSUIao6S92g4eKUjME8KcJdNkhWapGJFBm/Jr4vwUYSVHaI?=
 =?us-ascii?Q?9rPpKWmvSs/Wyoik/0NOH18A0i7Gi+ZPke1Mh3brSu1cjgt/5nmNiwFkbYuD?=
 =?us-ascii?Q?x1sH8hVbD6AgL7Ig9qCa574bKfJgV1qRBCMddKnOaZx+8gULQvMbmy9sLG4b?=
 =?us-ascii?Q?ZspnSbaxqE0HT5mrmSaKt8rLbIABpn3G8MDWzywBfOkEoUgGtFfFUitPWoR9?=
 =?us-ascii?Q?X1vUfTYJvYcx7T9RkHpCnEQtVDzDcgaRPSYHmTI/EdfNSa+zieGL49Rk2lIg?=
 =?us-ascii?Q?9pjjex7PirNv8mtXLwFKxvirswEZhl6U3kUja8GZmt13d+/06k7khaOPe9j/?=
 =?us-ascii?Q?fDybn3e6U1g1w4e+40BrSuGTpvSm8DI9pf5HHdcaIOCP+s+GfW0pbxLQo4Gl?=
 =?us-ascii?Q?5JOnXMq7OpneMl3TSxJhfatWgwJUSPE/8nmIdc1stzl0cidD/qbgqpLNamAJ?=
 =?us-ascii?Q?8KxDOf0Dxs0kCHH+Wm+UYkpEKtkyGDsdtVIMrX0b0F9HW4gOJ47VP4EG0r3t?=
 =?us-ascii?Q?JjkuaLoE0B3qqi8N9hIl198uf8dmkL4gaKIJMV5A9xFXy6tRcP54TTMXGIlK?=
 =?us-ascii?Q?vJvBoc2DPiA2ufMR0mY7F5xfwN5GH2LsTlsnLJAPJc23cWJFD4cYAhdOKbBL?=
 =?us-ascii?Q?CZkSAy5wTHRTP3tBuScfPgivS/fimq0Rd12KYU93Be4FaglwlWCpS5tD6gCB?=
 =?us-ascii?Q?WXk79ryQdf1npgQk3tEjioAwNCmy5eqmC4ARzvwMfhSzoV+jzWMkw6r7ipek?=
 =?us-ascii?Q?i6M5BOQW0CBwwT/yN4Hjh2K4YFQa2EhmGOQKV4+RbtG2h8SxmSmGso3vCw/x?=
 =?us-ascii?Q?cSXBdj9OVu3yphUtSDi1m1ktpk60rLuvy0zXwnFGb3GoZFk4KKj1Zoq7IXZW?=
 =?us-ascii?Q?2kEfFj8MXcPNVEKiEsudmQRBu1Ut4xlBgAKbNORRnWARuS+DuzL3jTw8Kx5i?=
 =?us-ascii?Q?fCP1ZbKfO2MizsvartAElfx9WEOs17a/z3xvBKa+b0OtO8xbQ5O2qKMsdW8D?=
 =?us-ascii?Q?3AwFAcAmwv8x+uT7WGlQeQG1JAUPVDNmQrNarDgWP3YFaNRqJo4CEXL/J89C?=
 =?us-ascii?Q?DFnFucsSXj7XxEdotRGT89L/coo9toEM9JDgFKzRtKJaNc0cfTsvcaxv4OWh?=
 =?us-ascii?Q?eyLBHka+HdHQjuG5s22rAVqqr0c1toorOUdlSRivPhyLIovWxRYCcbP3BXvy?=
 =?us-ascii?Q?So4Ah9dm5OzGF0OFKodDJ0+hOBDFOUc+xYYaJ4TD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3248e708-c227-4f4f-cb84-08db9fbaab54
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:13:49.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYKdXPWu6+ROLJcN6FOF1Fk6zE86aLvQIqwNUCXz/5v80QIt3ecu9w+HCR/Pe7GLsI3hPMrpgOfKOG2pAAhOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This patch adds a selftest for userpsace PM to remove id 0 subflow.

A new helper userspace_pm_rm_id_0_subflow_ns2() is added, in it use

        ./pm_nl_ctl dsf lip 10.0.1.2 lport $sp \
			rip 10.0.1.1 rport $dp token $tk

to remove id 0 subflow.

Add a new helper +chk_subflows(), in it use 'ss' command

        ss -ti | grep -c tcp-ulp-mptcp

to get the "correct" amount of subflows, including the initial
subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f311fac5fa0d..52d696f49e58 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3323,6 +3323,43 @@ userspace_pm_rm_sf_addr_ns2()
 	wait_rm_sf $ns2 1
 }
 
+userspace_pm_rm_id_0_subflow_ns2()
+{
+	local tk da dp sp
+
+	tk=$(evts_get_info token "$evts_ns2")
+	da=$(evts_get_info daddr4 "$evts_ns2")
+	dp=$(evts_get_info dport "$evts_ns2")
+	sp=$(evts_get_info sport "$evts_ns2")
+	ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.1.2 lport $sp \
+			rip $da rport $dp token $tk
+	wait_rm_sf $ns2 1
+}
+
+# $1: subflows in ns1 ; $2: subflows in ns2
+chk_subflows()
+{
+	local cnt1
+	local cnt2
+
+	print_check "subflows $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3437,6 +3474,27 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows 2 2
+		userspace_pm_rm_id_0_subflow_ns2
+		chk_rm_nr 0 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

