Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1566101EA
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NWs5jrvj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klbJqXxVleoL+Lf903gGUE5gGIpSjTuVTl6X9OLP8c5TR1NIHXOtABkGVa6mIxZb1dAsiMoCp876u5Y+T67Ow7/AupNVTSFig1nbQOFVr9bkdmneALbG8qBs7Ctwn8XA6BOoSKYSxoE+DzeXLvUqYdjgsIv6tVS6JWiX4InsRP2BpkF0ya2Z84GLwE5BiGP6BYrXTqJx/5MSkLZtGEKk5PU5qxUPpDHl7+3ksyd3nVv3KgBtG50jTh1XwrBLjnZ1nvHp8u+SeDmwCJ7o6RcYh+tpQKoP/wBVXR52TXJEKg+HepeACBJqQpVLtWH8NxjtfD6DdKpoSxC/IR4QuLa4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtFZ6DZJzV4+78frj955CzP0GHu3z8/oZaVg0FLt3oI=;
 b=IShTJ0ywQhKB7gw/zDP587L+5GCu43t5pUlqph1wjuNPLRnmjuhvQ10Y+qSOnbpoOTGwGJxpimRiPIjdTDhXwU2l4hvLGVuelGWRFRXtqwJYiRjr2E4P3uKo31Df7Y6FnEJowGYAEM6Hl6p2Op/uo6MZBYIURFZws41f0WenTZeiylwgdYwQwtr5Vw9nrdoYlHlJ2f32oYP+nARMvrmvcQIrDpelcq7Qhu6ztTDwWsFe0UUFpZ4FfFdOXUptA7KGTQJyGeFnaaz2uRJ/h3ilnNc6wA5dGf4AlRSoZELSrrm+UXSo7blFMrHBsxjgDDa4CYze7dq3NB0qOSSdPJTQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtFZ6DZJzV4+78frj955CzP0GHu3z8/oZaVg0FLt3oI=;
 b=NWs5jrvj5/m3w70XTDBj09ZVCn1Nb4VnhSXQBReGYBzeMh/RpKoweYb2NOrtJs5fbU6NqSMdAUppZfwwSFRUlzCsV3Zb59NWv6zPwPtYO/CWpWME4HwMUXn8mym7xLvhRXnykdNBewxzbeIT2GL6X1wepvaQhNkRgoWRvwAMD/cF4qd+vol+IqD0zQS2928ap5xCFlMIQXR1Kpx2czdKqhs1m1DDCC2UTguaDdIh4cK+zrXmHsKVPZoAVaMWhMoEZ25GPIaDy4l/mA+rpXuOAwZW2GP0nGXlogxJLYEcch8h0wP4xUNd3qW5kJVWi4zrJyXQcuGdXw7tvTyFbB/8tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:44:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:44:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/7] selftests: mptcp: add mptcp_lib_check_transfer
