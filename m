Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4315A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5pj/3tRLhsOY6ZAUX9UkFdBwpalsdlok2LDiKLBRl3RP28gGRHcO+w61DE0R0ZVPgEXVqb8mjC+kiJ7dy8bg69NzIR9i4rDg/g//I3mH/hn4tKJz4dhMCzKgpFiDqR7HKQFFabYH4lbFSWfaAaR0pTIMRfI/2mRCSxUkm6yB+Iqf/+LUVt9YPG8YOfVT1DA9wPcdXbh6g7U3pihuYI+Gr75hBdmkUXrGIgsoL9E4AiesSEAeShbpsAWyO4/XCXEvl/JGu6X5OzY6p14DdDMTdv+UeSMwv9ACRTKia5+jnyZVcDcF6I1S+SeXnAsWW7BA790X/HtILa6yo7yf9IQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdXkffrTuan+Q3i1vmi9G2JNmVhglRCO/xUFkILxiTg=;
 b=EenUx77j+bXI5MXjY1VvfM8OwGajFaydEAjNxGhKy91Fd/Tqbh1fNIUO1BWjXSYahSiqtZCRcIdQn2IqUs+q+AckpYgtqp6SzAk0t4ZILWOX3FN2hANAHTGpxu9jWduK1HaduShO43+7QkYUqfV/uBmpXULl2UAn4EDtvH3GlQ92hIhf189wWbJ4789JqPD7yW4ji1y9f0rAWNdyvGAseIpn57AfMPcM43CI90gHWny/V+KZm/wSVJWiNUP9+DBDu+yCCrM485mfHKCjOrc0XN77bSmeXE+qkQGkgdxLKNj0nrkKELOLwfzhNucsHPPQ0WtcwbQPG3WhpXGMJVD+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdXkffrTuan+Q3i1vmi9G2JNmVhglRCO/xUFkILxiTg=;
 b=GuXc6ReKBjcsaVnhQ3MMkEty2PLqjrskq47n3oV7EtqA8u/Qu/NhCBo00x+JHDPv9E1FKU1zGdCkNEl0eB7IdmQKIZvt0vVVBtsxnpOq7zbSs7wlX9RB//76xmWFyJDft4UGT+/DOAR/CZfi3axTHfajYSzYY/EvYUVqlo7phCv8a2acBkDVkzJo+T84Xog8hAMT18mEF6kV5qlV6dwo+5XlHYahpdpL91Fdzjqwzuah15dGZyaEM2wP8ALW/kjjY6X5B5Q/E0Y0ePw1qmKefuaeuI8t2yHzQqu/Nm8yZprAA9Lz2rPH/SJ//snbAD5IctghD40r+q9Kge9vN+WClg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 12/13] selftests: mptcp: add mptcp_lib_check_transfer
