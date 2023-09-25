Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDB125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8WKEPZr/LdqYSwsHKIaKWymFd9dvbMtWoMeif7vx+/oK5M78eB/iLKGhttaCxD3hBos/HzRfzmy6xQCKpmG/4rSpvz0TuBJeOFX6i4ScFvDeqi2lfHzygauwMZm1WF4sGk7iXUQkkRxAvl9AvCk9FFX+oP5IJuwlk9BouzVxzHoXL3YXXHjwlhDe31gRBYaF3noJuqXspCiC1FGgA+EtHcNo0qG1QQV2def2U0x+cNLUDlHL02tbHH+Vn5axG2cIoFxV7J+RFBFcCpV9iT3pQ6A0RrR8GlUI+WqBvXaliw1qe4hzv157D+FMWNtHkWIN28xCk+jadKfbdFbNWdEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wYLGyGAoYo7LK1fEPe6VfElrhuOCAPZq92AjlOF54M=;
 b=J1PYfjgPfZGqaIFjZuuxUthrzjZLYMVvL48BS1gORbkqUaEcKtEr/zMCMEKIpT0jEX9Rhk1wC/HJUCI3STfki+QqEFbQAAbkaNZR8YaP8L2pzNvhlkZiigWjEQbjT00uLZTbudieYEGnh9r27kqvdFZeA3vO2fJQa9qFnh08Hke5uGNduQBbO4DPL47BE0Exk1YH+hyoQPlgUtZO9tbLl3NSzvrkky3vrmTVBu0k2DpY0qG9/TtS15lo6Q4jf4NmS0zOwQkCvTIJfUuxaRvYg8m1pnR8k2QPOq0pZ2JtxdvDzhg+82lxEKvBZUc6T3aHpU1uuIB3hzR4L7uYcecGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wYLGyGAoYo7LK1fEPe6VfElrhuOCAPZq92AjlOF54M=;
 b=ABez+Kf9aHpF8YH4f4ZFZQrXd5b/hq3pPOr9Aq5Oxo9grOtEEPKBx+5oy7zONHHwcCyz5M/o5aBYNs3L2ECG4+6dHmOfgaIvSC56nkp53EDn06ZpC4EHNDpGKJDjLBP9Vc8Gj8JNEkww2F9/2CXl+OrfpUJyGT95ulMT6wgb9IhBLNjaEBAOl8Qn5r2bm3oBmk5CZBlE/sB64CczLAB46rtvBivBWcS8ILzzEYD5ei7RZrF6Oop4kAh2OUCd0Xr0Pj8vRa2aJJOXVqMFQ5dhJ+qxUFbUzfrpv74NY2rKKGJ4aLPJ9frLD2KZqDKIcIbsDVAxaGf8UFLz520CB22wDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:44:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 21/29] selftests: mptcp: add mptcp_lib_kill_wait
