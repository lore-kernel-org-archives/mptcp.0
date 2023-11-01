Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FA7F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FtI0azRR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU4+jJtm6dOlBYRG03iqEr/I8aMtScH1Rx01/Qgsr1l2RAMxaWCxg4drzMECBndyzjfcCuZKpbHHKqAdbAotG7IndBWUTZyiKqiwdykpmiizEShzVl7NIaY2vxZkR4wZO1Php+TKbvThvMq/sSTmW4CI40b1IIZGRzYhJDrljk88Bvi6tdz9LyUU3B3uggO2/nvv96xxiWOBCoGZaL6z2Zhs6uqSKpcpHQ/U+Sd6Umz5rppMc596Q6nG4cARnlN20sLPeH0rdEUCTJWHd/hN2OUhXuoID3RwRan3BHMwE0D6jQ3+5n9tTjjbIRW4nOInPF5TW5u0AjTk99PWHeS4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToErcdbiKzXOvA5P0c9BkXQSqP3BNKo3rEUeC9P4lHA=;
 b=ZwYN5kQlPs8tcnlHVwVg9Zcd1cTinal4iRu/wQNnl/G48lt/GG3QP7pwHbj3IVTGCrnn3ueeYGAvKPiSXQ53ZGI+qzO85urUdMmNgEtiqneYOKFrxjMm5mFIFH7B04wCFQE/LmW4Po5rXmvPD0VrTvxq544rgsH3MA1SPsDvs8IMAhFjMv9Z0H7SATFB1RdQDerk//uodt9u0kZikUKs92XC+KR4yqwvXJJSH/AT/vORDSD66A1W1D0v+WaoU9t5QmInkejmji99A3fc0iD2l+S6dVTEjWMxVqb7LQ2i3YNtXLIwNi0uGRmEq/oOwVjTQgA/63EakvrwEFo9XGZ4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToErcdbiKzXOvA5P0c9BkXQSqP3BNKo3rEUeC9P4lHA=;
 b=FtI0azRRI/Cz2I+KUIG8RcPr3X1eeYz9luMsALzRNP/FfKkf/erU7KpnXClAUGEVxMSzRJ0NrTuH/1Rtc7Ci12NFyIOvqf3FYIFRWtQGaNr6HIqGFTonEMpqcG4hYC6pRR+qX5WpGvWK7oNttGpjCeEpUdiQbZzhJE4m+yDGTQo3XCrGO+Qi7vArKZELMgLdIv39lH/9SHR1zxQA0LkovJ0zACOmItbc+aBb4wHUveAqmcX7ao5YISFB4aKpwXxFIpamXA71XOJZ4qvwHy+CqhQYO+SVDBu3cKT2X8J+WLC+GfjHGp5MRrhSI2puK70z0X50mRvjFSWh1Io/a2FZig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/9] selftests: mptcp: add mptcp_lib_evts_*
