Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80853A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxYZsHQPv68OToGBlWfs2YNy2Q7IX3m1hrSGIq6/g1BM66aBAlzrsygqWXjeT00TLa92jhA6f2XL+KdIW9P28Wd1bPDf2PaYoZCAG7tGY4XnlE1ldM/xvbApFPrEThI279ZNt+OHSK3SPuCzipFvnWrD9ZVDGz1ljg4JzsiR7UZCH7TYGDr7W1CspiuMHi5PoU58zZ0rOAt9yQKjdz+BIUfBzFBsIr/GwXvFlnp0D/jRbvIRZD7iGPo9YetPn2gDyjWRIxy+CWFAxJAmng7NSTGynnBpEMvgJOVXTNJtuBOnjRD3m82bmTT2wGV35BDBVk1TXfuOvBOQ1xT+YcsJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhJ2ux86HFu6qs9/gjEQCISc+PeD6Tg2GWg+vkTrZDo=;
 b=BVLv8CrP0CeWBoyZVNSncnABZrTQohB6PA8LZ2KHnZmdIvz+E2WOKvLhQaVTqOitDkXdHrH1tNa1AqrimXe7/l5JAkgZyHZ9EXBFsnpWRJgP8/Ph9QjwPBE3o0GXC5d7rjTIxjHDv8qzElMcnoFekct8jhqoV47CacCDT/WPLQq9WJBa7xk6K2YV6zS6DyzlNoUptz8AwmTliZGs64zYqkM+Du6i7fQngp27U2SqyFAAKdbzN05eSYaWqG+gW1HhFf+ToZwr8IWo4s15n2q0CHOulfuS74KO5zXZQo685ivo7Pt/ewgLz8nQruDGGAKm5Hi5y09t62PD4QYZP80mTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhJ2ux86HFu6qs9/gjEQCISc+PeD6Tg2GWg+vkTrZDo=;
 b=W5zKphwYeZpP7s8FaJe/9ISRAnYrZeD2PmdJW/aj5XE0szuiVTY2YHmKlfk0XcarlvsMpcPNiiGXSFYsLZfzWIdrUWXJOGowPbrdx1YMnFEhQluG+annwEpMPYGNzQoN3Jq+fKACqB06iv9XArOYI0Y7TUF7oUNggfkw8M8MpgqQ8hpigh5y3j2WKXOgsgyqAScM7qS9dYtgkqZy4Qmf6H5ly2ksPsNqqZU9UI1gA17DnB6SZbB5oUXlumjMYe1gN9ErigUvvDr7/DRn9F1h23OGcUdkESG6HOUCW8lS/werZstvyZQcB67TzAqRbpN/g0B2BHw+bwNsS5HP6Xkcpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/13] selftests: mptcp: add mptcp_lib_evts_*
