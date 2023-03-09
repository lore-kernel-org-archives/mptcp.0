Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134CE2F28
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 12:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQtoHu5lFeq7uSeQcAyaJsiYNIOC6lNTGwvp1P5NW9I803oRQoDuCCT6BMlLco8rCbaqTtas+O/+d4xFbJZdxCq23cDQcxtP7Om/+cEpqwEqp6TpTxtD/LM3pmVLf97wMYUalG2bcc9+gHAbslNUwM1NAJ/F0GDaSkO8K+2BrXClCYKkpMVM0Cl9ReHHQfejnSH42okvUdit6+bc+ccr2LCFGw4KYo9S6zn8xFGkSY86C+jV6N+Oghaeni5TS8Z4H8mj1at1OeWnUT6pZyroiSga74aIXab50Hsxf/cXXEKk0dcM/eNEOS4hjrvXRCIl0lYkFH3RHAhwoc++nQbqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsNUxCr8IeIOoBD1CDAGe/o5Hi0JfAZR537qpMN1jzw=;
 b=EL1WmZrYDXJDp3LkUb/NdWma43a8fi9gJie+qEBdMWVsmUCXL72loc2Pvg893LG9r11lofn/WZ1xEh2JxNjHHMSkMIjGYGcD67mfLygF2YYK5oPrNURVuJuLnSudiRkj0aq6OMFpG2ki+JB7fURasLKe8CfT33mK08jokBrRmVPRPe/A1dL8v4seNpRsWS/zRsMQMpu833euNKwGHLGBaWpuR19RmsyHJSCk60bmTJ+9JiSFlSLqDxEutj9TT5lxygp/ydEw8SGCZAs4aDFrXbQF/xOeT7D+RJKGKj8Xix4kAvv953AsBvLHwmqADKy+gw6l7uH21T09yIR1eJ5wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsNUxCr8IeIOoBD1CDAGe/o5Hi0JfAZR537qpMN1jzw=;
 b=qxWnUkBZYRQM2L05DEYmBIWD7sRimzwD58ua+BWZDbG14EMpJnQ7mFvAajeoi5WqlTu7TOALLaxnMFiqM9KO9ndUTa/WkyNEqnf9Ndi633Nm3VbSDbaMWcLt1jghUXzDkdNOpROtqm54PTQ6TyIjckAkhjljkH+G8Lk8H4ZxbAqV3ckbFdxaaZHnNqjyPwz2CQ1GlV8SYSo1ginpFa50wbxoL+RnRZ8fvdbdyMhiuS3TmGr+/OsmFhR6lTPOePPvOO4vWZIp+EBeHPxnoO9TP87tfqFOen2KwuAw35DGafd87CX4IzyFDw4Wh5sYn6GSi3KDgXPwDMV3uZBc3DJ6NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9137.eurprd04.prod.outlook.com (2603:10a6:102:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 12:31:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.016; Thu, 9 Mar 2023
 12:31:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4] selftests: mptcp: add mptcp_info tests
