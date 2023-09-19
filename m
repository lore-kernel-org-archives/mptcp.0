Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8731A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVC3VydQqWnmlytW7iraj7lkACogRnS5EO0bR2osBXkK3CoxfSaMKnazHQQgYg0doCf4RFZLu10ewOoZMp55xHLSLJmM/gNXblhOy0Se5dzxgjkjhJ67qM+TWNkrN8jnfmoytsujHlKnd1j95ECeeqXLcJIK47vkBxZjJdlrA4Eth5myDbPfXO/DmznZQMlx3pnhEb5UiaKb9xw8gLMr8EFnv4IzJwXrlAGsiFriWssnJBMIHv2C1VX7yetH+09FjuzMMEDwkTzgYEst7Vq10LOkQkhW1ajWnT0T0fNQYH1R4axd9W+6h2Ph/6P/VtzNgtzhLEQt9UWyg83wBkzMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBnPHfYwLlS/wdkpFJPRYKmaNw+TgwYNUTCFG0e/PlI=;
 b=CPfSPS0WyNLvQ7riJKusMGgdgplT8PCwmEx/NN0DkZ2TOT3aoH/uryagez3PEIQ+CKcsvjMoQqSbF6vzawcU7SkccRU4pRxsYfW2xncPtcX9S4gyxIADzF/N4P7iKPV3MqtxRANulxMkT2VJrD7bAM4g/MjumfjWFmO1ZDcHIZhArmTCyUgLk+iICmKIRMLAXQ8Lus8lANoTpai9KG5/gEAP44hVk7Pe+Ntxkt93DSZaA0KWwJHvY/lukbZ+56qk9R61gbsxvccwY3nSU82GYt4ujG78j9p0zigfAZ2p6MtP3X/rR6gAMlDl8j+lHZ+z7++waLhflQ93nXGNGmCIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBnPHfYwLlS/wdkpFJPRYKmaNw+TgwYNUTCFG0e/PlI=;
 b=AP5b62/nkOeJRMCxLw1bAcECxsvXtNWJ7zYLMr4CN8tKXIZa+BPEPmN7FUcXopIDji9b8gkGnrrl6lIfKFYL3Qyg4SollSCuEUA1rt+MlsY1AupNSdI6sUnYXlvSNBm+dfcUJv2/bOGpI8IGNDvf380LBA6MyLZ00GdHVPyyUF+LiJqYH3rTkVoIraAbbL6HAnQifnczVzpHL27o/itpIVdITLAQ/7Pj9bEjdRCUtcwKkTRbmCvlQTi91jIR5Xo88NXoKSyQYtpOJ3Iu/p3y/y5aujUTEb6fKI+iHsQjB28B6o5gBy8I7LkTy47/ijpQcpFgG2jfbgg6sPv6qslmJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:06:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:06:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 30/30] selftests: mptcp: add mptcp_lib_wait_local_port_listen
