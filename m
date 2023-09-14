Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A52AB4A
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr814Z2YSa8lAV5UWfxhZ5zesLrK1b1bdH4g1fwMTWYhPeFC4eCJsqR2wW77UG905KsNU22EMGCtwIBjuB7Ffz6O2Ymo/3zyX/lCrao//6O0psfC8HDMnJmm/3KZLnJdAZC9Jv3h2Y1mpos8F+8Y/vImZz0xNHbQhBg4tHKpgs2dacqWzJV3c0dzvEbYVITduKHXmZkOwriTQMwgrljJETLdBw11GgT7mOjex1hgUz7dd9axHR9bTMet+RBRx9Isf/e7pn0+7rYeTDfcg1aERhKAFcwtP9180lSfsLeV9nO/difVHWtVCkyRnIJd6BNEDujgM7B862LHPKGTdBjGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vodB1uUKHNq3mJj3T1gnVOs+WQCIDLmNEZT+b3CcoiU=;
 b=frY1DfTgoLeJLt13Jr4Bw4tnu3QdeZzSDiZm5Ulcbr+SN7WP5fODAHcTqYJ2qbCdXtrQY1dhykxG4m7DeMA2HySoEqx5DDKws47UZ2TdRhI4gGSn5MIi4pJAbP394ARAKqbZigfO9CcCr+k59nvVfyvYhU0RdyBafcylMuRV+miDq6J/qFuZ28GbNtU9fP+Bt97eaYj0E3MwLVTGcaO/EuUL0xmjetaaTIofXhFb8FB8xJRMIjJAujGUAk7462nmgAq0L2t42U88Z8hklSihXXmOM1vVJCBwxrXmiyZ9WMX5xBeszVfc+Fw1DqpVl/W/BBMH0V2E9s+teA3J8yKSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vodB1uUKHNq3mJj3T1gnVOs+WQCIDLmNEZT+b3CcoiU=;
 b=afroBn/oNxQwC0MSbhv6CX10S1WNaenvBm8K0b+8877oE3Wd4Z2F93fkphl1N1Wrb6biVRZuFEn6jL+hyQTFg6+nkPgbjAMgj8d/7GQ2fUz2H1+RDcSHiZrwERdAzt8+WlicIcHSXkjiaQHtQUNwIaXLoneaqJohVOOjIt2L237g4Bshxt0q4fNFQLDd0RRRgwTkyPpy9faXmAbYvCPjHKWZ4CTo2if2yAJ7z+QWw1KhgpN6vkWmmmFrOI0LYwDC7r6v72+vWXh0PqyQWWV0a3vzJ7BPO0eFWSzJ2EbisjitKW4Bs0TG0nnx2g2bhkBmUMGfjokBfoiQ3Ig5jtAKSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:03:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:03:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/8] selftests: mptcp: userspace pm remove id 0 subflow
