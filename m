Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F00125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyZR2D3UClsCRxU8MuLcyExYeHGnx0vxTyVqWcj0ky1HOsNnhHU9n8BWX5MYDzbxwTLjYIh48aBeh6CZfKExpsCCGPdDIw8ys2scoI/dk/JYPgwzEfQLKZ9q1pECmQfzytS5A38wEwX1MtDUKI5Oud5uVAffxJAtS+5N/RSGnKwlFkSdzgAqrscVZYtuqFqktfFnplj6+rPXM/mdJkqKkvXqXiF5TQXMlADdgDP/CVR4egJu/PAikqBtB2cua0HvUvgEXMKBLFdfY363ZvP6EWd01baVEGtfwaftFoSwvxnJ9LYTZSZWgMDQOrkTtAKY1aZWPJBLX2+Fuw6jvuQORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIrW7/25Xrfd24slnKQx4+bibQeZAmVdI/AdCNiFfq8=;
 b=lkTXhq0RsOQtOBFU+X8rlGBEMblrcqLFrHlGFd8iRnKBhxB8Q6hTZ8EnlfZZFnBHpDA79EVKO/OGN3dogdmxwepk87qrTM7BPIAs9NUvhRL8tv9wi3WLEUBRkWbfdGi9YKWTJX90xBCZRpxiH1J84Wl25oDPq6pqXUwHfCndw4YsiP9M2rM0zJ+EAOLGdbJmiWqWVlAK/eOp3AYvjQBKmzkUbDtbnIHEuF5A8HGrZe1JHkRbXqn566A1XoYqmLAqVAiIfH8JC7gXr6Gd1LSbpsUCgrISikvORk13nIrCvOUvHJUTvx8SGTQBlHEd0AtRzXrAuLB7arzATfc8JAwhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIrW7/25Xrfd24slnKQx4+bibQeZAmVdI/AdCNiFfq8=;
 b=Twf3FBwg9wYI+mOfTtA+fNcFwrPugnEAK56Pxbd6cE61MnXJB0VWeD351fvfkso2VIFLB6dt2+sCML2u9EHSKSS40Y66/EX0ahlyv1OeznpDhPko4R58RfLE6BaeaezI+QtnAlnbKwJilgCv5ZAJ+NWlyOn67lszT6KDS+SLND9pyvaX14nzn8Uo/VNA3qLOiroJpfkbj616dH7xOWfLlDS4omcMm9VRKWo7Zxs+4UkcGIaK8pP+jyvJMd2gD18lhFfZMjjYh8w0sdqT+BQKOwzdbhiNItq7f6QkaSTPhXQ1LMqkrPpFvD2EWcmcpxLXapRmRrioSf1PSbtqxRDLug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:45:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:45:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 28/29] selftests: mptcp: add mptcp_lib_check_transfer
