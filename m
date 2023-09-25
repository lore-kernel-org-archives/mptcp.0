Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C9125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIjr2kDOruwwvgAnNEGgpKA04GFwIIVsKZUGNQLpce/BJlHLfCo9uJDb72jZFZwXEfKQhAD3dLwI5Dli1gwM/x+Ger+NVMaMyYp9Ti4Whfv1TBWa9JXZplbYpuP/kNcdBCXLEKJOyzAGotI0fJKAfUqMSnFDAWIfLpF2Z0wJ0nPE98n5wnJRnWyt4xmmEoPgQvBSg3bkyCbRlnI+nmRyLqzAz3HSmCb2N9ll19YX0zlur/hCgPhoti6b7Qt3wdY0fdu5PtBoG1p6PaM5eN3Z8amsl5MzVMbX0zPmioMhjDd7OmBX/HNP8jmGFqp89zy/tugadr9M5J3WPSPdU/+RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiF11NXyb+/eq2Fr+9urODFByr5oasUBA34WB/Dj9Pc=;
 b=SN9byUpjxfO9+7a8WEJxIFfI156HGyErbOwu8qkjclHK7DHjuwdomLGWCG3mmlTv7WU3pPs1qblp3sp3P4YJki4bJlg1WPALWYAtOU3OtfnqYRHCzgTtXf+LLgsJXw5Mdrep47wGFBGdr2gStup4ZDWXLxOkUaJ/cBEZ7AgF4TQRlG19rjbok5VgxLFPAKmq3zMqV9u1ygKYxAdJtLhWIZXD++rgR6nL+ks/fSuV4P+5SX3LONbxhPtV3jJQXkpc9KHmZ6HRVS/Uq6l3h42YClkGxqqcjqKcU3H1YkTbpFqEuOxKdHwKTBmQ2qHkSiRdjJt+nr3cIHjmz8dwN8btog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiF11NXyb+/eq2Fr+9urODFByr5oasUBA34WB/Dj9Pc=;
 b=F7878endD6IrodjdS1GF9a/AVoLeZmTShn6bDoVzx8k1MO2jfm2PLqsohsi3J872yM23FE9FiFRSO+2FymZbUFw9dw9q7DDg49tq7NdS/kEWGtzbcnRgaDYvwft/KvyE6ZVdzVctcHzL+lUkg8xDW7SYSSFXAGZwhlzJHGre+1ozxNSWwwcfYGK+/idYju2mI44R5ujMtktRV9WCLOGoU315UmMRzGvQRpVUn1ch6GueoWjMCuca8G4S48sOKKcpAjzauPkLd49p7c3CD68mGv1s8CSJTVAy8pawef9Ix9GBgPKATfik6f5dm1jfC1YPwDvo0JWTAhwQSIfEcy8Gyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:44:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 22/29] selftests: mptcp: add mptcp_lib_evts_*
