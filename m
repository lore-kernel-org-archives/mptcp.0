Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6381FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cC4oVDjQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdfk3NmzBCPGkB2xiwSE/N1Wv4/cs/gf5sem8Dq7lVV9erozEou3sQ4OGN0Lo3kBPi3kjDyRoe3v4q0QGazBFJzX9g9F6w1g62zJJogCNizxKNe9TQym3Y4BDXeCCVMAgvz+o5T2PyjE4wQsDz2qmR1i5YunWo4xX8z6cUjJMFD66i9LQXrbVdDPv6udFFT3MDah0PKeXGO6D9Hj/dyqKMmbQYjgqrEsW3tyxXHBnwUwIhKMRD5IRG/X943CKaiZvu8gVLrgtCIjwC8XRhb34vfF2GQtyhGU54gZ+UVeQIhaZVVG+qaUsAt5DB6veq5Lkf8zY97hb7EPJQU2uggnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=het2OpWae9y6PQCdHYnxbQyEIAv0zHd/iHwj89WwJ+M=;
 b=KyOcOJrO/OJj1LwuA65nL9Kq3rYhjviUv/7otMHxddXRohhod7VzZ7vKiOAWmm/kPRJc+/AH/D/mm5eXAHOqukjc/T6tXSw/z0L+6QsQTND/znq954SB6qfaBdPc7TkCkLB/A9eZgxv5apigfl8FpWcVXK9QVRBFB1nPm3ckpKavFmm0vf2lUgsEN3UBBvLDddoTNpmR5OFY/09B5dombUqpfftMyGhYWyoIzBLqbq1VUXQgDuXgI8IwDm6paQS/BUK02xPazUyAXxODxsqcIRZRNXwff156BBoylS4gYLYJfnAbn21UPhExZe9XbKHCE1bMlSBvGfucKdaus5BTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=het2OpWae9y6PQCdHYnxbQyEIAv0zHd/iHwj89WwJ+M=;
 b=cC4oVDjQtMGSBu7xRAq6qPyMwGkjSThscpfpQ5/Iu4EnJaurAAr6mrdws+iEpMcCobo+GESWpUxmGUc5jFtj4lTGLnFOo/frPmx+e9CVi53XuC4xXJfAetECdRgO+oyNuvy4x7HXK2qWKs3fLvuEul+1qKKa7YaF+7FSwg+comEEWRHcZzZPAKBFN9X1p4ZdSZk+bW5YHXalq8fkA4NHGqEC7tOhwOqQBU/J9PEo2bT6bQofFUYH55GbxK911ytwPqbLp5npLZZ0PE+cFJvoMgPcjX0EGZOmOaJNSZJClvwrLhDqOjsYcPubc4r2JGGPzrslRHtXCHytvDn5/bV0BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:03:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 11/21] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Tue,  7 Nov 2023 14:01:55 +0800