Date: Thu, 14 Sep 2023 18:03:21 +0800
Message-Id: <992da57316dbdc881997ed84410fae875b69f6b8.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: b17e17b7-57d1-412a-4ab9-08dbb509d8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KdEu3VSdjy3FTdzIix36OPNcvYzfiLBaRSjE0fZ/zgO33ykyzU47/Qx4HC2t37kF/SUsAb50BZJMI23FYJ1AopEDqmeaXt0udy+28Ls/RxOQjPdyi6n+dNj5qQdQh+DjEHIO4cdz0rPqkrQI+P5+ypPSUIweGsm3wY6bgx6XLuyuJuFCxTmli5QvFgnltISB+tvJ039nFm8bjUEXl2n5Nha6xdW/R3gZsqJjobuNmYEyY288z+87bDn98Bt8l7lWKIoDGn5/a7dy4KesYTgstRuF5oP4lNbWXomo2UVLX6KxpLaXvcqn3ucp6PNtaLq6byoRY7Z9C9W6vXaE5IFkg6fCex4KAFG+Gdm8DcBZvi3520hv4jow8EQ1fLamGoaE7U7/BuinskeTMuXgDnv6m5yRXG2PUFPqrvCc/J5lC8Vt+tPm4NeaT5GmiMciiBZugu/WLHIwCgwsC7OSfMTPUE5+D86PukH+iQFzaqc1eBZzHn6jMmFR6/RAVMc+BECdJiF7VeN8d5nWXKyOAHY21wcNgn9AK3NJHZJeAutmGYhLGegOgvdwkTDK/ay5IW/A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(107886003)(478600001)(6486002)(6666004)(6506007)(83380400001)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAA4yi9LkNib92hOoDFQFaTFJs6anPrX+LLYA1vASZvqxkF5ha5rjKSCwW8J?=
 =?us-ascii?Q?5xBM6Gw1X+aEGmn0LA4QUj537lbyO31SYweQ17OyzOya+kXJ7WZ7DK5/1Cqu?=
 =?us-ascii?Q?43ABCp/CyD86StarrxpEko0JRrBtGhhjo4RdKywuCywcf5A80JQpa9ItghdD?=
 =?us-ascii?Q?leMAoptnrRyoViUPBG4laI4gAONpXNUaUeNjYChWzqBSM9QQr7wwbgP7IT9K?=
 =?us-ascii?Q?BfDwrvtA7LGmqjzzmPmBFuInO7Wnwg3Wfq9RmHVuV7C1WSU8jclJHM+baseo?=
 =?us-ascii?Q?JC/qCK5bN3BrhJqHxjqhDmNoAi0HlbQYUzIhCWIqNWNvpy8F6+/NjxrJujkG?=
 =?us-ascii?Q?5sGiHo4ZSl1b0v0OwKjFk6iecKGF3TTyjudxivn2ZjNaGsR32afuzmf9tKey?=
 =?us-ascii?Q?asqHNCftZI0fwhL+sRvHezE3+1ew3P2BjxUSWJZoV4KhZWl3B3uPNFxiWB3V?=
 =?us-ascii?Q?NUfNgkugbaBTXk8oAOOZE9cf378Hz1EQMk1QxGZ7i+xTistCPLefRyCuXHP6?=
 =?us-ascii?Q?gJ6lq4UXiI6nOWR63QiH5z8Q3s1TkyRxOTaJiKDJNZoKcx4QV/AqL3NIe9YP?=
 =?us-ascii?Q?S6wJNF6LL3yqcmGjvy6dtCbSo02xEJQa5Y1nytBXdzzHRUVcjpzNejY6UleD?=
 =?us-ascii?Q?fRBA2QtJCiPAASgGTG+2oZd7hLPrB9VSbaTgJ4U9M2Ga6N+UgFHV67UE4DmP?=
 =?us-ascii?Q?VKTxitohhEion8bGcW30OQr6G3i3FLXQJ6IWTrFxQgjfjHVLV1OQlcLG+oMP?=
 =?us-ascii?Q?CQ+6Lp7OO+aBXpD2E3rUb+uuPH25SNOxcZOUzWT1hD4T4BSw4b9xPs+7HKNk?=
 =?us-ascii?Q?q4w5GZR0BGZ2P9ETI5+je77WPJJJfZv+nqfhyyB12oJEbGXiKDcDAsCba3Ij?=
 =?us-ascii?Q?ttvQNxK5exZImPu76AQKlqCYc1DQwOG4kBOWLRHcDKStiD8KnichoxqaqHLR?=
 =?us-ascii?Q?+Mz2xRGu51NBFl/8xJx0VfDHYkD82GmPDxPfQRGMVb8KqT41V/zUpgZOLdgd?=
 =?us-ascii?Q?dhUQhrc666JK8+RrHx9sHB94KEDxO9E2ypjlUxjnwQ9iff0Qjksd+gyWcMt9?=
 =?us-ascii?Q?osgBy1ZnevSLqIpthH52DCOmiiNp2u/UeystaeepXw/e9ie6eq6HIdFZu43p?=
 =?us-ascii?Q?W9wZ8W0UN4vU6r8zQ+eyIibE9PUiVjXp/SwfiiyMDpqPS2DkYYCRWGKkDMS6?=
 =?us-ascii?Q?np3VFFtpZ9/t/mv8ibCkyvbY6FZyLN2qYvpM9yuAA5Lk8L4FSCve6J4daY1x?=
 =?us-ascii?Q?jGGVw6c9D1DNTkyKb3lK7TWQovb/S/mqlSYWOXc5aims1Rl+TtcCcE1qhy27?=
 =?us-ascii?Q?+EJ+5hyaPmgORezYCj4bP+MA/ZF9iZXxlrVBbLOyqCp3yoBI3U+QmBVLyH58?=
 =?us-ascii?Q?2sNhimsFF5ZxHlg1kxaXw1TUWPUIM4nin4hyZLELUFhpJuG2N13lsYuUVDM6?=
 =?us-ascii?Q?XNuO4X9U750z3E8koEhqoNk/h1xk67fdAbXT2Hb7auujlJ1twLxbtgnPmfBA?=
 =?us-ascii?Q?JHziFyAuMiF/F4FHp7CDGAUgNEbVJba7YW2v30CV3IRn3xo4zP0cxAJLwRma?=
 =?us-ascii?Q?ShCq8JlZ6oOT0lAtj9/HJ94c/pQZmvki3VudqeQy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17e17b7-57d1-412a-4ab9-08dbb509d8df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:03:30.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zloJhQW7YgzrKaxmCwpHcEQKd4dbyqhvq4eQe1K+vrtlR2QKmAbs7kG3D9Oe+zwNdH3saQTu6FhHSzCfN4YsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

