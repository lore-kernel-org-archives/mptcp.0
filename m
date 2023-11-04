Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F587472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QoLn7oW9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHgV0dN5gf+oB2KZNRS9iuvIsfMurr1mSpwy0HWVbJOUP85/zI84z0YxQBnDG9PI7GFQ3SvmRJERfAPZ/o9X4v2/EHabnfUVV2egAQNVKumIq3ATAwFBGQ1yNmSXG6zYICsJwHUHhS1psgOevncFUS3y18pIRT1pIjI4dT+UQxgOF4fwiN6g6opwVl1RKITUchClCxFKQOp+VGGQ1vi2gKBejN/IuvK+Qka2/wbwuaeRWiOoSF63nGGxYjQ7QOYzCzsnUtElBdsOMq0k6U/yQRvy4i9qTs1jMwqICmFbWOe1mJ7R8KGC89aKalol6vhtqnFbbxxwQVcnN9s+NloAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeoisLGFOZ4jhbyAe9JFYSZFWFy1oGybiovYkOrokgo=;
 b=dBT/RB+wz7tJoVgoQ/vwk2OORm+KQ3LI+cMDcwhhD6iZ1Fm5w2t+UvXaRKcG/wH+X5f1rPNde1cipqksc1CnyRy1DIqt+P/GesKzmgz3PuC27wy8eyaJ+n+S8vulNwPxewHaNpnwU6ZjKaA/L4AVc0muS36fyFB4O3dkXzD54oB8/dpoYdquQJItBoRefpdCEruHcFZikpyyB2oVqJatZCpTwAluR8G8c9GAFk1d5Ow/1xeIrcCN5jCCuFEoBsN9+82Qgu4JKSm3ohGzkcR5VkLvWSe+dcwiyBHvCZaG2ikCFp1mLgSkqqVZDD3uV1Trrj6WM4PdiGpl6JHP2y/TEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeoisLGFOZ4jhbyAe9JFYSZFWFy1oGybiovYkOrokgo=;
 b=QoLn7oW9/m/ZHHM7PMKEkdsJmj9BQzMV7kJHm3sPRGDDKa3y19lCkpPi5OTDXZ5N/XUj2AFxfxEl8umyxVphhRV1wCgtIRPsh4galOgZTNvZbwRMC5v8E8IwtOMpj2JGQ82Qs0zlu/8uxI2TVy6Atkjd8K51CEeaZMuPtqJK/JTXZ5xj0xkpzihJaCq1oY9G+1nagxuUEhewhfryTPyIIh18xqf9jSNvi9cub/N0refYbcf4EtlOBr6/LsWBveotiNr9nlNoN5qxouJxjhtbYLcZw1fynyspEtfT5Kk9Ajg2zuml4RsFlLl0mvjiiuAGwjhwz3sjcxCnWfaaBteSAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 07/12] selftests: mptcp: add mptcp_lib_evts_*
