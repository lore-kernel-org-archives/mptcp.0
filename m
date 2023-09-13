Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F0A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu6pu/NbTPIZqH/kPCWYbCz2HrQVLzmS3+TjXWTag9TwFv4SZlk+N3182gUoaK3iML345eYV8uEz/kNxQBOQ93OUt8Bc6JmPfK8c/WYYyq2f1IhUdNrT29RDj05B0LHiJ6cy2WWybim82ype/mV/rzBOZ40AHWL3/qSlBGBrnMHtpr0QgwjhQX8oYYZ6qUvByzB+nProfwy7UuafLMvp4+Qno/Xb9MFy9fygWH+p2qJxH3TM7SccMVHzhBpaRLHN8OlzyNzF5ud5cYb9oKoww6sMEQgF0ud2iJkMuCwtNDpFehpNQc8QmwVkg0aDXfjwgLGH4yWP9WIm/swCabQHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvZUU6fcRZ3C7krQrDKHOTDVQw5e0zQIP5bBhO1IR8Q=;
 b=TQeD1ufN8Drb0WGxJTYbXoLz1PZ71z3iBhj4/ErufnfM/dBP4BveYKjYYVK/YQ1d5uEkAPUJxwsTQXAkIgpwa8tuxljIJgCdilpeP12aUp3nORLh92YSte/lf5aLlF4wMMbBtClY1ys8FquJ3Mdc3oAVhqAnRib2cq7H0bIPKKoC1nYw9zdwX5LogvvDb3DuF5zNO6LyTWOuu23+gzIyWF4x7lCfd1VIRToZLz/z++YR1q9ujTD1EKGy5CqnvtHSlbgZ607xc5cZqPaIFvtHjAzNg+diq1YE1ead64kqyVyqk0NMEb8DRSfvIVZs/0kX4DikedQSLsoATP/OiYcSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvZUU6fcRZ3C7krQrDKHOTDVQw5e0zQIP5bBhO1IR8Q=;
 b=uSumZhhQ3NopGiw+7DIYDQFruVeFfUe+04kZksTtF9Kxs6Z88WTY7u4Zpu4/dqbeloh5YrpBA6vI8B0hI/oKd39u1oKXXhSkcnxUYS7e4A/mpi4AraIXlA2VCLcYDmaASHWDYm/oCO2amUZhbQvD9WUKvpglk5vhih2x/6wNGnDjdAV5gZho3RrTOdqoFn7YzelRxZD9XSzJ0VzNWg0S0MghkrbjcKHQuEaJDMXMH5TxtkLbOzLj8ybPUcIqo3AkIJNITxPFK0Dssz/rLIPlVn5I+IN6KLcLxy8N3UJaIQb13v37PMYo2YeJzdtJYvtlBxkJiTj3VMtezdCqcYC/Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 13/13] selftests: mptcp: add mptcp_lib_wait_local_port_listen