Date: Wed,  1 Nov 2023 12:38:16 +0800
Message-Id: <eeb0ea3d88e9a447577255c2ef38671e0f0546ea.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 281f7697-8763-4b34-4260-08dbda946366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cUUT7GooC1xquUIwRzbb0RtWM+/o29iAxnx4oSl6Lo0Xcfco+SZX6K2DCavwZlP8/eICduaU+G+Fobf+TK4mN3Rf4fM2qx4EESonavpgjTz9sHvhScM6GR9CrjpZhYOc2F9oHVwEGMllECqcWBuYqSubqpH7Erg5a4brZxL8D0c8h7/zjnFG5Qc0c6yyYy0qaa7AjPP4hw4OVE1mPG+XA49j5jc1CV2TpenVWhnrMjQj40qQ7f5OYo+iSNGmWaHCRPFRc+5C6pyRJ2b/etymKJmwJfXZNFRqNvax7O5oWshyF2LCrUkcfKOPUkZJswZy1nCYi3Jl9q4ykTLhCKlHY9szRvc5UGXl0C1E160UzwmdO+MibezFytwo79Yq7iq1iWW/DUm6RPBiwMvuQDabZVEHkg+oK8RpJpPfUrpQmxlb0f4bMXof7PHplcvUnKHMVlqIQrpzgA1IQv9W66MRBRgAuwu2XoXaCQPFsYo2uhCRNS3BzyfivRgf32vRpfq8I0ynx6FksMGx03yYZ+vFBhiDO9+Mac4bO6bHCRV8E/C2M/+3JbWx7RDT5CiqYR/p82aqEZmLJT30ty44cL84++yHCcqD95TiasopVh0bjcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JF1BgmrpF5uBWWgjKoalnQqgGUpNRIaoaZQpKsQmU2EmF1j/by+nq/QAvy0o?=
 =?us-ascii?Q?uX6lB4uBf51CFFff79BGle6uUEIiPjGqQGG5AkdsE2FOsU4y8528jdKngWYL?=
 =?us-ascii?Q?cfo5IC7hByblRnD+d2oNxhVZhsNP87ISvhgrnT4h6W9w7ogl0bxmTTJLAgot?=
 =?us-ascii?Q?Fjo7R2zorX9hSpCO8BgTUIWSkkfn8P/0wv/f0uLUpNZ7UICPf5h88kSNSzpH?=
 =?us-ascii?Q?Bel/hpzo4Ut7o6kJlCry/jtYvnLeJBQM65/UmUytcPFv5QfrHe9O3t0xyzbQ?=
 =?us-ascii?Q?/YMNup2K1P7QkBxnZJ84xD01Hh8xavsujFaCn6RZNjjpsrZchOH4VJvXNNsT?=
 =?us-ascii?Q?MQlUKHZhauKCKdXcpW/aWDRaJr3aghYych6dNmxv1I6qQ+mzJZsELSyLrj8P?=
 =?us-ascii?Q?/LLhWaLxoRWwENNBhaYHv82ryOLFoKYUPYdXCmAiCcHlBTO4+7Y8mR13CvZy?=
 =?us-ascii?Q?H+ymdkf0dIy7yKZEhAW6EnYogJwvABZaSUunr6cT0eXUrSTSUMExQ4shn0o8?=
 =?us-ascii?Q?Im01QjkoTQrVHhf81+xA/3nx7pOXKaOC/MsAfPaa88OI9Drqcreu9rVApQ5u?=
 =?us-ascii?Q?bQlpCXmxLBoqVkvMM3Jw+qr3HCWCbnCsHFNS50nbRmfhnG04WVGoKImFw4cJ?=
 =?us-ascii?Q?ZOkD5w7p6a2Zdr4IDvwMJJZYookcp4Ga+7WuQ6SWe26oTcuvC5y7ZzWLnVxz?=
 =?us-ascii?Q?bWZ93sbUHpsfacxDm7Q8WRS4g9gEHEgQ253QUEeq6uci+2o8Ioxmli5gK7KU?=
 =?us-ascii?Q?dco+0K9F8Q4aJPbPC436VVwF1csfNAdEAfmarteAKMBcXsQQjwZ8JKj/wWP6?=
 =?us-ascii?Q?x11+kAEBQ6drpS7ZA2RLXNjNnXYJ1kyhJlhQOOQ3EdiUioV/bS8ikKGs3BTo?=
 =?us-ascii?Q?5aPqLNkkSKu6GYP/zKqL4sB4nwhMOcSiBHTr31T4myx5IcddvmJY/v5Hnd04?=
 =?us-ascii?Q?tHQgN1fnOQE6rwblknGFn9tt3DhPgqFHNEr1is4i5f3/cd5YLe2q0MiufiJn?=
 =?us-ascii?Q?/kRkdloraSyIk7RhmatVCvyzK/DJn9NHdiQ4bCYRUj5/Dzx/ys+BfI42lTRW?=
 =?us-ascii?Q?bZJcMxLFqLFX1NZ5kwu76DHNgV9OngpUmhR1Sq66OH3JqOkJ18LqmQOS88TJ?=
 =?us-ascii?Q?REO3/LqutFCFlCRrxUJrkCUPn/d4PBJynvEckdk0G568UNCwkTJDlJTBv7W2?=
 =?us-ascii?Q?HXRfPd9iQ+MDCmgebzEEAoiK9y4kL+o44BqHIhoZsiauGtGiS0xaQsfytCPt?=
 =?us-ascii?Q?Jeb8wIGAUtR6U0QjGFOFuJ6BfiGEPxJ8ZPcJEz0VJ7FbdAgqLeKSzfy4zmxZ?=
 =?us-ascii?Q?qWjcDVObKydUT8zr5dbyjnwevcUhpG6Md9h0qMOAFQ/SdlscWmchsPkyxj1P?=
 =?us-ascii?Q?2YHa0Nf/M0HSn93Qc07xT2F5PXBjY7rtxCtL0Pu4145bje56DQCiMjq1sarM?=
 =?us-ascii?Q?08xr0S4trDAPP/uktROSX07nH6YSOS9cZ/FcG4QzpDK12zxN3q94DCEBJhNL?=
 =?us-ascii?Q?I5kKzlmh/sAVTMNhN0XwRYdAZof2he1m6LES5DzbjiPsJ0YWK37IwXJf6mjz?=
 =?us-ascii?Q?TLWOqyjAJXpEeL8wAPfh34svTJYuRKfoCN10IOMH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281f7697-8763-4b34-4260-08dbda946366
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:26.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVNSbhRX6eaFyP8UhYmHK90AgX7OfW2AgMdfLreGa/lLdjgcXoPJ5E8s89wNPeJJvaKynTAfFgRs6ctiLqyd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four functions: _init, _start, _kill and _remove.
Define them in mptcp_lib.sh and use these new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 995280882428..ac7cee3f4dac 100755
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
+	mptcp_lib_evts_start "${ns1}" "${ns2}"
 }
 
 reset_with_tcp_filter()
