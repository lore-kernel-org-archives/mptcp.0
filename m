Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8D2CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TU1dB2JS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpGWUZG7FD+qaPF+37oUA0aPbuPKJg2TGyTa692MbqVa/D9S/xFXec2oqhk1fN7NtP6Yj2j5b8P9fSTD1hC94faUpJsvgd114CkQMjILxKVros+MFfOljnt4IqaAQRx58jEiINdE/buQbYtJVTB/fTmWd32BqvUCmS3a7oz+M0H8+uYGQ94nw83tsfL0CdODSHnn9wY6eEA4UfcQ4HoLBx8dJU+ofF2RwWJReKwLUFssclqsIpZ32BnKP6CGRnt5m+BBwGvoUWM3H2+vjenM4cIyVawQaEwJWq8Swpg0QoLO7LjNzRyY9tHorM3rJJfzqJy9+s2GhAD2Vd9T8XpUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM4RxoPJZwDGutbcG61F6Se288v8pVVi6psQOSacEc4=;
 b=BlGKjEx7zke3Xe3IFn3WAwvNvXkcaaQcvf1V9Crl3A9F8cjPRGIaZtt6cT4+EDo+u1SEbGsdqAM02ODwM4T4J9eL5PoURnXmDqWAhaVNntyiZiVVJLbMmrZwxXybf45dQnWrd07kw/PLocayIhwnoAMjd9j77x7+LnLL/ZsnnAr2A0vjWh5tedheKn2RgdF4Y6b1sHXkDDyMu6SjK0qygIA2UdZCD2hDufzRDdS3d9tuRX8QlBbkFy2BrzDhro8tpkqBlfgzCMGDIWzPrN+8bbXS2dp6NiukBzblpfHeT9oBWAUCWN/dBWrbCYc+mJb9lsfpTQx8TBTSp5eZx8Ui0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM4RxoPJZwDGutbcG61F6Se288v8pVVi6psQOSacEc4=;
 b=TU1dB2JSMLE5dmGyOaRHhgOLrIeJotjw/jKSk2ut30ByPhQ3MhjzE2k7ZD20YbJUeNhqeuFKGw+/HTeDqOPG4MtilU/7lh5ylzOkYYpMGYg7fxoVLTHi04w5HxqOZ+F4x5xbsn0jjYc4bftSbiirSve65jKo1SZQC6oZDGmUSTLvrHF/N5eJ29oAkxo5yGkpi4uLMya0rqZyQtoQhk3O1fbOm8rnXpuifAzy4GUIXAn9qNIz7D1+cITB8Fuj1EwQUHwmWjfAYlTfndQ5w15nDu8IKs8eaBiHfFyLuv5VD/uOlXY3b7bYEPu6GU6Jqr/wcDB/BjCxqcTElFgtEtObBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 09/22] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Wed,  8 Nov 2023 14:49:39 +0800