Date: Tue, 19 Sep 2023 12:02:31 +0800
Message-Id: <32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: b05c6029-dffa-4247-2f58-08dbb8c5c89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cZaGIF0ZmsbJ6vEDvqnP13s/LwJ8XazfGKoaMc4FhZgs1ol6oT9Ec0DrKOkmEW6ltwKnktSGS2y2dwuOUbr+SyMVfkXh6Mclk7tT8TwwYtmXYdvG3S7Js5KP41MzV6zoQ8maJbfxP0ulbpnxUUlxxYTX9RRLbQPo5SVhmlzaJ1dk1uZGiTHB9au0Jz+YivJK5PYx9B+iNNSilslmk0aBtf33Pnyy8XWXkZx1NlCGGjQxL981As67zj9NKdFMGPJsSTCAZJDLaKpHosjjcN201zmOhBZPdi7T0/hzyjRf2y9kJ3j+FGgc9TxlNY2ZQFTsErUm2z6SBZgK2hyfurlq8f0659j2OtbDD2v9eThsyNABF/EByrSCHvysbbXW6jHkvb71i/MWTyBwHZ8WmO+DNNJMY7cWwaxVrzGeg8TfB5V9zWltiwinQL47oBbyWvmeUPnYyr8sl4wQgsKJqrrq8M1ipi2kdlNh5UtWuX5Ctoki/1YMQTOP/6pAMbgIk9Cb0J9zTaEqaxvA4haDdBkwFRRMPOQ4sI09poX8RGwjnMpzxYI4eMbYReA5jo1EwI0VJLHzewHswPnFpu2nUwYXootHxaCVCRsHJT4uq1UpVuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/+cQfHkyFpjE9ftKYANDTdizcB1X7/qUNY3LiTGw5rfKPjB7/ejpK07f1gg?=
 =?us-ascii?Q?obLWxiSIM32p3J8He3XSjh95BHWvaZ0phCPLf52EcXTYZAY3PCZyooSU2zx8?=
 =?us-ascii?Q?bkSvM/akvWQD/HHdRQUK6JPhMEHlgxoi1DpIYy94og+J0W/PdPHUDhR59+jd?=
 =?us-ascii?Q?RfvSBC/GBrMnJzvIO8v1mLwnHDnpMqerEAaRe0qB+JjMibh3mIqJmz2aAPFT?=
 =?us-ascii?Q?UYDF8yrCUQ1n4H6zx2LlBkE9Au2b/9Y9w53ALVol19pZRNz4Wj/Z/RpfxAd0?=
 =?us-ascii?Q?MQ8CIj2kZ6zTUCVCRJOIWZz0AwYZXP0tvwgCLB3r3CvVwG+9WHqbn6yPjHRh?=
 =?us-ascii?Q?DpokCRvjQYtskAUjeP6UdHqqlUcaX4kgb8SlkFgMMO7qg8bkeNpnl6xr+rAM?=
 =?us-ascii?Q?Ru5y3hr5LSD6ltIRigb6f0q3UQKu6seLaKqazej/Z51nE00+8W1P0OBwiXOK?=
 =?us-ascii?Q?v7IEEibFCT/9wcIXX2xR38vw2lTcjDrlbkF0sFFqQaz6/DXvAp9x8PVfu38h?=
 =?us-ascii?Q?+losVEUaG5Z0TH6unHFwF+mmofB9pbt5bgKw62UUUQ0G52zMj5Ev3xzDV1Wd?=
 =?us-ascii?Q?QmLjyRpYPKKpTzbCFQmVD6wgTtORdLPMFwI9GjoB+OlgwrZuL8QLRrL8u6Us?=
 =?us-ascii?Q?dPre/2jCQITdbxaFQH1UMKBZDj7UIt9EtmiyOf2m6kX8yvy3TlBv7Uh9qKfZ?=
 =?us-ascii?Q?nKPCH70SAwFG9vibj+KoVJmrD7+R8eQsRtJknztne6EJ4M5PN1IIN4ScNG/7?=
 =?us-ascii?Q?77MYL1LiWRs+TIrEQaDNlwyKQhIxD8U6bmq4+dqvZKupabCUKheqW64Py077?=
 =?us-ascii?Q?HjqRF1cbejP/cGomTmZ0ypbIjqwp3nJdP7e2gkpESoSnocmHx4+CEQr8Ktao?=
 =?us-ascii?Q?ytLx1u6dHwRs2D9Y+sWYVIp98AvjEqG98sFARxs3xC0cOKv+JFRz3yE7JsEq?=
 =?us-ascii?Q?k6lEWVFBE/DE2c62QmKAQnqGQLDAQRUmbCkoq7qwPW51F2nyywadCZEnfg38?=
 =?us-ascii?Q?3ldOqHpQNT4pjAXG1tEGfUctmCAJTvX8xj5cOqAO7YrPJrTYstTGSL61MssS?=
 =?us-ascii?Q?gjbYVpC9MDTVwV9Ykdr7pWzCbxi6HnWCYPP3gPtjNRPR0Ql2ZdC7FJjqUjSq?=
 =?us-ascii?Q?bRYRgqClpjxHGzaAc8b06DnSnLS7WUOj4zTkKvNZd1KVreZQMJ+gIWg+FrXk?=
 =?us-ascii?Q?oDQjfZ3Vodpl6lQggmI3bpQot3KEP8n0TyCAw2MCfPAt00Mda5laihKERlso?=
 =?us-ascii?Q?At0tKmSBLJ+Uz4qgL8ZcYpcHgoeijnUkr9IcqTOQY5KMOcmIOZQd99wUm8sy?=
 =?us-ascii?Q?cZsrO4UNcXWri9+vBXsZVY4W6OQsiSSNn/PgCfuJgPb3ZCl8WhE6WPRPHS6U?=
 =?us-ascii?Q?Hm6OgXObSqHyciTJhYWURIIO1S2RmOu/IUXryMytkv42ltAhY0tR/g+oyYSq?=
 =?us-ascii?Q?lF8bgVvigJ0YacBupq9tSexAV5fkicNiXNsyI6PsImSLGgymGtSgRUwQD73z?=
 =?us-ascii?Q?6VNqZmZL0DUQEfk5QfHP/X86k73rXj8rIFzYQYL28u/ir58agyXgcK0tHKn1?=
 =?us-ascii?Q?CL54xBMnQZxBEalBfxYq0I8hz2FUu0yKbQQVBhUr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05c6029-dffa-4247-2f58-08dbb8c5c89a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:06:21.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlaNGtlG4MteaARRttqOzuGwN9VTNuz/WaWAMsEKwjyWmulb1sU43NecUgKwV2VRarRf4HitmVjD3qzpbNjs1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

