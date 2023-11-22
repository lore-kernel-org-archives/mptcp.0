Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0A1CAB6
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EWwZ/ztm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP6nuy9dvW2BiAXGSjE7wcf3x46kbyxgh18pRPWxmAAHyt0D3TKnPMTIjGFvfvFYFSwjx5XSvQ4kaAAM/a9hkRJD1nm0pgghwLYbC7eO02XwlxR1VfEPUfNf125VJ85xcFUPhIG6JtbyMeACuqCzQTeHUVKhvH5ElU0x4IkpdxL1SS3roMu0jOODuri3KEoYuAxAF7ZPc7hIZajmU+Aw42SI7e/XBL8ZN7MGDxIvL3q9AFTAUtraWKiuJL26gxRBFpUxTUTULHRKvehuvHSxkywNbUaz/KNoVe565xOt1MVJ4ILGQFLvrBGLQBYhDuH2TjJAVWuvaqt4syCFY1B/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhdV+FL2LRMZ7aFfFeCFzlJaz0qQqLCWNLu8bRiQt1E=;
 b=ngYh6aqyag5GDnUQv6nHeFKhjSXw71nmIR/H6vKQi/oxOwYKULpHiWDa4Vo7Zdp1Hy6rORpXysY67JmgiweycFz7QSgVdRt2kmyB3yfHx+J8CIuFVHavUlX3syNr5D1qxnLmqWiUPyZaIiAeQ33sBsTpyHem953nXv7pfWNPeDw2Ri6X4GEc7oLy4g6lxivRUqXnOwCr3ZVFVcDwkYsHCd4WIPevPGCqRsiI7wFlsbY23DM8cgg1/DdePtp181ZFjm808KGVLcaUvGTfIt3x50z/+N5yl528MQaNR4FiaK626E44ldJ74ArInfqf/vWEGOtkq1nXCsUwolcF0vkLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhdV+FL2LRMZ7aFfFeCFzlJaz0qQqLCWNLu8bRiQt1E=;
 b=EWwZ/ztm0aremPgr8t87PzElLKSh/6ZV90gAiqkUovHP5/GxUYIK7cXWthi7ZqXjgMxdxhFdhd0ttvr5Tu/KIptbAUIVxawBC6tdYeUZBHftKheLwale2PRiLY3ee9t5bsEYdtaWq6TpvDie/VSfaFEkJAlypNUIW2BoOMVg2sJRnE1Tiusiy1b2c2jckstom6AH+SVLBRMx6p3j+IE221XgyhT1qbnPnPhE2IXAZhgGVaOXUZs0v/YSzX2SKNH9IasuFaPbkj8tel9Ept5KNKWLEdP33MhvTghRPmoLMSz7TYKhpHdD1Eixnb+5rnyNHd6toovWhdRauAF8d47q2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 32/33] selftests: mptcp: use KSFT_SKIP instead ksft_skip