Message-Id: <6d8e284e61c212f14e9aa216ad3eeaf81abd56e2.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d0efa5-9cb5-4af1-0ae2-08dbe02709f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SJV58FF1FQZvE8gKo1s88pLOft40/cAZ4OPYU9xtAva4JTPtk2t2AzmeTIx80M+Z92XA9yCfpG5io/1we+zWtAWzb/QGsWxI2LsCeje3b0mGVtuEzb0+WDCVWl69sJkjszhvVU944c/W6qEIFTvhaLKgLKRJ1NIUrDLenPSoOV9Q6k5v8g4R24ahK2WGGKmoqBAlDJfUYL/KUXIYHaqaRp5Y4cE/nl52Bdk7xig6h8W1Wnbw/Hmlw/+7VwHE409pRppkeiTxvbo7nZM33L2GwlYD9Vo/N9FDoZAsJ9jQPUe+OFp5S4gX8Bre43d58QG19JUsFfTO0yoWwgLycU0MHi+tY32cDRfbiikKix9s7sA6hVzk/3/F1xuAMUul3nxy3Uo7BIp93+G0B0MMrPyYLZtWfNEZaG8nlKUpJ/iSMXBLLOlfyXFQ+x64ixYpz/ekF8KSI9axYqSqhCXKI3sG8OYAK7yUfKhbZubONTNBv7S8nnAIRkjFWuZ04yKubwPYPNXRdG6NJF9k/3MLk7bHNO07t4TjS8xh9sUv6S+Fp9ZZnslevnjn3nYmx7UCLkTHU5n22Uyupjp09REcEnWczA9EyVkT8an7OgC52OzvufU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/LmKHq1SICIFjxC9NCqFqql/fml8Smb2ph+1RvazvHzoWlqJfYCAv1HF8k0?=
 =?us-ascii?Q?nqQ2Mk+lluRYdnQQEJS0W/YitEy0MrJnVKVFePw/WJprl/EfaGgg2tnEdmwc?=
 =?us-ascii?Q?NrSx+UernKxc9gwOHgunFUkxhL6ftHcAq/iEUFrqJjQvumobzyEJZizhS0sD?=
 =?us-ascii?Q?0XtNF9TeZ7OyhrVdkH1NO8J8IhjBp1Wb/Iy9SMvfgckVdg8ISw6JGtHBMGKo?=
 =?us-ascii?Q?8E/fpNRQHP/NpkRv50kKrSWcpRVhuQ1yedUeC2pSZdTgdyoqa1bPfl5ACoi7?=
 =?us-ascii?Q?zf/NKnT+OEXOQhpLaASNXTUvQQopCvQXJt8t6ZgFEW0iTRqt6lHiQSlVHbrX?=
 =?us-ascii?Q?O530cCRE0FSK18tS5VK/an9isflPYwSmRfXz1CP/HkMxNRvN637UzYTeyGBH?=
 =?us-ascii?Q?MTXv6qoRr4Q0bc5M4TmmrtC0NGvSfInp/gzpJh2mh1ax9aw3BUCbG11NdDBa?=
 =?us-ascii?Q?VS9kV3w5hSbCIKB1q3CeEbg1aqBOa5ngZhPy7QfofkRa4OWWLgK8BU5DBTOM?=
 =?us-ascii?Q?OzSXIkvdCw1cWk8TpbmGVTVvvzv7p6nlAIx+n7jyYwcZrM/WalwhoqimunXv?=
 =?us-ascii?Q?goPuivyCzx5sldSAa4tOWWYKdyYaa0nQRlEzfY6LF7NSDzGlQLmF1dTXtLOT?=
 =?us-ascii?Q?APBd55X0lWASChQmEUmgrLvcH1kKORNEM8dDFkcoBUDTriaHQP2sPh5ohEXD?=
 =?us-ascii?Q?AILsUxv1A9DKH/6EPLWCdo0KwFmj2kypGTSypICuJM7gu5KISXH0BnJqVXPq?=
 =?us-ascii?Q?gPPiZh1NKY2oRr8BCD8nVxWsxQqdquqz1rc22mfoPbabbUYKpd6jN5XZgnxc?=
 =?us-ascii?Q?JIs/ThSZk4/lWtvvc1K0aybowqdy++acLXfuxG0/Ah4h3TtKAAtu+mFYngNq?=
 =?us-ascii?Q?9c8qR8lBg71QHrnAgib0HJ3HfmdknTOItvKGZ1UWHHJDCylLYaBWzoRyYZXc?=
 =?us-ascii?Q?i8G0W1xZIiVvCGutV4z17s1dKkaCNTvfyuu/EPoP1+bE7zLKPVV1eTiwZuZF?=
 =?us-ascii?Q?GS9NI+ZEms/NwvGwUvJCHp23OpuQ4juXYvbrTwRBm7uOCGxsvvBuVR3TRRc6?=
 =?us-ascii?Q?TVQxfwPrOFP072O6PrzJyby8QAU+iHCmLEEWMQB23WkZOg4b7Gvkfufa40ih?=
 =?us-ascii?Q?PUTuP1vnOa/r1fmjDTvi/lsTYt6GgI0twQNnyrwpgv9eOysJkgY8eFNWVnI9?=
 =?us-ascii?Q?SbgKBeNlidbHLqrOheezCP8WwXhmietA8VJjxHJ66ibWPGcSa/7bZOonkkVb?=
 =?us-ascii?Q?QwJ5G8FvAr9q7lNGk8bj5bO3S14+r4j5hDH52CmiNh5RRcLF/Ds9ImV86pEa?=
 =?us-ascii?Q?dFJBbmDL+knqIoLtgzZ6IxaMEKHKFAnfOinCoNPREolvoRe0gJ0lkshmS4lj?=
 =?us-ascii?Q?dBH/huHPGVrrkYTdMbOqFODYXi0UtxdOl+pU0Zi6Q2U58l3a1ZDZ1rxEeIBs?=
 =?us-ascii?Q?+V8Z2Q0LhL8LXNZxxe1YOLKi5k7JEVRMB85/JW8l2qwFjredHwbcXAFypst1?=
 =?us-ascii?Q?jIDogjM1Pfndy1OgZvfe4KF3iOKASmy77Zz+N0LA4Urj+pCZNf/q9yuV7ej+?=
 =?us-ascii?Q?Q/iw3rfqLCpdw5OgB8Jd0RqH/s5eV12a9gJG8vRw7KGILcYSJCJKpoLc24Dy?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d0efa5-9cb5-4af1-0ae2-08dbe02709f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:48.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rcf6XJUduouhn7jhDm7EMhrrBxUYzC7InbOZddqxGrfqPCZ6Kj6Rt3Sd9oASWeErGfbC/O/ut31aVvDedCXVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

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
index 6167837f48e1..f1dbd97c0c96 100755
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

