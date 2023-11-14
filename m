Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4F16412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="oVjezXnk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLfoZyD5XY1kSOSMKU6o9+BzGLIZIIdClat3X8oaBIKTfhELvYcJGWJWm8n7qh1z7hULDT2VRHPaLQsxD7rRVy4nOzu9H04Gv7Rgh4G2g8PZy5QEULPIsSyV0J9g11bZXOuMB/kP/XZmPFazjZPs6YxvW7AXVpnlugJsuTH3UL1+4yf9mhcxEiY8X3TFNmGaq8yhMxqBE6+P/OcSpv9sraXjQe/GFx0jRFxQTwV4eW3zIeG+RjyKODO3kE7IVeamtXuDA3r6/uQzU8QDN4uDrYFreXnJVwO4bEl5iZoQ7dpbOLIjWCKDGQi9vdHLqVOvIi4Xm0jeDCHkAUKq13HPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GByRMhoJmYKTOwoDzD3yf4AzdlJtmvjNU7vpI0qa3p0=;
 b=lsOJmLjvsshWvFiSSPLADF7yjrpILa8F0XRC56X+P0m/vO7fCaKg3asLmjeaGI6jhuEYvzlC7R5zJHTrWO3qz/p4gsS1IMSayZvtI3MzmPvwCZS7h5I7wGc3SKmjmB8NB7xoUgV+jntUDsOdt+u8AlHuPE3A7Ukqs9kWEipPSPrfWJSAu9+7S584c48pOQXZFZLCPTda82raY8tcJEpqrybs5IpzOM4TuvQG90Mb+bnTymZ7yYykOPEeFC8q6zRrEuVbnm+t1Gv7fhvmIkgxu1DOeWwL/cFWdkSZCZD3pfBHvkXAZFhiNIRAxdGm92JChNxWcfjjrhM64e3QkvHx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GByRMhoJmYKTOwoDzD3yf4AzdlJtmvjNU7vpI0qa3p0=;
 b=oVjezXnknzqUi8eiZULkiw8VSPaWSBht132mrRzWJ15LHVlMLPddfi6vnixLFZFDuoJJLdYEZQrC8tz6h8yfe8k4o8TGYXFACkrl92cPcojHWxCiQHu6IRn72Lds3XvEYogiFesqhIuLlMrFdiQoFL4YsLX8Dj8pXz/uJn4wSRAAbdhfO+8bqk8BhVsiONn53uFRC4pkXLAzdIXbe02JSoFxZBLR779raqklPuQbO5StcECg/SINvClGIvRPgga0XP4ZkZT5x+JpNBtrxVkX3fGriBzsjgHbtiw1FCD5n8FPss5ZZze4jAAK3I8VykMdO+ngR3P+cOZJrMoxwNYiSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 10/33] selftests: mptcp: unify namespace names
