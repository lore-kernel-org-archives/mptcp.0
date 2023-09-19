Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997331A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtlkPz+cxKkODdTWvrM0nMPl7YpXmgvHEQpfJU/NpPZ9gvbYMRzU1dK6VGd/ymYHT/jwmu9m+NWDEAPCXXR3KbfE57JBYdf9b/qxqRW+pkjeTY3CzAeFnOkyzIRY0x/yy+zKkVnUxEGfAFHS9mN7517nZ5TtDTjyi+GIt+K0XybjwhKEkFdZIESrrRBEti1UbcykZcOiIIMdPibPnpji7fXG4IJBS0OmI4o7XLTnigdfDsZPthEv/5+SmOlmtY+FuzodQd9kAEvhEgeImPFA51zIMvc+ThN9hSba6SheTa7i5xKRg43spoMhQeQq19VjewGMTWQuIZZ8u+X07a2Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiF11NXyb+/eq2Fr+9urODFByr5oasUBA34WB/Dj9Pc=;
 b=WM/sjGijpXMNXUb8EL6S4tDxxA9JkD6OSe0zfHYkcn5CrWojAGEUHzmcb8nnhseylLgFKCO+Dcbri3SaJ17oPmeUbhtYt/UP5trpFUpbOyeJegXztQ7BFyCPByuGqT0FKyEekXKNNOpNYoFkGKXkmenyAYlfdG8qV7CBnJl41B1ku2qC3B1qill+K0gOS7sVQMjjZA4kZYppH0bU04MTqLM4xCPVx6Z58ndRmKuMu+IwDUIQNv7IS3bpDQ24AIr6WGGPcscQJnJVpjEIIwd1erXpb39us1x9fKmrB5Eqa0fPVyKxqniQjg7v+8BZL6LYxLaajD0Zk8Ee01pv2XRz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiF11NXyb+/eq2Fr+9urODFByr5oasUBA34WB/Dj9Pc=;
 b=ylNLXUb8CIKTubiI0QtRLKFl9zjrPefpQD2XtKSkZX3oGHNJ/kJPA1Bga6tuXUkixoYynoE6NaCNho3LvC0RBkppgkHSdLc2LItOA3tii95+WbBU4ITSMfpHJZYRCxM8SRENCirWxTRd7z6CWcghcBWVI3dyyliUK91LcrzMUSXps9IVyUVoh0J307SOgL+bmvUaP3qbZjq9CuMNYcU7yjqxR924h6KAgyAqUJ2gvUD9PVYL5iPdRQrNXptF38tda4IPHBItEuReAHJR6zq+/eoBCS9ZWAzNlY645Gn7a1NK9nR+mgiQDIetUBOypU+SlkUYPYNjdDG9zK7aCjtL9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:05:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:05:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 23/30] selftests: mptcp: add mptcp_lib_evts_*