Date: Fri, 13 Oct 2023 15:44:36 +0800
Message-Id: <ad2a485c366067aa43468ed0b26a83d49a3fb619.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0589c04d-8003-4562-bafd-08dbcbc02ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZwgkXuR2ClF+6j9jkizK9fZ0iHBt4rr4pAGAuHTAhkDEUjS8qXoU/oTYZ+oRtSk1lVI3OVSxUZOzMWP3/c8e27f6vrYAlEgaR5bSNAegSTSwfevBkpGsRhPv9TPrfaZoMuN1aoAO8nzkGv6k1GFFBa++ZNuHm18R0wAVVsZM8kUNgS3A6PFoFQEa2k4I6O/2xpP8MRO+kZl1Zy1aRE8c16fBHc/AssV66B3aIa/7lHCoIkcpHGcVeJ5eZeKcGt/O3DqOE5xM2yf1L4iLShkn/NjYc1RCxDFMJpHCxetZjhIWi5yUNIUzN2eB+ZdZASasWYhJrKlJJ8IrsaAC04WHuQAbO8Fg/Ev+U8N8Pei0ujODYh3fo47ECNQdan7N7zZpSSydpIu5yW6WQl/1ZIFzzjC/WSXLPSYQAEwdaj+r5t/Eei9EUKkkdYazUUby4hRCsPG9O2+TK6F2vkjxqHjvOb0xjPnl4YVcenQjBnNloWvD9sS7gHkQ71qJKiQIy+ncnSg6IleWZiClnVYvJ3LbUyTkjcJ/BxKjmIJMrTvLbLcszqswXJIga0/9Vfv2QZocgJl9RoImN1MMRoQVkw25ji5kkCojNuDciiRR7nAi4Kw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(107886003)(66946007)(6916009)(41300700001)(2616005)(66476007)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1yYo87EvsbXMK2vCtzf3CsbkBQgYicdebsRKg4ehfwcbIwFWV3hzNZQPTuNq?=
 =?us-ascii?Q?FXCuSTn9b9g9CrCJu4e09mJCuh75cJVhYkYduPSIK9qdJlKXjwL9wdeeLYvI?=
 =?us-ascii?Q?WlKSRS702u1jOzQ+WgsqZFTKkRAPujWHYHA0kNmGAA+Uhzc1JKVp09FBfTfW?=
 =?us-ascii?Q?L1G0UK0xwVxvzPEi6D/t6BtzXpJeAzhoQraF3MaleQ9vaqDXXzZaa7d5KuDU?=
 =?us-ascii?Q?QgfpfmvsT9MrKtcbXO4AjLIr4PGi0+1bsjKeygutOStOHQJ3CwPrlevFm0DT?=
 =?us-ascii?Q?7kFxT2L7GNtbRPffdPc4ZZllf46PE1pRezQrrOS36uj0Ov57F3ZrTashb5pI?=
 =?us-ascii?Q?ZJEhooMCnn+61mBZC+Z1chQM4xhwDZgBa7yuKujJCaFuyS5JdRtTQehHjdK5?=
 =?us-ascii?Q?iVuxXWsIfl6q20UL1VE4om7i256A5cW67IqPmQMhtipsMppGeAFqKOZymJXi?=
 =?us-ascii?Q?+C7m4mvfAQtkl3enQcHM+xVmNqGqW9QlJupjbnDxuYTlVnLMERyPznKxf92/?=
 =?us-ascii?Q?ekpBVw1QFh7KmuFrSmp9Zu+rhp29TmazqmQyMNtO7HrapNd0fDpRwLsR+cqR?=
 =?us-ascii?Q?+NAiUC6uBqjX6wF2I51jU4axMA6eQgqUoHdX6vFq06X8rZLqUcThRsOLogvQ?=
 =?us-ascii?Q?9y0w0XuOX/FzuRjPsAko+CzDfShWOwzn9qbV7c8PG96QAvHZtTkRSiXZM39L?=
 =?us-ascii?Q?J7ST05yyBbRTh+j5E7vE3e8u51o+l2m63MaOzQAMFZYbZ4012PW/+tb1PiV7?=
 =?us-ascii?Q?VeZm7KblYSFd48VyLlzQi3IBokc6uTqOV1TK0cGK3CEjYijPXlbuV/8HDOXu?=
 =?us-ascii?Q?nK4F5AFP8w/EZkYRn6oC/Uizkz/MucqZEDu9SGoFZqa1i0t8l8cfS3InifdI?=
 =?us-ascii?Q?Qu0mp6Vb5jtDhDSQ8YkISdWlufVObqm9dzRCuNP4DAWWGr0AUBPOEOjuVf1P?=
 =?us-ascii?Q?NbinLwcHraIkAABQm0dQN1c6y3V78zL6rpIz5sDi+xjZrR6KvmgN1JPfLR7r?=
 =?us-ascii?Q?ukI+BwoT8opO1rua06YkEPumYt1oTA1KtG7al4b3MUhAgH2yAfJge0OC/V6J?=
 =?us-ascii?Q?T1Zb9ckjBn33kK53mLn+CtVDPko4vOMlrCz9yTVSqc90Ywj2b0dABGDIHnei?=
 =?us-ascii?Q?0PO9PL+HWNQEIjyGmhzbq/1hUDEDsINju/20IfQvBVzhpfeXjjbJupKsQZlN?=
 =?us-ascii?Q?IByV80ckd3PRWyQegcDcx2IwpXdHQJK6h1zxQvQjB6KhB6aTf9SZhvlxZiTB?=
 =?us-ascii?Q?N3QukUlTf5jgQi6cow66fQ1MKoTKpgVkg1SK00rFtDNNgnPQaBOvkC7eNh2J?=
 =?us-ascii?Q?OuiWxEVPbtY3nmCz/ZamdKE9D29aKNyn/sFbN0oliMtxYoLE+8awGQTZjoUP?=
 =?us-ascii?Q?0sy9oMedB0oprCCdL63FGGCkhIrsuVjCqzaGwEsx/+cedSzomHdJXAovuzkt?=
 =?us-ascii?Q?CgsI+0FKSLOHpadODHRViBZxFTP8RmXlDjdX8d3lkISkBEFgGbLlKk8uo82g?=
 =?us-ascii?Q?YAt1P5jyRzQYwe/JSy/yKASv4xs0rCQEJzLoLX4FHve+dHZgBJpFG5Tkwj/6?=
 =?us-ascii?Q?4OB3zkzkBXDmWG/WFAQwCf3X5lFoRyvRpD2yUjFfaaRI+r+cFFsxxeXy1Lez?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0589c04d-8003-4562-bafd-08dbcbc02ade
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:44:01.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeF4smywo2tnift0quGsgysWMRuEug6YlFAo3GrVDX0aEc89kmS5LBBlw/82oyoanR5Hhlr8pRfxeJ88aYAcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

