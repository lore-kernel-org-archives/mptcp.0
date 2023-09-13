Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B4A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHPt5KE6vZ9AahTy4s8J4LBtCcPCnPKIORXU0MVF5t6kNdFLI6SFs53SPlVYueq+r3AvSxYLxw3Gz0NFghIhVWpIbYMvU1euvqWsBtUMQ+ovVgdUdWhpuqe6Fev5vYP2vIHPvDUQdCBwCeFjaUUC0Pig9GN6zT6iqM5nJrVJUVaTPT3OacuVbC2FnLeQVeA16Dg+V1KwFyKuAeSyCoqmrwgHK1XJlERmKub1sfgoNwZyFakk6uIV5bWG/mgA08tPdJXheNeg5lfESd4YNsM9Pndj6Cvum9iTsr6ny0j89PZ7r3y73D1xKUtFiQUNxkSdfkdzSc26L/PM2YQSmeKr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PnYc0SGe8rdmzbV1Q/MvkTzjtYqttkZRl2nm9Am+cg=;
 b=MC8NUZdzuwuOjf586d0zicdWhaHmi0EwTAzwerw8BqH27h7QFDwyuKbTgd1C/6yljN3x5ylmThNAJumDzCbrBzZtVCFSzxPD9HBDkvEWorepQSH4xhGTKh6zxU28BdWH3pszJ+Iub7Tvuhux4G/w+98Sk7BkafYr5ZbGiVGEo/VesVK22hJabnCjbCA7w2QZY0/Tj9E1PHFYV3qLaE2h21KD9k8xQ2pX1SLe1+ti8Ae1FNysJa19XS6qcAblnNyF4q3ocMhsqqPkR6x8QkQSZTM2tQ8lstpEqk9WjzQ5nmYT90rokX60bvgxr2MHtY8FYJmLAABEHPAM5Z2p5WWWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PnYc0SGe8rdmzbV1Q/MvkTzjtYqttkZRl2nm9Am+cg=;
 b=bplkKD8ulXxa1X6nTSwEdOr0Q8QqsKcJ8RGHBDID5DqzRlzXGRUx0AxjrrRt4IAlnm42tLVt5WoqPY4E9JFpRY8vU2ST+V+H//Kzs850ag52R1fQJMs7wOl2XZJ7FgjFL9qZ3d5IOwrZG6JTT0sHkaL6pD6Qlx9+B07eroobfgHFRQTxaMfm7r8c76MVaZoTj4zeP/Z/Q7D6Ci/jg9dzOveRIEE/e3DIUE8K9oztaHSKCIbLJWBzD1uqVBLlB8hlnF/0y/4xFljppnp3Gz8gw1uojF0wPuVSmPnQbtx3+5nW8Zo0AZuYbMukEgA0UNxPjKRhvbV+yDn5l3ENSjU3Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/13] selftests: mptcp: add mptcp_lib_get_counter