Date: Thu,  9 Mar 2023 20:33:07 +0800
Message-Id: <4b8fae0280f74cb4678677a112113bbbc2b27d5a.1678365107.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 99007be6-2a2f-46bb-415e-08db209a43ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nRqSNBcshuTjDiXJEOREaUjkLZSnpZcL7EfOPl050ookJPl4tCD9gW0yhE4X2+GxfHk4mOchMnWu7I68q3UGhUEJCJQgO1jmi/BdG31eOahSJDULaIa0JcZADcFNlnz0010heD5bw7HbHoFjGldlo1YjBEy4r1mN/1b89Wwcpnjns0XV+PgOczZaduiuGgCDaofsdzPq6on+5qBzfgmm/HWo4MNdKsjmtCTlmb+CIo5QJnf42XaSD/JPGshKqeuYqy0tx85ieEmAgG1jtrxG8AqmM2WnoDL38TJYokYt9NNexT3JW4Qa17xGVtvrednK20sRcltPuPGZMNI6fJF/raChrzzlQAs1ihlA3DWFINI0FXci8ujn/khHF6oWSjXbSZby6R/0PeMN/5foMjZp7z5PfTI9Q2Q37pdsLn/eWSsbIn47KhL0Kyc56+67v9JazUzOMQ8GWqkihYY1UvlpiFLlv3RlFmut+Qs8Ky+iP6EyQwIaQh4ub7Vuh/BLT4KB+VyD4X6Bc7rZIJswJgraNYBU5B/m/FqwQa7V3VdqtBb+9u/eMkVAlOiNXYj7yLyHD28av4vc97lVfdIepGvEAeRYD6u/JtBwkOoNGOnzUpsjNnboTuV1t7AEHzxX0x+6fyDqjez0uPkc3RhkEEM3s6ZCooBWxry9GztmjoHlxZw0/phev3Zm1fB0rnT8z0f4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(66946007)(44832011)(2906002)(5660300002)(26005)(8676002)(8936002)(36756003)(41300700001)(4326008)(66476007)(66556008)(6916009)(316002)(86362001)(478600001)(966005)(6486002)(6666004)(107886003)(38100700002)(6506007)(6512007)(186003)(2616005)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nCdsuaaIybdhz164sD9itNyiUdKzx4ppjM3qAurRGcopPwo5nZg03WH+IXx?=
 =?us-ascii?Q?X96yvsdhWYfgC65gablZnphxEAJ8AQ30w6cf1r/3y9NdGiZOjucTw29U0ifA?=
 =?us-ascii?Q?AjRZ7gD8+VXRRdkf33R0CLK/RfntMjFQZY2pZ/6BMtpLTUnhfgPlsAKeskMz?=
 =?us-ascii?Q?1NkMjCBghAw1IlAGbw+ltDvbBPuTccS6tpmzxzwJSiMdd3YW5loMpNuNo1Lc?=
 =?us-ascii?Q?cdUKnGCucubTkwgp/EBinVb/vcc6otop+jjXmB+34FkEkf7K9PwHJwRvmFHL?=
 =?us-ascii?Q?coXGbWQSbMtgQSzAu0gwyVYII7ReZ9vZ3Fls5ykF7MgbbbOpX8fHKZ99Zpbd?=
 =?us-ascii?Q?jF7qPy+nOIxhooJ+KP2J8Cx5VPCYpfi6P0FNGfLe9p6Vot6oh4yLlQdOuLCu?=
 =?us-ascii?Q?6rmFt2xuCUWuhbEwDYhgyh5REugC8NI9i1vApb9DQE3GglwnDxiTD1ux+0DA?=
 =?us-ascii?Q?18rf8F7bLcK+TDHhxuT01qabqPUOcRGs1XjZJcmSNCMwHTcW1opv1Uiw+RS6?=
 =?us-ascii?Q?UHgOAKLMZOTFNS/DaBHkWM1SDZEc6ijMRpAXwJ9BvYPTC9DUd7tD8TeTR1/L?=
 =?us-ascii?Q?+Vg3kMrSNRwVPHOaOsy+fPq6sPoouhTCwf7P+OQK3p8MTC+UuDYdF/aHwlmP?=
 =?us-ascii?Q?SK1CePAAkUiG6yUoAT6QZshFLgjVJD5qVbrnuYR8w7d3HcqB3ngqRbsQ0UOh?=
 =?us-ascii?Q?o6KwSOsCKPA1i7/E8C212Bm3o5W6AVh7+4ISBTYr/JWmY9ag+4cBJbpR4dH6?=
 =?us-ascii?Q?LiRsOtDi9yPFSbmcCdLUEANzea911oKReumxwBydGfFFY7XDEkJcxxtjAwI5?=
 =?us-ascii?Q?4Olu6K6f7ntN7R8tZVlza2j8t266wZY3cfGRIZJOfqGM29YiH330FXiHpxNp?=
 =?us-ascii?Q?Paz9pSO1V3Gfm74fCbMuhzInsejvaCmzke8hyyJhkosihrgwYYe+Q0IIQrgb?=
 =?us-ascii?Q?ijhEs48KrMqBEpkj9Ui/MNwoMV5Z1Bi7tjDpZ67D3FyePlplcMDzjQmbeixc?=
 =?us-ascii?Q?uHDQOJnkIJ1L2WtYYsviyZ7iRPhegrCZTAabhLogKQ8/V/rZwxFUFlCtvBxF?=
 =?us-ascii?Q?dDOGOzBxkHFa5N4b8+tuDjEOQTA8mjvjeTIPPLdwNOr5l/oJyhawAinm/oKt?=
 =?us-ascii?Q?Exn96qlGRz0I4y0ykySK8qffgE1kUa3N33Ko+EGdS+fPriuA9vw3o1Q9QZp7?=
 =?us-ascii?Q?4l4EguuEkTcIW4mQzzTQqN1ggx9kvjMDXjpI2VrdDahvicYA8GyJpftlLM14?=
 =?us-ascii?Q?ewm40HNMaIXmrPvTHS92r6CRd3WipmrTwIV9Q37JWIuquMqb0ZUyM3aTA8oJ?=
 =?us-ascii?Q?wqvzl/pr1tyGBYVPIBvq0lmfpE6FJBApwOGQmEA3zTBaEtCjMpPOXTq8DRZj?=
 =?us-ascii?Q?1uzfQ0/Crt6awGGXjofe1+Cp+ZX8E0xsnUa6OKgwh0Z91YJLcV+EOb+HzyHn?=
 =?us-ascii?Q?0QBLEc0GQ/sEsazcbL6Nmjx8f+WVfKCdK8FdyQjtIVoeYzcEg//KEJ4iEXIg?=
 =?us-ascii?Q?h7m01ThQZdVyJWBsnJG3/Gm0mRGl7AAHAK0JEtDA72ptKrcOfeMUUM0MFRHo?=
 =?us-ascii?Q?0rbPBI6TJWFmOqj8Fca/HdQm+gVo0rawxrj2u67VlfyNBhFc4K4Uha4OqhKf?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99007be6-2a2f-46bb-415e-08db209a43ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:31:53.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiuQ8BwJzwE2cYIhXkfsDMfkCTfKiHjQ0QCM1CNOB3SWGNGWsp+DvPsHQtxEpBHS4WE5wlTqUlPUMWwIEaCeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9137

