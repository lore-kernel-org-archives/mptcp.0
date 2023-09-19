Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388C31A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVZDP6ujvC5tHymly0P3fJhO4HDzCpPd6CnFvHTnhhHmBFBueoujh4LsxikdYF6yvxao8BiTi6lfaRvlqIhVWGuKQxZ+jJ3+F6IiGOdO52dpWuOKrmi6YMg20PeGvqeYHQxV0AadtHMCCI+y+EUKAmP5ZnMUIMF2psCHE97GHhKwVpkZFHWQnaDqlQMNMUjqaaP7TYpNuH49q5PmzixBUm9bGjMkxb+Nb1QJ9byeRnqmXHPnIbBgMerSYLcppEEM8GCvKf1hAuO/digM6UaAbtOcMb1GwhYbz+DmCLyVAsKl0wAEWzTMn4oTVLLVwZut8R+9SplDsy58aEbnUvWi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGhZiuYYIVVlw+Aybh0lCrW7ROExttZPli2QbbzK4hI=;
 b=kOVNHOTNgk9lkSHf0kjYUoj9ldlPodWto02R6UfQE26YSALHXKSumZx0Stl5uQ0OB8h/8xRpfzaBgtKHPxm0D6zEPBq2lmhtI0p/tCecodVCN1A4nixbvhTqASzPPmcHdLnY81qKcTe9uYJpVXQkfYlJzvgclxmiyt/pzVu8cWb9eIWrHvkXG7zmKXzj+YCw5zqejIyhrfsQs/ssAtanGKku45VDX78mtC7uwxHpCBMoSxd92oVB/nSS7ABgIDm0yPvqEiI1qXa4a1GZwnq2Pn9y9NcDlZAp73T8dIZeCZzWDwu4ip0nMpY/fNtCLYejrTHNs65aUMR1AzC+2L+h7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGhZiuYYIVVlw+Aybh0lCrW7ROExttZPli2QbbzK4hI=;
 b=iIbUI+IObMn7i89e4ITLOZYb0+STFTs7PAA/6y59OysIqgQulvEZZknNXXavo6IsXQdU53DQcMa4e1XfuLAymOck5/1nI1yGXOF94KiFDUjDGN/McWw4C8KH8xCjKta6gIiuS2/qY1tx5XKWzzyt+qYcXllGxePlaw9sC1JiALkv/aWDb2FRNB6eUOzu2oL6QnZrFJIyBBlSZV73Q4ndfoFtgsh/dnsEgyaK5XJ9yFe5mmp/M0MhW2WL1X41BHyWdoTRAWl4ZreHrQ8TFHIo4QllPToV7vRUw9ohdGCUltVv8//ezqjUp9muOQ9llZvsB9/ZE6eHFdDeetAX1UNyMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:05:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:05:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 27/30] selftests: mptcp: add mptcp_lib_get_counter
