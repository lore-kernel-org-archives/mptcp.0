Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A418C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X5cozB7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn2Q2UZhr2fqlVWywB06DUwzeCUQszIT286eTcvFoESPHuLkG4UPKDr+IkFdNYAOd2qdxWcbF7H38Oo4VPsEE7gPFqzoXjt5dmo2z+V9JK69GuJff54g4FPxWrafWBJkP9H73rvIhUqYx9QSPKdhAO8lQprgXcgVtHNlG+qqN6Z9miXTW27KL10aR6udRnqiSx/+dSioroxU+n+f9ZUoo3UHTlkvIm6OL0Nk1FyOkGDZOG2kamdVHxTPrd0YCt2/Gm9XDTca0RxgrgE5Et2Xy3wj0ouyv0ZK8/ADxkKsNHv8DDNRK4QsIcmAFiwgjiLmrzYHWA+FUIEIomsdmYEqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0MV/hMW++ZifaIqWy4+PBEFuFwuoWJC31Lza2GJ7+I=;
 b=bf2I4CQudyDq57hn+jpbatg9p3l/xRCExdPylsR7s8NUhbhRX2Lrt+zgTdQ8SZOYfX3Eqlurgnh1FJVO4OhWuN4uxT9RGkdUoCQtbwbHF9llnuwE7ng4XpxT20i+VGmdlQzsQlKMlmIJZMmfL7WerEWRdVFSahBBWHqi3wwG7Gt2uitNGmO70BrRgWPyFTmRMjlMhhz4Png98slobh1vkiIrjGkD3TOhMf8crJGkbZEQ0UV93HYkaGOnqfQM6UR/Rrz132e2KfkvWy9s9LOcroadIHOeJ3RIgpfwv1zMbBUtwIlt9Wr2UlbaL7Invx+Fg6V/I6n/CKQ4cTXC+p5ZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0MV/hMW++ZifaIqWy4+PBEFuFwuoWJC31Lza2GJ7+I=;
 b=X5cozB7TPX3AbGogSU/ceDe1i4PaaYRGnxSBagVSuR4eGyJjwtO1iR1Jm/moYEPLFXYeCDQZOc+gzAeylPVvffbHG+9Zp48AyV4t2QKdCFR6LvT4FP4R/RUljdKJj0MNc/a1SEn8Gu1Yopl6si5VwyWIWM1t/t1q2yf3VoJO922/ikyJScK/QjL+qQ3zX27MMTljqQfgMclraMXhdOFaTRoSfaM3jGOdb0B1pNO2YNqu5X8QJsGyI6NPJQ1de3rQMXJTfUzl4881k8CszY9an5VL1so4/zsXUcjr0dbxVc4simT/kxJKRfG8TbTbgvAUVPMfSlTKIfuQHV78drtX5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 27/33] selftests: mptcp: export cin/cout/sin/sout vars