This patch adds the mptcp_info fields tests in endpoint_tests(). Add a
new function chk_mptcp_info() to check the given number of the given
mptcp_info field.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - use '-D' option instead of '-i'.

v3:
 - add tests in endpoint_tests() instead.

v4:
 - update endpoint_tests as Matt suggested.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 42e3bd1a05f5..fafd19ec7e1f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1719,6 +1719,46 @@ chk_subflow_nr()
 	fi
 }
 
+chk_mptcp_info()
+{
+	local nr_info=$1
+	local info
+	local cnt1
+	local cnt2
+	local dump_stats
+
+	if [[ $nr_info = "subflows_"* ]]; then
+		info="subflows"
+		nr_info=${nr_info:9}
+	else
+		echo "[fail] unsupported argument: $nr_info"
+		fail_test
+		return 1
+	fi
+
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	[ -z "$cnt1" ] && cnt1=0
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
+		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	[ -z "$cnt2" ] && cnt2=0
+	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -inmHM
+		ss -N $ns2 -inmHM
+		dump_stats
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3118,13 +3158,18 @@ endpoint_tests()
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+		chk_mptcp_info subflows_1
+
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr needtitle "after delete" 1
+		chk_subflow_nr "" "after delete" 1
+		chk_mptcp_info subflows_0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
+		chk_mptcp_info subflows_1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

