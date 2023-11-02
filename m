Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639C125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OXipim0T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmG3rxz5RFg8NxniOCGEVoSKHvTUt6LEwqZ1T3AQV5bE2uI3oAUR5OUkkwMqI/sAB8gc+7i4DYJV0qMwSsiMPeAkEEKlOmHJWtxOb+m1a8Xw72qMdtZZ+jJjwtJhWoPEIJDFpi3BOg14BeLauW2ZWu6NRk5BlrBxL1qXTqvySGzSCOg28+U5Csz9XPEFnRvVu9Los7J3Mql1ijbxMwzZm+MVqc8NjCxslzgLpNNmhDpJJOMZNIOjmUJ8YIdpUQ2kmGCoB7JzMk8xYRkLXBNJBcAer83cMGezYVzeXwYmo7cdGJwKmwRKrq1NV7jSJB7BsGH0rNKXWtzW9z4JRhKjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvHcIxIcRGiOLidmOyvXlNEl2Deemm/peUkXOGwGy6Q=;
 b=deKoMCOY7cwmVSW9lBvJd1VBat77UpwSKfuMToHDyaWjaBo1wexz4BZSda13s2kTomIHCj6Sax7G93bLq8EJlYNO2X281PVsfxt+RU6HFpEVuLBnp54ZXdmtpS1beKAAzxjDmKh0Zk7yp+C9rNkliVGlvxH8aiWzlpMs8yc9Xh8bAoADRfOlm2wPWTqEfrbtIBDmQHWP+wqGIRpv1gZxVcsjTwC+DN1TgK+hJ7L3bHWomv90mlqnE7dQ8XiBuLNKzsZr+6p3OBSaQi4/Zato3U4n2ApUDoKAA5JgaQtVbbPTBdXo6kPTZCUPb4F40ur0wWe/IFCN5J+WB8TT2QgNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvHcIxIcRGiOLidmOyvXlNEl2Deemm/peUkXOGwGy6Q=;
 b=OXipim0TsKDAF6YkkcbGQ8Hc9mft2j/VewZMuVTbGXmyAmF/NrYN9M/yuqTVbEx20i0N5N13I7YjUCT4vKB3yjD+d5C5z4ippF/b21Fd0+tcyI97ID5O6lhV0WNVzzjaP9nn+QzphypWsY8uJpAn2AcVSXRs2ZDYM+/83YZfWvJcJQcfJMXHWVArCIz8JDZNZ/4c2SaPdoUBQvbs2MyaXCqQryDYMFMBPuuJ1dUBBzkRjrAn3PO/HTe3Z+3VVLUNvE5dZn0w9l2JP7MDhkZk6Kmy+H1KQUqln9BR7kcxfOS/XdeUMdBsHXjTQKgUvzoilhGM+gT3j88/7zHEbbG49A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:05:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:05:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/6] selftests: mptcp: add mptcp_lib_evts_*
