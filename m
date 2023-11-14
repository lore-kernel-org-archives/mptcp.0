Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620918C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5XllV8MQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDgCOCwN5uUd3xsK40RtV72UqNgBKKp1uv+Qo2z+gryIPII71c/kWJKW1AhbPBEda9IXIRAqWy73M7sKZqsRuK/CUWfUYg0g07FF8S7Ro28+j/TOw8C+Ur4tzuTRFUxxDHPC+N73hm3P1d7XpywyJV+PXjITkRLfrYE7h3PSHoBsQvhM/PxpxADrL65fU0YV8O0sgvLCPOhBRtbwvS8ExHUzW6zmTkN81f4uaYaOZE4sKYwsrGxGXhXz/YwP55sY1lbo3mk8OG0ergYS07i3Ou42sjdeSq4tVp5aQLeJW/MjbSFpv0ieLAtzjYxB9L50AeqrzU7Yv969uOKlgUTkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4Z444dsSUk4WVg16ltpMHA/NNhiPMgnURtTEj0+um8=;
 b=TlwfiI5gvBCAGkw4iYwvlqiBKpFXTESw8jg/S/2OdweKgfN+rZOzkqT2jq5WLtHkRy+AkcUadBSe9x9XE5qaNeUqQPwArp9ZcEE/VcBRBxWf4k5aFaTgJqqQSHILfG9guLyQrA1r+xGBXXE28xmZHpY/HhTKCDekb0g2U8qXJ+w+2Rgc9LBUDUW7KEaMYfeN3aD1ICEqJL67GRATZ0L9V8FCKkWjW6inpxL1luEsGkiVI/vLxDdtO+tzW3J1T6xvxODWb4Ejkiz+EVmpqv0PRgo3vxzzNc7cFVLqelNPIglkgcPWMsvhe1PKCKB9zgT3JiiaY+LKImUI2KpVg9I+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Z444dsSUk4WVg16ltpMHA/NNhiPMgnURtTEj0+um8=;
 b=5XllV8MQDsLO3zwdmzDEdxcWU3vQJ9JrC+sEEKd0ApHQK7JMrFbsq5ZOei5Tr4oacJj2EXGgcTPAaGdxHv0p27PnT/J4qfbhEPIvY17KHT4Q6p6eEMMhxpa1ko3bYkAKsuTgqb7oSEq57vdgjJCdE/4/OJgZPH1VhFupneaFC3dlMs5DnHZF/AGRDZQzK0NOxQ6ihouMHGbc3bFTL8VFtciqBm+0c1CxbQj+aB0ATypHLTWWGA6rYWDm1X3XHQavg4JE2be2xpPqM6XDlFDyY/E/lO2+2jy9etAjN0wbtCyASBulX9wilVVG6Vrn/On1KbQYV6neEZ+zh7jGJr9sjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:25:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:25:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 32/33] selftests: mptcp: use KSFT_SKIP instead ksft_skip
