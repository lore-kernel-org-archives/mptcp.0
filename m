Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BF125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMdJKXgA6/hEVH9DUs3SELt/pACMdxPPXHUnymTYya+Bprt7otHVaQ6dTgTgIqhTo5XLzXpucKx/5suTv1Exs0x1eVqjj6C/SmyuoaGpz4i/ygmMAwVF8a0maJpob+BiaaI2xEm32CgaoCsDzwBwdbozbF1g7VOFrZrSMwuxXSHfcMYtiUqn5XitseGZCZgY3AOltbAaZeGSFfgmS8FvcjvR3+RVFHGsl7PQZdqI+enaVlI5ZZrNqgILG0VfSc2De6g+V24YKkURpnfouq9rkvz2sPqeWIoryD0w9ID4+3GDyeHRMiY8uJxgTIPySOiMrnZEDtL0A0NkaB6JuREfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBnPHfYwLlS/wdkpFJPRYKmaNw+TgwYNUTCFG0e/PlI=;
 b=PP/McDQySuhKcm8i+vMWpMg56LbBJw0z/BpXf3EP2H1anRNnu5VbUucd6rom5OfREGyxO+++N7/Odho/f7PtggPqCLLkur+HhiDrrxyuLCAiZitmTa5/UpkM9AB0j1ObQeZujuu/ZE0sVg2n8QG1UNGQp3x9wEfkXslwpbZKkQ+WJD+09DnKz19wq219DkNqCXClN+a/wyCwb0nqMQ/hJO9anadXtUssGKVgukm8wRYQc1ZtZ48PmjCK+rUnb/LsyUVyDy2o2nd9DJBinKfl4/g/zbSoc2Es0/q5RMTsyKCtiUQYGVtgRuF6M7VBAO82GivxjwgVtHEk9fXMNxgBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBnPHfYwLlS/wdkpFJPRYKmaNw+TgwYNUTCFG0e/PlI=;
 b=HQn8S8FiCgt9euaSIpYEVjxON+Y+xWjXbfSzeYmy/HA06tVl7F8neYWi8i6HNMeQsVEZHCk+Q2lSIABsgXWylgqBCl7zByr0FXfaDAmhCs+CPh2vcxho6BdVyI7ou+oTX0mhh5P6kqfShgfretCBXFAbbCQt91sOsB3Ky3Pnulv/h7jgtmqBdxMkAI1/jLCmrSMVLQMpmR9rn9L9YpaS2qa5IVZZCHeKTs+FJ3/QRz44XmAWWeimpsAR6d81fh1TeGml44eTwdL93rLJ19trIpCUjEshljGj6rHwWJeosN5MiJH4dLBVa7w7CZLscundEBg+Is86KaZNj8/lcCNs4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:45:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:45:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 29/29] selftests: mptcp: add mptcp_lib_wait_local_port_listen
