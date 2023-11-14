Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADC612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N41u/VZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auj7mVlkxn8AggI0s1X8tf1oRkfBISOb5I6OqeOODNpK32SrrAxZ3f4o8yLe3zgYmzXlFS6kw9pQuXTMUFwhPwiDvSpDbbdXSe2aXOttUiZ1knVlnj4EtVMqkV1ftcSw0HF/ix7hfYm+5uQTS+qTmxVvyBYwQ6YNQn48za9Jv65jhX0e/OsJ91fA7LkP+kFeWeoST4v+or6rmCMs0tYFpPoE1XbBJQfElEziDxuqZ6JnxFmch6QVYVUZ0QC67HvaFj7O+vv2vOUzOo0tSVuLObBS2DIVkxlMXQpBPPOHz/yuDAoIN6c7H1w1/caX8A8IxKEYJD84aG/6Qc3JywPKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXAVDdJ5dorl7JQ6HCOnXprzfj8BFPQPgImQwEpdAq4=;
 b=Wl5J2k05G+o00NQoHfzR08OpwdQF69Cudh9X+62Q/dF0pz6fSFQvysANTHUL1dYZkJbVXttc1ejVWGjbRHUz4aPrU62eVAwF+1JkUu9Upat2WcOnd86pjfbhPsol2sJJ+lALMPEU0mfv1sIeHBJMBpaUaQnvUlmRHSLoEpJrctxhHgpT65ka4yQ+fcSK3xJISN9qKqCRVBx+h9GCWF8AVAS31+If0kfUKS9UoQ1kTejHuUH6uMe3hsjfRm46HMf0EXZP2weGrOnwc2IkNIAO8n561C8svGPl6CIY06XuDyd8cwkVPlIzSjE17029VLrhy3TjzkaNuppD3BhI7GbsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXAVDdJ5dorl7JQ6HCOnXprzfj8BFPQPgImQwEpdAq4=;
 b=N41u/VZYqqie2DPJIjAmBvDFLWVE3Hp9wk5bA8u64yqAXw8jtr9Mu0zuXYk0oeMd923OrlWxxBFI03BJMXzpMA9zJX6yxqPFJG3KXz5rEkx+ISOL91R5Og90/mwBoO01B5y24u76pqqIE2YC7pCV6lHqa9E1mhQMC9l/57IkFzMM6L+8p6ZhNEhSEbY1xrgzccP8SpstfAf6VcZEiugihEphf2MuJkMp/b6ChYNhvryxinScUc3fRy/tecKTpm8cmP9zIoMM8SWByn/byU62lxOV7J61MhfshOJWTXkvKc9+130Px0p6rKsroJEzhSkCqR7HuL5Z8B2Phgzm7Cqrvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 31/32] selftests: mptcp: use KSFT_SKIP instead ksft_skip
