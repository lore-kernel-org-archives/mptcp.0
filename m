Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575182595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EfDIz/HE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSyxyjnRxHul90/Nd81D/NJw1FCXgj/BWVU1F05B5ycKZ0vddopSRpfXkvjqvdYdYt4DA8AgX6LKZkhokFkyKGYs84qvF4jWaQheqBW0oZGJg3JUyXLhQhOuesHsN17heWj+egGmdNiz3rNrUSfSoQiya6xbCUgNNfF/Pi7H+6e2i0fm5yASI8L07vSrDB2w/1GHXjG/bCbt7LEaMvQ5WbW31r4C/VypK8itQjSgo/2PTW217+9ZBpSjKBPRlrMzNMYFrIhpIzhu9m2U+tnMu0Az1k3BzBm9Q1vFi/kZNWQE9IV76brqpbZNrqLDT+JjR0Bybatr5O6q0hdgTs/xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht25oHskR9wkwtkU0ogjZnvAMlFJESvR/VyZMSTaQCI=;
 b=hfd5nhqO2KeGcJnHNpQQ5saYRZnSMwprw74Lfnfv4J8FV7vcY3eQVv26l7YXwq+fAtY4YYZSM3KtAhvYS2w3UjZOVq/salFgOXTC2NpkmvokJoAsI2efcO4Dkt4h+i1dlDIRO+5dWD0dkB7YAT1bwDKmRsBhIzK6sINXOOfp06xqy5hYarYCA+Q6piTHWPNkfDnm1FV1wgeKvb/8c+WvLdcGCu6uaOIUTzM2keZhzO2ytiihRcMGlU24K4TdTIUBkA0wkUPUMUe6VowFE2jBRn96gAMDWJaVLKAxxb0KQAmbjtg/+crMCCUtKeUsSl+4MYlRMIeY62jykEZfK5z6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht25oHskR9wkwtkU0ogjZnvAMlFJESvR/VyZMSTaQCI=;
 b=EfDIz/HESKmhzPBr4bwhuHabARev0xDDTgb6L87MAa5hIvM+z3erKNjABBPXaNAOLy+TKuaTQFHS9ce07EPTgwMLlAiPuxhoNhJerlqGvAgs5s42/RxHgZMvcjt9Z2EdwSR4ErD4wSEQ4NpNQJhuUKyGTv0rMaFI7f9DIq8yFvnNgyYadwbKXDfTDxMTYlh1y3LOl9hnClUozR2o9yDVfqKyE2IhMXP5U3px7u/3wvnGr7oDFl40ji1GAktsQBoFcdfSodRcTdy5lYujsNo/MbVeEZiqQjagl+5BYqEh04yqwu5S8kiWgvh5LkCe3Ff0pcmfHtw0oyYZzNe5iO2PlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 11/20] selftests: mptcp: add mptcp_lib_evts_* helpers
