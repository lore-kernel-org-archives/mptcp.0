Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88A612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5oWKnYqt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZzcKIuToVArVRLgUT0etAqK/2NtJj4+SILEPuEwmM++hWgzMgb9HqnL23Og0TMExi+592fu9olyRN5bqpddOv3CTFhzSBlbNNdfva47MQkur82fYI5gRnhm5Gq6nUnpLILyipKN5BTEaGUgPtzfaNxoyyNbj7DvcTnO0w0lR26vDL0wePOtUPkAoBbsO2qMgxOZAh0TnsCmEDU4sYm5MgDxDvEoB1mBZBzFlnnTJZ3hhFPUPMXlYHZq8pJJbr+SWFiUN8Zisz1tBkBNiPUWfi69hJwcYHGSbnjIC2WhZyiFuoYUadC6847Ajwsa87f9RpiO2Bng1skjdGBUvTgtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZOiNOxf8gKs8PpVb5ZNltwtTx/my4/f6Ehn03Ca4Qk=;
 b=R9mKhE/Vwxm6dXRRDBWPiUabAuNC/+f4sxaJZltspKCC7jMQcnSXe7lAx+us5LPjA2ppVk1ImW1W+qcG1d5H9gkJCaakXbzK+EpF438xhzs4GRoiLk6iqebjV9VY9w7zKKQUMzklGX5UOKF6pTonEuL6TxjJPkH5JVl02nGZ2OAYyoJ5mgsTQ+Eh1fKTjk2EOrLhBWVttDAEVMyLnsYnHVPh8GgoVn1pIrtafdlQ8Vs+1iuDC0cLzelKJVOucZfsvEtxXIcbJaNX54qWZUk8gfN0DdNl7r3jCFVZOXKuSSKANds13jWeU3Ue5ovMbLEoXu/VIziX6Ni1fj++PhQiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZOiNOxf8gKs8PpVb5ZNltwtTx/my4/f6Ehn03Ca4Qk=;
 b=5oWKnYqt+g7HTQynTQJUFKohhvK36lEt+Sg1qxDzJlcMLYgcbRopM7dYg9Lh7zw1ZeddPSkqFJ6QWgZHdb7aAc7AbJHEIcfX7ETENVTNxFE4LAqePB3Tbqpf5BvbjDDEzJn46RSwN2TuOy5s2SQlrTxK+8pGXqJIhGZDnIod3cX7UIZk6gZKAj7kn+Aa/nIryUpCcUKPnw85HIz1TCOSS0tL+J4pG3zPM+WNiXxuC1WGzfSKQk4oFI6/ypLhXgsJ9o/nounDFaPiGKFCIHjOHVciBQXgPMle0L/4ARW+jy4uW8Dy3cX1NZ/Ykj/b9kNSGicI/1mDAgyiF33BiVdZMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/32] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Tue, 14 Nov 2023 14:35:20 +0800
