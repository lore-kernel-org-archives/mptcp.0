Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00317134C4
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 12:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqhVzZToZrGAxpd9cHeTXE/JXscBLY/2qw5iWY+2XMT5MCnW3zxP+bKrPMAlshWb8JCH8tYq2IIGjtLXtbeS4hySRYaov4yh1UFidyOjzqlifjy3WNQDmCwlXidVqoz5dyYBXYMasi5yjXTltpfwbJ8aM0qPvFHwMXvOaFSdRoYHf8zN55BBcDNdCwKFq8uSjjatUYl48j579xE2C0i3dSVTxNgbywjApcS3T8Pslall8mlURqA+PFLut4mbeva4DthbmVX39JIaAQNY6cueyHHbezQR6+QTmtQnRsqg/mKPaa6duKkPH/V4Fjjn0YSGopkCm/TiTMkYhlLMiMs2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4h6rJY9JOEnFxreKPuuRgN2XWKVdQUKHm052L9jaL0=;
 b=nzFCSkFMqIx2Kh+SMRME6mgZ5OHmBroxHFdCTWnhbeDDKRaSLgHHYuDp7fdhzF3aNrIdJtiaQRFW2TSeTtTJt4AASk7DXJ1tzKgPpBca42FwnLszg7mz2b2HB1pY3ckO4g3jbmXSwvRoBp2X3KdTZH5W4IH5IaW30QvfayfDQtl+yIZNGtYyjvDODW+T/zq9TbJFBTF91HhcqAphrskqqpwwshVvebHNANzt/iEZDP9QkcUp0yK4p44e3tXt8x+LFmhg8HOtQu+Fb8L2vYWTrP+vRUUKxNKMleFfHFb1bgWR3CcgTqypRen4DUM984/k787d3Wt9S9YJT+4Ay9o21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4h6rJY9JOEnFxreKPuuRgN2XWKVdQUKHm052L9jaL0=;
 b=FGlUk56ZFqe4OSz2KnY6nj2PNohH3CRFgBId9xL3eFuG6PNEO0zJpHFe/DtNdQ1JOcctdRlN3UJZZJTsBIg4zN+71ZPRz0zI0jfeYM4yTjRnt8QEk1NZ2sve+tgr5pGtcZR7y9tRQN51l0dc2b7O/UHji31kKveJv2AE3H3jDodQxLcTDHL9oPEKtSFakhzeMS7HJ2TL80ghjA1xiwLyIquonHNd4A1efSAMGHfuDH0O1JZ2qx3UuW1wyQxPJHdMiK1zj0BrAdA/oxlxNu3r9ftwyO3970WEF4RBs5lUj/v/aTfA+WC1IYKwO4G0ZG/Acbq9ZWPwVIb1Lh/TWrkGRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8772.eurprd04.prod.outlook.com (2603:10a6:20b:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 12:05:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 12:05:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: add chk_subflows_total helper
Date: Sat, 16 Sep 2023 20:05:44 +0800
Message-Id: <bab90ff8ed52b455d13d0ec9ef43311d79dff10a.1694865871.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694865871.git.geliang.tang@suse.com>
References: <cover.1694865871.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ae63ad-0ef9-4a70-cbf4-08dbb6ad3185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2dopLwfU/ioPoZdDc++Vf01nIJz+Hw7Ldb6R/eksigHAFJyKaHaBn94xDpVWtwkCAuWEQMqjSm4PltqzAyJWjUPOZ7RaJaV77VXf5n++oX9CNRlfAE/o9JIUwkSlI4oi3hCvmjTm3KnphKa4xAwQyIr6iZMP5+jCIh+yYLRXsHyGQ9ZUpNn/WMMuT0I0w0Edlr3ddxdDFzF9nFQXCSnS/vAxGrJSth/Lfux4Y/2X+1rIiNayO7KaVeniBMv58r6YxhjBRMZPLlwoDCLugrib7L8dRMCQHZkJKxT28IqycNTxVGQFZb4Z3YRSSHOUR6skDZIUoOXRFk8Ax8ZwywoJree8pCUAzS5aTL/VexKzcR0tEI7OG5BV2tPhlfFBYZfUB5KKtk6eN81rT1MLW9ERo1SnOZFgQEuhD5XNAmpmRWOfzBtTGCUKMfToDvhyofF0S0QCztWZmeibUJE/pcqRBdRZKm8htWjGBaUlfim0GAkNuHRY8HzqoKGoqNxY6qnHgG0qUIIbPU/9N2t7tfwL5J9uaDIZOUvFhvm18hHPvFiNy2rJ3r4mnrkdohja1Ht7CNd/rL9W9YaqYT1f74jZuARwz+42iTzkyCKqbECKduo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(6666004)(6506007)(6486002)(86362001)(38100700002)(36756003)(26005)(107886003)(2616005)(2906002)(6512007)(83380400001)(478600001)(5660300002)(8676002)(4326008)(316002)(6916009)(8936002)(41300700001)(44832011)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mehkY0R3UN5KxRjlpUahORMTCvl3AiYW9RNgOWVF6xV3UXdYr+3k0Sg5exm2?=
 =?us-ascii?Q?U3WwLIE7sRI0+Tof0Wck0TkOULWSSj54tkJrQBqo8D36+rMHpeWpyKKxWjah?=
 =?us-ascii?Q?14xzhV3+6+8XNBwM9ivxzpA2KH1GcFtNlpOca83f9siiRjLpZshZThf1QRMl?=
 =?us-ascii?Q?bHvzXv9KymzITjk9ipsxkv+2xq295VnU0kbanQXgfh8SfMRYRT0LkZS7vL+Z?=
 =?us-ascii?Q?yZWHh8l1VeCJMXwslqzEyZfJZQ+/+DKE6HNZXfSZnSiuapfsgq3blDUkiJoD?=
 =?us-ascii?Q?/XAZSYO6815qW2dqJXBbyHCVWVsPpeaDqBy+OpENQ96RaSJc0h7KBv2dNMKh?=
 =?us-ascii?Q?gWKMjUExYFfwlHQ7q4C7GPNq3YrKmSjruqik3ORg10u+MJmJbDrPPptaBXaQ?=
 =?us-ascii?Q?9+UNMJvN36jtoXHQ2ZDUuDZn61w5bV56XPSYQN7VcAda9VVL/5+kgKchtO/e?=
 =?us-ascii?Q?urZFe3sbBnYn+Jac01RXhpBKN45sx3W07c4WwqFgTebFimyAQ1Crrs5XE08t?=
 =?us-ascii?Q?dM5DuXW7/XhldGucYcnSmWuM5Xsw2wvoxe1rPo8FzyWsOkWkbSzEQYd5ruK6?=
 =?us-ascii?Q?FOfq83bdjrLlYmVHtSBTHrmIHmTAAdGGn9dWwP5YpxDx804q1fHFrDv4xEx5?=
 =?us-ascii?Q?iViLgZwJ1hTR/TVporcbFTdt7Nu3hilD+R0t+LPWWoVB4ZyIudveiuwPQPN9?=
 =?us-ascii?Q?Idrp3yuOQL3uuYS7xr4EGIPl3nUfgEmOS76PwK/ReXySt++jW7Cqn5ro4Zgf?=
 =?us-ascii?Q?z0S7Gm4V+eHx17SpdYBt8OCBDkpNbveHjasUAhay/1OmET7N1KBb/T2Gunpi?=
 =?us-ascii?Q?+AQ5Mvs6XK7ZcspO1TOsGjMxWwNTXsMbo6Kzoe+YfYth3izAGENZ4JG7pWEM?=
 =?us-ascii?Q?TuGBTC2pi7mo5iI8L9Wtgsl+2/zXWFViqpdHnEACnkrtmpnP7pUYMk3xuwGK?=
 =?us-ascii?Q?IDAE4zaYJtArXRIZGABs5UCu3fkWqvmePwBhkUj4QHsvPpt4fpizDio+tNtv?=
 =?us-ascii?Q?vEGrzqmDhQYouFdhh7oFACaFjuB9kvsp8xPaxJmjMZPkQw8CPR6Jkjx8sRv3?=
 =?us-ascii?Q?AaPVLM5uwJ8sAi79Egv0r5Jx89G3pQP+fG6vYhz12sA4fw/7t5q9+xJpzXeL?=
 =?us-ascii?Q?YkoznbvEwL6OOfuwj5UWhsMupWCqhz5rM1cK6Tfp866+zcp/mB1Yae1el/IO?=
 =?us-ascii?Q?MJvcaaEnl48RhQCNdcVnr8dH8ZMDhEIkF3NVlKCJ26gwzOeflyNLaGoDZgmr?=
 =?us-ascii?Q?LspJHshgcGUbkmBue/Y4BNbdGN14mORiFeFFhgtDAP5aEHPzS6nWnpVV4s+H?=
 =?us-ascii?Q?yJclI/xQsu9Wg0EQKABr48yA3F5TK3d9kD85D2zY7SLLPqfWwvcBvN99UPHc?=
 =?us-ascii?Q?F65k6F8fYTR5HieJjW9hADBcoMJkXd/n7v1aauxJ5QZGLiS45DEQ8hLdoDKS?=
 =?us-ascii?Q?NFYNr3tY0a+7uZQHXxrHj5iOerg3ZyiGv7PzzZbvS12GBTIT0EPIY2EtFC2u?=
 =?us-ascii?Q?OpebyO+CMxdymm2TAF+Gkh3UHVjFadmIho8HR5QyUf4qkLnTr5adnBfTmRRu?=
 =?us-ascii?Q?U7aYykaGNRrKhVD8/UrowFSOX41jo8LXD+z9hkaA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae63ad-0ef9-4a70-cbf4-08dbb6ad3185
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 12:05:18.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJYDEAHoUU/DmpKB9GnQQZQ2miF4AmyyVNDg1/qb2OP62KG0VPyVDqPyXalcfWiMMPDLSW173wr923SQjcM1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772

This patch adds a new helper chk_subflows_total(), in it use the newly
added counter mptcpi_subflows_total to get the "correct" amount of
subflows, including the initial one. To be compatible with old 'ss'
version without this counter, get the total subflows using this 'ss'
command:

        ss -ti | grep -c tcp-ulp-mptcp.

Note:

This patch should be inserted between the commit
        mptcp: add mptcpi_subflows_total counter
and the commit
        selftests: mptcp: add evts_get_info helper

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ffc8e061502..46a95ff77222 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1771,7 +1771,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1792,6 +1792,37 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+
+	if [ $(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info) ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3195,11 +3226,13 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
@@ -3216,10 +3249,12 @@ userspace_tests()
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
-- 
2.35.3