Add a new argument all for chk_mptcp_info() to get the "correct" amount
of subflows, including the initial one, if it's set as "all".

Add a new helper chk_all_subflows(), in it use 'ss' command

        ss -ti | grep -c tcp-ulp-mptcp

to get all subflows number if iproute2 version is less then 6.5.0. New
version of ss will test the no_initial_subflow flag to count number of
all subflows.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2ebe1692edeb..9c3ce3a14804 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1856,14 +1856,23 @@ chk_mptcp_info()
 	local exp1=$2
 	local info2=$3
 	local exp2=$4
+	local all=${5:-""}
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info $all ${info1:0:8}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
+	if [ "$all" == "all" ]; then
+		local no_initial_1=0 no_initial_2=0
+
+		no_initial_1=$(ss -N $ns1 -inmHM | grep -c "no_initial_subflow")
+		no_initial_2=$(ss -N $ns2 -inmHM | grep -c "no_initial_subflow")
+		[ $info1 == "subflows" ] && [ $no_initial_1 == 0 ] && cnt1=$((cnt1+1))
+		[ $info2 == "subflows" ] && [ $no_initial_2 == 0 ] && cnt2=$((cnt2+1))
+	fi
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -1881,6 +1890,43 @@ chk_mptcp_info()
 	fi
 }
 
+ver()
+{
+	printf "%02d%02d%02d%02d" ${1//./ }
+}
+
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_all_subflows()
+{
+	local ver_iproute2
+	local cnt1
+	local cnt2
+
+	ver_iproute2=$(ss -v |
+		 sed -n 's/.*\(iproute2-\)\([0-9].[0-9].[0-9]\).*$/\2/p')
+	(( $(ver $ver_iproute2) > $(ver 6.5.0) )) && \
+		chk_mptcp_info subflows $1 subflows $2 all && \
+		return
+
+	print_check "all subflows $1:$2"
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
 chk_link_usage()
 {
 	local ns=$1
@@ -3430,6 +3476,28 @@ userspace_tests()
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
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