Date: Tue, 19 Sep 2023 12:02:24 +0800
Message-Id: <efe189e68286a722dae730c44d1806f7c9606b38.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0199.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b52d233-9925-46e9-80d5-08dbb8c5a59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GLQffilxdMQtQCMjvxafjuXsiBzQEHCFW7dw7APU6y7yd+mckc/KQzKklp4WqwXscQguqsruZDxWA4RxGUSJNwufJkk8u1mtPVKIWSFGSG+vZ67aqFRi23dj+2crKf0M6q6/nF6tnEluEuocZbT6CQ0am0Mmo2BEw0xCTYxZRDjupcQjdh63LZ9GXUnshs9F73LDnF2lp3+AsuuTLCG6xyKhSew1r31hlx+blL+8ijjDkhZQvs2CQboMyD7W0Ijj8uT0aOUxOtHRREdpzxbSNQ4jGA/XGKm/uX+f7tPNl/8UrU0a5Uz9FkCpM1klEDVyusdhacpWLymMM/fj5cF5+tCLGqcoHts+5I8ZfHiNTSeCmxTG8cbnm0pcLmtghIo9/6WtSyyFyGqzuCq6Y1HKR94wUSCrE9vde7W/AsSeCJogNRXFMDSs1WobYPoAhjRaF1uPftQsmGw8mtm0qRqy9jL1foVqKj3V/FC5tyPY4ec9WFg/51++L3y2HTDnl41tQ7LMDf/q+u61BTXaloYpmqg05XmAB/7ZcNogpNAEGoYZPMMuPDRgwGsxHmWu/TTb1VMvVQ1FK7uGuxBDYRN4gsEgmmPRzljka870QAg5hVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Um41BDhpFkUQubjSPSpldWFF1brDiON2IKq2RgiWz36YTE5h4vhkDRPk4JCC?=
 =?us-ascii?Q?j9V+V3+WhQ6WpQTyMG+tZbBqgx5xuijoPfDXC1c1qyLj1s8jNDqk2uP2hJyr?=
 =?us-ascii?Q?ekL15ZQ4phgYPMQ8TYR9UQN5t9XM8xMcMZWAeXkMxnGjUVMogy/iPGlbDNLt?=
 =?us-ascii?Q?dapcdycmlm3y3lWjm7dnFQi4sw+7lEO5ZB9VzkNkENLOTyNJXjj2rR4Dqd43?=
 =?us-ascii?Q?Lc2vZmqgPo4D3ycfymZszX4yeCgPCN+cbZfGkg+OhIRrrv589foKWBqBBZVt?=
 =?us-ascii?Q?baIYtJwMurrvsVDqaY9ubKajZ3Db21Kj27Gl8IwaSQaFBXKpZEqLRX/ThV5x?=
 =?us-ascii?Q?yOWwoi3Zn7Kp/JfIPkFG5XuRrzr2vMvSaBumj9y+t/CJqH5o9vnCShDMcdwf?=
 =?us-ascii?Q?HcA4Als/7NxLgvtDE/RajE9h8kb8UmStqrk9wMmEo3yTaoccYJuS3ThBnKz/?=
 =?us-ascii?Q?CHNUVhkptPQcTw27Ba+zOZrDgFOsbodEl3h5/10vj9RQLrWeiwqpjv6/iROM?=
 =?us-ascii?Q?p1mj22PQ/so1DU3uKK86z3Nh1///mdmxGWxWsWX5qIQ/8JbYQthtEXQaphHv?=
 =?us-ascii?Q?geI2TSkoqZ+N2kyuEB/gwG8B8vyIMa1+KCKwLyVawhOCNIHTtj0ncZFb6OC+?=
 =?us-ascii?Q?NyiDiBKhz2Mw4aBwI4CiYIsz4CbjwDTu6RGHCKWaZszkN6OwXAvcjqFowwul?=
 =?us-ascii?Q?Ut9WfhJScr30WHK4+vBw0PLByYRS96hK/alo0C/tMRs+/iVTgkWiF54ifN8h?=
 =?us-ascii?Q?EJuq/5uo7VRltmYenWpFPqczG+DmS+mrjEC3a2HGeeRRCwOHaTkSjNUHf0Jt?=
 =?us-ascii?Q?/04LHv6QLYprYRgU86zZ8BbB2ERof6CymDBX+3KIQW8qw0wMQRsm2DZANu7a?=
 =?us-ascii?Q?nWnOmIF3WtrtnBCLGTR24HVRO9It4d1freX7lYooutO85m5UWqrGEwNA1vj/?=
 =?us-ascii?Q?W4HAiFZuuQ+x/tkr/fy+QgcErFWYa4u5r7FAUmZnrLj5a8Wmwky/JibjZP3x?=
 =?us-ascii?Q?RnyP2xZJWN3e98AJAAjq0R/YoHRusZyUP5arIo0jm+PMnL2JZXWkYZgFV1VM?=
 =?us-ascii?Q?2VEa3gjABg9GQsYhZw3ZhcjX3cxS6bQJNWZ4X2YtPctj/9x3yleNSTK1+BY1?=
 =?us-ascii?Q?lzGyci8bWkeam2mEPpReNOeXqu8+zQj1zSkf5qEG83V8aV5Nvu34F836pU7w?=
 =?us-ascii?Q?0IspK9Ewu5zHV2BEtKZMJ4yikaW+6Lh/Ka40gLgY7aZzUTPBfJ0amh76hOOE?=
 =?us-ascii?Q?BqxgqrPGGMJa6TAHC5rF9A5ZplovH2LNyv9jJEMou+NzT8HB8aOLL49gDxtZ?=
 =?us-ascii?Q?ccIXmgI+J531AZzvhiXlFQWWhp7Nvk+kNjraPoCwzAcIxkzBVItNq6OqmhxM?=
 =?us-ascii?Q?ISTP9uD1V7+4luqErHr3gJ+ukunxfCeLfV5GrGGXT/TynlxG6SXP+bH4X0sk?=
 =?us-ascii?Q?NqCtHLedBhQEc3PH9GpFUJhBQ5AY+CAJFmIw3l7S4ILDqpIdos+0umGoZZTL?=
 =?us-ascii?Q?rZzXxT/jAyBmuhEcJqbwaFFC8htbsj3mgmPtZcVeQA/iSMaoicuGTHFgnAFa?=
 =?us-ascii?Q?2nRe2OKPDbrf1hw3ccq9AqpesI8nJQRxKzJRnwAZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b52d233-9925-46e9-80d5-08dbb8c5a59d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:05:23.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL7TdkaTdqz61mPU3LZNuZyZr1oB+7IAoi4S+f4UhmmksvZ1FSPuK23zxIzwlIW8d7EFfc4/PwTkHR0ffXMqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four functions: _init, _start, _kill and _remove.
Define them in mptcp_lib.sh and use these new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 +++++++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 40 ++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++--------
 3 files changed, 65 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f335a782c793..8c708b92a942 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -35,10 +35,6 @@ ip_mptcp=0
 check_invert=0
 validate_checksum=0
 init=0
-evts_ns1=""
-evts_ns2=""
-evts_ns1_pid=0
-evts_ns2_pid=0
 last_test_failed=0
 last_test_skipped=0
 last_test_ignored=1
