Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA3D296
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="s10CzpWf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2lmnNKjTCfnDUOoE1ZUvJRxMciFc0vhx/j3IH7GGJxxI56/xdPhp7lTFbNFhaYTN0Jmiwk6iTancPpHfpVKhpUIXovQLUj2kiscUvKG1EBD8/eEX3bOfk83o+eO7szWbM7K3CQQNNgATH0Wj0mKmfvipUoUZxavQdRShsgcmDuQvfidyUv0AaQX9W1nkcfBeCWlzhPZQKXss0oEKo5zusInhu+GXXlV74PRMyWsLM4334+IN+t1H2CIr+AJfz93S0KWqNlsmcR83QG/oRJp7oZHjxf9AwF4vd16wGG9qvXIlCrtaG9VQrX+K/W9FsuVSB83jkh+OgP+hU3w3kU6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOedQMCJLoY0vY50UsLWLwEw9Hhz9n2QNv2Fy1tl0WM=;
 b=JD/eNdjnZSejOxQOm5XHi61Y9EIBQO+fdvQaR/qv10rvnj0K+GRU1eXTHOTQ+ga26KCRXXF4j6+HdmBjR4EIzVZy/ZTo3FBdszXDPo7f0c6MkSHrQmnSE5lkZXBV3R5JfWcTMVpa1tkpG90SzCPOxnwzbaY/JjeOn8tS8br9N2QA+IWmyFPvmhAlq9IRhXJB+8yEMqmyLkKsJ/LUcXgNt7PrIOzroZMDwdH4etoifhqkmucufFVud+vKiCtFkRrwV2wyP5wf9T1AU/7OAzuxUcksdGjuQewm94dnQrM+aUsLKAXp/4zyhnSMyvK1sf+UChdrEgnbgahPpXqsiah5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOedQMCJLoY0vY50UsLWLwEw9Hhz9n2QNv2Fy1tl0WM=;
 b=s10CzpWfBhKQ3T+L83w1Dj1SRXNz95I8sfEzQfs8YPdY6LvFJoC7AGUjdAFawjbznzCrAJXcd0XwGgpEcPgdUCqoqai+72ml9mWTUNEYXq5/pNndLackfUnRcA5fO60eqRqs5fE6jb87pbrIjfLYeK7CVcggLBMf9yjdfFEIfdCWQp73V58NV9yBUCylbwxuAXZlEEs1u2UFRBlgVa3M4jZIMHsvU954bkjKQ9+QBLpHDTxCs2oVV4ftFebMYJVNReEyUhWngEn4Yh06vvxWppBj7yJS+1PvGWRaqEdNbax4KLD4bgwWLNLzCo8CylmMO7V/SMmbNCTyjhFxabqh4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 10/26] selftests: mptcp: add mptcp_lib_check helper
