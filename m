Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7C612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lu2WiEnh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRFl0AVwKzYP+17/ttZMJ/8iGRQ5R7aXTUzhAHeeeI0btlNAB9rU2QUeyKuKF9uD0BVZG23hSiNMAF+jo2V2bi2sKyjtJB56M8JWdafws0sRpGwqYd0l9899ZXeDjzS4aq+/KjaSF/dgWaTp5L4aqU4A3EpfrFWXYhSd/hRnN+mQOlXm+kZTNRvA8eLXn3Sba2340hrC/8+zHHuelvMP+dSEfVo81noT+6dlFTTFnNnEqUim85+vctFdrjKD3vEKCbPaDh0Os8Yugj3DY5aDjP2dFFBLk8BYGvmWo7gbfP9SGF7td7mVoZF0IAkDCdroNDAtnA3kal4jUtTPCIo6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHK7lM4wn8QhIUMqWSAjbumQe1nowDC9G4IoOuPm6Nc=;
 b=lSBGQ/fbTFHBuFRehHCHleGP1TGKnDrxMa6hW+2O6F0LgV/RvokXoxfn458XHt2tHOFIbi7aJBxP8LMv/vIUCLVOoRX0QSf9CB5kiqwDwjGHwhuzE0jole6ZyyUJRkMrHO/3kg+l8h36k9HkCxM/U7ztVyF5C008dLBYokShBZFPmKgDa2GWXhMG7MZPoZwDLXhqGPEVetKEt7AeKwvDYYH+iC+KuKruOQ+afbaqANOlMJ6tc6wKKSAGkhRLIhxDP9YJP6PUurvd90hnX8PHcxuK7HkBUDGR0Bdx4l0TclWWRDIM1lestQTJwwcOv4MQ/2vHb2hSzas6xzGvm6B33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHK7lM4wn8QhIUMqWSAjbumQe1nowDC9G4IoOuPm6Nc=;
 b=Lu2WiEnhO173UPSiBIA9g1E6ooQ7f6gwZmxueMzb2uN62kCQ4t1rL1/eqL2okIJUAEXyG56SEDee9TXDfAAyZVm3uBeB+shUQIrdicat4Uwb8A0gB0Fdwief+dLE1VnjUqFvUNRTrAYD0ZtMpuymLHlH7oEElc9xTILW4tT0mxFokhoXRTCZqLVfM+snN4MVkal2J/gAQ+bdPZLO+moq+PCKzzlrDnjvIlEEo/ADcK90qogFHk+8W3awume+VQQTCiK99M2THjgBGlhRu2LOsCgIJOF9nFbNgOCkhPlkV1+zE35Joonhwfde8GGJV6/3/sQIm6EJ7Q2fGitMHmMdHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 26/32] selftests: mptcp: export cin/cout/sin/sout vars
