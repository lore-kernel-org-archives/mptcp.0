Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9974AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HQOXAuN9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLwwv5z7qqkn4ZgFyePiig63+JfzXjh6Jcrjx276uwYUz2BIKyVErR31LlwVoA/N2ua7pFwgmEyJZCQyN+Ke9CPdhBYCAO9OUsWj9qLqwcoY6JbW93AdnGn7BVaqx9KezQ7Fzv+/Oyd9QgZC0Y3W7kUy1JECCCe2OsOffHuOOfWjZbSxmtV1zTTqsrUVq6Fs7+wPEDSUBITNksR1ZPJR+6O2p+y7+nulqkJle1LcBgw+YTI8yHsRjruGPnKaL+lxLKwlCjtKl0xZrGS+YxvxQgGR2i5LLZU21OUfcjzohbuC3ZGNhhJ9MnTgbB5p5Y0nUw5Y/1hdOmPm+W3ap9BtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkDzcPInB01FgHRiLn/fJWqMw2C6tyY5KCXY5sH7Qw0=;
 b=Im0ECmCFHncWRnrqJB3jU2kOT7OpCDJ0b/olcfZwDrUIhL4meNengQsRFkpdzZ7TEgcpUDrMuj7LZydWwFxJy+13R5D5MGcdJbYVgt4VHDSEKn+DMvojz1uOrQo5rxAqQetre9PBMPB9SDqPk5eaAnFHAwyyC7o5f8FsAdwP1qQ96PE4vEhz1mG6q9Fc4+wf3naz+w20rhLGJK4FsuPizFOvQOHbYeAQFvJmB+L9MVDq4hl8+csOnxHl5uhyRXkxcjCcxJUpB4X2Go975dttESnlTrnlEZ5FA7BNPn6ezm/Ra6kxFV4NdToBiaDBc8PGbHkQK2AoQEQtJkYcuJQVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkDzcPInB01FgHRiLn/fJWqMw2C6tyY5KCXY5sH7Qw0=;
 b=HQOXAuN96vQ+8Jbrgc1GPaFsAOXnN/S33dqETKjkBBCXw+5dqxpbvy7fKR2gsl6Ym+XipMCT83BvT5rZM0BpW7REqXvixz+ZkptrYT76QDqnNcI2zYukNGdQjpNJYDkr7k0eO+sSx8DJjh9c/iRjaekbUzhiLKox6E3YCQhDz3Vkv5c8Nj/wNKFWGCBXnSqiUlgbipKmyg3EGq5arzhkUJDbbWdnpbPVv7FBDimgp7GjShwNNt7jJ0uiO2izdpXTbAYj/hOsDiUZk/decSMPrvypGStMkYGwtEQrF0TWwML8dyyTDCXNgiosxDIKkaN33UULDxdKhc2eVfdnX+yGEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 27/33] selftests: mptcp: export cin/cout/sin/sout vars