Date: Mon, 25 Sep 2023 16:42:00 +0800
Message-Id: <901c8e4cbae8f41a79d294c45f54f77645372df7.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6e716b-419d-4192-8561-08dbbda392f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+vvokkbRRmTo6NKZ768UUcPfZV2HDSlCXAV9kE12a9ZXvHDZCGxxVC+4Qk+MckuLnJ5Ne6QSiBWy4Bph/bZ5/iTWgrNMr+no3xa9t6B7R7i5N21UWgOB8XXWrFg0eT3oCECBqwHzc3LSJ+gj//lxJ45pIyiIX7Uh+fujQVbdHrSuvoyXaZbCezMa7GrU/nO2e8OM+DG8QTGjE8D/DIxzbDH7i8TkOjSo3m/HcX5vaqTzxCSykhtzw9g0VjeIH4+kJmaUF+JZSgiqdpnzy3gKvuSf7Lf2flYaJKNWi+Pv5Dijyiw5DcS+4193WmjywGqKA3TToSgSEJqFsUxnY+/sb4mm7qlmz5ci4LPpvO0YAUcPFKFmYt1ZbGBQF+ZuQdmP4Dr0ZeKa0qLBIJJvz0BLEcpuiJVGpbyFp7aL+KWfNdcn8iy7A/KBs+4TGWWEcbrwr4h/aNxh8NxyDh7ipUNL5ITzcypumlUKqUIQ5Bv/uTjLoBNShJkY1t7c00l0Q/xsuyysd7NHUyxjtQ5R1YsDi/mo2Z2zCDyUi/wuO05Xn6fKjEth8aXuQBVdmKHesjhn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYWOGlZ4SNqTT3vlyt5YNkBMxvPBqEpvxglQo8SKQ33dXQ/lCblMP4lGENd8?=
 =?us-ascii?Q?dzu4FVLrdC2McwNaWYrOLEoZZFah7wxHr1RJ1oRy5zwluLKmwVqcj7MeyyDG?=
 =?us-ascii?Q?HitzjoK2f4/HePfYxpoIafS/Kg8CGNs0kMYpucpX4Jkm2aS0aUnwvpVdkKR7?=
 =?us-ascii?Q?C5kerULSWTCjdEkKsYFr00/6Fv1FPpHk6B7QR+m6rgzks9roxdgdsPDIE1kh?=
 =?us-ascii?Q?6AXSylhtIJsFg/yJNsljbZSlgMBvOG1xw5p7Ayi2V+pmuPJ+cAyTqhKdVlKb?=
 =?us-ascii?Q?D/B09AzWJKUxJaLyADCf297ID4VuBcpX3yFpnQUywyDsMW7qd/bw3/j5W/pO?=
 =?us-ascii?Q?4147lnGkeJD1IZixfDLhI5VcxoDiRZ8A1hYZPWOU2KfzilmKvOnZRLv3rBWL?=
 =?us-ascii?Q?n2rWrNhNbZ4lulb+e/4vrfo002HcmiNOdhpbyoXq/m25FUdXnuvOB+lIXTfE?=
 =?us-ascii?Q?hDh5iEf2hCHZJfKXDuX8d0vU6u/mhMFthWmBEAoK2r/i5A9U5NCyaH6ubSkP?=
 =?us-ascii?Q?ZukKzTD1HpO7rUyOWxC8eIAfUgEZjsc0bOL+r5rI6ZMD26RKnbbtd9gQd5Xi?=
 =?us-ascii?Q?ZBc+q3Drq37oO6/NbWJzpqQ06VYhCdO10SWcAtsCRypkA8H+s4RNj5WBvT61?=
 =?us-ascii?Q?T+L1Qx1sUtaDeuvxPsD9Ex2cUHYI7Bo0OjT1cf5a0p+QFsHfOPwQlwVBYUAE?=
 =?us-ascii?Q?m42NVvaZFJKmrHQGbl6XFk1NAchVrl4Upl/Nm4i1/PZHBMu1io4BFRcD2tmb?=
 =?us-ascii?Q?s5NIE+u+/CQ5aXlMT67YO8WRXExdscAQGz6/6KWcte4liDr9AwWm/JCCZxeb?=
 =?us-ascii?Q?Vz8Su7JT67o8+wp8rhAr/Mgf+lkq9axgG/+GptGlx5efVb+rqs5CXeZEYOlp?=
 =?us-ascii?Q?uXcJD73f25G79LoudkkB8dPgegZ83OILr9zrM5e9XbI4IW27zkn5Xz4o+4Uc?=
 =?us-ascii?Q?sB2L6GOgUdj+CFtKK1DTpmVCK+1/ks59rHSk4VCHf6n/0rdTLgDTxeLzsrH5?=
 =?us-ascii?Q?Q+j2/ywNl/gp/bYVwT9SBk9pd1setie6qi/PkWJE0eMGFzmqnmK+8oLxquBs?=
 =?us-ascii?Q?i2d8eVX4Ivf7XpEszz0msIzEy2bUZo4abKcyfv5LxtbvtYHp7tHRBzbBrwZQ?=
 =?us-ascii?Q?DVmiE+87xr4JuR41BghCJP292l/eWwPMtOOfj9FnBWapbRFJH6ozvftqRDr/?=
 =?us-ascii?Q?NXE+wcvlcnjDMXqN81qILg8E3YUIf/HdViiG8ml+UOwQk0rRvPdrlGr6uxud?=
 =?us-ascii?Q?oXkWi07W7MtzYgikgh5O+MMbEurQojYJ1rE/VTPZRbhPcjb4G/4Pt4eEEzKm?=
 =?us-ascii?Q?Gxlvy2HPk7RRY+SJ6RjKz7osnNTZbCSO0Be6KoXjW2xoYGRRCD8G4HcsDNvZ?=
 =?us-ascii?Q?1hKc/8bDZR18OaYeSEV/65HIlhzbzd6p9I9jNg7rBytApqgNCBnrB515yYDV?=
 =?us-ascii?Q?icMBv9LZllIFeRGQsTL2DK7qr1tiwDyFxlkembTT1p1tvZAYtrdVIt7oHhC9?=
 =?us-ascii?Q?V9umhr0pZhBg9p7jZ2A9beF+SYsgXj8ffeUIwwKLFWYs9SLQWk5KJhE/XFjY?=
 =?us-ascii?Q?F9IoM/muzASmOx6YAzyXiFerhx6lOXiQk5TDTUT+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6e716b-419d-4192-8561-08dbbda392f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:04.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px6lOQ9/Ylrsci/lbflrgzlkTg4I1vSkIrasM8m2xkDF/lmaL00hmjza1QPL8IKBdg1RL8qFJPCln3I8McO5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

