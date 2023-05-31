Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01AEA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1CAO6fgn+tanrLN6xUa8WeFUIO0KlmJSx+iz783So6tqPnLtnBDqvfMt8i7E1I4psJLW4GiEYgr9BR73vq9Qj/QACYDBVvmbYcDBaOBJpatAj5vLPu/KYupDjISYGUGQJhxK0ehTCL9UdR4Tep6Qnm7nFFAfCLVR4elF1A3/SD5ZaUq23y/VK/SXKzMgj33UGQDO6SpErm9BVQR8LyB3kqXXdWqzztIsXbeUyBs1exOyBGyexaUsE/h94UbtIMmKr6jL5u83HpjmOLHO0yLUxHCVUh/1spDZUcxwdZ6gecR/1asPu0euykHSOZua+uUrtqD2Lm68W+bz7XthZX1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5Yf8LUmFRPjdvu9VSJ6NwQitFke6FSDP6AXAFtLfSA=;
 b=nNY8CFL3ppIlVZh4VYPO+grMwJ3f53fUzuk1zwxSwU4BoqMPIeuMol4KEg6ujc4laJZa/iQjmwfBog7U8ujLn6R54zEZgWijMRbA/2bZoAlLfW8AoVz3/m+eKX4C15LtWfqonQ0K6HgL9T1ycXmbfMoX8wvKkGicdO8GyeSBrY2vbFb+szFiGEUvAh1RiWikN5pjY11sBHhrCVM24cTei5ddmrQglYj4Y9movexBYunK1i3Gql9BzkSIrC3NM5XoUrMpEuerD9Z0O2LTSYumVdvTvVIlElcowXlSPl/wm+VzzeUyxYY7Ax+qVIeeUCnoHSl3dKYFsik4nGWzwe7xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5Yf8LUmFRPjdvu9VSJ6NwQitFke6FSDP6AXAFtLfSA=;
 b=RvSDjKQ+F1NctD96+IJqYNZeKqV/vdyeEgx6G6silTSz3YewmKaT16hQ+Zxyu53w/GHRRpHbypp0FePN0NYFknGrBxBvSu7lg4H0Mo08jQNMJlZFgtXY6N7dwmmtncteExvA1HV3eJWuP/PCdGum4vh/RqZIIgMlA0377VQw6zPfBLC7GJgrwOvrhfjOgGs4A5PgqPO7OaqO686Wu+3D0mf2h2sT8haC1lC1rZL2mbgYj52ZDN3YGWPjhMThNRKD4qBsGNmY/NEeXqbAnRGkwREMdgJzplT0a/X4qzc6cq4N95rl2gXUOBDDY/xV9JCTKPwo81f5MxQaGtPcxHGgMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:53:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:53:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v14 1/7] selftests: mptcp: skip tests when features are not supported