Date: Wed, 22 Nov 2023 19:31:15 +0800
Message-Id: <f2022ce613e13f8ad82deb04da485070839b30c0.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f34636b-49ef-4a69-6c79-08dbeb4ef6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DwJtd/m2PEBVQYsuuqInzVcQk1mruz4sc/pH9WXpBYfILqkRoyrRvYIEea0Mav9WqzZhi04inKJzGeDHdaGA+rh6sHGwQY8Lm8oWnr8pWbni/fem0C992qjFxOWoLgA+bO+M1Ur9VWISWcTXb9y2jLk2STEpCcmNzJhXkacGUmvMQW5E3Ut1DavSeiioNa2ig2mtiFRKr1y9Lz0aUa1Iw8dwlFwjVeRi+jIW9LhO0dqi4rNUh4JBPxxQ2m5F1uO5yUlFv62FR1ROCfK2/1aU5UluqCt44B3kfLlE1IG4tWnw1rMFCEbH+FC5CYGTFFHwictWg4Wa8lncWVtrKQF9vlog43/y7FFgh0lPvtCm6PbOCFKvBqQeKxOosIH+RZ+mr7ERCj4EKyMElF2D0/THwb9kelOGjONUqx6p30RRBkfXSKyXXz7yrNhjDVlOa2TrB1iapvybJBNDZh93PqVjDA/u+ANsaQGC8kPsCv5pt4f46OhTacC8tqho5jOb8cv/UbJf6mLCL5tfrwxUvInlASwyU3MzN6/ce/cGumzvXoc+mIg32uj4yixXPDouJnLFs1fU0RbbnWdZaR88JrpseHJbOBdVqsj+LrZeGwWYaoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Eg72MgmSBBtumYj5iG9C29biOZr2S/NWnRyeXtITM6rC402Hr+RrCBruuZ1?=
 =?us-ascii?Q?qg7yOSUOw4zMIN+xlwXURnTV90oIR4nXvF5w5aRe/yH52axwj/f2D4G2jzTD?=
 =?us-ascii?Q?wrAaq6yiQDyR+hOcDOogGEN+OSCyGS6GCjGk6+ONneDsLzGWTukXZUKaju+4?=
 =?us-ascii?Q?Uv70uYCuA4I/DQVwBt+tdijsCAqc0d1ZMK868hIOcWmpfg+YV+9ymXLtpstb?=
 =?us-ascii?Q?5kdpmKmN1psIexKeykLHwdb8F/wDd8dqsWzEmIWBXSB3eOgm3N+oBzKYx04A?=
 =?us-ascii?Q?1s+5QCsZImYZkrVuqOby7wD/Q0ziTPH1uebe5zuhzm/Y2m2PdqtuRZIaStAA?=
 =?us-ascii?Q?oYWCSe7C0jNGcNWvUFpwK9qPpw0BsxVCoaXTwT/1E7QthQLwZ/ag8QUE147H?=
 =?us-ascii?Q?iRqPCgXXfZXI7dP/JpGTE3cMpUeBXlX7AeZHZ0ZsxfObNiZGJeXFMKcpiNJy?=
 =?us-ascii?Q?Bl3iSzg7PqCNO2V9+NhN5q1Xiqgq4FnSbOwGfVBF8qXRJ3Et114Aun7lvFPD?=
 =?us-ascii?Q?gy2Zp6ShzObdSAce9NaG4mV7hbcRzI+28rL0Zgp4EJn7VhS+glTD2y7GS+Se?=
 =?us-ascii?Q?QhgqqldCn6qwwJm1lIvAZq87wUMt6g1XcAdzj+jBWkevsjwnomxVByL8kdYq?=
 =?us-ascii?Q?rbDw/3rN7hTQrTClurOBMr0MyluSuPkC8eQmKhzs6/Pxxskz++f7b6BxheHJ?=
 =?us-ascii?Q?2us18NqGBgNRjNhm9ihTa6hU+pCQfbgdNc+wB4RPKOaQ/N0nlxhFZ9fHLEn+?=
 =?us-ascii?Q?0F+WhRpQRc6hAkXWeMQrrvjalrQ38CQ3OaB/Zcw2IjiGDKdri2vtth0zM2zi?=
 =?us-ascii?Q?PybvTokB64Dtz/BdLvcq0aivtyYDNG8aux3HHNSJlX+0QvtfCWMBc2JfUIjj?=
 =?us-ascii?Q?NA4o8Uh3ZF+DK/2QYPYdHVGXnnS5j8159AL5yu2DMg/n36pT/dR9eHz6Oi+N?=
 =?us-ascii?Q?JVSyOpgUdvrOTmqcbH54NLHB8Osij/tbs0chz4pw5xTZjq5zhj7qxN37gyIp?=
 =?us-ascii?Q?07p7mSUJYK/3Y7P1FiLZGL4iIWGniknDBHvaK7RkiAsT8alB753tTQUi80mj?=
 =?us-ascii?Q?QLp23mgfOJOjozzcK1qgRKNWnGMNczmBHc8F6KD4t4AsauIvqw9ec1sLVyg3?=
 =?us-ascii?Q?+a5d9aEGn03QYCurL2rg6/CSU3GIhpa9SEL9FCDlysJsjqAYn4Zr9neKGvic?=
 =?us-ascii?Q?R+/pGVdVnaUrXVuKTSjvGBp/k4gKZwScB9cYzrBXliEEt3r2SpK9OZPBGmc+?=
 =?us-ascii?Q?U1gXZHf+FekW4J6pIW9sM1EddrBTN+ruDhjlezoBwKdlsftto1l5R6CyXEPE?=
 =?us-ascii?Q?vc2pBszjkIG/45VzEei0dsavtqxhXwJXzbrikuith/fBuUn6w3zdDlSPpeKO?=
 =?us-ascii?Q?FhFpEnEbWYTGmG3r7l2gabXIVK2azTfvFtyFRcWLgk34228veNMpFy/oZ1lP?=
 =?us-ascii?Q?bFqFgDrLRGms1vOYYvbmhhdRg7VPabFpYAxRWYrlGh5v9o5iLT5yBqKwos1x?=
 =?us-ascii?Q?J1QT4olzvD/rXUiXyQmXvjEtNRjtvXMzCNHahA5xzRwY+eZ63Q0ZD4S0FpLk?=
 =?us-ascii?Q?xjRWNqquLhyQxpzO2IDogBqckZppF4J88oTWAZVImfK2dGDrKN+WIc4j5cGg?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f34636b-49ef-4a69-6c79-08dbeb4ef6d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:18.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhD+nmTHXLtslMbfacFjwnvClml3U41Eiivb01ymijjIuwbdWlC+pzBF0YdsyiT288HqT4Rm8lwACETv3YMfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

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
index a52784a14b76..f412c6cf7d3c 100755
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
index eac5485616b1..806eae63fbd3 100755
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
index 070c277cad4c..ea04b2888bf4 100644
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
index 2b02689a92f2..839ce692e099 100755
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
 
@@ -331,10 +325,6 @@ do_tcpinq_tests()
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