Date: Wed, 13 Sep 2023 14:04:54 +0800
Message-Id: <50a72083ab2430329f861a40a60e6295547eae93.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bbcfb7-7c81-4f5c-cf21-08dbb41f5e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GGN0uKGbvDLFg8bj+x4qzSsVkXd7Ft9yOOKmMKl6sNpLetB114U/XZluKh3xfkQQoMxnpMR/ocb6edLutCUEipMgpPUXEt2vMfA/+L6B6rnaorWP5RsB2c/makSygqze4Jccr7riNtLKv6pXAdJUv3WjCsIo74R//YvYjiWF2NYkDb5wfPgLz07buXdGpJmOK5ktCIsf8twkwVmNzynN/ukAWQ6eyVZLrjKqHalgkx1O1dbHL6JuzHszoreQR2wpmGQLeJQG4imtA/UrEKooUBhXBrW356Dl/UwvNICbTZblxWZRrmEM3v5OMKyzofYes4oF173uHUpJzKToz1uVxh1lRUkaGBt76gTtfYKHv38+2DSIj98IqQazFJfqpmMwTBV809q3W//dnngHY7BNg49F3WbIcnp+sxEzIErqA/38eLc3ugSQaEA7tpQSnJTythIFazkbPv/+7Dso0CcG5Rhb9VL3LdfiVm7kdnx/ytG1/T+Bv09UNZ+qcqtP2tuF0JI7iZl/jfDh9GZM1N3BcWQEIXP273dLe6/Wxh5D2DNHmw/B7YSyjcAiJCJa6YFFLLBTGsSl8NrqC8uqDRqh9DOioWOoVJBxO6sMURQrFdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Aq8Rtb66y9jEJT6+Cn/y6mJymBBwF0NRTKsLH0C3xj6wgzvBHhZyh0awJxn?=
 =?us-ascii?Q?QH5my5/puiguL5l3vys8J6eLB8CGnxofCw7IUhmW1BVo1Irwxc6Glblqz34M?=
 =?us-ascii?Q?hVuONlIKoHpNAgHIWcL+Fm2WCw+QAjUqGMLa8AWvEdsb+XBWLkd1MwyEKW1Z?=
 =?us-ascii?Q?nM91xKd+qjyU5Csqs47KTupxky1p4LLd1JbVLpmImVdcRrRI4epsPVQiDnxt?=
 =?us-ascii?Q?fUXwuiM4LqcNp2XC7OFPTYiBqC6MBU9U0Sa7s+eT0zFZZZc2y38kYAL4B2ht?=
 =?us-ascii?Q?jeNC0Cy4/CS+4hL6N58FMmBpOnur9doJajuVpKwPLz1ZZugviAVQJ69miqY5?=
 =?us-ascii?Q?G5oXo+yk4fflaGiPEM8OPsDZyrW1tfA+3SE2RY6sCfnhxhxchKhHGM78Xq3C?=
 =?us-ascii?Q?s8cQDgbkiiYOZvgU0t0AJJulcnZF/Mt2o62Q3VL+Ypo4B0QZUVoea+3C4U9p?=
 =?us-ascii?Q?ZU8aK0/RiR9DMiPq/YWEgoFnB02QQoVZsMSRIC0keWtUoKcy6G68JIRk+Ga+?=
 =?us-ascii?Q?BZU7fkVIFo378zhlqWtHdfDCR71uk9IqQ41uzvo5NFfqYYuP4z5nbfcDy7Mr?=
 =?us-ascii?Q?D5kgmCpintC/xSUJ/YjV+N3OVskjZXjtZhMs+1bRLFFK1jNLCoifx2Y+t5MN?=
 =?us-ascii?Q?bo/WQJkhSerKjXkHAzQ9uDgPz8Rocb9Kcz2x1xeH67zKLbv7TJt8P+IHMRIu?=
 =?us-ascii?Q?kSd++N3tar0iZfpqAXFmuN22ADgFosB1B/akvklbuw/v/VThdMBG/iNQI/I/?=
 =?us-ascii?Q?8VhgPJtX9W1C1i0wOIzhp/pohRo+6vSOfrrmuZe9RdXbyFFhR6hCzbUsz5BP?=
 =?us-ascii?Q?swqipy/GmkOiLLJq7oNcbB6Ln+iSyK/d4hKORSktO9r6qscX5EZT/kE+qA8i?=
 =?us-ascii?Q?FV4elhTFFWzceLQQcc5CWQ0cGKyKHWKzYo4EwdVJFJkuTs2L+hz+xD86mW0S?=
 =?us-ascii?Q?zsvT7oNDIjH51vgkdUIhf2VPLY+H6jSNPbJOc5JMCRzNqOtyKHEObTW1r/5Y?=
 =?us-ascii?Q?/foRiusCSsQdjYD5NmOok8b3ZgIWo3FxS8gNvHgPxEFSWMWHumNBeyDKBqES?=
 =?us-ascii?Q?WyCHTASGj1tdP7qfa8syWzNCyky7FSZFbEmcvrHiDvzWHtekeVzo11MiWMFT?=
 =?us-ascii?Q?n881tzFade3kH+NHKCwOQZ1dx3eXb46fOl8zNId/A2him00T+oreHtwvAPtX?=
 =?us-ascii?Q?u7fOCCrQTcF4+5hSyn9gg3n0glgDJQkgmoHH0hkKej0XdASW7paTzTy/Kn44?=
 =?us-ascii?Q?297seexYUKa1IMElyiZFICRnngkA+r/9RWUPu9a5BwwdQDkBXkEKtAqoyRKY?=
 =?us-ascii?Q?MjLE4UFsySrsRJHxfyzc+FoKwQsD28oHOINodZMQLVYjQvZmEIbdSLxP2wn0?=
 =?us-ascii?Q?TgqLkKBcxYSsPYm3uOWs8g2SetXamY9JOo+Iy6OaS6DvOL2hBYQYMnLx/3fi?=
 =?us-ascii?Q?JS2aWXNQDCj3f+S7p6juc8zI2ySEbHv14i9TfEadbqtTQQUluyJ2gXtoxV8D?=
 =?us-ascii?Q?m+aCXcDK0n1qpekfmrZFn/6yuC0vl0ffSDMT6fcWEpGGvvdn8202l+eB/pMS?=
 =?us-ascii?Q?CkMZS2i7Be2cE0wPBWo/Ots+7KSRTimvhB3tW6G5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bbcfb7-7c81-4f5c-cf21-08dbb41f5e2a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:02.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wBWiy/Lmx4IxUvxVagyhh4sOXcJCwcLWei5PwpUWnR4qNxfpDoNItYkeEFlcRi7fRIZ+xCnZ9H0Sgg0EPLHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

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
index 96e3fd219968..bab94bbdd512 100755
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
@@ -2899,9 +2883,9 @@ add_addr_ports_tests()
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
@@ -3274,10 +3258,10 @@ fail_tests()
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
@@ -3287,10 +3271,10 @@ userspace_pm_add_addr()
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
@@ -3300,10 +3284,10 @@ userspace_pm_rm_addr()
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
@@ -3316,12 +3300,12 @@ userspace_pm_add_sf()
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
@@ -3426,7 +3410,7 @@ userspace_tests()
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3446,7 +3430,7 @@ userspace_tests()
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3465,7 +3449,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_all_subflows 2 2
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3487,7 +3471,7 @@ userspace_tests()
 		chk_rst_nr 1 1 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_all_subflows 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3511,7 +3495,7 @@ userspace_tests()
 		chk_rst_nr 1 1 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_all_subflows 1 1
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