Date: Tue, 14 Nov 2023 14:35:45 +0800
Message-Id: <b3bdf1f94845c93461f1c530630ed7c30ecb6ff2.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 982eea3b-6c31-4cd6-bb3a-08dbe4dcb182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NNKCzRZ78RyqQQLHiKPt272nKLnTZ7QCLSbgCCm38F/s81I95Ltz4j0NsRs7glm1x9kkiebA3l8YfNjW3qUK0SthBAAexlLZ//nwlI581zW7hYlyUz8AhgkXR3wSqupg98unXMBsxahPVBYAXCIY3MUhmbjx3tpZKy4SLOWTiwWs3kgsNqcMkluevlbzRcByUxdSDIxvJ33pgTIA/EedbaiijHrP5ETj5jT3I/ysa4T6h5NtVGXoxCSqtAUF2KyGZ5Unv/Hn7lAP1pJ0aAerWbOsx+314PrWFqG1Elkq9lgGN0s54znwI8z2wHVRVQAb0Caw4NrqJHAWxX4mKrGOHUF8T4OyidmkbVzwravAnPvOZs0XFBIU1flKwJQT1d0K5vsk6Ec6195TP/YIVrK8EDrT2ypWCFJh4kro7fJLkpTyvwYkKKJVKGn8hhY/aZsB6dUKopTJrhu+KoZW72akJq6juv1uvxuujgpwZOmdysClFw7MJ5SMUNuAZXt5VwxSP+BR6yD/AiKh/7J8kOhAwe6P3Z2p+EEHDKRLiPYBaDjMKq3HD+CmCcC2c6HPGeRv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8L5HSbT7w113GUedPPbb+qKOQbmn1Mq2aktgcxqG82ijebt5jaLJlHdDUUIx?=
 =?us-ascii?Q?bZkmFDbtbyFlH90tzHGY/5CCDztHTqTFnkFMv+dq//Qy83yoqh0vKLS01vuz?=
 =?us-ascii?Q?J6k2OLB/htkIiR6LdsupGEIEWt4Y2NezcMqSps8lJO9K3hKFkWrKw3P94YLI?=
 =?us-ascii?Q?/oB0oIPsU2XUG4yFPW4z3HhkYekQv90QkPGN72dehO8F5s0dGuP3JrdpZ/px?=
 =?us-ascii?Q?lG7mNRMSvmqR0rar2jzbMbzGECc+jquw8a1XuTZFQ6LbLf06J/TUi9jOHPRD?=
 =?us-ascii?Q?klV46usDe/hN9nZiGbVfaOOrwTH+cd1ajaxLWSjbEGQyKqEl4GUId0UI6eyo?=
 =?us-ascii?Q?D+qQppKvQObHiO+89l0UrBffYcRs7BC7EWFzYcMID3Ha3US2UbvoJBeq17PU?=
 =?us-ascii?Q?96RcI69SEdLJ4DNCk1JjzVTiKOpB9jw9b512gVj9iIXyOmmQ44fYkVrL0QtK?=
 =?us-ascii?Q?xeYXmFCDpCAMMHLK8qkcH4yXmN+Jcers2X731RxAVnymmkxkH4Fc7SLhon65?=
 =?us-ascii?Q?BomxDeHJws7Nd2bbAy6urBPUYDntw+qtxfQ8/v2hHxVJYIRKVA5WQEHpTR3B?=
 =?us-ascii?Q?mWEsnqB31lSTew++rS3k0vHdXh4sUM5hxVzQeA7aQv+sxeRsYmEPfYlwzHQX?=
 =?us-ascii?Q?n/iNIniijAVpb9ayLXnWKcpncIIxXVuTQNPSlsuTmeYlLjUShm8MF79vCsGq?=
 =?us-ascii?Q?Z9fORNEbYuAubQEcQw1nxlf5WOEKGmNerI0hAtcq8E3VUEA0V/s4pfpRcB19?=
 =?us-ascii?Q?/HtLm9N8QG2jvOefWwL/d35Q45mXFJKfEFRlYkAQ72hThC5UFROsAuHLEuRU?=
 =?us-ascii?Q?L+smDh/o2atPDKasE6FfJFw7zWai1/FQcF4D+1LhAIarz16JjKBcJrmk+4yX?=
 =?us-ascii?Q?cQV378otMh9eVR3ROrfjdZ7+je0uLiMeGrrAYsUTEgxTYEfyS5IAP56HYu52?=
 =?us-ascii?Q?WgxfCCIowN/CifWGV9i5Q6/AX+odFbsfQvJjcp5MVtCfGki6I/GXC2ljOXXX?=
 =?us-ascii?Q?MockxJl4KDCApTZTh1Aj+2FBBRPunMgevlrRaZ/X/WBBzKTbAS/G6JP5niFy?=
 =?us-ascii?Q?y1HwGLEb/wLDB9Now6JKuVFuRAC/QH4GgB/E4+792I5OjELJftASU7J1fdSF?=
 =?us-ascii?Q?1scVVhKuqbOXPG4LE8spzBnLNMXf2UdRDmeDDbJ/8zdNRIy/53Mxj4TXyCAe?=
 =?us-ascii?Q?7YGApyPgTtJC6DwnmhMwbjegIL2qcpYT2imG4MS7l6833B+XW1CscYQglyqK?=
 =?us-ascii?Q?4HBNhSUinm5z+36QIJPavqLIqaAIHqQZ+PEawcZtrTB1OHzJ0M7UUhnu1Iig?=
 =?us-ascii?Q?uSY7b9wzLe9/YwNv7NBV33c0gi8mTJVxcNnE4MgtVe3INqoFEs/i9/ZFzFAi?=
 =?us-ascii?Q?4Kescu1dsH/HFVB/Z5JepJxCnMSwEZ+nzwidEMBwXk5hJvGCUXZb+B9Z9SPd?=
 =?us-ascii?Q?YQP/MuTrXDJUVbK/n+JPQO/eBCqef33mPjdPnByuAtkdn5DWJHxvhUT8KUyX?=
 =?us-ascii?Q?Ec4pXHIEaVStqvdzW9o5q77fwRb5PNswR1frtdSdePeWAbKe5UQUgrm8X/Nj?=
 =?us-ascii?Q?dt3OjpK/Uf1vXGc6Ppm/zF5UtJzcbiq1qKv0CXXV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982eea3b-6c31-4cd6-bb3a-08dbe4dcb182
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:12.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIeSs20o1kbhwxFt/sb5rzJuQ5+brsnUstpBw+bq3dFqA7qV17+o90YbcWgMP6Jtkc/cmCfnKpEHWBGVSMFmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