Date: Wed, 13 Sep 2023 14:05:01 +0800
Message-Id: <c51e4549aa039fc9565df001bd409145d918fb34.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 4516c8e0-d304-48b8-d0f3-08dbb41f7fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	97IZ9zs0iL+h/xfRVYdp9QVkMz3yiex6q+gD7ZjCJY7nhKlwzl79Xtv89aklya3EBd+YZoWbXwcbPsmUxGIxrTC9iBmikjqxTSU7zPH7uryHjpEqwo2QDW2FRqLkw+k3AVOO5LzkwPSDcBGgr7HmI9P2DYabW9iKwDI9zejkmpovPzWK5F1TMs/LDwEK1s5cnUPRLjejV/4pZcpnxpzigm3+byug/v/sBZ+Et24RbfnDPgQTVxRt6zeohV0ZWIx2SGo1wm1Q2fqBSFW0fIQEhoOcu2HeVXkIS1OBjNO3zu/IZegTpqFyfjJR3U19x9ilivFFQmRoTEoZyveeJfRXEbJRpaqC2FM7C46U3qvcW4X+Y6f0v12bsDPHYXhwhmU16L9qjq7eQCrl/11kyOn/gNNO/pi7XNQHO90il+7+fy/hkmzDrvkBFHPXo8gw+UsGF4mlVC5ABMRuLEw19gMPZQ6lWYtQX0WIlbqZ3IJ6o0gYSH62ZS1Y0mp6TaZL5jA0KIN0qlIvGwc/xHGzT+lnZEv2hQ4zjLdQ8Jh5ciCCSAQeJ/oAIe6Plz5qOSrEIyeVEWVXYqOTG0a0VyFCBLeffu1UWWIK0PS0dHCikofiOME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fcf2QApxjUNGcFiUjjpRHyzlhVP0byC7okCx3yCdNhOUGpWOcy2CCG7OaogG?=
 =?us-ascii?Q?D29xYOAkqS913AB4abdypEF1W7pMz0PYHDvpzOtg81dsCKGHC+2V1Uo0Eq4j?=
 =?us-ascii?Q?u1wQG2qNcXwtTnpOu1pxXJVCMUjZRgi2mQOGvK1dikTrxmmWeqRLgsePASXZ?=
 =?us-ascii?Q?utLH9H8QKJL2E4GlNDjJAYpG+xP9qJPe+UaFk03cttyV5UHwxuN7OjOBaIXV?=
 =?us-ascii?Q?srGNS+HF0vALMA9VGV1NnPb9UZMbMUONKPygAOg43pd1GtHX71USV3DJfuyH?=
 =?us-ascii?Q?MOPq5XH90EJsfpwX+Rvi7wdGFvPgoOuwCX8dcXbC8zwKtW29IlZyYxsF8S6c?=
 =?us-ascii?Q?ZmXUvKygjzb0cIGdYMmF7F52EMo9Q5/M9Pz5GFC1JApdrtt+NQYmNXc4QGhc?=
 =?us-ascii?Q?tQTqsPiEdxsP9s5BLqPw3CLrsxuxV6uA2HxyYy010RIw6FWhkSML3YFF6JxQ?=
 =?us-ascii?Q?sEXo1L4dH4mzBbTDRqRbxxvfapvsFaSVcVFDfCqgNU/SZ0vfovSpEJMxG6DS?=
 =?us-ascii?Q?flTB011O2Ly6iXOvAdIqrjAVlGs3qEtyabNmCrodZDfXus6518reuLvGojxA?=
 =?us-ascii?Q?kV0hS33I1FelHJA7K2ml1JRv+9z9dvE1KLquHe4JNftEBJkqZSu1/GAkkCH4?=
 =?us-ascii?Q?xKmBjBCcvC4PAHisevF+K380hB+DulhqNMeap4CMWpnfc+H7PgyrE03eUuBn?=
 =?us-ascii?Q?dYUqPFZcSk6aOgqDolDbaA2WQDQwWHYLprkH+Z5YZz38vbT3GuENjSEYZhds?=
 =?us-ascii?Q?eOqet47BGv0WvUtmn9nLiZjqlvsDOEkXTHtBYrug9I2o4pDVsfkWXhVfwxlp?=
 =?us-ascii?Q?wa+dok10Ihw6T+qBDXwmuB2CRjnfprqkiuatnukG+SkXbZuSZajnSYzcpTID?=
 =?us-ascii?Q?4Oid/AX7HoD5tNPpwccdqTEQKRcNWVbtKdFVQqUjEHpx5GLNv+HqIUdojvSl?=
 =?us-ascii?Q?Lj5SG89cC7bE65FShX+VtAPlO68pVsOFlQHFu1wjjQiAlH2zj5A7vIGs/VRk?=
 =?us-ascii?Q?+6V8phAvL6LUpXnVsBGX9+CCXnlsEs4c9pVuO8v3O5f4vat839kxX6OFwFqU?=
 =?us-ascii?Q?vIlvP8JFEnY5qilwsvZQ03s2hGMf7vwvcwxgAxKaf9IouB3kinJycV6JybE4?=
 =?us-ascii?Q?rGG0w5OM330w5/L9qXI7PfM/F11LjsO0/uCBj+VyAmmmAdLFy415F7V+4KpT?=
 =?us-ascii?Q?hKFP2/SMeVaWI92BLIJ7iuOza9XGAjw2SWhDWIAZyvnBw/WX2xkGXQ+bksAM?=
 =?us-ascii?Q?ogmOQFl1qK4ABK13BqykzMHuW/V0Tx5vaVHNAWckhTD5nDR+n8169NQrAI9O?=
 =?us-ascii?Q?fC3Az8DIWPUpXR2pMFhHRsXPa1AXhYUe5xu31TJiWgpsarxXNzi3Ovt/7nKx?=
 =?us-ascii?Q?lA8wShFS843sU461GWBd8jh9mloIlH1jbpuPMiSUR71rZ5+HhxPQ5n06+NVT?=
 =?us-ascii?Q?yCOa54/+71hh5NaKaENUCINb3mvDM4xoXQaWG/dVICPaWLfGL9hjYxHGy2Ed?=
 =?us-ascii?Q?b4R7MpiRfmUwuAoByy058XImD/KTdTysVkEnWehjiw83c/AocS7p7zuJPx/5?=
 =?us-ascii?Q?8Ny90UruKP+Z/6sBrTjZwmx8ImKBCN/2gYBUBx87Zr1TnfB3sCaS8b7Gft+m?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4516c8e0-d304-48b8-d0f3-08dbb41f7fcd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:58.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I80uVQ7qcAOg63kut4LrFQ6fZv8WVIIwZ544iYUFpJdXbImq8xySRE2GjgWpAB5MdfoI+iWfq4qLVCt2VbWpqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

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
index 0ef395c9eecb..04785c3fd432 100755
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

