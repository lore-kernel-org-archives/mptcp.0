Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACF101EA
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GhkEqf5A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tzb4zHvvG7eYyxk3HColrL/m1CM5yErInmqeoEj7jAl3zmK9owux69jj2OU+GRoq/Ow+wnI7ySzEzIYOx1G28vM88I92MXKq/9qHUTiq39BCmTsKEk8n6emZSwuEjCiOUp7YoGlucvwczVLqCvJOr1TSv4jZKKqN/0Nl5NnlcGdhADYPl3obCDLMQwf9ur1zIaZjkgApa2fPY2vGcgh/b0pjEkT0GuKyZ4BshQVcF4hX7VlOAL8md2UKvKWjHRZ3pFI63qGNOrVIfv7mDG+2lbcW7zXLBjqLURjMUeSuoeezrc2K4VScjcaqTuRiQlky97+jA6kSoFfUWtWtqghKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5BQmwJlhGFE8Isp8xOaqpwa0dh22ICrqqglTn3rcEY=;
 b=RaVguNBuR+86uQFYw8KJeBYh+9FUT9MA2g0b6ICk98bmOjX30c1BOvcEuR5ONM2/B2b+c3xdCAnkIHFpMtfDCRDbEBobqtnGCXX5V5t3EqnHwoPQlDmIxG49fZdSwiJaaX8ZJYJpI/21lV3+X7glC4AmvIzGMFRDRHQ6Cx+5blPqujmrAqfuU+psTTTD8gGnrv/tiO1icqS89MJCAjRLJZP0RJQqIq+lyVHO6kKD5AinuqaFg5f5vMIOh7pLTjPowffhgO/u2IxvhNU6n6QAQBFYDTEijsdovQKTJFhotp+zxf2sp0LSUsFNfFL8uNDRoYuxogOlyezk51U13QaInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5BQmwJlhGFE8Isp8xOaqpwa0dh22ICrqqglTn3rcEY=;
 b=GhkEqf5AsYsexI1osTT7KQQ2ZCTrHYpzCVfbfOKdm/yvc5nEhCOHBDbFj6XAkjPWY1K0+PdUsKeUfm8pz3VHC93HOYRLpMIIW4otC7CmDBEVTmVhrWE8hYgoOMmRAP47F0YNlU/8mMFLG2ZLE2ANq3rpGU7UYN6mT0jGrAwEB1K3A0r8qbEJHjTJlfCl/h+QxnW1MOdiyANK1voMTrMkIAvuQqdTkc4HsRdh0kn3usfJ3Bb73aMK5qrxBdqF+mS/yClrRB0PDQxaE+AFOFJumF4hwOFP+S514Lz3alFZLCYjARCHHqcX3cAjJ+bR2ZaMZWBB1tU+HVctvfQ98gcfQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:44:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:44:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 7/7] selftests: mptcp: add mptcp_lib_wait_local_port_listen