Date: Tue, 14 Nov 2023 14:35:50 +0800
Message-Id: <70ad1f035a11dd476c34247cf59b29cf2e06ba83.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 434c09ab-5603-4867-9988-08dbe4dcc8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lHD23VZos2ND4l7Fn+9GC0eQLgxwff4odkrw5Shk9Kpgz2+2ZKq9Xi45S28X29mg170QvR6qd6reYLxoArxYWzNwDfQrC4EjVCiAWQOz8M16vfGqQV/NmmKImLmluX1nkRpXjlgLJD3ax9nTCHu19GJzqh+AeXvBu83yaWqe86VCIB25GL+d9HhZ0dHXYnxraVCM7ainHLmmluOjeniqQGRFvOirTuZL8RWn7LBsFm7oGcMVyEpZAU3KGYPERPDpzgZIiPVBZ22dQ3RQfpE1sc1yxYbO//cNtOCARTHtfb1RY1Kn0bspsviBsohH8gAnAL1ybMzyodRZqaLfCbIYUxh7TSCCo3txSUrbT2RSg7kRYpMmyE0RJctivi0fF42BhMIdbz9EHEftCuEqQEMZbs/aTG7oNtFxpcLUXtZ6p2jWkjthDAIrVT0wk2gHx2YrH/f8BtMY3c4xnAx100MiUOZmbxVPgWed1S3q36f9cSdPEFejQUr27YK+27pD9sHfnJYjj7FhOESMPMIUQGjAYMBACLmfachz4ecu9LNxi/55Jr3ckHeNVVmMYi2s+MMl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2pRC5di/F9YieKyNUbXor1FApZy2/zrf5kWThnOkaoegOOCHLprwE+3pg6Lx?=
 =?us-ascii?Q?SAmSTKrnjIhzQnCtHPtE3AgdOWBs8VetafSgelAgCiqBx3sOr+VtgD82T24w?=
 =?us-ascii?Q?+xSgV6dXNIHHfq4gsvQQCdEoTpowFhcwenbh6CStsu1VinB68QpFseSmhsgI?=
 =?us-ascii?Q?J5gT4FSMDiaxvt8WaHyJKyeyP5mYQwXyBSNfHWkwjneX2z+S3m3SN6NOJJns?=
 =?us-ascii?Q?WwWGQOlpz0Y0cXfWgBoV/7y0ZrJ8wQ9QuFT9jJDUTbPFA1UfXQCMQsPNIymh?=
 =?us-ascii?Q?L9DUfhubGu3l1T0hKp3YilCh5goJp0TFuo89K+I89dAj0kPdBQ08TH5cQYqW?=
 =?us-ascii?Q?WpF+CGXCntFH7ZNNp1B+Rf50c+VY1SGy7qooJN0yOguLm16/13QRAcCw6pad?=
 =?us-ascii?Q?4QRif/tflxGimpnj470NmQaDYkTti4FF0ncImzsGgA4MSBpij8OLXmACsAPu?=
 =?us-ascii?Q?g4gvHvMqmunJdLh6ymXL8WYd/kzKbql4LJhk40pXcCKM0Yh/peXvRRgaN3oR?=
 =?us-ascii?Q?s0wqiCK5mbu69VDm7N1aR33bxKmJwqkq5R6gvwnM4fgOeOqTDeEuEchCo1At?=
 =?us-ascii?Q?KqOgqrQz0plJBwdxbCfo5BylwpmjDN8WaKs3VEV4HpzdHOWVWb9kw6uW5P2r?=
 =?us-ascii?Q?zh+WcGbR4E5BdTkr/2o9qyxvf1T5drq3n5t0JuyrIpXDzL85En8kxV3Yt/MN?=
 =?us-ascii?Q?92LoURPs02O+G779O+6bxmsoLzes5AmZFKbZS7+0Q0pKWe1qS6pX2Gm5xFg+?=
 =?us-ascii?Q?jaFsmcCHkVglQbuZag4uYoNFvJ8UYwRQvFLYAjF8Bf//+aTqCMaVI23gZB2Y?=
 =?us-ascii?Q?WDwRay06wFaLXoF5ImY8m5mx8ScXen8ez49fMK1lTmkVsMwvjc05huw7KYld?=
 =?us-ascii?Q?jfXwRbYEsOt/tBGPYGUyjWU2g6d9X4anyljAHY3/bo62jtdq+Gzk7CCnlCvs?=
 =?us-ascii?Q?rmeYh7VmjLnV6YZdsw+liBMaLj685WUZBzIMi+0zrSf0NqPucVGAyYl3WPkG?=
 =?us-ascii?Q?e7+vbJKErgUSW1X6tmrYVDRCZqKCOgj1MqotySC2pKA+bALL6AOspcnMX1au?=
 =?us-ascii?Q?fezSTs7bREYKEICbRMNsBaJc606iEbFTMmtBTwpU6zP4dRXA9K01h0fdBAaK?=
 =?us-ascii?Q?G+kPWkoaZw8O7m9EqsdIvRkMW5zxXEGZdWszzolvepIWh8t7wup+iIwmjAfq?=
 =?us-ascii?Q?lKQqioF/ItxsLxI3oIcf17dG50deV+kYiHC1VN7narKbfSTSFkGt5lab58ux?=
 =?us-ascii?Q?B/8w8AZG8/OaTCyIByCmakjTjuhVxOCV5x3vDIhrQZ6nMij9Q++63LhpCOtd?=
 =?us-ascii?Q?zpGDO6k+6K1BOqogw+tU4fbyR5wUkJwNnCktoV/7eVTLq/+MnU0rpLmy66e1?=
 =?us-ascii?Q?SC31/+hRt061IJuPvZzyrYaidQSGwrAQ6QELIjtobCnQZ++6b0stFYNmTl10?=
 =?us-ascii?Q?UNo1+4bWz3ForynFrq2vibGZ612f1KWF+VFT40TInQU2TI1SnKR5Bp7kuzNZ?=
 =?us-ascii?Q?kq9RmBLTsYDJJ46mikjmNJRqO2huBdyN60yRazDuyPwEbvHO4PmBV5NTkHJ0?=
 =?us-ascii?Q?tnSOOYzny5cd9cmBzqhTbYhNC8jtx5HAL8XMeEkL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434c09ab-5603-4867-9988-08dbe4dcc8a2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:51.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbF7TaZSaJ/sbxI3WkqulqXr+P4bWuA5c7qcR0HBoLh4/3OyXgCeRK4wB51CBz5V75YBSYIBU0W0lekJkZaL4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

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
index f404ac8d4b14..03d155037182 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -496,7 +496,7 @@ mptcp_lib_ns_init() {
 
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
index 0ba26a749571..cfcdf43ff660 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-ksft_skip=4
 bail=0
 slack=50
 
@@ -29,7 +28,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
+	exit ${KSFT_SKIP}
 fi
 
 #  "$ns1"              ns2                    ns3
-- 
2.35.3