Date: Tue, 14 Nov 2023 18:21:40 +0800
Message-Id: <0dea4fe7c2cf50ef187683f435e845bdb85f4861.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 67150d05-7b65-47a6-2266-08dbe4fbab59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WBGrlyqRhvbWDty+wgQXSlQRTGezoUKnEgieHV6y+ksMCMVAr/xYN7Nuaaby7iaZLW1VQTS+L+AcYRdO6HWMQ0o4lUQ18eknTv/RLdbjccjW8ZK6BX5ESXH10XhNwSR+A40+iJmPhfSOpUWhnIKTYi2bnHvuStvp/0uFz7yloQI95rPEd11zod/FeV3NHwZwLUTEv8YdeyykR0qcGJLTUcCPQExYQDmp4dxO73HSRw9q3bXgmlldndokytNruK7LdIbotvl5KyVMTtTkBLW3meWCMdlJ1WbdVGGpAkCr3OK/LmKgpQorj0VUVrqqfTpEk86Lw5jHeSetQn1iqPTTtR/0CBEgs2asIt2VPAOgMoQm++TxueLkBp91mfpSCiuA1ZBKwBfPd8hxV6rxucDCBgjwE136h7Ch+qd6pPwNBH6fbtB4TelwI+JlV4KPWSVfs4co0ep5Na3OY4HBUbWeA02MCk+i89IZy9fHNMOKcM8ULnx87yrJs/iWzUVVfx4wZ0mGMCLpGgBFWLx2w88y0FYn98c8AkP7maeKfI7IxCac9P9FN2ypK2GcwH/G3isT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rwYWKiQuGK0xPeLRZttEJ/sM3Uyz9mKj78cqYGAkPXxDyu9s1p3Oa5n7kaK?=
 =?us-ascii?Q?mNLsQejS93Sd5lw85f/acMAVFUrg5lPVymxTPgNQ3aMBP5FpBvpI9qtTb5DZ?=
 =?us-ascii?Q?IVlbwc9VjC0e7H0+EZ5uQdV43W3pvzIHIYbpwS5VXiEauhc689vRx/gnndlY?=
 =?us-ascii?Q?WRVnInvsDLrMoclV7khwwhxs1t7yNgg87o+AcfzWzwaXd75QWUocrJJDreTq?=
 =?us-ascii?Q?n0qtjbpjGfTz5XO8aN4AelzXHCuSXWIwwsqh+pDZ5ch6Zj9oh7JlTO7k8fBs?=
 =?us-ascii?Q?KR4Fal2Ch6S3p9EIadth11jF8kFfP2x5K3URdim5kHbe6vvQWw4ff9lP4st9?=
 =?us-ascii?Q?zssreE8pPUv3Fr4KFi2KQTHvmLamSySHrvNv5X5JJei5RbLKV6ijZ0J0U8ul?=
 =?us-ascii?Q?33dhMo81MzbrJ4IhKFwBpnCgNoExtuUN67/iDL9oXT9Wgj0UkMili5OTmVPD?=
 =?us-ascii?Q?uNV0fYsOdFE1qLLayAuQNy6EUmROs7ukSU2dbCJzQa3lIu+bR12fJE7clIMP?=
 =?us-ascii?Q?zRTnFn2MSV+Q9OLdJsfki6zmHpqplxq0WNGDxclYdzyF5vWv8kw/xgZcz1Mc?=
 =?us-ascii?Q?LowgAuw355IazWm3dDhAQw6gcinKvPEr6iKDDpYH+n6C2Lf89Vmzu+jQD8d0?=
 =?us-ascii?Q?kQqboDBdGCxuD8SpC8KzkhkrpHpC8ROcPj9dgFSrSv7Ywe5+nmuciifIx6mh?=
 =?us-ascii?Q?E8Aqr49IPRfCCxebcseSzHdy2aFCT8YBcDzxKdBlvT/mAJXYc1rlEyN95vz6?=
 =?us-ascii?Q?7kPI3r/fLys78O++76ne06eX9Lh8wbtssZoD0ZSqM9zGIR+buYeLROFNkWut?=
 =?us-ascii?Q?m7tHSnESfuDpCoGTUrEBhnV/MwEsX/sHKQ8g7UipSbDcrdwljE+NKtmTc2te?=
 =?us-ascii?Q?lyXigoQB2VZJ9ROV2ChaanqOpy2zu7+lFqETMHAAPWAiS/SHN0dr/mg/ndKC?=
 =?us-ascii?Q?O8bqHPtOXsYaGurFbNDtPFejkJhzZ16CmCUkpNNr/sp9lEoW0nBFXmWcvuxp?=
 =?us-ascii?Q?ujpdJRuysxIPtHPsVyhKAbiactMjYzW3hOOqkkRFsPlRV4aAtacOhIWGAzuO?=
 =?us-ascii?Q?wwYoBp8sa0/sb/RRknVwOzj79927+ehlJYYWMEj6GAlDIT2U/TgmTb4HD35y?=
 =?us-ascii?Q?HoWXtJRrRIfR73syjW7UsvqIGfPMU5BGJB9ohancnsTAlrEttXiuvx967qnX?=
 =?us-ascii?Q?0u2jIkZrEbu9votCO4n+Uh/1TPe2wr52zKErHN73OAcRNbhXT0ydPeYOcuE2?=
 =?us-ascii?Q?hz4ZUnhGEiDR3upjkJ0Cmq3010a4gLiw7mOprYxPrbdJZfHsheRatpFWmph6?=
 =?us-ascii?Q?ZSpwt/p4oGT5nN8uHn1AqVgM8ZflmsNzmOZLcDRQN8pFAFo+cng1okOT/Hvx?=
 =?us-ascii?Q?SKX1j9vwCXIu49XHBZSqmj1dy3H9lZJF8TTkkua1yUYshwU81/E+GIIYOCM8?=
 =?us-ascii?Q?D4iBEpVZuQcdrlYcSctoBXbI5tddVhVLONYWaz0eHcU6qTD9eFSDcOD6V1PV?=
 =?us-ascii?Q?H6nI2Q74lByHvU7wK/j2ewEkxd+Le/NPwqKz6sflYM/UW3KSrud9giCHc806?=
 =?us-ascii?Q?gw5iJdNIYfjnxkfYiENoCG4E0DlE0RHhA2dxs5KcEgkFvekSb7AP/YGgBI6P?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67150d05-7b65-47a6-2266-08dbe4fbab59
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:56.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXXKY7cIkLmyQYHECpPjKGJ+gj9I31fN4iJaeslifALaLNV471X0GGhnrGUTHeGjIjgB+3Of7XvAdil/afLI1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