Date: Tue, 14 Nov 2023 18:21:57 +0800
Message-Id: <f7eb6160be8e0f601b769ec0336643c4f56974db.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0173.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: f44963dd-0b71-40b5-7568-08dbe4fbecc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XKGurtGyGb+f+3q/s6SwMazkJxhr4wndvdPmRo5rxMkdHib0qn7SHeuWEtVYj4LHj3iHWxmjeIfl5KDPovi+RXSKhgiOYX8lXOa6ciqtR0VaqKiwmHzMiswcNXXpDCFgsCFLHy0JBg+8SjSNaT9C8YZ21lm7JnpBArbZeGstvU+bgC21Q8qDSde5JRcSRKuTNyhrvBKDNT30OUsVBi/Z1NQvaV6cVexvLFM/aWudcIQdr1GjJF5cLVemE4yO47ecQ+jzpOs5uvqg/XfrqueAum1wWD3Qb4NOd94bI0sfkSQbujU4EgCwy0/T4pQUp+Iug899vF0l3IQbdfIZd2Rv4IvRBPirPVCWVZMtyX6CIPynbInEOB14UK4MJpnhY4AkwyP76e+vX3vNtDSxRfH2uohlI3AecVRexgoV5SKkxVHcvF5H8t76+sAzSoFqktQnq3kDYukFzQl9lZP/Z/maLlkiCe7QBvC5RncjzdQQ7Q7gu4T9FAOR/dorn1ssA6NY1NCyBb0+ALnmGz7EfPIJYVQTGW57SMOB9k0xT2LtjakWz/F71eGgYGRtMacgh4uw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJCtJSFc4XyZYH9Tw2OaDzFQE51lXXhf80ujxhemgiFPaMcpl65Nkb2hd3D5?=
 =?us-ascii?Q?wL88jlxuHjDAEiA25eu1Zm9L2+dKdkFXDTq+FGL6vtNi9PnhiqTted5Mu+xM?=
 =?us-ascii?Q?YErhr9AbMdWVOknDM7IvzIc1tHI6M+4KB6vR955m30itHs2nrLoQmPSdBJjr?=
 =?us-ascii?Q?019J/KH9FZj0QL7v4jxESvVqb2/mAdmsZ5xrTm/0f209Q4IVnoSiOFkBxZBd?=
 =?us-ascii?Q?sDUmkTRpJNeRmEIIjWGYr0oaA/GlbslFa8nKibF9R18/P6KdAf0ot6ejs36s?=
 =?us-ascii?Q?J6hy+vXGLZQRNXxGgS7xqAngu4GBlZnsEIHkJqjo2k6sY44gURFadp+wMd79?=
 =?us-ascii?Q?2IxXnMESet8eoHc8z26BYr4GQPQhJnJe7lQxAsMwqGhv1u3FWE1AfoibkcpV?=
 =?us-ascii?Q?JN3sjOJkvMjGqARRr+ZKdqwZHXSLDLHmDaaTtV64Pu56GNzb/wCiKjnxd99v?=
 =?us-ascii?Q?PdNWSrXW09trjQDCIZQjv2f1pirzKe4CSwfUmBNOBgT6egKV5TB4lZsdPfJN?=
 =?us-ascii?Q?hAAVCtuQNRq3D33aB/3mthc4lgemetut4iyJC5pESTHt83yaVr69zN1Hckk3?=
 =?us-ascii?Q?zT7fyOvzb+Wo+UjE7+mxRYZPdJTHg8hy74F4z2b4plKNhHPGR6IBrGz2MMlX?=
 =?us-ascii?Q?y19PfTC6khwF32l3XfrYk9KsXVRlja5/Tr87C7xhTboy0VWeUwWTU61p+9wX?=
 =?us-ascii?Q?qckV5LKbrBGkgDN3lCu8OmlRE02ZNCAwjLsMuf5GwN/3MyN9eYP0VpggwUxd?=
 =?us-ascii?Q?zjCit3gNZiE4rIvzqIieY6oViSlMDfE2+yB8o8Z+ppKZMl0JSa4fAiP9iNfG?=
 =?us-ascii?Q?nAljCmx4x42rkHCvTQXQCSxYjn7QIQQWU8DMu/ggj1lFIg+s/4jxN/kwW2Aq?=
 =?us-ascii?Q?CxF+QzXOV8w4werQJIZF1cYu77uz0HqRUT+3jyY6V2TpdNTDuSgv8VDjLY2/?=
 =?us-ascii?Q?gBTTTFSp1z3KjWN/KqighRG/DIP6hmZ7TmhkP9puQLInP7ugzdeTMDlt0nRq?=
 =?us-ascii?Q?VgCxQSgg2Z8pH2eiaeD1zrL0Lejrl0Cf9Tq9UMCtkQlPb/zSEazgkl/V3nBf?=
 =?us-ascii?Q?nvQn/OyaFg4LpuEMLEYadLkGef21WuF3vMCdloRXFtuxod+ueFJ4SMC1GgVh?=
 =?us-ascii?Q?upNDZgRfPx/EhehEmGuOnmgxrCvjrYwXl++2zjCuAAZiIpN/aokv40XteR45?=
 =?us-ascii?Q?YrtEymlOY/GKFk5vzESRoRAEtHQ4UM54IILftX63ysVEnGAcotYoBRHpuzMj?=
 =?us-ascii?Q?yCSdIS6kqEy7kyW+MnzZ6Y+fcH96byPENlreauhiukRPoaWEEVlF6E8s2SPb?=
 =?us-ascii?Q?ermOrUSTLoU/tfaDepVeFrBkIg81jdeQ9ximpQebysy4SYpP+wwT00K2wPJU?=
 =?us-ascii?Q?EsMRJ/6xBxnzSFHOiALeaN56X6dj2ouO0vuzHefdZbc9bD0oZQ5MTnVfNHv4?=
 =?us-ascii?Q?AgYWw1Tb1x350CUNUNJcMzJlXCm4db8z9NNZMOC/lOeVbLUNDfw3Lfrrs8VK?=
 =?us-ascii?Q?0f3a24V9E7CabK595YG1x09yNhrbtuv2ZLtEdvwhOt0xteq2G4TSCaYVTiZM?=
 =?us-ascii?Q?vFjCxdr2FFjZaUadHdYnrOUQPgUiQmuFGwOvPY/P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44963dd-0b71-40b5-7568-08dbe4fbecc3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:46.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0s2mXeNrWvM8F8j7UH930w0joTxxr5oTi1Q2368Iv9N7kD8zbUHJjuzAYTIQGBbqzlSbKq4GVCeandDwm4pyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

Export cin, cout, sin and sout vars into mptcp_lib.sh as public vars.
Then they can be used in all test scripts unified.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 10 ----------
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  5 -----
 5 files changed, 8 insertions(+), 35 deletions(-)

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
index cc65d9e25481..1d7f69d36b4e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -25,6 +25,11 @@ TEST_COUNT=0
 
 MPTCP_LIB_SUBTESTS=()
 
+sin=$(mktemp)
+sout=$(mktemp)
+cin=$(mktemp)
+cout=$(mktemp)
+
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
    [ "${NO_COLOR:-}" != "1" ]; then
@@ -509,4 +514,5 @@ mptcp_lib_cleanup()
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
index a85c9ff21e54..de897b226d40 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -12,8 +12,6 @@ bail=0
 slack=50
 large=""
 small=""
-sout=""
-cout=""
 capout=""
 size=0
 
@@ -26,7 +24,6 @@ usage() {
 
 cleanup()
 {
-	rm -f "$cout" "$sout"
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
@@ -52,8 +49,6 @@ setup()
 {
 	large=$(mktemp)
 	small=$(mktemp)
-	sout=$(mktemp)
-	cout=$(mktemp)
 	capout=$(mktemp)
 	size=$((2 * 2048 * 4096))
 
-- 
2.35.3