Date: Tue,  7 Nov 2023 16:14:17 +0800
Message-Id: <0a4a775eacedfa0b489f0d7c40acfacf5c3461b2.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca83590-e599-4d69-47f5-08dbdf69b807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Akp2r+huOTvfFZ20pQVAshN+NZRXvHvCAWpnO5/R6q3khI3w7VTw5sKDN/gKJyw0kq43Dd1UETwZCPMFb2OgY9XyKa0vTfcEQzE1TNA0wc6C2uEjHpTK7keQ0QcGNrNSF0IR1O4hYoFnPK0KoSDiufgM7VlmViYnn2gLxnofedDY3jSlyFHjnAes7allCquOpXcfr09EgixAmnkeNreXmu4gldxUOAKV4zKwd1qvmTPB26gbLnaMd3T4pKiVvdQKgLVSnujKA+vd1/+vfg1XwtWkMPu3l6kP97VsYA/+3Dr2j0mKJ8Ibx2+2kbwNMXtZNZ7zkdqCYaqnOLuHhQ/h6EvuXSItYxydHtfj93WHYVJJskfJnaVwF/sW1rf21CmDqXeGxedjjwzF/G6HYlYXQ5EorrpLIhKfKmx4kHGEwnmC24rUyc7yEfJKTq4scMtUcuP7FeE+IUWh+esMSr/dscwXDSnsX5mcJ/jCfIra82S89VLbd1CsGKlkirug5xg9T/TDZoNYsc9rWszqVR+Zgvd9/5zMFAav3GtCkZMvS9lYWxc+pIk+sGF9gVB7bblU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8xORua1scpE1B9/GfNzhE7aGOJFdNd7V7h0wr418fz0iIdre9cj/kc87mdNR?=
 =?us-ascii?Q?OuH9ZOwAEkehV1Tuz03xtQss5YyGDzpFNFFzErBLSII0P7c30rce7nzQoc4e?=
 =?us-ascii?Q?zhHY2R2xyQ61vK7mt3QpVYN61q5jR63S6kKkdvoHgKGIt1t+gxSwd32B2pgz?=
 =?us-ascii?Q?iOSsjARkxrbnfuNHZBbiBPSRAQJ9S/X5vnubSJrC5BvvnxwhbPnyq5+bQPD0?=
 =?us-ascii?Q?r/3PydPZno3yXWwbT4UFGS3BG9upvVd8sU8a33bP7Eqqr2MHG8uROcokao4i?=
 =?us-ascii?Q?t2bujPc11Mqm4dFkOBPrsSVUY6LyGdr59uQAauHFCAKTDjQICuoXuGO+aFXy?=
 =?us-ascii?Q?1NqZARvnyEJz/8DmUbzrX/hbzVXqMg3kwWGOj9FG9dOd9ZnX00Q3JQ/rYhHG?=
 =?us-ascii?Q?bu0bC/DkK2IEXSfG0B+7b3ztzsoRZHmY39nQ7dgVGeVM9XM2ScAZpehVgWd/?=
 =?us-ascii?Q?A/SX/LwTE6iGPA06xuwn6yCT0Yr1tiyrxUEdnmGM6R9bsep6nuw8qzg1/tGD?=
 =?us-ascii?Q?+wyQawLcUhPJGwNco4t8Ct6L09YKQ/JjgvAO74kqGa83r23GwQQFW6CFctTe?=
 =?us-ascii?Q?5hjxv0XvmFYdNErz4FfvubSCkn+SVO8h5oKBGwFwSBaoLrGqyrP1WN3D3hDA?=
 =?us-ascii?Q?XDxmxdfTxoFJks57/XcGqaQ2/r+SgJBS95abOyewdwQLYdqr9Dxw0CZJd9b4?=
 =?us-ascii?Q?h2odn4D7bXUODTfY9emo1/dezKgFYrQ9281R3sB62ABucL+Fuy04h6AmJi92?=
 =?us-ascii?Q?d9aOl0TvBpN18L2NVCd4CH+Uq3UxsC9OGabSRT2hihD9NWTReI26MSxyH1tr?=
 =?us-ascii?Q?38CDuFqUwlG1cxfiqZ8Y/xpDSyS2bkURHcCvjeIA9HZOzTtjIwkn19eUXpe4?=
 =?us-ascii?Q?5fJTc5zr4qor69s/CXY0nOUwA/97xsuGyFcFvVlzzoNyTo1ds1JQJThmX8l9?=
 =?us-ascii?Q?VY80KeuzMiTT34BCQCGtTTkljcRCrH6oXVEi7Xy3DVsxgJt6KjwiCUvM98VF?=
 =?us-ascii?Q?2lUiV56Gy9/UW029ROZpg8ecr4pOULvvFmoDDGNpzlPIxv4yDqD8V5UEMlaW?=
 =?us-ascii?Q?6cR2I5du4cwlPjLLsNeyJJNjUKsUiJHbV+zJIDdDgKxYBd5nI+PbVpJPlS9x?=
 =?us-ascii?Q?BtLEVQu61ChGB1pq+6k0isrCihfTHlpflQwqadskU+nJb5/+X3LhOts1/jez?=
 =?us-ascii?Q?YvuO/n/6v6EcRNm7qK+OCmlfqMv0di7U7OiQuaUE//4lPf2eG2eoPczfGLcj?=
 =?us-ascii?Q?b/v5Nu9LaDt/hZ+yt2rLRdAR/I3EqOWOyjBetjnppglTfd1DSvPt6wP725rp?=
 =?us-ascii?Q?egSdnF7WFu3Mn2zLhJqafRcAIHoddxFMfY7sD+KONY8ZgPn6D6zf+yBMRGmM?=
 =?us-ascii?Q?ExCkA7qZGNqRGQ9fi3wmAZNLGmyk7DbZxIynyctqBjR3xJ4/mdhhWayPtfBt?=
 =?us-ascii?Q?qN+9n5EJB+e/jyBj70w7nytNFGwWX/cg+HwLw56B9vVaGqtdvvdnHNaXKq74?=
 =?us-ascii?Q?EvARKEDXxKOawfFVzuELq9UbjGRHXvhK4yQIYFopYAzN0IUoWWU+MqD6nyqo?=
 =?us-ascii?Q?mZwavmujutsQSOngqp3dGlMVFHhIwMU1CRWoC3tH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca83590-e599-4d69-47f5-08dbdf69b807
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:35.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al6sxLQpzaDN6BShW4YMIIh/xbeU9FzmB+Lk9axHhywb0JXEJgJyr+cNQQuARZl7RsVgxj9kb5hbfAw84jWdqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

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

