Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AA20F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf+PAT2Hg5ObTCF1xsXh98jaySyD5CdJkTSDaYcqyKfzlpDIBbNoDzBxpnOkjpYLaf6i95kmUOXGCEZZ2qv9t/DxoVH+WjO83JbU8jlYcDczxYDbRd3ETDgkoC22H03a/fI/ttkfqAaks7IZyPUSyQH4nZGKOXt547iYGUXYd9x8X3j7fZbpnuvmAgQ8J7CGqQMTR7WpWq5QnsGy00dLwuTlUsp295SxohGEcf3wpfPbH7JCxqeL3tCAlD9N6zIz/oBmF79t0ytokmEznegHg1dnuLyVGBHQTfMwhKY9QyjI3yuH7ybmDmZjtuvh95DE68hxFVC7wxHGXmX0sue+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBDh2uP7WlHnk2/RTglWowHnCBxw+CGw7ftEu6ptPdc=;
 b=jDBOJFUbsLz6GSMK/ed3voemWcNDjr7PJpzT8+R5RdIZ6U2UyiiyJjOKM2pp0v1lvbngkPQKdGf6cbRPdo07sf4okGwqQtH2ABkirdjDdgN911tJNnesSw/pn0TgWEeK8wEBPAdVhj//Pe79DOD7XMCaukeO7B31/h0oR/7kjeB39LoNSMAklSghPWy+F/nlz6BpMvz6hdl+WVQE+dUhENbjWFuCJ3wvcB9pJ8cMdlyi1fRPJDDrc8YRO9hzdNGrsRb8cMpWU9Ah9jvzBWX8wqBdHfISmobpAKtXjFb2ztm99NiSMuCbyJ2c8eRa4xI0leUb5XCdW6dTVhpMG8YkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBDh2uP7WlHnk2/RTglWowHnCBxw+CGw7ftEu6ptPdc=;
 b=l7LIkX9i23/dwlqZGKXZBabUWKpD7rrlCh5hWd6ert5Ya0iYCTbyq/A2yPLrvQuXNV8aIPTVCtMGAzr3pTKwjkmaCJRMwBxKXGcTHWdjJg/45/+R/v3szTi19njx+KcJVOsqDytXqNb9LQ/vBoGDye7KHOKHsuL+D4AJy2PIt/dIMdCW9ltMXfoMZqUhlt8aTDFwOx+XfbDL3GyjkPCiBlCaYOuZJ9VzcYB5QywBFyTFvqifiXndn9HUXT1xKRSlXrOXkDzSJA7SlOe9peMU6VA+VwOIjdgtQy96SzLyskR/ppvpQVDsdHeoFMJZhXpboyAL+YaknJZ/4+MCYWbhXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8529.eurprd04.prod.outlook.com (2603:10a6:20b:420::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 07:20:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:20:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 3/7] selftests: mptcp: check subflow and addr infos