Message-Id: <7a469442b9bd7df748f29d6b9a6a8747544202bc.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: fd48e6cf-b78e-4987-3c5c-08dbdf573c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fEdsrV23yTpLiH29QGcgqtoXEUjHvsHkkiPg1hXvrBNiX9CdcNBkzScaOsC7ybtWPFyY75eQ9Z5QY1IMRFhK2R6ptboYkmswilXUbfzm4FQ+0L+/dV4wXx8WsSEJlKFD7gxDhoAFH8mmA9PbaZFVDcdAyjKHNcI6qA8pDtghPXhlDLgG5nIQ1RBc34e9PRvv2djTr1Y00wCG1Sa4MnetUUhb6o4cW3YEpueUv2nlvCZohCA4vi204A57bJkp0ckBBAmhxTXfxszDMy1Xz7mQtFqMRIr7dgCnHvI73zxZlGFV5pLNdPjmDCCo6x1FthokT3Ed0XcQtWbaLGwIrMsUgjdHLcpRmo57FkYjBJxmcnJfrXtliOlOP3CcMUrZta5LuH6lVJH8Krzif1LD6R9GkIBzj5AvBTrQi9+NOLYDUBjW96zXjdzzIWbLHmHEaDUO3xG3lD5BhOG85srdhueIaCycDlSCx5lK+PQCrC8QLZ65B70Pmmw5ViCWA0fkXknpr/iWEBulrD9YIA02Sgy2jIwQJxwkyooqG/lpeLXlsxbLIYN5RTnfyw3jhgU8ejLi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TmQaqTfxYyn6SYqHKY3m67I0p8hFj/0nFreEVyWZkRnT4KnoWg5xrLxmWQj4?=
 =?us-ascii?Q?w8yttJqfXX0xH5ek7yGDB5IUzi/B668tEhUVyJKpf0VyDFM/3YsVDqPhyaAL?=
 =?us-ascii?Q?J2zwNGKuRaqvsHKYtrHKV2sYaBeXsAbPH/QckO/yTxcmDAQ+0XKHYA34TUmb?=
 =?us-ascii?Q?gtKufy0kNklf0bYhqlhuhvEzKcf8OPVUNXq9xq1dl76Ct9kHnDbgAeIxbOtV?=
 =?us-ascii?Q?LunQ6s04QC+qQQHeJYtac8lPupENyttc1BwybxUVyS4rGi1qeTHxPSoY0WiM?=
 =?us-ascii?Q?mBMI0bjgI+H6S3gk+ixBp6BMrCoJCvj4Ph/4jPjZgb4EHbbUkjnfMeMfNz4b?=
 =?us-ascii?Q?KR4BB85SQubcI9Xm1ApRQKKs3Upf9zbYkjx26yal6wH2olZscg6H7f7Vcvyd?=
 =?us-ascii?Q?NEy1Gxxn+4eZhTe28YGBb057TRWh1DPOqghQPEhFALGN1ApzTtQjOgI6LZxq?=
 =?us-ascii?Q?eG3ekVMU1MGWwOeWA+1q0/hyTxBcA/CoyBXI801oZnxdIi9iRmhDw3PF0DrQ?=
 =?us-ascii?Q?UdhF5kJ/r3tvoW2LdUN1ujLAlWM9l7WMRkLkjdHp4pC+MuKHFRP8jqBUgiTM?=
 =?us-ascii?Q?Nbtk+FIY/OaA+VUqcJ4WKSyzU8gnycQK0Nk7A0nP+xzXZH0XUf975B87tMfo?=
 =?us-ascii?Q?HOG67tynPeJuX+ShXXRmCmYadAJgNq2o129pE9MVsiUmTtZZtSFb+4BjDqtB?=
 =?us-ascii?Q?NlW4NfTjCTS0yb808n6yTNihqagIDQM/ZAlTwwZTktVozdr4s1T3UtBgDg70?=
 =?us-ascii?Q?rnzKagG3D6wp+I1M3NqhFN8dI1OWDsittAYixix8sUnhwaAd5RqKKRGptwGV?=
 =?us-ascii?Q?vPSNxBfenNGHYlAJShMVjxPkyH5/Xu1N9qwVyIMUO9qeSmKqLAx1VcSg+6Ki?=
 =?us-ascii?Q?jdJDF7JETODt5HiInj10MNGX3knkVFDnxiyEiD5g+G5TUTxz8lXoTrnLLOQy?=
 =?us-ascii?Q?kDFv4hR+Roqht6hK5LXita8Z6eBggl6Of5Wmq/zcQf0XA73HDiwIYif/ctB2?=
 =?us-ascii?Q?ws8hHHYmXItzfq/3SldtUj0T9JMTXF4BWUqmQkuaDKCPCm+Ttvx4HW7qQ+Q0?=
 =?us-ascii?Q?YqE9iKznPhsDmO8aH64jfhtBb6+tOL+ykg5x5HAk+EenKWWdZTpJ8PdKuuVh?=
 =?us-ascii?Q?mwfgshSoppv8Dv1Q5APWm5FORA3t3/upBDBtvwN8qzSZ1KdpCjGA1IH3jham?=
 =?us-ascii?Q?VatBykDG0D5BvqKkMNS5auqtGrTXkMWhIY99VqmxIQARa5DlI+MaKvBeGXyp?=
 =?us-ascii?Q?1rjiI0GyIFLwYowtNP6KCiRNHuqvAobVBJpTdDxIgWRjKK3Qb7cN1PUQ0Ts1?=
 =?us-ascii?Q?AdNtoFiGoobfsKD0/4AU9IEmVkJS77/PapLd2QC5kcH1kaRXBTb/c7TW8AAU?=
 =?us-ascii?Q?YJPuIvIzH4afapqOqlfEbOFgXc4f4Le7hNtW26eEbQZrlpylYLkgWwsKS6PB?=
 =?us-ascii?Q?zJhEC1593m08mJ7grciTOC5l3hkoLWI+UHd1WaF5ZP7X8t9/zJk9NbKkLMIQ?=
 =?us-ascii?Q?01n/ZDhK4pU+rKBbjDaRfb24d7qGDpHmSV6JqYL637q2seODCewfHi8tIEkY?=
 =?us-ascii?Q?KEogVT2IM85EXu6w0O2+SzqoK/ka72YR+rcgc661?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd48e6cf-b78e-4987-3c5c-08dbdf573c81
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:17.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VraDRCsAq0u2RESPKsF9DEB/Xew3Ip3IK8HjRkuOB3oXx1uWKlJXmBw8kZWUp7dtK6lGINDdjuRj2zm78tcLuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into four helpers: mptcp_lib_evts_init, _start, _kill
and _remove. Define them in mptcp_lib.sh and use these new helpers in
both scripts.

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
index 1f8be9dd0e20..d45d39356d41 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -265,6 +265,69 @@ mptcp_lib_print_file_err()
 	tail -c 27 "${1}"
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
 # $1: input file ; $2: output file ; $3: what kind of file
 mptcp_lib_check_transfer() {
 	local in="${1}"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 8d95ea94c019..34344c481046 100755
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