wait_local_port_listen() helper is defined in diag.sh, mptcp_connect.sh,
mptcp_join.sh and simult_flows.sh, export it into mptcp_lib.sh and
rename it with mptcp_lib_ prefix. Use this new helper in all these
scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 23 +++----------------
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +--------------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +---------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 18 +++++++++++++++
 .../selftests/net/mptcp/simult_flows.sh       | 19 +--------------
 5 files changed, 24 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 85a8ee9395b3..95b498efacd1 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -182,23 +182,6 @@ chk_msk_inuse()
 	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -222,7 +205,7 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
@@ -245,7 +228,7 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns 10001
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
@@ -266,7 +249,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0bd2392ae442..d6e3ef786694 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,23 +310,6 @@ do_ping()
 	return 0
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -408,7 +391,7 @@ do_transfer()
 				$extra_args $local_addr < "$sin" > "$sout" &
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
 	start=$(date +%s%3N)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f88168d66fdc..d11a2289f8f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -577,24 +577,6 @@ link_failure()
 	done
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local i
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 rm_addr_count()
 {
 	mptcp_lib_get_counter "${1}" "MPTcpExtRmAddr"
@@ -1073,7 +1055,7 @@ do_transfer()
 	fi
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_linkfail" -eq 0 ];then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index fba62cdef2cd..1fb0950ce44d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -377,3 +377,21 @@ mptcp_lib_check_transfer() {
 
 	return 0
 }
+
+# $1: ns, $2: port
+mptcp_lib_wait_local_port_listen() {
+	local listener_ns="${1}"
+	local port="${2}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
+			     {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ce9203b817f8..ae8ad5d6fb9d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -123,23 +123,6 @@ setup()
 	grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$' /proc/kallsyms && slack=$((slack+550))
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 do_transfer()
 {
 	local cin=$1
@@ -179,7 +162,7 @@ do_transfer()
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
-	wait_local_port_listen "${ns3}" "${port}"
+	mptcp_lib_wait_local_port_listen "${ns3}" "${port}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \
-- 
2.35.3