Date: Tue, 14 Nov 2023 18:22:02 +0800
Message-Id: <c0bf0ada99f602aebbbe5dd8dd313825c0cbcd50.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: a89c462b-406e-43ab-37cf-08dbe4fc046b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0fGs80SW2MsYvfrupmh9t8iT+4YfB/c5TCJZJ1djYSOQ5dIdWQz5L50DUcYtE0D+HVIE4ssy+Azh0ugj0gahnZJsZfkdt/G1kuckWi2QBdkx34ta3qQTHVuy1kiZyEq9PmpC2p+qASCjGHjNt9WkJfZlQ/FpD2GsO5FPj2pte9x0K0wg7/xaulkuVkOlrbr8S3yuMrpWEQJ0alRBVvG8PeAnv5FEC7XQq8H2NK0PxW62CCmGAYV8msKuTETswSRFVkzwfQcUao/S/mESafsczQqTLXDN5/FTYfVEcAbwydyLD7cyN39DoA0Kzb+tGAgVdVc6Y1E2/OORcxPn8IAF509WsgvW+J1vOTy+YdiTwKlCUrBO5Wt6ja++n2UeGsMfRznSuBGWJ52+PuQx5kZ5C8woYh/Ra1GpDq9AWWdxUbv9ZP5PE3JC7sjCe0t1M6jop3FRWfo4vDTQSv17yfu06OtMGYe8+6/JksycDuIh50ib6AZ53g/TbE5zjaqWcuTNETlZkPHm2XEESUXfVgG1w46ILd7VKNYjWvZU+m4+O7hIajYDBYLa+ch1a+rjDHFl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GVTbUcm9tsMEKORWcVkHryARpAejAYzhrDnqotELHxNa251uJgwQHmvLR0yS?=
 =?us-ascii?Q?fQLUFLjInLRdAGfU0sNfSTXqzdZCKo+20WpAn4KSUeCZZOj6+GkEPitMSAd2?=
 =?us-ascii?Q?uoaOMPcT6Pz+OSwn8w3WXftXZdxLzzEsggWLyBC2nDcugYVnYW92eeVqj6A3?=
 =?us-ascii?Q?h2xLh2A1AtoEdE+Lvzs9A4CwlS0q7uNgrSEHPr5oyNX60HKZ2Zx5LcehfcYK?=
 =?us-ascii?Q?pGZVh0tMTx4ddr20AJuTTsJ4nqsnm/mniQ/mbDYS6p8QW8ay+pj4r6hLwPKY?=
 =?us-ascii?Q?CpWUM5yP57gASNJgx7EagJjxSR8dVytRpsSyKqwWDmdq8KK/cER6wl9ipb1G?=
 =?us-ascii?Q?3XYuOG4hXlyEmic8svN9YtGKtkEW72goRMOe2JmEsdJaEAAwNq3AppUMGzXU?=
 =?us-ascii?Q?RoSNbO38NINIIYry994azfGHMsBzj07kWCWq3G1wIGvirwVhpAKwhhenCrIN?=
 =?us-ascii?Q?Vpecs2Gwsv6qayhJ1j3ZThFqZgP1D+nCJVUxIGN4MjhNomp4T7ZbYgSiwjTJ?=
 =?us-ascii?Q?Ph6Z9Qg3WW0hnaoh1XAxpDoQOzPUvLzjeBENYjWVxqZpMb6fTQy7oq3sGW+R?=
 =?us-ascii?Q?+8SeYq7jbYXWYb4R70yN7vooqpfA7AwA+HWphWHRoszOFtArDcyD4MsFsWnk?=
 =?us-ascii?Q?HDwE39hj5sbPAjebBQ2BLpQS6ZcjXGZvGH56pYPqiDi6I9sLax3GqR0y6Dhc?=
 =?us-ascii?Q?6hQaFDb6Qv6HhLwoztAUiHk53LVPc3nwtuGZwBrpz4qAFlkOSr5QOK4d0Dhy?=
 =?us-ascii?Q?9lSVqmZpF3L93natTJNitgZTpgEJEEvPyefY7wSdllapbPvLkFJT81jO2bRM?=
 =?us-ascii?Q?zWzPGE4BQ5xYefXdeEWsBHcmTHoI5oDuTRFHB1Fxopb4vaNPaij7iL/0HVxt?=
 =?us-ascii?Q?HtC3WTKBtqOW+g/YCJBeCvnVsTxkEFvSi8qjVsfyYWyDROUbdVN4UZGakiIg?=
 =?us-ascii?Q?nQ7XmpTnLSBPirYj+k0+BNq5Lv012trD3tt+4+pP8vEIRbUPLleM2qURB+TD?=
 =?us-ascii?Q?6+ZiHpiWsXFGVvUBH9SDBE0uguEBRbkoLQasJEKHBDLEz2+quKf+wp9+8yb8?=
 =?us-ascii?Q?/zk2c78PL9hacBuzXM7h4fsvExBvmUKyF7B2cV9Q9IzUrWGXfmHKp5cIQAXX?=
 =?us-ascii?Q?MLVVNK7tvDLEz4NeQe1NaFk17OlIxjuATgUhmk4Vjaa29q3etKuYR4r1L1Pr?=
 =?us-ascii?Q?/fn4apFwNPex4ynyDDIVRLSZDiViGLZi+vODZXS27hnw2MPkR0QKBnJ+emX5?=
 =?us-ascii?Q?oxg5y4SUWVaifugaXccSx8vptkXyvSyGzCYGj01zzrmcYNlk2uGFs6MNhgjU?=
 =?us-ascii?Q?WLTtw3bT4zGWfnZG3crslNxQgXEH8OpnYvwBo2PjeL9Ii29Vc7XaxFtJ94va?=
 =?us-ascii?Q?R99FzcXoF8M8JpvzPwKa1btbe71459qUHYh80M7+3m4keScC/2OedQik1GlP?=
 =?us-ascii?Q?ohk7L/x/xhdX5P7V+ZraEYPY3vdhLvAiwkn54pk4qdpjt5km1dftEEVAv+1c?=
 =?us-ascii?Q?r8X19oel+M5JjROUwgPcYEKFhp+PIjms12uL7oC+O9Umob5EFzGfwittDSmC?=
 =?us-ascii?Q?5Jer0RC81Hsz3xvKaYGZPti8msmwtX21O/E4tRPB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89c462b-406e-43ab-37cf-08dbe4fc046b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:25:26.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pCfue8yquiqfEko44NsVjqiKvn/fS29VWX28Yux0W7/iXyaFGSfeslD73VLWkOUuoU4Ymb5lMYpvvkeRIEjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