Export kill_wait() helper in userspace_pm.sh into mptcp_lib.sh and
rename it as mptcp_lib_kill_wait(). It can be used to instead of
kill_wait() in mptcp_join.sh. Use the new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 ++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  8 +++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++------------
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d883c6c2426b..f335a782c793 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -682,16 +682,10 @@ wait_mpj()
 	done
 }
 
-kill_wait()
-{
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 kill_events_pids()
 {
-	kill_wait $evts_ns1_pid
-	kill_wait $evts_ns2_pid
+	mptcp_lib_kill_wait $evts_ns1_pid
+	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
 kill_tests_wait()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index bb95dd967eb3..8051ac5507dc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -219,3 +219,11 @@ mptcp_lib_get_info_value() {
 mptcp_lib_evts_get_info() {
 	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
+
+mptcp_lib_kill_wait() {
+	[ $1 -eq 0 ] && return 0
+
+	kill -SIGUSR1 $1 > /dev/null 2>&1
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 283c62deb628..7cddf793950a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -107,15 +107,6 @@ test_fail()
 	mptcp_lib_result_fail "${test_name}"
 }
 
-kill_wait()
-{
-	[ $1 -eq 0 ] && return 0
-
-	kill -SIGUSR1 $1 > /dev/null 2>&1
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 # This function is used in the cleanup trap
 #shellcheck disable=SC2317
 cleanup()
@@ -127,7 +118,7 @@ cleanup()
 	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
 		   $server_evts_pid $client_evts_pid
 	do
-		kill_wait $pid
+		mptcp_lib_kill_wait $pid
 	done
 
 	local netns
@@ -209,7 +200,7 @@ make_connection()
 	fi
 	:>"$client_evts"
 	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
+		mptcp_lib_kill_wait $client_evts_pid
 	fi
 	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
 	client_evts_pid=$!
@@ -218,7 +209,7 @@ make_connection()
 	fi
 	:>"$server_evts"
 	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
+		mptcp_lib_kill_wait $server_evts_pid
 	fi
 	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
 	server_evts_pid=$!
@@ -623,7 +614,7 @@ test_subflows()
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	local sport
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
@@ -662,7 +653,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -701,7 +692,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -739,7 +730,7 @@ test_subflows()
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -778,7 +769,7 @@ test_subflows()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -815,7 +806,7 @@ test_subflows()
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -861,7 +852,7 @@ test_subflows_v4_v6_mix()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -973,7 +964,7 @@ test_listener()
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
-- 
2.35.3