Date: Wed, 31 May 2023 08:52:58 +0800
Message-Id: <a9154ba82ed18ba04e1eb18aba99c7a84a120665.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685494054.git.geliang.tang@suse.com>
References: <cover.1685494054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: afe0265a-3b1b-4a75-9f02-08db61716f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	djrUqLOT1w9IGvkGknbAQhgE+VakHhZEvgE+p972aLz8GVDdDlIw2/20seAG59g91IzNnpKFEIk9yNJtoeqEuv2XKeQVQxGTVAfkCxkF0FHMaI4KCKF+8zD3Q0/OxxN+nJdRkdcPycgVjlnSMzOfra8+KVfDVreQFA+KhjP6gQ0V79gCD4Z8DtzDTzRtPW4JegfsXD0aos3HNepo+c9NoLvyTdpLG+S16y//3Vf4oqZ9jBNV3LWWl1p4MiGWmvsSo2mQi/3OAFBYcXvJLN+2XwY6w6WXT1V5ptn0xWyCHiNoLfc6FF2WCgDcyX93p8jDpeWW64Bhlob+xHX9lRY//Mi9y+OqY8m7maysxC5zWC94wxpvvIsn7kCW65RqhV1f7xdUNtmHgRYv9lNMvyWcF6OiMaCEZGviVvm/Zzx89X82RkhCHEX5rf5XTcUY2xHigeFGaDriKBOzDYzVCT6bY1mEGnzLyXT++xqSG7K9kJy3S8D9KBKcHwEmo58Vbv+GSEqBJwbE9XY7oUjZqoIq4GIpWXpKTRCjvzF/v9dGzxacAmx9taGxilXULmgkVPKW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(30864003)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(6506007)(26005)(6486002)(6666004)(6512007)(83380400001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wke87GhOYhfPUI3Mhi5SuMY446S2xbhaIOd9xvgNCIYSIvgZGseIdbdHjt4m?=
 =?us-ascii?Q?4VqZfDe6WO5dwiUeMX1oDaruakSthEsi/qpMDO8VQUbhbcD1MFkzVPXzsDfv?=
 =?us-ascii?Q?rHkWXdPpwjQnkqlU5rts6q74J75HAJGVBDzixid7sd9tveIdXFKMMkjt9pFi?=
 =?us-ascii?Q?UKWjBj+T5WailSkoYtiIg6AlxzUUtQTi50r/HcjOlZvMCPzk7NBsm1/MWO6T?=
 =?us-ascii?Q?bD10kUkyI1fy6eC/y4i8H3Nc/kCTen6/MUs3JO7uUhlO/fws56h/3X+HzAQh?=
 =?us-ascii?Q?+jG+ZdpP0XWgO0q2YgBcRW3E0lnDaAayc9FtYoRJB5qAWaDbS25Lv5Ql8Q9H?=
 =?us-ascii?Q?kwUXaKF77vnsIrP5axjpExU4pS7aCyrk2uK39YHUd00ncBPCq49m2HZAFi6d?=
 =?us-ascii?Q?Co/EteFUvqLLcmoFq47iUzPmSk0n53YOoC0P9DWYiVdcbSZf4j0ZoySZspYI?=
 =?us-ascii?Q?+zAlKm8TtienhuLTe2aUOJLu2gxSLW6jMqMLaef6dJh+CLi0xLk/t2GTTb8E?=
 =?us-ascii?Q?QHmdGEm3opurtqoK+hwmGVrT/jn8MWBrJYCpAkPox6ryanb6d4QooWkHdK2n?=
 =?us-ascii?Q?4VdAg3nWLEck7pFRaODHvUmOoKBRQC/L35HMjuIRoMCG4vtVD8xUDKHQADN7?=
 =?us-ascii?Q?CJQbzFRD2689UUM1Z4RZGeDDJsNjj8raAPJHpW27twV+omhDb8eQgsyGm0K2?=
 =?us-ascii?Q?oxMg4P7x6fdSw48RJc/uR4UyfvrnMu2+jteQ/kOM0XC1tNuZIwCOQGK3i45q?=
 =?us-ascii?Q?pTObZqB/gQz5k4bfwzkn0JazZVEazdrvZZSZXpVqlcVUuoDfJi4LyyH6sccW?=
 =?us-ascii?Q?dt58tgRMhd7Rm+JMi+FAItT9+Dzt7V+tKqv2YeHehA3xi6vCzmLxy3ac2bST?=
 =?us-ascii?Q?TqUe1tnzvaPVOWvWtb1y52aQ9P2dWagoAqWqYJfYSnUhhVxjnu+bj0fdCrmG?=
 =?us-ascii?Q?Sj7VG2b/Ovi3VDA6kda8V26wm9nc8DAvAQ3EJ1jiOe+LqISlmxPj8EHRDB0x?=
 =?us-ascii?Q?2uk2GoLx8AMiIGGUwGmKYtjyvlfYeJqjuPXWa5zlEgipTsZkbqWFPbsT3/RZ?=
 =?us-ascii?Q?b7FAQgLkpPnYmlPZ+xpSf1mjWSKHADlDjVRV9Yy3E2zMgM2CrR8wmorsPAFn?=
 =?us-ascii?Q?MKH7ZoC4+BrtfbgHWRYp1+pQLTDgaHyi58LhKD+jKAh3ar9qLwvgQY9RH7k8?=
 =?us-ascii?Q?WFxu2uHh0DqjAtv9LUcp1QmjaXQeJR8MMQVg/uYRQyJk1D/ctCOvBaRmvRAN?=
 =?us-ascii?Q?98VBAFp8Zx502b6c5VT245OclQG6b4Covrn6cuQJCSAljOyBjFpwrvnywUH5?=
 =?us-ascii?Q?iBlsxo0ryjeje2lRVDvyCkpA20/8Ks6z7iSu5xlN32IkvPgxPjT5+TwGK4Jc?=
 =?us-ascii?Q?yA9L6p73hTSoNcGO5HDR/4EaFKI0VmlJ5ESr/ITSSV4uSJkSAaZnBARz8Pt6?=
 =?us-ascii?Q?zHceKJZ99Saai4iErhfS15XJtrkrtlwbaCMYOB3OivRvzm/UJ6bXu6qcqlE5?=
 =?us-ascii?Q?mHXiXyYXnJ8nPfPHLTgkpFKldFV3gDhaXy9e9qrnnGaJjbCo+bs0u1P1HxHS?=
 =?us-ascii?Q?Urk5DyL3ChUb6B0mTV064jjhIpx9/AlFOue66BTT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe0265a-3b1b-4a75-9f02-08db61716f5e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:53:23.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng1Gn3js37FqHTgKIEVF5WmfCa3BGKweaIsdEk1XWkoiFeKhoh0Hhkhzk8nBJyhUydh+PH2eaV7XciTFwKg6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