Date: Fri, 17 Nov 2023 16:56:03 +0800
Message-Id: <40a8a4a5ffeb99d98c75a3c1c1b609c01ecd68c8.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbd872a-f9d8-462c-56fb-08dbe74b35dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5vX7thKcRwOoiuceBUXEEaaRC9OR04PGoA0ak280e1ovSfEumplG+TpdXL/vJbAhdRSsmCN8mbmd9obcjzP6F17VG7FW0VL3yO2XQKLMfsMNJyL+cixEmX+ukBQWVxZkHMc2LNfn/z7c30ltumWJLGUCDJyCazqHw5j4MNeZ3HVgz8iDoE3q2sy8Bs/yQno11oAc1bO2deZGrXizTqnfh+0e/ovwUowaTmtgJ3LA2Yc0AP90pvGpjFjah3bT4Zw+f9AcwxV+/bYt99QMNX3zr/lvXDK4zEu6tw5qqUNxo11IorXqwkb+1Jy/n4ZNnwlyT+biJHAV6Cosaygp320EFm2xxC4yZccnGH4ZA8x3J5teHwNWSWWpq69tGRmCdoBvqgqE4d86FNJaOhAu+g85FHMXLClN7IdbHo/HccO504dsVOogEvWrdQ6o8XQmtVK1yU+rGhFHgfMHXOE60t2W09C7RpW1BiaibHNTEu81yGLcAlkV/5fe4iIEwtrXQyFwK1uaRb9Eht10YDJ+v+qBHo/NtQjxyPnn0FGYgM0EHI7dlEiDOMRaBlXyQlznXcwH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2lFe+136+Z2Y5/ndCh4wSay0Kufgbc515JSwlJ3CT+V0RPuqglqBFPL9Cgid?=
 =?us-ascii?Q?Ab9hCUhpsMem5UISP2zMcvOIvbzoztsoNgHpTIb1oRSyMeBIk79Bx95CIfqs?=
 =?us-ascii?Q?AVHW4OlY3lAuMmlJLpxgPyAlblBYzuyv09rlYTxYAC5qhyXGszVAkOjqAal+?=
 =?us-ascii?Q?KhAbFDuzJGWxZWksDtVIXT9A7fPXmTgmvRULBPu5y2aNphjgpoGywRn3KOIB?=
 =?us-ascii?Q?y8ZDziPiFu+o2s9KJd+VhQaUsjI9yM8YtxqPwZw68CMzo4Kxb/iyAMxwUAGq?=
 =?us-ascii?Q?H59tpEp3Xzv4ldpURSw0B0kI6Qqs41eZeM/QRVHc8AsaIxvZYJsYQrzLbIxO?=
 =?us-ascii?Q?AVB2LIKLY4CUx6vGtt/LfVxtIIEFl0b3kb3OISjfly2+CyUv5GL2UMMFpKeX?=
 =?us-ascii?Q?AoscDkX4d1f8l2AUpYq1s6bE/HT5K7Fk3dLP5YZg5s1xCYkk6y2Nbwakw517?=
 =?us-ascii?Q?scS2+gi3XjE/BQowjEQKv2mg3NDLC8e45dROA16lGSr6fobRjym6Njhh1AzC?=
 =?us-ascii?Q?1mgVxf7C/EE0PuKMGu+8EfdAnNp7smAI7aqHSgecoowy6XWeQ5MFrPmgyG5m?=
 =?us-ascii?Q?MeIhRn0IV4k0ohFPVik66dxQKOc5mDJQ2XDV14U+B1KXR7xl/eGmvE9rzsAL?=
 =?us-ascii?Q?IqWx2u8Km4fHxPYqpV7T+fKWzrlQBmgAL2CExECdYZPRQ6GvBdYjuRDVGEUm?=
 =?us-ascii?Q?BI7ShsLN5o5smOLdLD1MTN9I5ZG571/5RyT2LYc+DgbvdlY+CmCZdpmB8l1Q?=
 =?us-ascii?Q?0Z/Vu6hLZB1TgOYnCKsAHz//sprBmkUB1BNxnre/KPktTdfAbaKkOsDvC93/?=
 =?us-ascii?Q?MY7UcCUnwku4iTyAU1TSJXCSJNnrI+U7iSjBxURsGVOMy1Hk0i2f8p+mR21d?=
 =?us-ascii?Q?B8p0lhInWs1U69dVeosGhk1FGs6gYrIXPXN4Zu0kh2dMVnJKPTyoV48FN4UF?=
 =?us-ascii?Q?AnXnJqOQalHwmiHKudtdPegZdEgufY275cuMRSt6r8/tzU8S/PcFnEGAlFO6?=
 =?us-ascii?Q?W3T77whb9oPpf0H7chdSu+JnAACPZAXcEhqCJiSDTsyfTvSg9FIFuD62+Hmh?=
 =?us-ascii?Q?Igh2q89Tgu+TvXaxulFZK1ahqVHppZAA6aKqwWtTt17DIIhBwymC6EnbUZ0e?=
 =?us-ascii?Q?ZS5CE1luUw40ZcwkaIDySIWqK7FFOGqZjBzkhFAcVnFEYkp07KwdevDq4c0p?=
 =?us-ascii?Q?0eH9DJx2wAfl0QRtWgNcVINo7ebmjUzMr3LqzaisAqUzw/OfQ/6lcp6bIxcJ?=
 =?us-ascii?Q?8JZJZVQ1mQntDNjj5Jwg4TwjrI+2u9TTCPmtR7X/v5RyEFTipNylct/vCZuw?=
 =?us-ascii?Q?vFu6Nak8NOFuKT1uC+eVR/2TKICkVB4lsycn/lUW99TPX9ufTg4Xdgtm3Ovw?=
 =?us-ascii?Q?k/6OHEgWfDWsCyNs7rk9fS3QEH8K6tJvdu/FEjAnO3K3uKcmrOMmCnQtMVLs?=
 =?us-ascii?Q?2vcUbB1F2SRMJUkZ65P5OWm40EncuFC2ljrbYo9kYJ3HsMTgZg3GftNCZ39k?=
 =?us-ascii?Q?Wnv3Pr2t+xUdnYSPXoMTsrcjZofRqXrHJI+/HRPh34c4+x3NTlQDb536peIq?=
 =?us-ascii?Q?HFyoxmdN9BM834gstFU8baz0ZVVGVaHQSk56615O0ndNOZeo0bm6TkqEWX4K?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbd872a-f9d8-462c-56fb-08dbe74b35dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:22.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWhYofXK5U2OsWVXtr1z4+Z3WjvGkG7lFVQYcP76lSomxTN80ZRue8rHA64R9kqUxa/wnXmfbLDi//F9QtqR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

Extract the main part of check() in pm_netlink.sh to a new function
mptcp_lib_check() in mptcp_lib.sh. And use mptcp_lib_print_ok() and
_err() in it to print test results with colors.

This helper will be used in mptcp_john.sh later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 27 +++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 29 +++++--------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index cbaa55ab89b1..466fde97d3f4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -300,7 +300,34 @@ mptcp_lib_wait_local_port_listen() {
 	done
 }
 
+mptcp_lib_err=$(mktemp)
+
+mptcp_lib_check()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$mptcp_lib_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
+		cat $mptcp_lib_err
+		ret=1
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
+		ret=1
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
+	rm -f $mptcp_lib_err
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index fd413b4c8123..8d30d4a1db57 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,12 +27,10 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-err=$(mktemp)
 ret=0
 
 cleanup()
 {
-	rm -f $err
 	ip netns del $ns1
 	mptcp_lib_cleanup
 }
@@ -53,26 +51,15 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
-
-	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
-		mptcp_lib_result_pass "${msg}"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check "${1}" "${2}" "${3}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
+		mptcp_lib_result_pass "${3}"
+	elif [ ${rc} -eq 1 ]; then
+		mptcp_lib_result_fail "${3} # different output"
 	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
-		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		mptcp_lib_result_fail "${3} # error ${rc}"
 	fi
 }
 
-- 
2.35.3