Date: Wed, 13 Sep 2023 14:05:00 +0800
Message-Id: <2525c6e56112612abd69f6a3426e5210d25118ce.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 77958b9d-325e-4c96-efc1-08dbb41f7a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KmtHDCV7zP2dK3PTpKSQmwI5DqteTRU/yAPar8erlWWdwUThOKDGF9VhLCKFR5kpJHygG0YpyCc5pKnWwZ+qBcAwv1d+6uFRzAYYh+0yskNl+8Cawo1UpRCoBxj5YUxIVDQe5/xEqNYQ2fiSCFLL5S7lOOVmlFzdMFj8gJFSPGbu6uzWj9yGlZ2qrKH8i4hVobeqqD1fgaMbWRONSYYT9gPQeCp0ruNRj2yMkn+rLuJKfR1FwG8YY6pms0R7ZaCEf53C5waSh4eRnFRVx4kAOE62x6M50P1QMBO3JaRBSg0ndP4lgDUG3XSs2JAq10Ah7ue7DYIbsumWsxEa+/GPlghjr8DWZ26U6vgx5H9XJ/R4dG6K+5XNAGNjHwop14pnWfbA//Yo3KGcEFxKobOySi5/22+UCNiZGF7m3jbSM9SsjCbhwtDDz1iX9c/q0343enb/uk2rfEVDN7d8mzADJJdH/mVrlUgRPB4XOca+mN6zK6V/OuXVBCuRosmj0p9ZUNYZ753CPIbMVJ+lqNc+zE2hzBYJwHAhR8OtxoCMCM5qddwjxZv57WF5yWlyn8WI2WcG4ouoVYrBvjTOzpAOsBod/H89mRjGmZPLc6LTGAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/hww8/Px3np0wdmCoinvq4b1vTArL15JEgWJ3Jly/4MJeo/KJsIG32ZwuR2?=
 =?us-ascii?Q?ECxqLc0mcX2nt/1P8AFOp/z6/4lICA9IhD/bDLp60mLvqHi8jIvwkVcu13N7?=
 =?us-ascii?Q?4DsIADZbGM02DCtfDJjgVZKkeM/dCgxwgXsi1cjdTdVEny1DJHjEseO0UT4Z?=
 =?us-ascii?Q?ClBy9oKre4+Ftv7ukiYbWH6bQwkMtjL1S3BhCE6yrNGZ8bly5QvzLZ3kkqx1?=
 =?us-ascii?Q?xDwNnXS+vshZ/4tmefq6p2YpnnuImLLvJf2USXmrf9raO2eh3LctO5SzhFhB?=
 =?us-ascii?Q?jabBq5mCUG5T91zrMc44TeFd4xXoaDdaCQPJLnoKkRMle2TNEJgWB3HJElJi?=
 =?us-ascii?Q?/oBWxXdELxYK66JqXGoN/Ur0jPmlUdC9m6kT308hh5ThLtcKyQsEdNO+wqyM?=
 =?us-ascii?Q?S4ELBAAaGnh06BjR0ylcaH03dYl+RCH7H7rhyQSMLXr6sYroO+VbPu7J5lsN?=
 =?us-ascii?Q?RdvGDeetxvKGa2zRzPoQK8HZC7t2aBuXMSLg/cbxtzSpfaMDXLoJJd6OozAt?=
 =?us-ascii?Q?5Z6I2osInS5CN9v9ppYHdHDfOfShZsmjXvsRUYMPwlaDk8iTk3KdRsypYH+y?=
 =?us-ascii?Q?tom5PcOO36CG52axCfnuIU79DggToVHHPWwG3ts3zNPH0BRxXQYzvr/qi+uj?=
 =?us-ascii?Q?PJ0SnV8cVLvhMFT9vCEipVO1uq4GDk7hWkPYvO0W32HCS9ohzdzhA/WF+V+L?=
 =?us-ascii?Q?+9DmuDbEYzOEWR92+c7hsQI31PBsXIfB+/8yArWiHBcxzCZsVG6Pgx42ljDa?=
 =?us-ascii?Q?sEfRjtY4dHyDeuY8v0t61Q0+R6dKBqj8ZGPt4AWvquWltA0lgPgSqrifgxk8?=
 =?us-ascii?Q?8beTchRUupVGbD7gsiBYl6ITo+XdiXncuRZ43dfnjfT/sBkh6Ky74lUuz4z3?=
 =?us-ascii?Q?THK91by9BHLToBU/XBF2cbXV0ldimAUg4mYZmZycDZmivSYEZGvLcNrdiSog?=
 =?us-ascii?Q?M+tA5jBHtyWHRDd4QU7ztnXuhAZgZvcCiEJgkjHOb8fAsI36M3VR1p7kemOi?=
 =?us-ascii?Q?L3R5kqGVHq3LlpKuGjAGy1Z3IB5uOJ1N5i9yWtl4XkUwv/y8pL6+7dpVz2EE?=
 =?us-ascii?Q?Qhu+dqAyQry1hPYOr74HYnEUU1sinwPDVKXmyBOvzsepSVbu51N0XNsqgwXD?=
 =?us-ascii?Q?X55rdC5MqGGbTLS5c9cgKXGGjFL8AwskkT4B4sJ7gw/XIs+ULkadgJpnNJSh?=
 =?us-ascii?Q?Mf8hWgpjknghoAkT/RlXlX8m/nEXabOI5R10FpFCLcpP55sjN9ziasMg/Ado?=
 =?us-ascii?Q?ycbU8F88kupUEQx7NxevKuJpfQyx4VaN3S+83YVZbww8gRZfDhJ2hxjKsAf1?=
 =?us-ascii?Q?eFle7pMl/Ik5pbrFLy280yMZhzh2elwrtKmSEXZ6ov9TVrMFsoIZ71TyU3lc?=
 =?us-ascii?Q?qH+ttqjbm24DJPs9et04OC9yaM/2mJbKLv0k5OTzVpCsq75fgvLOpjJOzjN3?=
 =?us-ascii?Q?LQDxiesIAo1EalQSUDOcXLaT1ZeAAYW3niGNHugRbuiR/w0ty1FL8TIfWFaN?=
 =?us-ascii?Q?uIdOwY92g6SmghYtYEC06a14uYAV2WJ0DieyBW3ADH+nrgsefwD4PXeqX5Jc?=
 =?us-ascii?Q?BJKBUWJ56mktDD/6/tAXDpUwKky1X3+LaswPH5c6mUMl3Ex1tLgtDJII5FtE?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77958b9d-325e-4c96-efc1-08dbb41f7a7e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:49.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aukx05WikNQPTlNGKDw6VyADt/LdcPtgvouDRcZXSlrdj7z944QhwLgSOR1MwUnmWxNtgQ7cQdJBNY4Oh6k/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

