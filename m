Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611E31A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfZDekim6ffv0edbZJGKcjwDV2GNhYvF7a66v4JlwP7StlR4u40QJBAbHzFEUqCe4PSCrZJMIvO6NRGvnz/4R5YHiKDcksjb7OiHuHSgKqvpmwLAylewZlm/8bZI6OompkRwJEln0VkU55s65CEB5Mefevkkt2446bDCn/i5pEEgcWdj6omWDiBu9o2wf1DHImEpS8ST7DHaOWrad9GIiBPr+Yxq1VfTTt2LZ4wgUImM8V5dXWwKVFNgbblBjx5E8Uwzod8Z6AY5uXRFY57WVADL4OfmEu5keSCYiEmj+MRPMczN2/VRiu7AECDsQHaZId4j4hGce/wOK5PU4thxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIrW7/25Xrfd24slnKQx4+bibQeZAmVdI/AdCNiFfq8=;
 b=OzC8Q7d/cvd1+pnGw2DQ9PPUIoLR0Q5m72zph4rWq5sHaIlKwKo9EHnxaoBgqospwRCBA6TyG+M73C6KdOHt17fxTXhoN0Tg+4hV1pawarXb6oMet6KU20KLzOMd20MYDUd+NO9vLpO/584Rsp0IVJV6glGJz6dDi+fs5kqjwWOo3yypMEi4scMMeztrHU+EnPp7kB89I5Qv5+c8s5Reo+3lvOdR0L5KfMa7MqweymeHcMfTqACag1QXJJ4/JG3WH2mWjYNb0XJmH+sD/YcUY7G7yY0ucLwa6PwkFN8WxFrcNaUjNCo8pQwYp2RbLy4dslJXlZg2TfXvECl8/5GiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIrW7/25Xrfd24slnKQx4+bibQeZAmVdI/AdCNiFfq8=;
 b=vGMT8PH52gYlVbVXXjKpFN3tTLfuwzv2IwPRwm4ZFftuC0uxlPmz5n686FMtxMBJ+deMwYtLgXLYc4RTW3fXIChUVz6ppogBXGt9ciOaoTwOYHmcdA+UslnqbnWNd5gOWxMtoj9Uxn19AL2Yujt4hkSPXFiw5Ioej7rUJw2VnjBCCXqT8TmfJf/d3FfsnCB98vLTDwSFJ/GHHAHY2gSS6KJfjJj/YYjEc2oDTlKX9Y/1hE8iTbNs8o+OYXXWypuI4gWGX+vM5VDPEGczoErJw1XGD8lBRA0Hv4HNPndt7L2l/knJrwB4RgFFIRVcfSnuSruXnU2N5EV95v3/NShJvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:06:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:06:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 29/30] selftests: mptcp: add mptcp_lib_check_transfer