From: Matthieu Baerts <matthieu.baerts@tessares.net>

v2, patches 8-37

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config      |   1 +
 tools/testing/selftests/net/mptcp/diag.sh     |  42 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  20 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 506 +++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  59 ++
 .../selftests/net/mptcp/mptcp_sockopt.c       |  12 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  20 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  27 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  13 +-
 9 files changed, 477 insertions(+), 223 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 38021a0dd527..6032f9b23c4c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4eacdb1ab962..fa9e09ad97d9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -55,16 +55,20 @@ __chk_nr()
 {
 	local command="$1"
 	local expected=$2
-	local msg nr
+	local msg="$3"
+	local skip="${4:-SKIP}"
+	local nr
 
-	shift 2
-	msg=$*
 	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+			echo "[ skip ] Feature probably not supported"
+		else
+			echo "[ fail ] expected $expected found $nr"
+			ret=$test_cnt
+		fi
 	else
 		echo "[  ok  ]"
 	fi
@@ -76,12 +80,12 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" $*
+	__chk_nr "ss -inmHMN $ns | $condition" "$@"
 }
 
 chk_msk_nr()
 {
-	__chk_msk_nr "grep -c token:" $*
+	__chk_msk_nr "grep -c token:" "$@"
 }
 
 wait_msk_nr()