Date: Mon, 25 Sep 2023 16:42:01 +0800
Message-Id: <8b57e996491a1057c9b1385797f7c96dec2225ed.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c1680a-8d2b-497e-9dae-08dbbda3974f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BqYDipL6KqGlup2AZfBGBMi5/ApYJGozKgoubVTbUxGY484gySxWFkX01qc1twjuVjVskCPF6AThUwZgW+HKABMMf5UPU6TIk0+QUUYH1NKJUygk09PDFnNb6kAVEfhDk8efWFORawhV8TFmgmoj2VC+zZg8WDoy5YwCdSqpgb8BJIdMeKs0GoXM4vFb4FH2nw2gQTn4jMr6eIfD4ritnoYjYy6c1pRMg9bR2H1GPagpMR+D44G1EbbLFq5otkm3zSBHgW95CQA+QII4l5r+Rj5gB1JCh9Sedz1jCGUztzER5kMMPz7AMkxL4jP/in7rwtMIChMXvTLzlEDsXIMfSkU5PR+cTVV/FurQ5JKQbBSS5o0Z/gJPQuWybo0Fshg2Sl1/pvyOcmXH/nkLI+VNIiZsgnfJSxgN7r19eRnGBqwdPUd35c3TVnsE/06lJ8uCbssr3B9QQtTEoec2IVS2wD/2l5H3WQtDLme33ELlJenPcRgydRXzzp3S/0OGG6GeFLyfeXVuv2oUeVIlu85D6I4Qd5ULrLa6rc3nCRSQMG5J4ci8ufsSy2GlE8fHpfBL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?986UKN3F/ArMYhuRDWn3msjKqClqLXGLGPOOuazYEFS7fe0hqdBoNkJUIX8T?=
 =?us-ascii?Q?V+Vqo4HMszV22bj0ixMQ2FtXyf1v6qqJYFUVer5CtAt0acPMGzop8m9v0iPo?=
 =?us-ascii?Q?DZi3VYa68yMf0gqmA1bdYZMs9fQajmHjp6FE/4bLZg+B5HQm/mmSwTlWg9B1?=
 =?us-ascii?Q?25Z1iiAJZREEIttD8ds05LCDUtPGekCQMfnmF1BvC/enb7dihDYTbgOzGCUv?=
 =?us-ascii?Q?g5/o+mAk6COs7FnKgn5RgEQIUUBPGFB9oP/ym6G7guJQJMGCduxXbPv3moRS?=
 =?us-ascii?Q?49GRfYqnpZEOuukVPwJw8Zpvxi274lOUc0hRBD4/ab2wK7z3N0WPe0i1oRc3?=
 =?us-ascii?Q?bnEiUpmZuQDpI6orlMVLSp786HTx4dhSdVSOjJ9xCHdLeUAUCm/oFExo2o68?=
 =?us-ascii?Q?A3XT1BfTrvOKtCrVe+xHp+yx0cTCLSpOPA95j76Fg45xGWEfq8Y9x+6Xp5sv?=
 =?us-ascii?Q?NtlneG9jEnmzGDmxryrHtayrAP7WvJEwaK/FNe52AmTrjvhtIV7+vzkinEnY?=
 =?us-ascii?Q?BhRAko9hgtW+/OMuj1rTgHQX6J9T8fnhFx218VmG1hxkhHW7lShkFJX1Qfkj?=
 =?us-ascii?Q?rzDpGTcuK7Zy+s8edpXNM7wihBqQWs/a8zCbX0nJiiT7fPcQboTi2YlMWYAF?=
 =?us-ascii?Q?mrZaXtyt558W0kW/3T3EpqEDC2hcSzAfFJlS5/wejn3N3smjQm1weFHVGeiU?=
 =?us-ascii?Q?y+j0i57wWhNRJhX3qbE4O4qu0tQuzSesEaytP7nerrJcnIY4i8GRXW0mmbXr?=
 =?us-ascii?Q?0zAd0bybEiZVsgPU7PCtsCFJRx1sz0L0bUytP0ldFAQNfXUp29l58lBLi0ZB?=
 =?us-ascii?Q?ZjqPKL+x1qBpSQ6kaEv0Al2pri3z+721/5kdoET9CGxWNydse38WRiYlWbQB?=
 =?us-ascii?Q?T/nAYsmazDcb2oZKzR/ISvS4+k7z3S6lUvuWFaH06Ous8Jv1JIjvPek0oOpV?=
 =?us-ascii?Q?6856utL6IEMLYuHAntN1XCx+QcOtrgSiv2qOf7cpbwjo6h4Ln0beG3ex6+K4?=
 =?us-ascii?Q?XWaxjfxFOzEXXMiPIh4DkWPxSFGYYymEfUwkcqlD3KAERNLzJtUcHUiW5H1I?=
 =?us-ascii?Q?Y+d904GFG5T4d1M5yH6DAyQopElPjzgpoPxmIHFuMqnRcMugcku/4HWYR4eB?=
 =?us-ascii?Q?ODfRsKXKgSLZCMaFNCIxn78D5GrLGOxgqeZp0niTEFKz32elDEkT9yFJsxwI?=
 =?us-ascii?Q?A/9FlDIdlP7BEHFFd4SXZ5ChiPJ/OILkl+PI0S4sjQHcM73oke9C9a4jdl0M?=
 =?us-ascii?Q?iKx6cxcJxg0xKZSLUs8GbrKAIstHLA0u1kwqNtkbppamvAelJnnp470PK9g8?=
 =?us-ascii?Q?rfsvamqxH5LKPu8RrTGYffU0UwSBVKelmPiuWPBxj5fnwbqy8aQr1eU0M5eZ?=
 =?us-ascii?Q?uHiIfmmZNRg4MM8SHQ0OGrubVlZwi4vMJlidaVGIMDsJ62qrOir83ZCyEGXb?=
 =?us-ascii?Q?gya4AnAcoDA8PwEuUJ2a9CCOqiihtqmw1H4JxNhj2SzubwOQB3AGv5rNCaAc?=
 =?us-ascii?Q?rhI8lmXDmk6X1b+nJEW1omjKB67lroJ9NgVtF8dK4fJEKdPVSg2Vxk9EZaMg?=
 =?us-ascii?Q?juMFh1PPqp1hghJFMMlgOyv3Hp4jvDhmxrny3eSl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c1680a-8d2b-497e-9dae-08dbbda3974f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:12.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp8wLj6k1qrxc7+k/A8QaVa+EbPVkZjaKGjt1DXsI8NzxuWzMQHN8tDM/a2DM5t40yIXZmT+cr36gPhJzYETlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

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