Date: Thu,  2 Nov 2023 18:05:52 +0800
Message-Id: <190102421750b74d7209b7ba61b495578f5e11c0.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698919435.git.geliang.tang@suse.com>
References: <cover.1698919435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: da5935e4-7585-4ffa-5582-08dbdb8b4ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	awSonXg1EjmaDGXYvF9D35sGkcNDbcT1PYW5khvU0KcyFzb+npkFPHjAnVcovs66WaDagQgYklPR+uCb+kJCrNVxAmmZ0ma6rNLLt4ud68h/Mk19BjcJkUG6t0tFvxO5CDBZ30U/YmYJTRWYWaXQG32H+D7ABUMS0g8cU46HyCxQDd9TftXfOnN3z+wwKvs9w6EvHyIBWzmCpbLj/DfKO0iEFAW4vvauemtQxhaNlIJuYOfqYJkESkdFClcsvJSj8fRIITBySPNK1F1LSMHQXlAHoPTqmFmF8xh7xljM4aSmONq1Mbe7o54UQarZGv/frVIkAMmZTpjFUqA443veYUJevwcGwVuqQdkfAa7juUWwVzgwcCJNltwoN6VQ/rQsdxYNtFqq6oF3vAAjMRBxQI4K0eM2cKTn0NloqEe02bXjLXsHzOIcpgFRpz/FX25mH1eZeNYEfmXgFHLxOYM5C07Yr3ziZvgS/UYtnT99QRT4L0HAR/nkf0wy51NpxglxuFwXbVff49cmnStBLrTlmtgHJrarPkUEyz7jQd4bNIx7mIWxFf1AjkYuDZXenscYxEraoTlx0Tz0UE7CjhHrACvVVCw8QKiizmfgOwidRMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(36756003)(107886003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/BCnC7NUQRpS/Jazs4kxQ/BcsHKiQOTUQAM/U9LCzahsjtPodXuwULJOlcx?=
 =?us-ascii?Q?2m/xD0CezikLq9KDBnlB4nIFm+mhs0aYMIphm1UbihH0M/2vYDR2GXp3o1A9?=
 =?us-ascii?Q?nMv9hTCPGX4v4QKBiCjtLgNq7/49UZTwv3W2Wg39BpQilqHjIw6VcD4hPp4n?=
 =?us-ascii?Q?LxFWVWIopc8SanrokgnVHJ+j/22tMOUqnZw6GTtYVOV1Dqt/X0xKClLflAFx?=
 =?us-ascii?Q?+xpu9aeTxnZeU8besShZIYKDC4dXjMBVrJLGZFyIRUHg6F5AVuPQTn1EtnYL?=
 =?us-ascii?Q?LkmlUGrfA+q/zDdIu2IV5sp4DgTUSH+2FvDFy8P+FpQkngAxZVynPpNbZ5xp?=
 =?us-ascii?Q?Efz/cLu2j30HxWXwakq0ZKvLkdTu4upT20Cx3ScbeZD3m7QT3pudvRDNdQER?=
 =?us-ascii?Q?j5gkx1sl9lv9/VmRJd11fYfh/GFXRTjbfopxDsfb3nDau2HQRoPWakJ0/S7n?=
 =?us-ascii?Q?aRegFtBVIFKcvv/C8BxNPW6p0VFVDPgHt5JceGSiKTkfxAUWntTIP2A9dI5I?=
 =?us-ascii?Q?xClbXbb9vnLmuiTYM1vAMQ7aRTSb2EXKjJ0GiYT9ZWf/M//xqYfupvRv2rxd?=
 =?us-ascii?Q?nWJOWInW1wBs+x7x2F/2u2eIN/CgBy3NxLdGG1eZ/HLG5dIGsw+yZDbTsWxo?=
 =?us-ascii?Q?5Zd6pd6YWrTYzD8yFU2opdlkVbP20GH/SWUnjHwgtXWuGyZ01mQILxVO6p1D?=
 =?us-ascii?Q?YbQrzFVwvdyUtWLUfoRw9vJaymaCEhXmVPTXkDsZlRaw2uHlOW9OFDCIBKBJ?=
 =?us-ascii?Q?PRMhHQVLn5/bw+Fpk1AqGF5gIvLdYZfMLw7wVob8z4RRoMGR85CJxItyD9DH?=
 =?us-ascii?Q?mS97zJHxxb5TcrbQGbqBWPY7GKainq4mxvkH9+ULLWrOMRkdj6gTmgw8KAsa?=
 =?us-ascii?Q?aQX/6jUvMYwsiHSY0oHcApdOKQ3xFUOiCZBr0zC6UlcHhXjBOlDxyLlbxLpq?=
 =?us-ascii?Q?s5OKYuarGq2jTdESirdJm6EaPDt52brrfNUkGqOv/5tCAYeD9/eBbQsDaYhM?=
 =?us-ascii?Q?7qgXd3bqrkCvPgPOJ0n+d5AucRLVKgie/kbS0XDiUXhDERJN9z2BJapihtP7?=
 =?us-ascii?Q?eFXJPEfevWvUzinmQ2raK1kGZ5C2IRU5KsmIgNEiVsKsnVmdlhDXau2u69I4?=
 =?us-ascii?Q?e55ph6bqDg37m6vBeTU5+2pA4IVUVSWHpmEWrTEqcTWWXBfXELrnSngaifGe?=
 =?us-ascii?Q?Ta+HpnubOW7+6yHAM4JZlG2BLo+TBuaFzf9JEkMDycZqwVKtno6xzq/RRX3F?=
 =?us-ascii?Q?SW7RqwnJGcMUN+3WU0BCv9pXM8+LqoEsatT6yA6EF9Jxx2CRk+zu3+fLy8gX?=
 =?us-ascii?Q?oxwJz/VgDKJaN6VpEYHOEDJqN7HsvwTsAjQQLKqHlqiYY4Cnil+bm6v538Vs?=
 =?us-ascii?Q?wN7yNwV6j7Vw9dpZWCbKeG8hZY4B79yjBGK3BHSauXqTtJcnIVTa1N2wGfB6?=
 =?us-ascii?Q?DmLlOq2C5lE7CLL+bjuVxOOiBu2dZZj1LKbMK7Yh3+UXc+nmh1mATr2tqjkP?=
 =?us-ascii?Q?38TxQnchqseYGWwjZLpSKwOJ6pOyO4iVfQNigpsDglP9ClqPuQpsfVnScIrc?=
 =?us-ascii?Q?+U6c0LinDH4ARuTCNuGJME7aBf4Gyr8bNfur12ri9GdgxABvyRM9745tUfbN?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5935e4-7585-4ffa-5582-08dbdb8b4ee5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:05:57.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ88obFjCu/paHpVYaSsfoc7r/UZRmV9bzo8q6840BgtOLS23jjYNmJHOIcUu/G7JrFsX0zNlsCwESZWBP0CvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

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
index a14381c94c56..040a4d1bfb53 100755
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
 
@@ -3458,7 +3442,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3482,7 +3466,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3508,7 +3492,7 @@ userspace_tests()
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