Date: Mon, 12 Jun 2023 15:19:42 +0800
Message-Id: <cc9df9ec7d422a3b862d440e511b800cf8e97bd0.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dcd8b5-ecce-4db1-82b5-08db6b1583e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vD/Tu2xx64mKO6RMyRzx/bT/sFJ1d1F780G6wp828oZF4E1JTg/Yb45cgIFA57Tmkq4fLpd8FNIfFGzMIi0uPzZULdMHOFDBIr7XRi+Zg3XiZyChUtVbe/N7jp6vE4Sm+Lw+fFE6OrBh/X98C9cX+Kmk6KO2kFlrglaZC/zc69B3PT1idPYMnJPaPsQLDxF2gyuMRTWhwHVYEfzYJEkujwaD2JcVXpfMdxctpEgzPFyMJg4zfzsf/YZcyfThG8Ehp7dkdItMxmHcrumirEFe05LW4+J/84cQsazuCfz/3gx5X4tDRQv0C1LCqdKJcc3tfbTuyOEXBWIKGHBOtOb7YJ1BU1j53N5g0Vx4IMLMqxcZ0GtPEYrWart4R9v1znr1UWXgbhQuOnz0r5+3uh5i89Wx4OIA79pF5mLFMjkYkgD8KsrjpIl+FcUyDDnzxqDbzV8+Ipbo5ZWElQ8/dA6fc60tJds18Pd7aH/WobEbzSCttSLrDitcgUidHpEOsU32GWtPcD0FqF23Q3JWLCg3q6wQb1PvGzPQr1fQlxltXVkjND9FwTmfFDi3tOaAE7V/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(66556008)(316002)(478600001)(41300700001)(66476007)(8676002)(8936002)(66946007)(38100700002)(2616005)(4326008)(186003)(6512007)(6666004)(6486002)(6506007)(26005)(83380400001)(107886003)(86362001)(5660300002)(44832011)(2906002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GttKIccDfrmFIrp9WeubYoW/r59FlB0WytT6we9o+77SlG/JohKAErM47kcw?=
 =?us-ascii?Q?nmmn6AC7tKaZclwtmb90epFlZSULDG42pwHcike9TTa4kj+Gf3xAjlbZnlrA?=
 =?us-ascii?Q?S6tzCY5g1cPDUqKR3PgaJelPZ8zJ+tjq5KhP22N16AAoEmWTBqUq+JtJ8g1c?=
 =?us-ascii?Q?oGS1Ft32b87GQeBboH0fsaZRBRor8y4Na0vlbz4EvAYh+ERJKdDCyazrpPxI?=
 =?us-ascii?Q?BCJWJ+TugDUNuKNW73+jIy0oRJeM3eiTvPmqSWOOZXsF6GmMgSpGLCTGfUo8?=
 =?us-ascii?Q?mVUXpjMQiY6g38djOK1NoN8B0LH9MC7qyoqVEUM6DWferhrjl2nd/Uoo2YVt?=
 =?us-ascii?Q?rZZpGz7eJmRrpFDWCThfaT/5TjNNAcTrIV3q3xdUcgDQhDQpjlEt1zG94nJE?=
 =?us-ascii?Q?ABI+gZ3guiywfIM70dJ02J1NOiZq7gD2TYf5x/URVqJjD9YfEpH/tYoiHtJe?=
 =?us-ascii?Q?Kx1+zq0oxdMZYKBOiHgtTQOC2WdbLEn68ti/7icvqRuT5BEQ8P5mXQ2odkYY?=
 =?us-ascii?Q?ZG6SGX/5hgzaDGbuIvluHPzGsAo/Wm95chJ78epKPrqn/Yz0JVAyVxJcg4Qj?=
 =?us-ascii?Q?kH140aMjTc2gfBLQ9Z9x89SK/dPTTU/gXRSFwAeUnCYiDM34jcAUMTv5z2JM?=
 =?us-ascii?Q?xWRTaOdMl7HC9RGPQsUS3WxF+QIX8gMfFZ/HvTev8wV2pE6LDZxfV7EwD2JL?=
 =?us-ascii?Q?+f5n00UPYq41N7nw6sxLVZDUSwbj2Crl0ft6nhRVF84C3Gwpfk91YYmmtY9A?=
 =?us-ascii?Q?Zw1dT5pOuGA0aTUhJ6MTAc5ajUlBLhht7/7Z2CkgWH1hySTQqfoJlYQ0mL/T?=
 =?us-ascii?Q?2slf09NT3a4L02eMFrCd9NDva+9M4VXuV26ruWCNuw75XRpfUrnpXdf8i7jj?=
 =?us-ascii?Q?hBMlVu5fn356qMYre9GLaxnLummWxVb16JJDE5b6TEJos61Q/TtAtKPVVQoq?=
 =?us-ascii?Q?FL2lm1HancdCp15lc2aodxBY8yNZ2aFntNdWasanA4bu37khAWtkBmKB0RyK?=
 =?us-ascii?Q?GNgfoZs31eolXPB5aJuMhsjOHDdNOIjbp2LF20jhJNaldYEDNcqhGMAURjXV?=
 =?us-ascii?Q?olkCyxLsL4iU0B3Bdp52hfm1LbcE6P7glCMuzJB9I28eLoRnXfZwmIJMfQQe?=
 =?us-ascii?Q?+w/HdNzc331iMlN98gZurjlreQKsZ4TT0vP7nbJj1geE4vJOgUw3TLzpAaCd?=
 =?us-ascii?Q?Nn+Q/24Sb/xuw60kErYXKi+q2LN/cfjxIbdK11zMQqCaWWhQ3Irm74czxMG/?=
 =?us-ascii?Q?83HSX9qeA0RGtC1XlOK1EYVqOU21Nz2fkl6kAYhRsn9yOjyyiuTBKaJykC2W?=
 =?us-ascii?Q?f0e6tTWQDCKGIbtNQkLSijbSFKSDDtpzTZt+MA/oBSdlWS/uwjhnX9fIA5sr?=
 =?us-ascii?Q?whTXAyfkBCxqKcP9LfahjCZhQbhewspC8jzMCZJAZgqp8Bsl8EMPJEWmfOKi?=
 =?us-ascii?Q?Bdq6kUc3Wz7wGiwUBAgN1ZqOmMHwK9YzCgOTbvn04cRlNB140+pHTxUgKdu3?=
 =?us-ascii?Q?hldFc3L738PwkGFsFXCbeHotwerrfaPAMgw2POIk5mSLL1LV1zC8u9nqrf1+?=
 =?us-ascii?Q?C6eavg/YcN4D6IZeEls1YLVQ+pILCVc9SfyEd7dX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dcd8b5-ecce-4db1-82b5-08db6b1583e8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:20:35.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwO5ldA12vcbfVVv6G/kFQ/zqG9aSf7vBQL3e1qfmwTJb3oHuzO++yuZhJWN6Khq4XZNL1z8hrDpJABYMGs3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8529

This patch adds more arguments for chk_mptcp_info() to check subflows,
add_addr_signal and add_addr_accepted infos of different namespaces. And
invokes chk_mptcp_info() to check subflows infos of userspace PM tests
and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 ++++++++++---------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 556d21c4b7a5..1697b0b89d9c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1832,31 +1832,25 @@ chk_subflow_nr()
 
 chk_mptcp_info()
 {
-	local nr_info=$1
-	local info
+	local info1=$1
+	local nr1=$2
+	local info2=$3
+	local nr2=$4
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
-		nr_info=${nr_info:9}
-	else
-		echo "[fail] unsupported argument: $nr_info"
-		fail_test
-		return 1
-	fi
-
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
-	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
-	[ -z "$cnt2" ] && cnt2=0
-	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
+		mptcp_lib_fail_if_expected_feature "$info1:$info2 SS counter"
+		echo "[skip]"
+	elif [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr1:$nr2"
 		fail_test
 		dump_stats=1
 	else
@@ -3327,9 +3321,12 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3345,9 +3342,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		wait_rm_sf $ns2 1
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3367,6 +3366,8 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
@@ -3387,17 +3388,17 @@ endpoint_tests()
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
-		chk_mptcp_info subflows_0
+		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