check_transfer() and print_file_err() helpers are defined both in
mptcp_connect.sh and mptcp_sockopt.sh, export them into mptcp_lib.sh
and rename them with mptcp_lib_ prefix. And use them in all scripts.

Note: In mptcp_sockopt.sh it is OK to drop 'ret=1' in check_transfer()
because it will be set in run_tests() anyway.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 29 ++-----------------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 25 ++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 28 +-----------------
 4 files changed, 30 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 409520f5b2a1..15f46a8c0ff7 100755
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
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9d8b8011cff4..e0fe6aa4f958 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -511,13 +511,6 @@ get_failed_tests_ids()
 	done | sort -n
 }
 
-print_file_err()
-{
-	ls -l "$1" 1>&2
-	echo -n "Trailing bytes are: "
-	tail -c 27 "$1"
-}
-
 check_transfer()
 {
 	local in=$1
@@ -548,8 +541,8 @@ check_transfer()
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			fail_test "$what does not match (in, out):"
-			print_file_err "$in"
-			print_file_err "$out"
+			mptcp_lib_print_file_err "$in"
+			mptcp_lib_print_file_err "$out"
 
 			return 1
 		else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 6318752497f4..30096acb41f2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -256,3 +256,28 @@ mptcp_lib_make_file() {
 	dd if=/dev/urandom of="$name" bs=$bs count=$size 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 }
+
+# $1: file
+mptcp_lib_print_file_err()
+{
+	ls -l "${1}" 1>&2
+	echo "Trailing bytes are: "
+	tail -c 27 "${1}"
+}
+
+# $1: input file ; $2: output file ; $3: what kind of file
+mptcp_lib_check_transfer() {
+	local in="${1}"
+	local out="${2}"
+	local what="${3}"
+
+	if ! cmp "$in" "$out" > /dev/null 2>&1; then
+		echo "[ FAIL ] $what does not match (in, out):"
+		mptcp_lib_print_file_err "$in"
+		mptcp_lib_print_file_err "$out"
+
+		return 1
+	fi
+
+	return 0
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 755ae0f5ac4b..b90a5f32416f 100755
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