check_transfer() helper is defined both in mptcp_connect.sh and
mptcp_sockopt.sh, export it into mptcp_lib.sh and rename it with
mptcp_lib_ prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 29 ++-----------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 24 +++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 28 +-----------------
 3 files changed, 27 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index dc4a1dd3566d..0bd2392ae442 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -254,31 +254,6 @@ else
 	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
 fi
 
-print_file_err()
-{
-	ls -l "$1" 1>&2
-	echo "Trailing bytes are: "
-	tail -c 27 "$1"
-}
-
-check_transfer()
-{
-	local in=$1
-	local out=$2
-	local what=$3
-
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-
-		return 1
-	fi
-
-	return 0
-}
-
 check_mptcp_disabled()
 {
 	local disabled_ns="ns_disabled-$rndh"
@@ -483,9 +458,9 @@ do_transfer()
 		return 1
 	fi
 
-	check_transfer $sin $cout "file received by client"
+	mptcp_lib_check_transfer $sin $cout "file received by client"
 	retc=$?
-	check_transfer $cin $sout "file received by server"
+	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
 	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7b0d03c40f89..fba62cdef2cd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -353,3 +353,27 @@ mptcp_lib_make_file() {
 	dd if=/dev/urandom of="$name" bs=$bs count=$size 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 }
+
+print_file_err()
+{
+	ls -l "$1" 1>&2
+	echo "Trailing bytes are: "
+	tail -c 27 "$1"
+}
+
+mptcp_lib_check_transfer() {
+	local in=$1
+	local out=$2
+	local what=$3
+
+	cmp "$in" "$out" > /dev/null 2>&1
+	if [ $? -ne 0 ] ;then
+		echo "[ FAIL ] $what does not match (in, out):"
+		print_file_err "$in"
+		print_file_err "$out"
+
+		return 1
+	fi
+
+	return 0
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 9f11dfffe956..15a6cd8cd2d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -136,32 +136,6 @@ check_mark()
 	return 0
 }
 
-print_file_err()
-{
-	ls -l "$1" 1>&2
-	echo "Trailing bytes are: "
-	tail -c 27 "$1"
-}
-
-check_transfer()
-{
-	local in=$1
-	local out=$2
-	local what=$3
-
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-		ret=1
-
-		return 1
-	fi
-
-	return 0
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -233,7 +207,7 @@ do_transfer()
 		check_mark $connector_ns 4 || retc=1
 	fi
 
-	check_transfer $cin $sout "file received by server"
+	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
 	mptcp_lib_result_code "${retc}" "mark ${ip}"
-- 
2.35.3