Date: Fri, 13 Oct 2023 15:44:37 +0800
Message-Id: <71949d82783458d066f4d49bdc5a0e24d8687e04.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 2923f33e-4a59-49d1-a220-08dbcbc02ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zH8fV+icTo9vyetOZ2BlZnbCEWgslFnzVx/tN7NsUIbVl+mVFSa0YvVGat1OOa4Pggbhd+68VCPs2eYBueKGB0vs/ycfOM4a4s0Q16De1X3jUb9Ihm0OuTKZw1OKDDcaSPZ1l6NFBc5Pn8BKX3VoIZx7Yh+DSh4ixRZ52aZ305DEcOV2byB1cTnfavDTrLyJ8uEeRLOgwAlotze0n5k22Ctd5WHJeAJlo4GO0TkdjSeDF+fyGrlCUTsB1mo9BvdjGfq8jgjldNF0JnAcwA+O+BoFnwC+73yv5v5BbAi+59Z499/5yNcqYAIcIdflRBBMPHi7ZrlkktYH3tFNyWgNHhfY3RhchEdt5vs0qG3FlLt9re/A/thYtZoTOwmYImqYiAfIeoLxAbHbHJX19uydB0QJXE6YoFHcswNg/yezxAdUsPppOyTI1nDi2v72WoFWMJtIhys893tbml3G9gUiAgS+D1EOqaUgHEgz/+RPjq7h15ADDweeOkUdCDnpNAN0WsNFmjoO3OGtBb29mDs1bkZS818TwsVrEd4XpO1hdyS6L+Qbb1y3eews7D0LY6jhA/DbKFCUWCQMGPGGS/Ush99+LD+eISdT+0n1p7+FoCZ0rT1PV+13K27ObYAQbfq0w7l/kl6iabqRu2AO/5MEFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(66946007)(6916009)(41300700001)(2616005)(66476007)(54906003)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(2013699003)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z7/GJHmIyjIHbcHZ9v2idoYcNRIFwEgqTSNT7eyOmOP21E3G84Wi3YC075w5?=
 =?us-ascii?Q?BuyxdpfgoKynrQgpZrvYARz5wPjLAJi6wJpaqAyV0NKjLSa16g46+CNBfqEK?=
 =?us-ascii?Q?R2zYeFYRvgzDQknpQN/KyodvVueCtT/0mbLN1QDRtIjaEuFSdicQa1DT07yD?=
 =?us-ascii?Q?I/6XHOVkaKK8nZQYyBjUmh7KA/EaKcSkMwHcvkSA3E1eo0XH9kslRjQAXK3Z?=
 =?us-ascii?Q?Zdsx/50BK2ES6ucTlrTzKRHiFZ9U1/+xiB1OfwAWd9hYEP1XH0G6ApcGztp/?=
 =?us-ascii?Q?v+Nkp1XGDRA9IRybIIcyUq8rulQDJb43phSrq/xrElGLXeM11w/r1QOsrAD2?=
 =?us-ascii?Q?Dy9c82d8DPauZ3U2Bbo4HxDfUn3e8Ybck8O/DTo1zYm2qXt6pCFpBQJY3F01?=
 =?us-ascii?Q?iG2aV6shDEvPrKJFatLlYHIV4B9eyB0QpBQxJJqdyZff5H7ooJ6DdFe+JGi5?=
 =?us-ascii?Q?Dr9NU51cdPC1+NPosyx6UGhLS0rtnL2iLXFUT4dKzQSf0K/ayWYgRvwNRBti?=
 =?us-ascii?Q?/5MEPMepfxgIhbgqXW7Yzha1TYARLckhxszTbl+8x39ybsnurF4fDFcNI0tX?=
 =?us-ascii?Q?uESyEKiGuEIKEd/nIoM9o7ECbnjjLv/+TahaHNsrurcPIFRG4Ll6IP7ItJnN?=
 =?us-ascii?Q?erfE8tZ3hs4WoTHMGhqrgwW7Nk59Kygdx6za6o38SCr/x8QK7fjEMtQHEuPc?=
 =?us-ascii?Q?tUDy68pBO78xedH0LJoba+nl6XDyWRXLD+rjk0QiBkVO/HsO4t8rKbneLUaR?=
 =?us-ascii?Q?w0jXtIC3N2GUdQQU0ay5T0PBKqhFog5Qh59qIMMnYx1B4jsOMmW50DCp6Vdq?=
 =?us-ascii?Q?2Oq66iQTvJotAN1/+PDUsrpUYN44Hpuft4Len7yqqbI7CNX8/zUyBABwZonS?=
 =?us-ascii?Q?8KtBI6GmQCzisfcPWEY8+QxRtkMs6BJgfZMKbJyLTsUqZBVWAUraKcKbAvZM?=
 =?us-ascii?Q?xF3Fu/ZFifxF3I0+JFWdusuQ8sq39xjRbUdzm2++/cD5gqJaJh04KvAZZFSf?=
 =?us-ascii?Q?M4q4cl90pAfROui0PDcusKFTmi9lP2upIeVGJxvExirkB8tgZkdEAFqFpQRk?=
 =?us-ascii?Q?zzBeOQwahSa/uSuicUvTdnt6nVbQQvJlnJWRzVa0zJ8nSVO0SqkC31RQkSbi?=
 =?us-ascii?Q?EZ2yd8BWDap0HUqO4jsplxq7NJmVtKAHlHRs0dwC6NGRkUdOSQs2xJ3OHhDi?=
 =?us-ascii?Q?Z1VweL+Cg+Ws0/nNp3Y2IGCUtj2mDThAByCWD9V6510R+YBDd/G/d989rPm/?=
 =?us-ascii?Q?WHwOxOtWj3PFgBm8uJAtGJPOPbLcDbGUjGRGkgFk/ffIjxRR5Z09VxvomtBM?=
 =?us-ascii?Q?VPWNYQNzUU1SdgcpLmA2cqhHQ16lTOucLhRyvmAFADoIisooLunS5JnFEpsY?=
 =?us-ascii?Q?gbBtDb/naio08K1ioL1qamCIkQb3bLeVq/C90Ajknd/Scop+bqgyd48BE7cq?=
 =?us-ascii?Q?3XkLGeEX6BkcAyYItWlJX22Hh4GNfNcMqjEeUcYw8HauZephqhthdOjpij6C?=
 =?us-ascii?Q?0D5hVaJ5/41GnQHlb5d30KT0PGPSX6IOyrUVoQMgim8oTqykoJfT5P124umr?=
 =?us-ascii?Q?y3Fy+Ccp+gNrkN4qX6AbD7rn0WctLctQxEDzAqDCH7fxn1mDcz7TliFGfKjI?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2923f33e-4a59-49d1-a220-08dbcbc02ea6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:44:08.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Smkynj+ZC5M/odZEaAS3QmM6MCQq32FBBBBGohq51wKpijZ4vS+S6OHygcAzFECrBpRk5XN+tRPpE9IaqtYBZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

wait_local_port_listen() helper is defined in diag.sh, mptcp_connect.sh,
mptcp_join.sh and simult_flows.sh, export it into mptcp_lib.sh and
rename it with mptcp_lib_ prefix. Use this new helper in all these
scripts.

Note: We only have IPv4 connections in this helper, not looking at IPv6
(tcp6) but that's OK because we only have IPv4 connections here in diag.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
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
index 15f46a8c0ff7..fa1675c37201 100755
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
index e0fe6aa4f958..6f0a9db49d18 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -580,24 +580,6 @@ link_failure()
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
@@ -1082,7 +1064,7 @@ do_transfer()
 	fi
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_linkfail" -eq 0 ];then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 30096acb41f2..ff959409d08d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -281,3 +281,21 @@ mptcp_lib_check_transfer() {
 
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