Most scripts use ns1, ns2, ns3 and ns4 as namespace names, but ns and
ns_sbox are used in diag.sh and mptcp_sockopt.sh. To maintain consistency
with other scripts, this patch renames these variables:

    ns        -> ns1         in diag.sh
    ns_sbox   -> ns3         in mptcp_sockopt.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 46 +++++++++----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++---
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 300aec419dd6..bc3f24c454be 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns1="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
 timeout_poll=100
@@ -17,19 +17,19 @@ flush_pids()
 	# give it some time
 	sleep 1.1
 
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
 	for _ in $(seq 10); do
-		[ -z "$(ip netns pids "${ns}")" ] && break
+		[ -z "$(ip netns pids "${ns1}")" ] && break
 		sleep 0.1
 	done
 }
 
 cleanup()
 {
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns
+	ip netns del $ns1
 	mptcp_lib_cleanup
 }
 
@@ -48,7 +48,7 @@ fi
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
@@ -83,7 +83,7 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+	__chk_nr "ss -inmHMN $ns1 | $condition" "$@"
 }
 
 chk_msk_nr()
@@ -104,7 +104,7 @@ wait_msk_nr()
 	msg=$*
 
 	while [ $i -lt $timeout ]; do
-		nr=$(ss -inmHMN $ns | $condition)
+		nr=$(ss -inmHMN $ns1 | $condition)
 		[ $nr == $expected ] && break;
 		[ $nr -gt $max ] && max=$nr
 		i=$((i + 1))
@@ -143,7 +143,7 @@ __chk_listen()
 	local expected=$2
 	local msg="$3"
 
-	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
+	__chk_nr "ss -N $ns1 -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
@@ -169,7 +169,7 @@ chk_msk_inuse()
 	local msg="$2"
 	local listen_nr
 
-	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	listen_nr=$(ss -N "${ns1}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
@@ -197,24 +197,24 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns
-ip -n $ns link set dev lo up
+ip netns add $ns1
+ip -n $ns1 link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns1 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10000
+wait_connected $ns1 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
@@ -225,16 +225,16 @@ chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns1 10001
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10001
+wait_connected $ns1 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1 "....chk 1 msk in use"
 flush_pids
@@ -245,16 +245,16 @@ NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "a" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns1 $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -w 20 \
 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
 done
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 45e5b5810a6a..b82f7b0b85bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -17,7 +17,7 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns3="ns3-$rndh"
 
 add_mark_rules()
 {
@@ -40,7 +40,7 @@ add_mark_rules()
 init()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
+	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -79,7 +79,7 @@ init()
 cleanup()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
+	for netns in "$ns1" "$ns2" "$ns3"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -240,7 +240,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt
+	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -251,7 +251,7 @@ do_mptcp_sockopt_tests()
 	fi
 	mptcp_lib_result_pass "sockopt v4"
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
+	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -282,7 +282,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-- 
2.35.3