Date: Mon, 25 Sep 2023 16:42:07 +0800
Message-Id: <a37ed95ef83e996c98a4f3e7376dc708cbffccbd.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:300:55::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: a62bccb1-0f51-4d62-1002-08dbbda3b5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZzyAxKIJpqFt4GYQFOQ7MS6jLxg4Qn1nENJEPfaayHsFcvBnDwFLQMMIG+E3s7JS7N7CfrGt021XQsdSw0xP3hzIMO5BZHMgYCVL7sC6CTASGBqDw550a94AjZxA5soNRwRRHCo44zSjtePEhWdbXHD5M9ZGiUn+mGjsY32rk4TJradq6G8GJpYTyywm6Lbfo9opX3p32bycgtX/bGLg0RvagdTSxKm2xw6OcF5nBrE6DhlU5jGyrT8XZ1VedLi1jpycKVP/NkUxZWNRSvD2KWbi/uOCDx5cZuyOXFdJWkCH0notV2UxT4f8Ie9KUZWjVWxCUQ9ENzxolbW09rIL4mFeDEkHe4ko8Urlx45Xgyz/DHxl15tCenRJ8Yy30P1/KLRo9fTf7IjMEMAVaswDq8VGvimOCp0OX+A34zsEgVWB2VwDNT6d75D93nGZhsgoETWFl2l/MBHgJW3eMNhKW9LUVtTUcSzPxCRXqPSY0VfWk1g3LZ1RoPjZvodotWS6jcfESOQ2MEn7VOLJFpPbpFEgBdX8jBdxhHvAbc8eRt1m5YLVJnAW3mKo6FstvFyi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(6512007)(6506007)(2616005)(26005)(86362001)(66556008)(66476007)(66946007)(478600001)(6486002)(38100700002)(107886003)(83380400001)(2906002)(6916009)(8676002)(36756003)(8936002)(4326008)(44832011)(5660300002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hfIn4TDWjJnXGSXgK7N8eUqxWLkLxAwtbDoatoh+qUEYcn02KS0UFYHqCAkD?=
 =?us-ascii?Q?O84Uih6Bnt9mFaXUyaUATTdMDxsONe8q1OhcvWlWX9tn+dbqHf+vt9yNCpEX?=
 =?us-ascii?Q?cuq5ZoVkrGNoYxLDzQLhPOSQMXhYluMO0ggdFjKqxwSXxobhaSEoheiBMd+W?=
 =?us-ascii?Q?PLDk14ssFFeMzHU7ClO3YOvE1V6oS5stsn5twDvmd0NuCWocmjX6ETBuwiaN?=
 =?us-ascii?Q?vCv5VR6OTNc/1IiuSs3ifvVJE30iAivUh90JFDRCaevParRFyd4ssFyc62xg?=
 =?us-ascii?Q?HRJcn4u2Y8lejbFKny/AbINfRT+lvBLqO2vZvtSP47LTis5VmqadI87Gtn6J?=
 =?us-ascii?Q?dPy2GTGb3JF63iprT9+21+h6qP4Dj3OdaafizLxPc3CKGvOBU17mW0eK1UeA?=
 =?us-ascii?Q?TCgNPF0vqliLRcWFSb4ll8TEUKxmP/XSiQ8SRw5vkl3d8O2ntXOONMWWUS0e?=
 =?us-ascii?Q?CYs5lS8leHyOo4VI/i+hSA7+6sKOAFrm1BtPtaSSbHhDR8GhtXWt1CjyQW8m?=
 =?us-ascii?Q?gSaedjQZ69RY8Q2p9c6UvbO2oJuTLxfpRYdTOEqy3MCywynBuw+Z4jRTQyVB?=
 =?us-ascii?Q?ZfTiACuuWcchpYXpVgQNvCWWO1thR8W7oL64qttkVIAqjjuVipIab1+aHeHz?=
 =?us-ascii?Q?A7N4/uXBK+7BRjfBVfj7cSo3Rr9Yzq33gxt+vT07YbQyWx0/ZYseLWs8+GCX?=
 =?us-ascii?Q?CRYQVbAgkPo3dnqI7CGWVLpSdDn7kyTi5B4jtKBCSBl7Os7PxZBhyk1YtHYd?=
 =?us-ascii?Q?N0wphIji4mpoL5VEX5uXNQDZEAeu97OhJCQBCV1E5BFtDxMl0eFb7sSCPLZT?=
 =?us-ascii?Q?E+NTcfYbp/IQDtNTGZDYhrP8nIEFTnwKOVbT60xcharO703inQ3nERcQTN+G?=
 =?us-ascii?Q?bpjxeoSiqXodWKXlAe2nBNCi1i6QyGMRBnu9G2WguNZB/LLbL5+Kze+IKMjD?=
 =?us-ascii?Q?9oKCRceMFlOxd/nKIbKrAbYjkI3oqnkSBjMjxF4BH3cC6ImVj+4b3rDdUuJ6?=
 =?us-ascii?Q?G6WefB/6L2DekVVsbXeDu7aPNo80a6Qxgf/WJ/81xIORaL6jpHLTY4LpoKZj?=
 =?us-ascii?Q?u+makK9CDdx8hakSR+pxXpu7b6aXmam+izxBxpVVg/HGrWv/OXiBQ0cU58fT?=
 =?us-ascii?Q?qsFAQSV4gTbhBS/PGjvlzGJJuolzemtuVeF03QjjAT6nB3sGPNXD8SIxXpE+?=
 =?us-ascii?Q?+at8zYWCVvG4ma/6uDWBmChvSdmeX1vZq1hWv5RChtYFPMSo4qGTbzqtxdi4?=
 =?us-ascii?Q?QEAIqFFZe4BdBkiEP3JjiubutaUOml32ejJSCj8jCqYf90emPQWOW9PKubjP?=
 =?us-ascii?Q?qRTJMIrG6xIxCqZ6lo8v9WoQ9I0ea+5v0wtQGbOR/GdfL83dcZ1n3qBQ83MB?=
 =?us-ascii?Q?pv6zotm+fc8GGZ85SjcGwTIUutLfD9l3xvsnSRad0+JwiPybQ0ATxKfrQme4?=
 =?us-ascii?Q?NUaN3yr2SQmy+eM0tCtzOnng+DTtlMZDbLzWpJkHxqb3Kjyl2xl7OeEP+/b9?=
 =?us-ascii?Q?KTN0Qt1L2zwZtlLEGDHuaQub0gp3HwDt2uHBdcTC4mG1vRv1IwUorhaZMrz8?=
 =?us-ascii?Q?2Ai2HXFOnbQeuxHufHJ+OM6aleUNsFLtK29Ho6SN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62bccb1-0f51-4d62-1002-08dbbda3b5a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:45:03.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNn/lzZu+qP2AsuBNtvlXX7VrYuGyYnL71i4Fvwc4woAIrWTbnCZtJpSXUmAT2Nxt9yb9KmA8p8GYfCYvd/E1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

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
index 39128fca99dd..aa4b9a4e6a56 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -135,32 +135,6 @@ check_mark()
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
@@ -232,7 +206,7 @@ do_transfer()
 		check_mark $connector_ns 4 || retc=1
 	fi
 
-	check_transfer $cin $sout "file received by server"
+	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
 	mptcp_lib_result_code "${retc}" "mark ${ip}"
-- 
2.35.3