Message-Id: <96ec7a08b3d643cfd3aec8261bd3c6a8d1af75ad.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bd38c9-f2f4-453c-dd85-08dbe4dc42cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h0/TaeTleBg35Mo+heD7TEm8l5ycqtg3E1WPI6H9mYaCvBShlXxHyeTjhx0hQUW2kaHj8rRHPi5uJqaDmkBe9Byqt1IQivtaEhP45Tw3BxW6712COr7tLpbSLkSai1n+DRHTTzZ+gVYJ6PK2+GSu8v/4K4Hq3FLNgTxMIKqmhhzOQib+XELSu9VF08kRZzC70vwhR/bD2pOTpPffGCu/9GixNvyDpkD0pt+cU0HQqkuEJVk4YSvWuDfHcm/mG55LpDBWMIJkS0WFlv1ZwO0QXn3JghA/mFejwgJC3mJ1F/Vv9c4u2n7w7tLZdnumSsZ5PfifWe+0tlBUx30VGTosf4IOWQ3AFIZ6SmGRh2ZqCxvBW82pVWu7utJItaXtB0wnVekSyh4IPn3ucJ5mXLY/hvF7VIEq7n8TdDPFnM2sX171K68wdyj7Wbic4bOtBEggk2/Jbzlfkr62okl3apKC/GS1DJOygPXVck4Gv7uMoGRPOulPUku/M+SfEcOSlvKhJqyhTp6Dy3AA0LOLkp7qEkTLsYeMDysIlLuwiEgpjEUahHn2xiAFMoOnvUo2Z8lf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQMJiSeptdGJCbbNtnxrQbaR9xA2J7LLa3qRmb7cNH6szSUQ8dLQwHf/c09a?=
 =?us-ascii?Q?+OCKNVP+6QL84vw5g7niEThoflULz0uCWR9NrJT2jd7HZTtefz3LMdqEfpr6?=
 =?us-ascii?Q?lsZjzsQeVJNHKGw/iLQ6PwIslQVN8sXqZjjmZQShV5T7YYnARP8EevCME7BK?=
 =?us-ascii?Q?b8TGDhR11M55tOprBuckZx0uAXcbMvyUswKEQalnQpr6vYaf52UORwSgk7xw?=
 =?us-ascii?Q?4iGkB4NID2GtSG+xN2jU8G9J+7uUCn7FDhnK5WoP9hhSGwEizd6ob3T1gUmY?=
 =?us-ascii?Q?KeI3kTQzc7apFjU4r96mMKNjMbxhGtY5I9kG2GPQZbD23doBSyS/fGlzer5k?=
 =?us-ascii?Q?J+7QqOSUBD2J5bih4CadE3hjW333iPUPpU+zafRXlFuHZBnEPDtqMVUZ2/Yq?=
 =?us-ascii?Q?fBu88G0fFtIXkCj+hmeVTIvV0Yr1LgGTvyKlUBv522afwVYgeDq6XBrVSvwq?=
 =?us-ascii?Q?oD01Rgqv3bZboX6SwEady3w3jkl4XK2Bzia+drqfMvd4nN0RJ0if4vhiWdbq?=
 =?us-ascii?Q?t3qZWD5sYEi4R+7aYPtJ49rTl9en81UX9cqGcVqlgjOPs20Vd+OJIrCN+EGz?=
 =?us-ascii?Q?xuwGeJn7cHGMHtxU5/ZsGnSWDqo6ym/uWcBtP73rBSSULl5EzCg5aXcniq+4?=
 =?us-ascii?Q?O2uTtbJYrOWCHxkxMO+YP5JZbzoVKJxc5McAyUJryc/ZTvMoLNIgvgxB1MJb?=
 =?us-ascii?Q?UdFAmJ4XgfK1kB/jRFcp8vwrDLxp9cX2tB9NHX0es3C4NEYiuz4mdaNsawNK?=
 =?us-ascii?Q?PJ6jJ30x9l+RcnXGNrgef6cp7fW7ciTvHC2FXplijRpgI9cnxktXqM8mDkF8?=
 =?us-ascii?Q?uPVwPI+3CvDeXhK4KqzKxYOlGzb3hm0bfBTZZWOP/fqsAVEG7MrH3AQK7G7U?=
 =?us-ascii?Q?cDTsjOKQ8znWcjQY26bh62XqAC6UHrJXPjPsJkrP0BWU7Ebmc/zahZZdvDMP?=
 =?us-ascii?Q?jp/aJ9xkyfB9muFp844SJ7aQTAN8t9wWS7qB7X2xM4mqdp2unqDGV2Yh6ogd?=
 =?us-ascii?Q?amj1rlQ2/PjVeC2Hxe/lebRKZlhS5tC+VJQjHv5SOsr7O+47N2C/MpI36tEA?=
 =?us-ascii?Q?UL2P/x509+2pmueB2DM4NAzpNL+AEoKTmlXtIjRmz24AdiKHLQ6vi5GleLn1?=
 =?us-ascii?Q?znAomM3uPaxQA95/plZztuzP3CGw84DC0sgs0i78Z5/zyTcyglp6VbMAI43H?=
 =?us-ascii?Q?Cx6wkOzg8RD4vXeMF7WBNJOA9NeWsFprZI/hE9vRWkjIJn/uJvbwF2tRJFhQ?=
 =?us-ascii?Q?Z3+ouLDQk9pI4EVvQyHXWYnmTN56mZvKPkP5iNniDD8wMXXFOCLpqWOXpR47?=
 =?us-ascii?Q?gK4pd5NONMqqT+qiQXZsmwBatw9qXfmmv6oThYQME47KOOj40+iUGmfCAYo7?=
 =?us-ascii?Q?vHhfEvRk+k7+87aUH0cf2Y6cBvfHEbVCwpu/0on9k7rEjLohkZDIvNOhmbhc?=
 =?us-ascii?Q?OtFwNhw4i2R9VV93kX14kiuZ0c/Uj7oUFTSh6LdFkdVLyXahSecukHTd7v+f?=
 =?us-ascii?Q?6Y6BO4P4aB1EJjGAKgaeTd0TdL9myScDqKUQdXwLLCDYJBdBWz0vlP1yoopC?=
 =?us-ascii?Q?K/raKexvaHh60KX+dLh1A9+Dtn/+GfkdCPSnKJinqeUl7VBkyL+vySWHF3pr?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bd38c9-f2f4-453c-dd85-08dbe4dc42cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:07.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1RJ7zTWBnbKIYN+7x8Fnuu+cSroBqGW+MT5av8nD7sf6Y3wQN6Xcan0Bqngb8hWLUof29zfpxMtihyDplBKQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four helpers: mptcp_lib_evts_init(), _start(),
_kill() and _remove(). Define them in mptcp_lib.sh and use these new
helpers in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
 3 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 24a55f7622f3..42f3e49db74e 100755
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
 	mptcp_lib_cleanup
 }
@@ -461,12 +456,7 @@ reset_with_events()
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
@@ -636,12 +626,6 @@ wait_mpj()
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
@@ -2883,9 +2867,9 @@ add_addr_ports_tests()
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
@@ -3258,10 +3242,10 @@ fail_tests()
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
@@ -3271,11 +3255,11 @@ userspace_pm_add_addr()
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
@@ -3286,10 +3270,10 @@ userspace_pm_rm_addr()
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
@@ -3302,13 +3286,13 @@ userspace_pm_add_sf()
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
@@ -3423,7 +3407,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3447,7 +3431,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3470,7 +3454,7 @@ userspace_tests()
 		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
 				"" "      dump addrs"
 		chk_rm_nr 0 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3494,7 +3478,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3520,7 +3504,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 466fde97d3f4..4f741725436c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -326,6 +326,69 @@ mptcp_lib_check()
 	fi
 }
 
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
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 005251b61d7a..55ed3ea0a691 100755
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
 
 	mptcp_lib_cleanup
 	_printf "Done\n"
@@ -187,24 +184,8 @@ make_connection()
 
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