Date: Wed, 13 Sep 2023 14:04:58 +0800
Message-Id: <006291e15972882da2eab4092154bb97a47a174c.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac9be75-955e-4c79-16b3-08dbb41f7136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C3GBrdBGiGKuuTjpqC+X4HLNC2vRCJ+bD6o6r5/G5tF7MvyeSWPFiYbGYJ9pQkWNvTkSv2LFEeWIkScHFD+hWwk6jFeLbyVMdBY5gg8AmRne+HUyXm1JB8E5k1vVzPRijdCWIPQWPROZwC+9HTjpgApSbgOguNqNtDvbvNpPvraX1346/Xka31D21cU72SWUF/20Pni91giVEQiYO5Kb1Q8UB7m9YsTYGK/z+QezkaAZQbvIANusxTYSscKSeZVmTurOUkI5RHLjWOQ/T7rVbvGQ5JCgXTHmZ0M1Ik/LiFXwcvok9tEttxKGAcq7cIDJpNuncCz4i0dh4X4MlvQuUsiYswJ2bpEQFbgYm2ct0l1ydznYoEjV6I0hjDGwt3dtR/ZGhURm8RdANgNbo/WomuctTpIGCwBhaI3EQ3trTxt9DHx4plY+K0fduXvSduRxRNXhaVPqtEdcvSm5cKZm9m5VIOqGDl8Ptp5dvBsvH9Vk4xWCuDmdHC7wFjS7XICsvBa/OBBlErapR1GD0xyrgBlX3pxmXe3bxR3pk50ACmkImvGriaX5kgvo5/Kl4FHtGV68Eqo0MgK8d17l0QNFBITygGayyBxcJUA+sFiGVts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(30864003)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJxeuCiconeWLN57YU/IAuUf9jgWaQEnNMUA5lshZhuU61TM5+8P67xsLte/?=
 =?us-ascii?Q?SrdHv03adxSf7+PPxgamm27JvqfP2TDMnyBatoXkmIx9011g35TQ+qZ2GHfo?=
 =?us-ascii?Q?ZYaCbzM7FL/7+ANyKi2ARKyRtMNd+eFSwyBqEcwp50tk1f83HvD+CIAqzC5W?=
 =?us-ascii?Q?Lle/8H8b2CiMVZIPYN5uuarrXVXLUHUJSWbzeDqhB/aIa2D4FnmqiRlH1WG/?=
 =?us-ascii?Q?6FV5I0xNkxczh2CHz4jD/8+/oLzKW9Uufr2LyhJF3rKCgU6C+JnuNtqA3bxz?=
 =?us-ascii?Q?9yG3J9HWT82ztrT6KUvn3ir4+LAbjMja0uvSfFTFjOpBTRnvGjaCU655f281?=
 =?us-ascii?Q?XKFjKHuabju/KEfnF+Yl9gEh6u2m8aTqzKFqZg5+af2tQCYaRYGmqULbJj7h?=
 =?us-ascii?Q?aZ0DcxWHfJx8H7Pbi3cWAFCh1QNyZiK9+gS/m+OLLVnXzxkZVYS99fWa2J5h?=
 =?us-ascii?Q?ejsKgzPLx+Ef0FPX9IE0BsvFyV+D2O1Kdxq13QEWOfgDBII7YSlSnjP0rVRi?=
 =?us-ascii?Q?SzPI87boReTgq5tmQu+urRO7qXzr5pc897TA7HwchOmXMinBBs2y2VO9ziVG?=
 =?us-ascii?Q?RVom/CASCOPsU2SZYsyxlVFPDIvUKMeCTkjEyKwBeIpXkxAiZ4BkiAAy2Y11?=
 =?us-ascii?Q?fOmsGsdJr9L1j4pMIrVgGm84pa0lV0xH+X95jdU2KHIG7i0uQbfhkvujUXZy?=
 =?us-ascii?Q?HPyAT9x1giqxWKrOGWtIvEnKstlX+mcZZdUwvZRPKJ77n7iXIE+lE9/u3bUo?=
 =?us-ascii?Q?QWrbSCQfb2l5Vrj9r7sEvHZgEMrM7pLO8jHtK2ke3lIEfrQj8wAJd6thlSJv?=
 =?us-ascii?Q?v9PNURoZt4+imGpMMarfweITKFQCnpWW6Y7iloH2jJ991p+i2TODP3VIgK9y?=
 =?us-ascii?Q?x/Vj3+tWFE80ybSR0sQmTWo1bsexvaGRgrxuZpllL0rKgphJLTP5PXhrTxAG?=
 =?us-ascii?Q?hUufOBUxD/ZXrwHw5Eg7ExwvJWU4FZiivFKGbwH5n37ZeJ4E19OBKyqnOfoi?=
 =?us-ascii?Q?G5bGtHSjloACbNXflrnObJyj7Ub64xbLKQwS1CPPSHFm0zHPt8NchTyoBK8H?=
 =?us-ascii?Q?2KOIMyIBM6kHQxR9PviR7OFjYFvJrAwBil6sbu5kSbktPVkkzjtS1Ih+D3ig?=
 =?us-ascii?Q?ZBunEl1kxzofQatj5OUNzJRmZCUexJPOJj642SC6w7Bji72qejuiKQSSdLKi?=
 =?us-ascii?Q?qW0fZfBHndEVx4Vx3z8uwC7RaTykHKBB4BVDVNPjhj6VK9O6pDaDsLjVbpTO?=
 =?us-ascii?Q?FT07afRZyjjhLTvJbbsMRinfaZOyTw+5Z+ecrLRMNa80/SLX0Lxfc91B3BCD?=
 =?us-ascii?Q?DQhLJ63HNtGkjGo1g6tyR1qVpCOTAUkBbiZg3lpDIA77fsSOUFYuQnOiqsDK?=
 =?us-ascii?Q?oEZL5636q+wIxh+r8JcT3jdJDeIf3XX4NfpssFl3bdm4uB01yqVy0VeVDM9J?=
 =?us-ascii?Q?xkmCzxG+cWQfphsWLheeUl3EgVj2l095UT4k9zqQIx5g5fa326o/t2kEmL42?=
 =?us-ascii?Q?ZX9vkBSeSwDgA1pE331Z2xr1x8sgec5bj2PybfFfdbxPrDQVi8qP30yO9pCH?=
 =?us-ascii?Q?ijJcoNhd8TIAujNRVtM6SPpO9PMAgfx+XmXjEyp/P4V4hvk0tc3YsDl35ozU?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac9be75-955e-4c79-16b3-08dbb41f7136
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:34.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsVonLqToNZreM9T7bVTVvPblTrWH5dbmodEwwUu7CoTOMT40CPaGo/NfYEwc/9R/3PZIz/IyvD5y123uxg/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

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
index 1dd44b38a553..0b7c48b54bd4 100755
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
@@ -1759,7 +1743,7 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	print_check "rm TX"
-	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_tx_nr" ]; then
@@ -1776,7 +1760,7 @@ chk_prio_nr()
 	local count
 
 	print_check "ptx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_tx" ]; then
@@ -1786,7 +1770,7 @@ chk_prio_nr()
 	fi
 
 	print_check "prx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_rx" ]; then
@@ -1909,7 +1893,7 @@ wait_attempt_fail()
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