Date: Wed, 22 Nov 2023 19:31:20 +0800
Message-Id: <93893e08fd111dd05fec34c8b17fd45d190c5b68.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3db291-1da0-42db-8387-08dbeb4f07cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R6TL7yAx9eyrFQ3MIfRyESwlDJLzgguBFeV7qzhOryIOa0L7NseLnefqkEZCJHqDl7VyeN/fwJp6oBJPodiIiz9tKNk9SK/FGeIfZIpOjtN5R31279Ie1HmZ2w+QSGmOwW/fa4Ahy7X0bcaLwrzp5E4lBUZZtKDo2X5RtpENxhpoF2dqdCJwhjmjPOaT0joinK2OZqteH+ZmksffILRQYbWCFwe3gewoj4lxnRMjpVDfWRNVUolYOjFiSFDQISdsAxmw6VlUUqxv0Kq1xH2lsKiIleJUIFuPTub/tLBKLTzrD2nfcMywwEgIrOKgr8MroMzY73V5SKd9vi6PXJ1cIabYmbniLDYLVm3Osb8az7akDFcFQh2mNMj7hvt64b9IuB7EVEOu7xkRNiRK2kbGfxR64j3697aho/IlbHIUz911fjwZg2r5xU85KK3Q7by4Q3GJQ9mHAn4N2jfTJv9H92j+NoWwVmoWRxXRPPL6MaU7d1cYUCsQaTs6WtnCh5AlKymHy9n2oySM1d3Wt503KANQeQSrh0vEcYxY6LZ3z3AgHGBRZAWgWaxqhhyemJu20cxM5w/VVlbDaqZYW0Vk6leAyBP6TRpWIBSZNxI0H1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+UmT5hvQiKYFsUsF4n3WfjrDnnT9jojicuscL1CoM8shFSXYPd/hwoHGMaQ?=
 =?us-ascii?Q?+NTd3nI2b/axa2zkRjAvahRD7Fnss7PYaXx0fNUimHxE0ww3bj4HWhREdTkn?=
 =?us-ascii?Q?cQtGXPtdttwTkpW+WO1aznP/28OiLG400AH6BvJyKhiFwsdDG6fqiFhJnySW?=
 =?us-ascii?Q?k6vRu5R06tMLUigCySXDuM83VOuMlUVKlgWCRMZ4OXCgNQ+R4HlOBmRzv6cS?=
 =?us-ascii?Q?CDgDfZU4nXNR/hNpxGmcqM+aWW2qwfZwDF5NFD6dfMyz+yvKEjOz8qSeLZMb?=
 =?us-ascii?Q?xkykYAuUt3W8AJ9kuxAq25M7sS8QakxRSxKrGsTMnI3NAAxwwIjj2DSLylg4?=
 =?us-ascii?Q?QaqofmepkdS6U8RByIa8f1xu1epA5wRbisRcV0C2lwigUpGYXnXM3/l/xJR6?=
 =?us-ascii?Q?8Qe8xOMpESFUCEWxiSguI8rQsamjKapFyO2OWfmvuCFyBLhszCK6tKftLn7B?=
 =?us-ascii?Q?lLvipj7uoHp2bYggxyocuMmjTRhNaY9ASG+o0Jd7UbppgnrEMI2sS0Fb+UsF?=
 =?us-ascii?Q?vX6gEPn8KfYndw6bKdNFS+KHHOv1iPZkSIHlUxrvI4NWw5wbvXOlh6u42M/D?=
 =?us-ascii?Q?L4aah4QgVPONtBgeoSImldvesAvQ2F9rTmtG/mHJHO4LSalkBHzz9ItLPi/s?=
 =?us-ascii?Q?d/fTeJ4nJiVQq9tZDBhLL6XjePvEa8jwJPC0wu0Y8oqMP2QxcefimwAAWzVw?=
 =?us-ascii?Q?WBdwcWqwDGHhITi+IV6LD+ywaIv+AiRxzcDlTttQKuPUJG0DAsVXz+CkCUyv?=
 =?us-ascii?Q?5BWeNfHag/QCpuxApwtuVh9/iyD380MyN6vhtJD+oXSE8F0wqR1UclXe5IRI?=
 =?us-ascii?Q?HZnPN01yoI53SQjnE0GZGGFFvO5bbdQUP5q0cRlF7vNhwrS8oAwnDv262uPK?=
 =?us-ascii?Q?VqVpeZDCX5wbjHv0ea+f5lcnGOIY7SOgbXMcTp7dt/Q962MSRUFwgt715Jng?=
 =?us-ascii?Q?VB4bsC/RY6LBbjIMBJgWgzpHHZ4mxixUT25mFEZcQeuK2FViyWHIgq2DeK8E?=
 =?us-ascii?Q?yBA+GfE21sjhQdbfqrAcQ8h8Cnnw1QPvr/FOtxch9YN55obpLsWAl/Joiq1Z?=
 =?us-ascii?Q?0833Ea0k+YJ/JgyV2xasonJdS0+t3qiQaMb+ENi6+4twuSNdKnkaDwH8Z+nJ?=
 =?us-ascii?Q?QiVtx9dR1HxQwkTT1xzhST9xvftG7kmBDUkzZyCysUuXv0vLmmS54XSl9uP8?=
 =?us-ascii?Q?vQkazGCJXozukWQbmJF1zhMATPrM7vR1gtz3f+olXpO3Eq6eah+8jlCOB1RV?=
 =?us-ascii?Q?g8pcwb3nWEZRDUaMfJ2643kxKifxr8dNANC2JhLern4UG2U9klgtDM5PCVlx?=
 =?us-ascii?Q?ENGQ+Ir1xcTIp698+GOuGI6bcnQkhn2/7KG+UDTrnA7oCK6XsCXdCQ5iZFZP?=
 =?us-ascii?Q?sym23acZzfnLOeo5dZWur0XFoGMvJOXhiNyzw8WOZJYcWC7Cv9nMQWPBJTuj?=
 =?us-ascii?Q?rbiOgRUqYOXUR1pHQWn6EdbGEH1PXBlKii/ajGyRte1VdPZbSJ527cW6UtFV?=
 =?us-ascii?Q?Wv2cMktk6ZOTw8OkOBPAwnaYEGYS3ua+sMeqXN4RczT1QHtq8rTelgvr0oOc?=
 =?us-ascii?Q?jkH/uZQ6V+rQqctZyXVOPR8aL6QYQXTIdZ0c91yXtr6Rcund0hF7bCATFZvx?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3db291-1da0-42db-8387-08dbeb4f07cf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:47.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXDdbDmBrNm/x+AuY62y5HRe10aPpOZQFCjoQ6vYCBw3znRxtJ5Eg0LXnjbp2QEhZ0zOfmpSnAAIVx+cPd9WaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

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
index 7bde17ffe20b..c2ca2cbcd211 100755
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
index f49aa59ca326..f0f464922783 100755
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
index 0f5dad2ba3b8..e6972d0e1147 100644
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
index 139b3aff4c4f..b6e604d03a23 100755
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