Date: Tue, 19 Sep 2023 12:02:30 +0800
Message-Id: <20c74b7d5dbac1c4a47d167ec64ae3b993f24dd5.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5c1637-8112-4cad-0894-08dbb8c5c515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lIk/B5fbXnM9u0vfw+6SSgPF3tCK2XcF4fDHoXRDs6L3VDvChn6ZrB5CE1hKgfV/xRMx+jUZnY9nki+phegDS73l7v482J+l2iLfHXO31zmdoYNezSRHfMdaesZ5JoFhXzFfHGDzk3IsDX1SMIY7RW7i9bIAZamqKKSS7Dv4602eq+75UHLNhHh/3qfeTbJavLABj3Mi+ikU5SPtjkBaAFzxRvNJg2DZmBrJGD3oLlHVmRugHChnia7j2KwCUvK1WpXV3v7q/vRdiRIM9XPNJmk+6Lt+ekWPzhIpHRyQn2Rl+aKcmnfXW7X4oL1ZQ5nZtnE2aN/2/0HKSdkvdetDQ7BSrDMqGHw4jIJRZz4mxIVE7Obx6+2uzelK7zr5qamnFnjgJoU/K8mBDSh9u7R2zD1SE5kfZCzd1yaVD5qXWkYbEM5jzEA3+nR5Xe97opB4nxwX0nBlxFv9smiCov11x8NjNcSlF6pJqbUEoryKv5fG9tvvs6SPfYF4xM84GjIV9h7pLIuTabpYk8QfE3GZpdqZvUrkwy4DTaqQcR7whFEallH/qh8KU2UAAB2XKylXvsJ6iRIJ/Zl1oF1eOVzX6MtKCebeoEr2gRx7C2HHIOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7pm0KKjgHiLNuFEYmA8T+3ltqUssNSTu1C1Mg0UYrmVaAVPydGAsUaeEiSH?=
 =?us-ascii?Q?NAoOdxl7JbMPoT2x0oMNZTHi0Inzm9cWbjhOgdOJbdLEtWBdi3L2cF7xtoeR?=
 =?us-ascii?Q?GbojUv6x6YPXr7AQVe1YPgYsxs9pIx+Q5dfA+8tnvvdGf0s7DvxfdcjK2SeB?=
 =?us-ascii?Q?7qO3clyXodFYnyuCODphb+fmL3b99ACl4TdhuOpBOhTdKFTPtAkSjzFhHNg7?=
 =?us-ascii?Q?REJU4vwLaLKEPFxfwEqPbZ0jIRrmyDB0JU0QPmlQQG09ADFdO8ZA5189E1y9?=
 =?us-ascii?Q?Q4Tm864+deeADyss7xtfVjvyxlWQRaoOIVPaYwD8LlClHcPlkeUliE1+RJjj?=
 =?us-ascii?Q?3+mp5pSFxxcpS9GmZFU2nVG3swxjyBfXdF+G9ZQyfbAx620FmNEnCkAOULGA?=
 =?us-ascii?Q?jGn8GP39CBbWU56CZCzaLoBAUtqKhf3ZZl8HGBPBHjhXyfQHZ+71yngkidsi?=
 =?us-ascii?Q?biDp04+GAhabl4xGiSD+fngEPjZegXaly/xutycYr1oVBmUP1/pIrnP+0jTX?=
 =?us-ascii?Q?WVWmhJtNWQ9qYdnXvPeVRtF4Djc6JjPWlU/3U2DbdChrn8KtrMfdsopkORGu?=
 =?us-ascii?Q?QlZfplN7iwlyYlV/HTGH3UBS8Eulna/w5u3fLLhT2FEW14OTRh/QVI1X2r8/?=
 =?us-ascii?Q?4AaPRCz4UbtQpSTCvLbIXKJ9SlI30PRPmDBt8eCAqt9op0o0PsG4YjFYtDNq?=
 =?us-ascii?Q?UN4gVrdX0rZU8n8gF2L6QnLWEAGG78Uk8Z9kEJNWOSJlRNAoE6Xc3wu3/MUS?=
 =?us-ascii?Q?WkW1nIJvSKFLZl86meq6DDI/VFH8SWkdsWEF0XcmHrp86234E+uWrE4rxywh?=
 =?us-ascii?Q?+ool8ciNeUupwINTMojFc9v2LxYS0cFGPV7BuyPnw4FCbnMyq7vsvYZVnrCH?=
 =?us-ascii?Q?427DzsCnIY1PW9WXbgWx4FbGO7rFOPv2G16Cnk5JZtAzeK4CSRNyTfrXa7v/?=
 =?us-ascii?Q?RXQd6TIiCda/OUPeEMPHrkdxHFzMDMbSTFfVatPsoUWJbkBI4LCyVlNmm6Mx?=
 =?us-ascii?Q?h1xX8+0KkvLyCWDfkaflyJOPpxz5Ih1Cua0ybmfjjvKVeldDvseit5/gM0d2?=
 =?us-ascii?Q?qbng7aHkWDr5YJ9F7jUSyAiwW3D+B9aGj9jHu/EbW+WeXKgKT5AmlGqV96GU?=
 =?us-ascii?Q?qyZhSI84srPh/0l5tVonUTHUmRm28rYiTYzLrylHGqmpXFYZbvuNGBBbkrve?=
 =?us-ascii?Q?sLaXUjiQZ76mq6L8r5cGRK9sPlnwoqQ8kq63bb28IWHC9XlAuj9ygo5N8JQ1?=
 =?us-ascii?Q?vNadZpB0yigF/xpss6uITiu0OtXJRGbH/YJxhjcXC1GXPvoeUQcORuONWdwY?=
 =?us-ascii?Q?wtMGWtoEIw5gNG0q9MNtE1NE5hqT9gidoVnfeB6LtrXuDUF0UObZplZ8MPWb?=
 =?us-ascii?Q?lxsrL1LyYEpTNtkRqafX1+cVQIZASPI73+Wd8aA+ynHiwHdQ6qVqneh1L62k?=
 =?us-ascii?Q?dGjc/KEmkUUraQ+2m9RqxTVSWl+rsHt4Zv7iCAA/CN6t3CbdfdEWFgYYhfR+?=
 =?us-ascii?Q?ipXA71evxVTTQZ6/yM+xaURfN6V43mv/nq6kwMCaIYNtz+G6AqNKabBJ3E8E?=
 =?us-ascii?Q?wVIxPUaAOHdPvNZfSHJsiyrBeMQQlGK1XGqdDUQr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5c1637-8112-4cad-0894-08dbb8c5c515
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:06:16.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FURCNjjkYUOldjYx8B6O9IoDo54CTcVvBXxPTwwMzJE2ph+1MAzuDdhH+nTXhvVJSHVZ0JYhNNIOAIy857Cbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

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