@@ -119,37 +123,26 @@ wait_msk_nr()
 
 chk_msk_fallback_nr()
 {
-		__chk_msk_nr "grep -c fallback" $*
+	__chk_msk_nr "grep -c fallback" "$@"
 }
 
 chk_msk_remote_key_nr()
 {
-		__chk_msk_nr "grep -c remote_key" $*
+	__chk_msk_nr "grep -c remote_key" "$@"
 }
 
 __chk_listen()
 {
 	local filter="$1"
 	local expected=$2
+	local msg="$3"
 
-	shift 2
-	msg=$*
-
-	nr=$(ss -N $ns -Ml "$filter" | grep -c LISTEN)
-	printf "%-50s" "$msg"
-
-	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
-	else
-		echo "[  ok  ]"
-	fi
+	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
 {
 	lport=$1
-	local msg="check for listen socket"
 
 	# destination port search should always return empty list
 	__chk_listen "dport $lport" 0 "listen match for dport $lport"
@@ -167,10 +160,9 @@ chk_msk_listen()
 chk_msk_inuse()
 {
 	local expected=$1
+	local msg="$2"
 	local listen_nr
 
-	shift 1
-
 	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
@@ -181,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected $*
+	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
 # $1: ns, $2: port
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c1f7bac19942..9cebe0252b78 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -144,6 +144,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -695,6 +696,15 @@ run_test_transparent()
 		return 0
 	fi
 
+	# IP(V6)_TRANSPARENT has been added after TOS support which came with
+	# the required infrastructure in MPTCP sockopt code. To support TOS, the
+	# following function has been exported (T). Not great but better than
+	# checking for a specific kernel version.
+	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
+		echo "INFO: TFO not supported by the kernel: SKIP"
+		return
+	fi
+
 ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
 flush ruleset
 table inet mangle {
@@ -767,6 +777,11 @@ run_tests_peekmode()
 
 run_tests_mptfo()
 {
+	if ! mptcp_lib_kallsyms_has "mptcp_fastopen_"; then
+		echo "INFO: TFO not supported by the kernel: SKIP"
+		return
+	fi
+
 	echo "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
@@ -787,6 +802,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
+		echo "INFO: Full disconnect not supported: SKIP"
+		return
+	fi
+
 	cat $cin $cin $cin > "$cin".disconnect
 
 	# force do_transfer to cope with the multiple tranmissions
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 85474e029784..b4a2c2388d2f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -25,6 +25,8 @@ capout=""
 ns1=""
 ns2=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=0
@@ -83,7 +85,7 @@ init_partial()
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
+		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
@@ -142,13 +144,18 @@ cleanup_partial()
 check_tools()
 {
 	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip
 	fi
 
-	if ! iptables -V &> /dev/null; then
+	# Use the legacy version if available to support old kernel versions
+	if iptables-legacy -V &> /dev/null; then
+		iptables="iptables-legacy"
+		ip6tables="ip6tables-legacy"
+	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
 	fi
@@ -187,6 +194,32 @@ cleanup()
 	cleanup_partial
 }
 
+# $1: msg
+print_title()
+{
+	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
+}
+
+# [ $1: fail msg ]
+mark_as_skipped()
+{
+	local msg="${1:-"Feature not supported"}"
+
+	mptcp_lib_fail_if_expected_feature "${msg}"
+
+	print_title "[ skip ] ${msg}"
+	printf "\n"
+}
+
+# $@: condition
+continue_if()
+{
+	if ! "${@}"; then
+		mark_as_skipped
+		return 1
+	fi
+}
+
 skip_test()
 {
 	if [ "${#only_tests_ids[@]}" -eq 0 ] && [ "${#only_tests_names[@]}" -eq 0 ]; then
@@ -230,6 +263,19 @@ reset()
 	return 0
 }
 
+# $1: test name ; $2: counter to check
+reset_check_counter()
+{
+	reset "${1}" || return 1
+
+	local counter="${2}"
+
+	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
+		mark_as_skipped "counter '${counter}' is not available"
+		return 1
+	fi
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -249,17 +295,21 @@ reset_with_add_addr_timeout()
 
 	reset "${1}" || return 1
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
-		-m tcp --tcp-option 30 \
-		-m bpf --bytecode \
-		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
-		-j DROP
+
+	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+			-m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
+			-j DROP; then
+		mark_as_skipped "unable to set the 'add addr' rule"
+		return 1
+	fi
 }
 
 # $1: test name
@@ -303,22 +353,17 @@ reset_with_allow_join_id0()
 #     tc action pedit offset 162 out of bounds
 #
 # Netfilter is used to mark packets with enough data.
-reset_with_fail()
+setup_fail_rules()
 {
-	reset "${1}" || return 1
-
-	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
-	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
-
 	check_invert=1
 	validate_checksum=1
-	local i="$2"
-	local ip="${3:-4}"
+	local i="$1"
+	local ip="${2:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns2 $tables \
@@ -328,15 +373,32 @@ reset_with_fail()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || exit 1
+		-j MARK --set-mark 42 || return ${ksft_skip}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || exit 1
+		index 100 || return ${ksft_skip}
+}
+
+reset_with_fail()
+{
+	reset_check_counter "${1}" "MPTcpExtInfiniteMapTx" || return 1
+	shift
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
+
+	local rc=0
+	setup_fail_rules "${@}" || rc=$?
+
+	if [ ${rc} -eq ${ksft_skip} ]; then
+		mark_as_skipped "unable to set the 'fail' rules"
+		return 1
+	fi
 }
 
 reset_with_events()
@@ -351,6 +413,25 @@ reset_with_events()
 	evts_ns2_pid=$!
 }
 
+reset_with_tcp_filter()
+{
+	reset "${1}" || return 1
+	shift
+
+	local ns="${!1}"
+	local src="${2}"
+	local target="${3}"
+
+	if ! ip netns exec "${ns}" ${iptables} \
+			-A INPUT \
+			-s "${src}" \
+			-p tcp \
+			-j "${target}"; then
+		mark_as_skipped "unable to set the filter rules"
+		return 1
+	fi
+}
+
 fail_test()
 {
 	ret=1
@@ -472,11 +553,25 @@ wait_local_port_listen()
 	done
 }
 
-rm_addr_count()
+# $1: ns ; $2: counter
+get_counter()
 {
-	local ns=${1}
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
+
+	echo "${count}"
+}
 
-	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
+rm_addr_count()
+{
+	get_counter "${1}" "MPTcpExtRmAddr"
 }
 
 # $1: ns, $2: old rm_addr counter in $ns
@@ -499,11 +594,11 @@ wait_mpj()
 	local ns="${1}"
 	local cnt old_cnt
 
-	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+	old_cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
 
 	local i
 	for i in $(seq 10); do
-		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+		cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
 	done
@@ -703,15 +798,6 @@ pm_nl_check_endpoint()
 	fi
 }
 
-filter_tcp_from()
-{
-	local ns="${1}"
-	local src="${2}"
-	local target="${3}"
-
-	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1161,12 +1247,13 @@ chk_csum_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "sum"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
-	if { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
@@ -1174,12 +1261,13 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
-	if { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
@@ -1218,12 +1306,13 @@ chk_fail_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
-	if { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
@@ -1232,12 +1321,13 @@ chk_fail_nr()
 	fi
 
 	echo -n " - failrx"
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
-	if { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
@@ -1265,10 +1355,11 @@ chk_fclose_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "ctx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"
-	if [ "$count" != "$fclose_tx" ]; then
+	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$fclose_tx" ]; then
+		extra_msg="$extra_msg,tx=$count"
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 		fail_test
 	else
@@ -1276,10 +1367,11 @@ chk_fclose_nr()
 	fi
 
 	echo -n " - fclzrx"
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	[ "$count" != "$fclose_rx" ] && extra_msg="$extra_msg,rx=$count"
-	if [ "$count" != "$fclose_rx" ]; then
+	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$fclose_rx" ]; then
+		extra_msg="$extra_msg,rx=$count"
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 		fail_test
 	else
@@ -1306,9 +1398,10 @@ chk_rst_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rtx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ $count -lt $rst_tx ]; then
+	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ $count -lt $rst_tx ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 	else
@@ -1316,9 +1409,10 @@ chk_rst_nr()
 	fi
 
 	echo -n " - rstrx "
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" -lt "$rst_rx" ]; then
+	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" -lt "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 	else
@@ -1335,9 +1429,10 @@ chk_infi_nr()
 	local count
 
 	printf "%-${nr_blank}s %s" " " "itx"
-	count=$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$infi_tx" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$infi_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		fail_test
 	else
@@ -1345,9 +1440,10 @@ chk_infi_nr()
 	fi
 
 	echo -n " - infirx"
-	count=$(ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$infi_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$infi_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		fail_test
 	else
@@ -1375,9 +1471,10 @@ chk_join_nr()
 	fi
 
 	printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		fail_test
 	else
@@ -1386,9 +1483,10 @@ chk_join_nr()
 
 	echo -n " - synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_ack_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
@@ -1403,9 +1501,10 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$ack_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
 		fail_test
 	else
@@ -1435,12 +1534,12 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${nr_blank}s %-18s" " " "stale"
-	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
-	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
-	[ -z "$recover_nr" ] && recover_nr=0
 
-	if [ $stale_nr -lt $stale_min ] ||
+	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
+		echo "[skip]"
+	elif [ $stale_nr -lt $stale_min ] ||
 	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
 	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
@@ -1475,12 +1574,12 @@ chk_add_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-
+	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
+	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
 	else
@@ -1488,9 +1587,10 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=$(ip netns exec $ns1 nstat -as MPTcpExtEchoAdd | grep MPTcpExtEchoAdd | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		fail_test
 	else
@@ -1499,9 +1599,10 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$port_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
 			fail_test
 		else
@@ -1509,10 +1610,10 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
 			fail_test
@@ -1521,10 +1622,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_ack_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
 			fail_test
@@ -1533,10 +1634,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
 			fail_test
@@ -1545,10 +1646,10 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
 			fail_test
@@ -1557,10 +1658,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
 			fail_test
@@ -1582,12 +1683,12 @@ chk_add_tx_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add TX"
-	count=$(ip netns exec $ns1 nstat -as MPTcpExtAddAddrTx | grep MPTcpExtAddAddrTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-
+	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 		fail_test
 	else
@@ -1595,9 +1696,10 @@ chk_add_tx_nr()
 	fi
 
 	echo -n " - echo TX "
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtEchoAddTx | grep MPTcpExtEchoAddTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_tx_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$echo_tx_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
 		fail_test
 	else
@@ -1633,9 +1735,10 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep MPTcpExtRmAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		fail_test
 	else
@@ -1643,12 +1746,13 @@ chk_rm_nr()
 	fi
 
 	echo -n " - rmsf  "
-	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ -n "$simult" ]; then
+	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ -n "$simult" ]; then
 		local cnt suffix
 
-		cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
+		cnt=$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
 
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
@@ -1657,14 +1761,12 @@ chk_rm_nr()
 		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
-			echo "[ ok ] $suffix"
+			echo -n "[ ok ] $suffix"
 		else
 			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 			fail_test
 		fi
-		return
-	fi
-	if [ "$count" != "$rm_subflow_nr" ]; then
+	elif [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		fail_test
 	else
@@ -1679,9 +1781,10 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	printf "%-${nr_blank}s %s" " " "rm TX "
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtRmAddrTx | grep MPTcpExtRmAddrTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_tx_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_tx_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_tx_nr"
 		fail_test
 	else
@@ -1698,9 +1801,10 @@ chk_prio_nr()
 	local count
 
 	printf "%-${nr_blank}s %s" " " "ptx"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 		fail_test
 	else
@@ -1708,9 +1812,10 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 		fail_test
 	else
@@ -1821,7 +1926,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
+		cnt=$(get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
@@ -1914,23 +2019,23 @@ subflows_error_tests()
 	fi
 
 	# multiple subflows, with subflow creation error
-	if reset "multi subflows, with failing subflow"; then
+	if reset_with_tcp_filter "multi subflows, with failing subflow" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
-	if reset "multi subflows, with subflow timeout"; then
+	if reset_with_tcp_filter "multi subflows, with subflow timeout" ns1 10.0.3.2 DROP &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1938,11 +2043,11 @@ subflows_error_tests()
 	# multiple subflows, check that the endpoint corresponding to
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
-	if reset "multi subflows, fair usage on close"; then
+	if reset_with_tcp_filter "multi subflows, fair usage on close" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
@@ -2043,11 +2148,18 @@ signal_address_tests()
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-		chk_join_nr 3 3 3
 
-		# the server will not signal the address terminating
-		# the MPC subflow
-		chk_add_nr 3 3
+		# It is not directly linked to the commit introducing this
+		# symbol but for the parent one which is linked anyway.
+		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			chk_join_nr 3 3 2
+			chk_add_nr 4 4
+		else
+			chk_join_nr 3 3 3
+			# the server will not signal the address terminating
+			# the MPC subflow
+			chk_add_nr 3 3
+		fi
 	fi
 }
 
@@ -2290,8 +2402,13 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
-		chk_rm_tx_nr 0
-		chk_rm_nr 0 3 simult
+
+		if mptcp_lib_kversion_ge 5.18; then
+			chk_rm_tx_nr 0
+			chk_rm_nr 0 3 simult
+		else
+			chk_rm_nr 3 3
+		fi
 	fi
 
 	# addresses flush
@@ -2529,7 +2646,8 @@ v4mapped_tests()
 
 mixed_tests()
 {
-	if reset "IPv4 sockets do not use IPv6 addresses"; then
+	if reset "IPv4 sockets do not use IPv6 addresses" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2538,7 +2656,8 @@ mixed_tests()
 	fi
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
-	if reset "simult IPv4 and IPv6 subflows"; then
+	if reset "simult IPv4 and IPv6 subflows" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -2547,7 +2666,8 @@ mixed_tests()
 	fi
 
 	# cross families subflows will not be created even in fullmesh mode
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
@@ -2558,7 +2678,8 @@ mixed_tests()
 
 	# fullmesh still tries to create all the possibly subflows with
 	# matching family
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2571,7 +2692,8 @@ mixed_tests()
 backup_tests()
 {
 	# single subflow, backup
-	if reset "single subflow, backup"; then
+	if reset "single subflow, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
@@ -2581,7 +2703,8 @@ backup_tests()
 	fi
 
 	# single address, backup
-	if reset "single address, backup"; then
+	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2592,7 +2715,8 @@ backup_tests()
 	fi
 
 	# single address with port, backup
-	if reset "single address with port, backup"; then
+	if reset "single address with port, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
@@ -2602,14 +2726,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc backup"; then
+	if reset "mpc backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc backup both sides"; then
+	if reset "mpc backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
@@ -2617,14 +2743,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc switch to backup"; then
+	if reset "mpc switch to backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc switch to backup both sides"; then
+	if reset "mpc switch to backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
@@ -2659,6 +2787,11 @@ verify_listener_events()
 			$e_saddr $e_sport
 	fi
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		printf "[skip]: event not supported\n"
+		return
+	fi
+
 	type=$(grep "type:$e_type," $evt |
 	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
 	family=$(grep "type:$e_type," $evt |
@@ -2987,7 +3120,8 @@ fullmesh_tests()
 	fi
 
 	# set fullmesh flag
-	if reset "set fullmesh flag test"; then
+	if reset "set fullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -2997,7 +3131,8 @@ fullmesh_tests()
 	fi
 
 	# set nofullmesh flag
-	if reset "set nofullmesh flag test"; then
+	if reset "set nofullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
@@ -3007,7 +3142,8 @@ fullmesh_tests()
 	fi
 
 	# set backup,fullmesh flags
-	if reset "set backup,fullmesh flags test"; then
+	if reset "set backup,fullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3018,7 +3154,8 @@ fullmesh_tests()
 	fi
 
 	# set nobackup,nofullmesh flags
-	if reset "set nobackup,nofullmesh flags test"; then
+	if reset "set nobackup,nofullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
@@ -3031,14 +3168,14 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset "fastclose test"; then
+	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset "fastclose server test"; then
+	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
@@ -3076,7 +3213,8 @@ fail_tests()
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-	if reset "userspace pm type prevents add_addr"; then
+	if reset "userspace pm type prevents add_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3087,7 +3225,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not echo add_addr without daemon
-	if reset "userspace pm no echo w/o daemon"; then
+	if reset "userspace pm no echo w/o daemon" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3098,7 +3237,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type rejects join
-	if reset "userspace pm type rejects join"; then
+	if reset "userspace pm type rejects join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3108,7 +3248,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not send join
-	if reset "userspace pm type does not send join"; then
+	if reset "userspace pm type does not send join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3118,7 +3259,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents mp_prio
-	if reset "userspace pm type prevents mp_prio"; then
+	if reset "userspace pm type prevents mp_prio" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3129,7 +3271,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents rm_addr
-	if reset "userspace pm type prevents rm_addr"; then
+	if reset "userspace pm type prevents rm_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3141,7 +3284,8 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset_with_events "userspace pm add & remove address"; then
+	if reset_with_events "userspace pm add & remove address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
@@ -3152,7 +3296,8 @@ userspace_tests()
 	fi
 
 	# userspace pm create destroy subflow
-	if reset_with_events "userspace pm create destroy subflow"; then
+	if reset_with_events "userspace pm create destroy subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
@@ -3164,8 +3309,10 @@ userspace_tests()
 
 endpoint_tests()
 {
+	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
-	if reset "implicit EP"; then
+	if reset "implicit EP" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3185,7 +3332,8 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add"; then
+	if reset "delete and re-add" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3286536b79d5..dcfe5eb6f7c0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,62 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}
+
+# !!!AVOID USING THIS!!!
+# Features might not land in the expected version and features can be backported
+#
+# $1: kernel version, e.g. 6.3
+mptcp_lib_kversion_ge() {
+	local exp_maj="${1%.*}"
+	local exp_min="${1#*.}"
+	local v maj min
+
+	v=$(uname -r | cut -d'.' -f1,2)
+	maj=${v%.*}
+	min=${v#*.}
+
+	if   [ "${maj}" -gt "${exp_maj}" ] ||
+	   { [ "${maj}" -eq "${exp_maj}" ] && [ "${min}" -ge "${exp_min}" ]; }; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 86a378731e8b..74d2ede6b68b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -386,13 +386,13 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
 
 		assert(olen <= sizeof(ti));
-		assert(ti.d.size_user == ti.d.size_kernel);
-		assert(ti.d.size_user == sizeof(struct tcp_info));
+		assert(ti.d.size_user > 0);
+		assert(ti.d.size_kernel > 0);
 		assert(ti.d.num_subflows == 1);
 
 		assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 		olen -= sizeof(struct mptcp_subflow_data);
-		assert(olen == sizeof(struct tcp_info));
+		assert(olen == ti.d.size_user);
 
 		s->tcp_info = ti.ti[0];
 
@@ -440,13 +440,13 @@ static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
 
 	assert(olen <= sizeof(addrs));
-	assert(addrs.d.size_user == addrs.d.size_kernel);
-	assert(addrs.d.size_user == sizeof(struct mptcp_subflow_addrs));
+	assert(addrs.d.size_user > 0);
+	assert(addrs.d.size_kernel > 0);
 	assert(addrs.d.num_subflows == 1);
 
 	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 	olen -= sizeof(struct mptcp_subflow_data);
-	assert(olen == sizeof(struct mptcp_subflow_addrs));
+	assert(olen == addrs.d.size_user);
 
 	llen = sizeof(local);
 	ret = getsockname(fd, (struct sockaddr *)&local, &llen);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff5adbb9c7f2..f295a371ff14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -87,6 +87,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -186,9 +187,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
@@ -196,7 +202,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
@@ -253,6 +259,11 @@ do_mptcp_sockopt_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
+		echo "INFO: MPTCP sockopt not supported: SKIP"
+		return
+	fi
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
@@ -307,6 +318,11 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32f7533e0919..d02e0d63a8f9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 2" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
@@ -176,14 +178,19 @@ subflow,backup 10.0.1.1" "set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nobackup)"
+
+# fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+   mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,fullmesh 10.0.1.1" "          (fullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nofullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+fi
 
 exit $ret
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 8092399d911f..98d9e4d2d3fc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -4,11 +4,17 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
+
+if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	echo "userspace pm tests are not supported by the kernel: SKIP"
+	exit ${KSFT_SKIP}
+fi
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
-	exit 1
+	exit ${KSFT_SKIP}
 fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
@@ -909,6 +915,11 @@ test_listener()
 {
 	print_title "Listener tests"
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		return
+	fi
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
-- 
2.35.3