Export cin, cout, sin and sout vars into mptcp_lib.sh as public vars.
Then they can be used in all test scripts unified.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 10 ----------
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  3 ---
 5 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 54ad82ed8c91..a2511a37d9ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -7,11 +7,7 @@ time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
-sin=""
-sout=""
 cin_disconnect=""
-cin=""
-cout=""
 ksft_skip=4
 capture=false
 timeout_poll=30
@@ -128,8 +124,6 @@ TEST_GROUP=""
 cleanup()
 {
 	rm -f "$cin_disconnect" "$cout_disconnect"
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
 	mptcp_lib_ns_exit
@@ -145,10 +139,6 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cout=$(mktemp)
 capout=$(mktemp)
 cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bf2f73209cdc..c2f78c849da8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,14 +12,10 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sin=""
 sinfail=""
-sout=""
-cin=""
 cinfail=""
 cinsent=""
 tmpfile=""
-cout=""
 capout=""
 ksft_skip=4
 iptables="iptables"
@@ -155,11 +151,7 @@ init() {
 
 	check_tools
 
-	sin=$(mktemp)
-	sout=$(mktemp)
-	cin=$(mktemp)
 	cinsent=$(mktemp)
-	cout=$(mktemp)
 	mptcp_lib_evts_init
 
 	trap cleanup EXIT
@@ -170,8 +162,8 @@ init() {
 
 cleanup()
 {
-	rm -f "$cin" "$cout" "$sinfail"
-	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "$sinfail"
+	rm -f "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	mptcp_lib_evts_remove
 	cleanup_partial
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d645bfad1415..11983648fce3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -22,6 +22,11 @@ TEST_COUNT=0
 
 MPTCP_LIB_SUBTESTS=()
 
+sin=$(mktemp)
+sout=$(mktemp)
+cin=$(mktemp)
+cout=$(mktemp)
+
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
    [ "${NO_COLOR:-}" != "1" ]; then
@@ -506,4 +511,5 @@ mptcp_lib_cleanup()
 {
 	echo "cleanup"
 	rm -f $mptcp_lib_err
+	rm -f "$sin" "$sout" "$cin" "$cout"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 2aff01813058..8640dea7abca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,10 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sin=""
-sout=""
-cin=""
-cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -71,8 +67,6 @@ init()
 cleanup()
 {
 	mptcp_lib_ns_exit
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
 	mptcp_lib_cleanup
 }
 
@@ -329,10 +323,6 @@ do_tcpinq_tests()
 	return $?
 }
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cout=$(mktemp)
 init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e1f4ddf04bc3..2b46c95bb6af 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -20,7 +20,6 @@ usage() {
 
 cleanup()
 {
-	rm -f "$cout" "$sout"
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
@@ -46,8 +45,6 @@ setup()
 {
 	large=$(mktemp)
 	small=$(mktemp)
-	sout=$(mktemp)
-	cout=$(mktemp)
 	capout=$(mktemp)
 	size=$((2 * 2048 * 4096))
 
-- 
2.35.3