Date: Sat,  4 Nov 2023 16:35:55 +0800
Message-Id: <16541235ccf25b4ab35ff4810417baf247eabb1d.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 943e8936-dd34-4f4a-2982-08dbdd114efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gqlrgrZuVJinnigpPf9cPvSDTNw68MZSjncEilhYYDbWM8OYRWv0L20889kdsxvgZs3tuksIi6kqJYYlUVauc8naWK4BTBl0X3Sz5u1mLSNCywcVn6q5GbeS3Qto9232b0qDOVQTfr6WY4yzXMTXGM8B4BN6chsbSRJzQIMFnksIhDac8+oIkk+Xo6YnaEaie40ihH569RBPhJSRVDI6HwYSd4/IZrgOzYlebhSQ+bY6dYIKDTDfdDXjj45rZ7Q14sFfIRBeMsuSSZSnzaQ4jwzMYw9Hdb1XWAitszl0ohLDVWjLHvav8NpE3x3sJ2XKCUFgEpr3Oo4Xe5AlaCgxg8yaQx5yxEQTkZv0524zn1jfWn7zscmzB7s+yEuZiiivvakwi7cRxWHx3SDbPKYJnJtCWJqCIVA9o7scklzLK9861Oko1DpjPlwA/Vz8vSzoxmWsn3wWrxzVgZQ5Xd8KmtAZdJ7kqXlyd01VIIaEy1iRVxjEcF3cAbzBqxVJNOgbRZJ+aMhq2UiALLlNWa4b9ARybyG2989hHk21NsZWSth1L6jiTzAwm6jF9JAujdb7TMeVY8zZtpDCMo8qLhPtxaCgZ9GzDp9k4zk8247/n3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8OOqDKV7DwtkstPqyzV5cF0+M3kTN1IwBe8Av5ViPLqwsed/GbkSHnq9Ch4p?=
 =?us-ascii?Q?e+K39nzIX3UVnhvVjH6yFk59wRYg2SaVHjyVN1xC/zu9NzEpsBQ2FxyMllJR?=
 =?us-ascii?Q?VgglvW0dbJRUT55u8gjwBKAYne7BlMPeF4tx18T08u/g6q4seWFoJeL2+di5?=
 =?us-ascii?Q?LzXx0X8z6nsZH62xvkmLsQ2jpp1xN5sIt1em952iEkXq5RDBYqXqq7LlN6K7?=
 =?us-ascii?Q?OKPfmbrvxhBEPo8V8NaPo10K48z0g6nCZ4GMxCNvGUBYtFNn2IPb5Zlui3gK?=
 =?us-ascii?Q?3c48Gb2TnetbHKRuenId5Z0GZssk/lCzk4rVfHE9Jmny62LbCdZVJ3nSEY5G?=
 =?us-ascii?Q?K9oli7te/UMuRKftzx6BlvUmulkcPOqasFPjTxCBhJWe7exdHJRbrLR+VH1F?=
 =?us-ascii?Q?Lvx66KjyNLl12y9GJmyh3pFJH3d7mygSpc8NU4iTBPnRnWz/w6xL7cfDcua2?=
 =?us-ascii?Q?MjT2Rq5RvmHH0t6AT67wucZwCGFbhVdYyczYRXEmgzFW/kyaKLbiUkKDY5kj?=
 =?us-ascii?Q?qMS06nYhsD1HcQhzxMHEecvCkWh/bwlBwes+gqZ0jhPcT6WiHvLNc7UP2pom?=
 =?us-ascii?Q?DFJ0tLAHy/6JVHr+aIFQtccZZEICEUBXxW6dA0ybdyY3bGUuCa4HNCW+9qVz?=
 =?us-ascii?Q?kK683Glr+Qwm9Jv3RmWzmlK2lXrQoYCPMJQH+nnnHKXOX2mu9u5IpxjH6ewF?=
 =?us-ascii?Q?qz+FOdxKNdmrW/WaoHiXUZjYhzkr6stWrzvXorfZJrfISyuqp9Dnc1+ita3A?=
 =?us-ascii?Q?NfiG204QmDpOPRtU56wwQ2dvIxGuvMoljgXV1yuioAnkv/rhm9+WYrT2FCT0?=
 =?us-ascii?Q?h8n6h/cOP9wyQmE+W+Q+HzoNdRxG5f5l62Nu5OrAbJ0S74VO9M2HpXxZc6CR?=
 =?us-ascii?Q?RPqEVkAGKtT0HZF+3Lka2w7BlA1yafLnN+y61jxKgs6D8LKfgZ6Zccujz0X3?=
 =?us-ascii?Q?xXZk+slfLXOMQ0omA2UQfllxTa9lGBLMRMzMy2QYtQSqGV7m/523NI7MJtiW?=
 =?us-ascii?Q?L7BDZvkNpMmkWMPeYoDEL6GHvUszcp/krDD+A2ZKhFEcF4L/52s978E7qaQZ?=
 =?us-ascii?Q?SvJkiKnS6at+M9+i6hv0jB2Cw1Esot98jzLV/BbrGLpeCYRvxig3hj/+A7x3?=
 =?us-ascii?Q?uEQqyp6PvCK2WgYh+MvJBf+mEdAuDYpNF+2YwfZf743h6XX7CK7ypUPoGIIl?=
 =?us-ascii?Q?avxgkLpCUbGX/BDNNlbF2K22d35cyos04TcKGu6SpHcKcSYssh8mBatx9MaA?=
 =?us-ascii?Q?o/KxZNW/QL+C2ftK3JHnLd8mk50S0PkqTBDcJ+MHxwsJcfVhmD41nIHm/kmI?=
 =?us-ascii?Q?f552jn9u6BNZXSV1eaY085T7mOh8kv6/uM4CpHH4ZleSZgxOswyTDDtV9jz8?=
 =?us-ascii?Q?lIv5plXSfW12XbF9JaANkOAHQ2NL+VyG0yHN0b3eZFKEQ0+bBS0cDmae43Uh?=
 =?us-ascii?Q?UDELxWcAcJn5xTsvlP23EtzwpVUfX7hdkSaXOOqJrWVINYhv/JiaZShpC1/u?=
 =?us-ascii?Q?OQGy2CTcFV2K7ei8r5JF28pVduPCmzWy1ZX6UMGhGXFvod/62S/JchYbkjZs?=
 =?us-ascii?Q?ITSACfJM1hpdYbHNGGz2TEYoCFhO+UGJMje8ggnblSkh5qwJEAD0YqQpuWAu?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943e8936-dd34-4f4a-2982-08dbdd114efb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:41.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMOye605DvNqO1vjgF5zvfqMoYHhtf9cLbM4IJeB9jeR6FcqSZP885UjwTsxRidvZhw3B1701CNYp0QavTWJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

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
index 148ff0f57481..9b614a214ea9 100755
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
@@ -3421,7 +3405,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3444,7 +3428,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3466,7 +3450,7 @@ userspace_tests()
 		ip netns exec $ns2 ./pm_nl_ctl flush
 		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_rm_nr 0 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3490,7 +3474,7 @@ userspace_tests()
 		chk_rst_nr 0 0 invert
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
-		kill_events_pids
+		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
 
@@ -3516,7 +3500,7 @@ userspace_tests()
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