@@ -635,12 +625,6 @@ wait_mpj()
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
@@ -2882,9 +2866,9 @@ add_addr_ports_tests()
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
@@ -3257,10 +3241,10 @@ fail_tests()
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
@@ -3270,11 +3254,11 @@ userspace_pm_add_addr()
 # $1: ns ; $2: id
 userspace_pm_rm_addr()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local tk
 	local cnt
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	cnt=$(rm_addr_count ${1})
@@ -3285,10 +3269,10 @@ userspace_pm_rm_addr()
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
@@ -3301,13 +3285,13 @@ userspace_pm_add_sf()
 # $1: ns ; $2: addr $3: event type
 userspace_pm_rm_sf()
 {
-	local evts=$evts_ns1
+	local evts=$server_evts
 	local t=${3:-1}
 	local ip=4
 	local tk da dp sp
 	local cnt
 
-	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	[ "$1" == "$ns2" ] && evts=$client_evts
 	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
@@ -3415,7 +3399,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3437,7 +3421,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3456,7 +3440,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3480,7 +3464,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3506,7 +3490,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..980ef3dbb6ab 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -299,3 +299,66 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+server_evts=""
+client_evts=""
+server_evts_pid=0
+client_evts_pid=0
+
+# server_evts(_pid) and client_evts(_pid) are needed
+# by mptcp_lib_evts_init, _start, _kill and _remove.
+mptcp_lib_evts_init() {
+	: "${server_evts?}"
+	: "${client_evts?}"
+
+	if [ -z "${server_evts}" ]; then
+		server_evts=$(mktemp)
+	fi
+	if [ -z "${client_evts}" ]; then
+		client_evts=$(mktemp)
+	fi
+}
+
+# $1 ns1, $2 ns2
+mptcp_lib_evts_start() {
+	: "${server_evts:?}"
+	: "${client_evts:?}"
+	: "${server_evts_pid:?}"
+	: "${client_evts_pid:?}"
+
+	local ns_1="${1}"
+	local ns_2="${2}"
+
+	:>"$server_evts"
+	:>"$client_evts"
+
+	if [ "${server_evts_pid}" -ne 0 ]; then
+		mptcp_lib_kill_wait "${server_evts_pid}"
+	fi
+	ip netns exec "${ns_1}" ./pm_nl_ctl events >> "${server_evts}" 2>&1 &
+	server_evts_pid=$!
+
+	if [ "${client_evts_pid}" -ne 0 ]; then
+		mptcp_lib_kill_wait "${client_evts_pid}"
+	fi
+	ip netns exec "${ns_2}" ./pm_nl_ctl events >> "${client_evts}" 2>&1 &
+	client_evts_pid=$!
+}
+
+mptcp_lib_evts_kill() {
+	: "${server_evts_pid:?}"
+	: "${client_evts_pid:?}"
+
+	mptcp_lib_kill_wait "${server_evts_pid}"
+	mptcp_lib_kill_wait "${client_evts_pid}"
+
+	server_evts_pid=0
+	client_evts_pid=0
+}
+
+mptcp_lib_evts_remove() {
+	: "${server_evts:?}"
+	: "${client_evts:?}"
+
+	rm -rf "${server_evts}" "${client_evts}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f9156f544ebf..bba42f165340 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -34,10 +34,6 @@ AF_INET=2
 AF_INET6=10
 
 file=""
-server_evts=""
-client_evts=""
-server_evts_pid=0
-client_evts_pid=0
 client4_pid=0
 server4_pid=0
 client6_pid=0
@@ -116,18 +112,19 @@ cleanup()
 
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
@@ -186,24 +183,8 @@ make_connection()
 
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
+	mptcp_lib_evts_start "${ns1}" "${ns2}"
 	sleep 0.5
 
 	# Run the server
-- 
2.35.3