Date: Tue, 19 Sep 2023 12:02:28 +0800
Message-Id: <34b089b78d9f4ed9a9a3b5ebbc7d9d49599b22ec.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a98c843-c7df-4f0a-27e7-08dbb8c5b9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J0MMzj/tBPcNc6GvAy/X/eLJ8AV129ezX06QYKl0+zQhGsFq/cBCulWQLFAgMIL8Ia0yc20FgCDo6ImbpshBDCfqxrWELTw4fsydokvV3VBEegu468htQXKBvEqiOh5+01Qh8ICcAiK0ByzLh2pVpJdfzV8Tsokt5fyg/CNRRUpXPu+MiERIpoixMIQegtGi2lSrwIxDPDWuViLxUhI6YGq/fqUTyzvnq6kignJ5rvq0ODpsjVG0GQNVCVHHisP643qo3W9Q1gQiRq9TPxOc0rCxAHRjUwi4OGGNF95UMM8T22jkyf57vRgxXOIy2yoeVQQE1FQTSXwrZGf8ihtnc6hqblDwOoM3EKR1281ghhm+QNNXiAFDwlRVB4t6ZIWsfNuoR3sbF5LAPbF+zKIP13lpNC39OkwdWc5IeiShYuaD05ZTZsSkhUYjyWghd/h1slF9fEGrwcR9dviixmmO9fGzEIUaDMlQrlSqSY3r9DEiPiOJLskc1arlsn4pDeqfyOLC5MvbT8sp5b/c6wr02+vWjSvzeJf1evYTPePpdSzGMdEejKKlTLs0Y+qNmwJh1h3db5hJLA4F+yKkHLpCFVawwiMMTdsdugJ7C805lZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(30864003)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKQPGqIF+Xw0JO8AJpnbs2w8O1qbsWklL73haI15goLRou4ZIcRuiv+KTn3r?=
 =?us-ascii?Q?/pZQ2LysrtDIH5XeussUFgfLjTEya/rmlQwJFQZvk7mjaeSIcAr97AKCl6OH?=
 =?us-ascii?Q?vmlysh5A8JLUpplky4UMb1QLiZgc4HeIDYPpSxlnka8sIDBgMHzEGDlWpA7Y?=
 =?us-ascii?Q?jTYsvdIBnF9GMZx69TpkE5vKZcuN4Slc/T+KfZEfUZA1w7f8HuX1muAZL04i?=
 =?us-ascii?Q?hZD/49feAJalGx9GYzYO0YHbzdRGWEg9N+x3M7t4T8o2Ah8J9kqHx+PPuHtu?=
 =?us-ascii?Q?9Le9waSMNUq2vMcAFpjZA6c5bR/Ii00iArG3q0MeamvXISL9eIWSxN3Yrhh0?=
 =?us-ascii?Q?R3wrQ7LSsGY+ZVOcBpnO2DJ6owvhvh2v7oufPJZ0jM0nuKdia00uBEZ63ihT?=
 =?us-ascii?Q?mr4RkHBzqk38l5uU2PjREyg4MSbcnLfvS+bKi7kLy5Fre9E+2efj0chidd9+?=
 =?us-ascii?Q?ghKkNq88QfcjamjQWXBzOJkKcNLLtSZy2XZtrhLwLcXdR9bDxZQeC08rh8rO?=
 =?us-ascii?Q?A4lpjVeWxnE3ifWs9PJO6ZUVLc77BXIlNfco12pRG2I9XQjvNy4Mx42Szu4d?=
 =?us-ascii?Q?4ZXQHc3TF6DGojOqhkNHMHMWIOKFxcErr/WF7vjlg/XtwJ8Y3QRiYlcc3kgV?=
 =?us-ascii?Q?p/fgAQXaxUbN9kftfzNpv7FJaJkHMrAOxrR5CuNPr1qVNrJatj2AMdJzRtMu?=
 =?us-ascii?Q?Ex3ZQ+fLLtwxgUpHuVfpGpONSQH+ll9oVaawwhdui6/oNWAWdepw2YjhJArF?=
 =?us-ascii?Q?XiAYoXyiSbBkU/q/i0QqXZ/j8lnaPER+D6J6y8dva8hOtbmT80pUf4zfcWqa?=
 =?us-ascii?Q?a9qpVBPN19STCqTKoIBnHOeH5GqPH8bdYOjzOEkvcSzYYyBqNRAMVqiwsD5V?=
 =?us-ascii?Q?Gqf9LAfkxb2yTor4KXl9rmfXB7rFwpNrvPe5qekaGjFlonD8QMietMQcgZEy?=
 =?us-ascii?Q?eB7AKxKyWCuJXgajeo5UY47asa5ledU8sd+dfbqeepchc1Qrd4TQeP7UDzze?=
 =?us-ascii?Q?U8R89mMDraTqnI17zZnsIWP3mG/ierxXkuc0n5HIN7qg+ZUUcSr/c2VT9BCU?=
 =?us-ascii?Q?T6p50PN6U1M0kF1HXzMN/xgmI4QwNCyAMbga0BvtsARVdwreXIklnROxOJGJ?=
 =?us-ascii?Q?BGUYoR0gzFl/DJZfVs6kOwsW+P+2DxV8+ZKCZs3O/nbkcJLiv/42gUTjUv9r?=
 =?us-ascii?Q?E0qm2ierjLeU/2co8wiBl7hSlcIIBTi1aijQxHNdwWT//VhPgYWH+XXFSYqK?=
 =?us-ascii?Q?0804YZQObN2x0ionUHlAUp8hFq9p04rj01Yz45opf8iMQxqiPVgABPYFSQfS?=
 =?us-ascii?Q?9n/z9Nb6F3T/bkg8iXBCnqI0gRuPTiTdoP4m1xSndyiyBMAEidWIINLY8t98?=
 =?us-ascii?Q?C1KbP78sNmPZv0z481w3jY5CbEUGko9qJ5caMqlKg3AhSPwtllAq/6P3vtA0?=
 =?us-ascii?Q?6C17md6y/TTlIXgc5tWW5gFVdr+QSiwTopOF2lZhzWefcb/aWevGaef8LU0B?=
 =?us-ascii?Q?PcxuCghcGPNfE38xfCYG4rs8EqwHGspmhrrQUWXW/rkt2IOnY2lhqX/hMW6L?=
 =?us-ascii?Q?G0EWm8No/OJBiRg4GekKxJNTo+fVZytY0y+CHpeu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a98c843-c7df-4f0a-27e7-08dbb8c5b9f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:05:57.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2TOM+8ACyNPUiH+jzAV5oWOgXHNbqHVUzV0GlmvNMLpSitKPon5sVC74+C6KdVykLSsHs2brI/LAqXyWy1toA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