Date: Mon, 25 Sep 2023 16:42:08 +0800
Message-Id: <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d91d9fa-5d60-4da5-8670-08dbbda3ba47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXgKElUdXrpPxFswW+EMxlAK1fvOYiq+SWCmVvZiQ0x+kQeEmMLiDg9ZJ42RejymPw+9+ePLxvQ844CJa9XEHSxwmrvk+k2Ug8m+P88ZceCX1KWwN/NDds1Ky9FVZjlEtUb6uohwO3PbaSH0TbZ9LOG8YHQ5chnrdd+Jcf0c1vlxNnC/0DWQcp9w154uui9IRSyas9tz2Z3YrO8FOkiuX597CIqEJ4+bdFW1LwejCB9Av/vJpzlvRSLXsTv2gMkxLRgvKFfl5JeIaZS0kGWl1+rKPyEEdldMzsl5Pt9nr1Q/NsiDmjQ+laGeYBuL0TsMwJdpQb9su6kBfMlTLqOSVNhkB2d/9PSrgLbyg0ktXK+e317VGPJx9ZIPmRaG9d8AjX+bItH5/zmCT2VjkwyOJej+K1xqgFlZIOw3I2Th69aDWxdQWjtkx3oUpNpaEGOamb1RHZus+mJ4qqYX5izY8k3BTtTLyB+Gv9QiwiEiUYRBMs95cWgkntwVOF9kTZ9mbK84pVxM29k6C/j7OVKFLv9yuUj9sIkCv7YFFff2J1GlCf4ulm189lBPqN4FUodSgD6N0USmZgpyDmRq9CoU4wbwclH2eJIcPAf4MO4B7xHqtSm2UQsE1njqj9d4ndH1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(6512007)(6506007)(6666004)(2616005)(26005)(86362001)(66556008)(66476007)(66946007)(478600001)(6486002)(38100700002)(107886003)(83380400001)(2906002)(6916009)(8676002)(36756003)(8936002)(4326008)(44832011)(5660300002)(316002)(41300700001)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7PczGuDmCX0RcoztjfDKCMZxVRmCx78jmbE/zW+pIDwoSwXSGrGlctj/b83T?=
 =?us-ascii?Q?r8riKfZLNK3vRJeYIM1n57Lps2TxSRRDN8+lVcfzfhCMh784EN3V2Yy+TchK?=
 =?us-ascii?Q?/aT5d2LyrUgd9Wfmza5mJEmNYIQGd3Ad2dcWpW7yJQJs6qn8FGaZKY2vo+J3?=
 =?us-ascii?Q?hUegtr+DAWGrMvK7MKNEd2BtgMjMxw5INwNp4XW7KXdYQx7/l73fsNTU/+ue?=
 =?us-ascii?Q?LJz822nQqKxUajeHi4xZhcLaLvGK9I4TUBgkUcjBVVTbly99m2O/J1/ITbIS?=
 =?us-ascii?Q?dZ914Ms9ct/YR12R4eTIjqKmmyFWZ1/KKH/ZoFCQlvZCp6OWHAIp8TJSsnBH?=
 =?us-ascii?Q?+/j+eotU6U2e9MuoP3gdL3NQ2+cVFBPY4dERU7GZV4oIwBfunr6bWc2lFvmX?=
 =?us-ascii?Q?DbkvQ8oFTZVuZQpFlEQ2MyfLpFuIhk8TJ0mLU3kfPCLpzG/AEKeon0DTfm8w?=
 =?us-ascii?Q?ZZK9nI29wyLrsPDOzQbacv9bV8dsc0YRlo4FABKePPtTox90i8Swo7Dn63pv?=
 =?us-ascii?Q?Rjc0CY+lgxlFBlDDLKaanJ5S/XJMVnEiQ9myK5KOHSPwfctfpZj9B0PEMNDO?=
 =?us-ascii?Q?5SHdDIKtxZrKlel5b1jgSn5CInzCbrmhTeBNMEphUP1s6ioYTELeMQAInHz9?=
 =?us-ascii?Q?qTxTiMfnWsAYlq74kS4rNs8BElQtWKJC2FnBunR3+zoqCsAbgx1xFbdkSWGn?=
 =?us-ascii?Q?w4W8XoA7q8hYhqUiRG5jRx1I+NoMM5CWEWr2eAEAFlX91gzRsfIQTVGc7p+l?=
 =?us-ascii?Q?8BA1bp/LTvJDmiWx1E0jSW29VW9y9KyBeFYVVzkC0sxfkX5VA1AE10qPN7Kt?=
 =?us-ascii?Q?4fVVNkOpCjyh9zz7zjnk5+VyGP5Q9x1iZ34c6puRnmJRKIkK1Yi9nJY52f99?=
 =?us-ascii?Q?lu7/x/Ms+Rfv6yWb1EyQv5GQx1b3OhU/cspdisMiZNlSJjg7KLkq0ivlrZvJ?=
 =?us-ascii?Q?TW/Kh4AEWi1G87sSOso6rVD7d9pkuQgXVecYH1OeV0PhqQThDXyQoVEtdDDD?=
 =?us-ascii?Q?F5lr0Vd5omOujbMyTctYR8VSJ4029k+4bpFR/49YhBz0/tAE2LvPpREtdowC?=
 =?us-ascii?Q?KlAXHqHXHSyC3XR8ZEk2QItXtS05zL9WLQmdjciv6QAqJQNTmqA4GL3tdiTU?=
 =?us-ascii?Q?OvRpBTgG//4ClT/ox+OAyDmHa/f/0CZ5i69SjT08Fp6YLLaiA2Xq27aN0Q8y?=
 =?us-ascii?Q?65RemHq7SJTGlhbMOWgKDHubVqp+nYhDNQ7ePfpBUKoOO9H+PQjp7gr4MS3M?=
 =?us-ascii?Q?nqfJ71Lm4FmcEbXS64Ge+Oq/RAWKE5bmXhNDgbefKQePSY1VsJR9Fp/fbfvY?=
 =?us-ascii?Q?PSefI8qofAfZeW4Z6CP1oG2DkpFAQbZYEaG7v6hUeJZBKoayaXk0RRDuRBtm?=
 =?us-ascii?Q?ru6q4+Kg0GQy3G5k9C4v1Pi6cgneCNzZRyPRF0fQ1dhRYto2hCT/Bu3CsuKv?=
 =?us-ascii?Q?ddySDyjyyRLwTidKQ5aqZlWA9dnuyjsgrLtM23qc/rDlOg8QMeJgvaWreDhG?=
 =?us-ascii?Q?eO+ykUY7Pdg6RQwn0z1Sld8+42Q5K6ZgEMK47cZWZG4rfdjVZIAa417I3Ufq?=
 =?us-ascii?Q?tGy9FrJ7SvMn7aFm5MzS9XbttO6UgZwt+F1YqMyG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d91d9fa-5d60-4da5-8670-08dbbda3ba47
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:45:10.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzbWTXB9z4kugzX5a5JIh20LMeS9iXgrpna2QVo4cmQA4hYXP/fsWabG22/x+JeVpNKuBiXBkmUdgpfEjxaYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

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