@@ -182,8 +178,7 @@ init() {
 	cin=$(mktemp)
 	cinsent=$(mktemp)
 	cout=$(mktemp)
-	evts_ns1=$(mktemp)
-	evts_ns2=$(mktemp)
+	mptcp_lib_evts_init
 
 	trap cleanup EXIT
 
@@ -196,7 +191,7 @@ cleanup()
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
-	rm -rf $evts_ns1 $evts_ns2
+	mptcp_lib_evts_remove
 	cleanup_partial
 }
 
@@ -460,12 +455,7 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_evts_start
 }
 
 reset_with_tcp_filter()
@@ -682,12 +672,6 @@ wait_mpj()
 	done
 }
 
-kill_events_pids()
-{
-	mptcp_lib_kill_wait $evts_ns1_pid
-	mptcp_lib_kill_wait $evts_ns2_pid
-}
-
 kill_tests_wait()
 {
 	#shellcheck disable=SC2046
@@ -2907,9 +2891,9 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
-		kill_events_pids
+		verify_listener_events $server_evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
+		verify_listener_events $server_evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		mptcp_lib_evts_kill
 	fi
 
 	# subflow and signal with port, remove
@@ -3282,10 +3266,10 @@ fail_tests()
 # $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
@@ -3295,10 +3279,10 @@ userspace_pm_add_addr()
 # $1: ns ; $2: id
 userspace_pm_rm_addr()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
@@ -3308,10 +3292,10 @@ userspace_pm_rm_addr()
 # $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk da dp
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
 	dp=$(mptcp_lib_evts_get_info dport "$evts")
@@ -3324,12 +3308,12 @@ userspace_pm_add_sf()
 # $1: ns ; $2: addr $3: event type
 userspace_pm_rm_sf()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local t=${3:-1}
 	local ip=4
 	local tk da dp sp
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	if is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
@@ -3436,7 +3420,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3458,7 +3442,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3477,7 +3461,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3499,7 +3483,7 @@ userspace_tests()
 		chk_rst_nr 1 1 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3523,7 +3507,7 @@ userspace_tests()
 		chk_rst_nr 1 1 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 8051ac5507dc..899c21ced5a3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -220,6 +220,11 @@ mptcp_lib_evts_get_info() {
 	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
+server_evts=""
+client_evts=""
+server_evts_pid=0
+client_evts_pid=0
+
 mptcp_lib_kill_wait() {
 	[ $1 -eq 0 ] && return 0
 
@@ -227,3 +232,38 @@ mptcp_lib_kill_wait() {
 	kill $1 > /dev/null 2>&1
 	wait $1 2>/dev/null
 }
+
+mptcp_lib_evts_init() {
+	if [ -z "$server_evts" ]; then
+		server_evts=$(mktemp)
+	fi
+	if [ -z "$client_evts" ]; then
+		client_evts=$(mktemp)
+	fi
+}
+
+mptcp_lib_evts_start() {
+	:>"$server_evts"
+	:>"$client_evts"
+
+	if [ $server_evts_pid -ne 0 ]; then
+		mptcp_lib_kill_wait $server_evts_pid
+	fi
+	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
+	server_evts_pid=$!
+
+	if [ $client_evts_pid -ne 0 ]; then
+		mptcp_lib_kill_wait $client_evts_pid
+	fi
+	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
+	client_evts_pid=$!
+}
+
+mptcp_lib_evts_kill() {
+	mptcp_lib_kill_wait $server_evts_pid
+	mptcp_lib_kill_wait $client_evts_pid
+}
+
+mptcp_lib_evts_remove() {
+	rm -rf $server_evts $client_evts
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 7cddf793950a..640273d4d7a1 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -33,10 +33,6 @@ AF_INET=2
 AF_INET6=10
 
 file=""
-server_evts=""
-client_evts=""
-server_evts_pid=0
-client_evts_pid=0
 client4_pid=0
 server4_pid=0
 client6_pid=0
@@ -115,18 +111,19 @@ cleanup()
 
 	# Terminate the MPTCP connection and related processes
 	local pid
-	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
-		   $server_evts_pid $client_evts_pid
+	for pid in $client4_pid $server4_pid $client6_pid $server6_pid
 	do
 		mptcp_lib_kill_wait $pid
 	done
+	mptcp_lib_evts_kill
 
 	local netns
 	for netns in "$ns1" "$ns2" ;do
 		ip netns del "$netns"
 	done
 
-	rm -rf $file $client_evts $server_evts
+	rm -rf $file
+	mptcp_lib_evts_remove
 
 	_printf "Done\n"
 }
@@ -195,24 +192,8 @@ make_connection()
 
 	# Capture netlink events over the two network namespaces running
 	# the MPTCP client and server
-	if [ -z "$client_evts" ]; then
-		client_evts=$(mktemp)
-	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
-	if [ -z "$server_evts" ]; then
-		server_evts=$(mktemp)
-	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_evts_init
+	mptcp_lib_evts_start
 	sleep 0.5
 
 	# Run the server
-- 
2.35.3