The helper get_counter() in mptcp_join.sh and get_mib_counter() in
mptcp_connect.sh have the same functionality, export get_counter() into
mptcp_lib.sh and rename it as mptcp_lib_get_counter(). Use this new
helper instead of get_counter() and get_mib_counter().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 41 +++------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 16 ++++
 3 files changed, 65 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4cf62b2b0480..3b971d1617d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -335,21 +335,6 @@ do_ping()
 	return 0
 }
 
-# $1: ns, $2: MIB counter
-get_mib_counter()
-{
-	local listener_ns="${1}"
-	local mib="${2}"
-
-	# strip the header
-	ip netns exec "${listener_ns}" \
-		nstat -z -a "${mib}" | \
-			tail -n+2 | \
-			while read a count c rest; do
-				echo $count
-			done
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -435,12 +420,12 @@ do_transfer()
 			nstat -n
 	fi
 
-	local stat_synrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	local stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	local stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	local stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+	local stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -503,11 +488,11 @@ do_transfer()
 	check_transfer $cin $sout "file received by server"
 	rets=$?
 
-	local stat_synrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	local stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	local stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	local stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -536,8 +521,8 @@ do_transfer()
 	fi
 
 	if $checksum; then
-		local csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-		local csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8ef91a939c1b..26ea0919810f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -595,25 +595,9 @@ wait_local_port_listen()
 	done
 }
 
-# $1: ns ; $2: counter
-get_counter()
-{
-	local ns="${1}"
-	local counter="${2}"
-	local count
-
-	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
-	if [ -z "${count}" ]; then
-		mptcp_lib_fail_if_expected_feature "${counter} counter"
-		return 1
-	fi
-
-	echo "${count}"
-}
-
 rm_addr_count()
 {
-	get_counter "${1}" "MPTcpExtRmAddr"
+	mptcp_lib_get_counter "${1}" "MPTcpExtRmAddr"
 }
 
 # $1: ns, $2: old rm_addr counter in $ns
@@ -633,7 +617,7 @@ wait_rm_addr()
 
 rm_sf_count()
 {
-	get_counter "${1}" "MPTcpExtRmSubflow"
+	mptcp_lib_get_counter "${1}" "MPTcpExtRmSubflow"
 }
 
 # $1: ns, $2: old rm_sf counter in $ns