This patch uses the public var KSFT_SKIP in mptcp_lib.sh instead of
ksft_skip, and drop every 'ksft_skip=4'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh         |  5 ++---
 .../testing/selftests/net/mptcp/mptcp_connect.sh  |  5 ++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 15 +++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  2 +-
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh  |  7 +++----
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |  4 +---
 tools/testing/selftests/net/mptcp/simult_flows.sh |  3 +--
 7 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index f646fede9872..f93f5bdc49ad 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-ksft_skip=4
 
 flush_pids()
 {
@@ -33,12 +32,12 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 ss -h | grep -q MPTCP
 if [ $? -ne 0 ];then
 	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 get_msk_inuse()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 683172e626b8..3d03e3b82eed 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -8,7 +8,6 @@ time_start=$(date +%s)
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
-ksft_skip=4
 ipv6=true
 ethtool_random_on=true
 tc_delay="$((RANDOM%50))"
@@ -132,7 +131,7 @@ mptcp_lib_check_kallsyms
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 capout=$(mktemp)
@@ -229,7 +228,7 @@ fi
 check_mptcp_disabled()
 {
 	local disabled_ns="ns_disabled-$rndh"
-	ip netns add ${disabled_ns} || exit $ksft_skip
+	ip netns add ${disabled_ns} || exit ${KSFT_SKIP}
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3b92a0b78605..112db64402f8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,7 +17,6 @@ cinfail=""
 cinsent=""
 tmpfile=""
 capout=""
-ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
 ip_mptcp=0
@@ -126,7 +125,7 @@ check_tools()
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
-		exit $ksft_skip
+		exit ${KSFT_SKIP}
 	fi
 
 	# Use the legacy version if available to support old kernel versions
@@ -135,10 +134,10 @@ check_tools()
 		ip6tables="ip6tables-legacy"
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
-		exit $ksft_skip
+		exit ${KSFT_SKIP}
 	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
-		exit $ksft_skip
+		exit ${KSFT_SKIP}
 	fi
 }
 
@@ -394,15 +393,15 @@ setup_fail_rules()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${ksft_skip}
+		-j MARK --set-mark 42 || return ${KSFT_SKIP}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || return ${ksft_skip}
+		index 100 || return ${KSFT_SKIP}
 }
 
 reset_with_fail()
@@ -416,7 +415,7 @@ reset_with_fail()
 	local rc=0
 	setup_fail_rules "${@}" || rc=$?
 
-	if [ ${rc} -eq ${ksft_skip} ]; then
+	if [ ${rc} -eq ${KSFT_SKIP} ]; then
 		mark_as_skipped "unable to set the 'fail' rules"
 		return 1
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5c32fa8e91f1..2a37b564700a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -499,7 +499,7 @@ mptcp_lib_ns_init() {
 
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
-		ip netns add $netns || exit ${ksft_skip}
+		ip netns add $netns || exit ${KSFT_SKIP}
 		ip -net $netns link set lo up
 
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 2d5b6ade7df0..c8d08521c552 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,7 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
 
@@ -74,7 +73,7 @@ mptcp_lib_check_kallsyms
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 # Use the legacy version if available to support old kernel versions
@@ -83,10 +82,10 @@ if iptables-legacy -V &> /dev/null; then
 	ip6tables="ip6tables-legacy"
 elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 check_mark()
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index e89b78e7d4a0..d68353c18996 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -3,8 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
-
 usage() {
 	echo "Usage: $0 [ -h ]"
 }
@@ -36,7 +34,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index a598deaf890b..c660e1f8547c 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-ksft_skip=4
 bail=0
 slack=50
 large=""
@@ -33,7 +32,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 #  "$ns1"              ns2                    ns3
-- 
2.35.3