@@ -656,11 +640,11 @@ wait_mpj()
 	local ns="${1}"
 	local cnt old_cnt
 
-	old_cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
+	old_cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
 
 	local i
 	for i in $(seq 10); do
-		cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
+		cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
 	done
@@ -1256,7 +1240,7 @@ chk_csum_nr()
 	fi
 
 	print_check "sum"
-	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
@@ -1269,7 +1253,7 @@ chk_csum_nr()
 		print_ok
 	fi
 	print_check "csum"
-	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
@@ -1313,7 +1297,7 @@ chk_fail_nr()
 	fi
 
 	print_check "ftx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
@@ -1327,7 +1311,7 @@ chk_fail_nr()
 	fi
 
 	print_check "failrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
@@ -1360,7 +1344,7 @@ chk_fclose_nr()
 	fi
 
 	print_check "ctx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
@@ -1371,7 +1355,7 @@ chk_fclose_nr()
 	fi
 
 	print_check "fclzrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
@@ -1401,7 +1385,7 @@ chk_rst_nr()
 	fi
 
 	print_check "rtx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ $count -lt $rst_tx ]; then
@@ -1411,7 +1395,7 @@ chk_rst_nr()
 	fi
 
 	print_check "rstrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" -lt "$rst_rx" ]; then
@@ -1430,7 +1414,7 @@ chk_infi_nr()
 	local count
 
 	print_check "itx"
-	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$infi_tx" ]; then
@@ -1440,7 +1424,7 @@ chk_infi_nr()
 	fi
 
 	print_check "infirx"
-	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$infi_rx" ]; then
@@ -1469,7 +1453,7 @@ chk_join_nr()
 	fi
 
 	print_check "syn"
-	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$syn_nr" ]; then
@@ -1480,7 +1464,7 @@ chk_join_nr()
 
 	print_check "synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
-	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1497,7 +1481,7 @@ chk_join_nr()
 	fi
 
 	print_check "ack"
-	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$ack_nr" ]; then
@@ -1530,8 +1514,8 @@ chk_stale_nr()
 
 	print_check "stale"
 
-	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
-	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	stale_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowRecover")
 	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
 		print_skip
 	elif [ $stale_nr -lt $stale_min ] ||
@@ -1568,7 +1552,7 @@ chk_add_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add"
-	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1580,7 +1564,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1591,7 +1575,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1601,7 +1585,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1612,7 +1596,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1623,7 +1607,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1634,7 +1618,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1645,7 +1629,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1667,7 +1651,7 @@ chk_add_tx_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add TX"
-	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1679,7 +1663,7 @@ chk_add_tx_nr()
 	fi
 
 	print_check "echo TX"
-	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_tx_nr" ]; then
@@ -1717,7 +1701,7 @@ chk_rm_nr()
 	fi
 
 	print_check "rm"
-	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_nr" ]; then
@@ -1727,13 +1711,13 @@ chk_rm_nr()
 	fi
 
 	print_check "rmsf"
-	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ -n "$simult" ]; then
 		local cnt suffix
 
-		cnt=$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
+		cnt=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmSubflow")
 
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
@@ -1761,7 +1745,7 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	print_check "rm TX"
-	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_tx_nr" ]; then
@@ -1778,7 +1762,7 @@ chk_prio_nr()
 	local count
 
 	print_check "ptx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_tx" ]; then
@@ -1788,7 +1772,7 @@ chk_prio_nr()
 	fi
 
 	print_check "prx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_rx" ]; then
@@ -1917,7 +1901,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(get_counter ${ns} "TcpAttemptFails")
+		cnt=$(mptcp_lib_get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 91a17ae81cb8..0f5e34c76bb4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -328,3 +328,19 @@ mptcp_lib_verify_listener_events() {
 mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
+
+# $1: ns, $2: MIB counter
+mptcp_lib_get_counter() {
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" |
+		awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
+
+	echo "${count}"
+}
-- 
2.35.3

