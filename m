Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2F125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INnWFk/EBJ1OWr42D0yWg3zJ+DVeOJI8e8Mi+Z7HB5Fb+iq4xCNo4bkpRAG6HbT4JCmO+76L7T4Z6X/65PT7SZoySG1l36yCfRvdQGr5fND1lfSD6A70s/zaZZqq4frH0ONXs4gdwyQbddRnV2ylAPcx1+N7kmHPKnIOm9qKjt5Gl1Ls3nJgSeQHoQxGB0iBZE54Q1NjxhtAq+Pab/iSutRvlWKhC8lVQKEciuwh0jKMIRZQt26tZKMM1aAg3nzH1WXfvSosh5w9Ie8fFWryBp4sCffxtNl7FMlUFqjemNbHfojnnQUJjUBWinUzf3VXq/zERwvdJUIhx64JMD0MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am8hJtkTiPDT8vVp1mxVXBoJNYgwBg9fDaARfBxNm1A=;
 b=A/cGLkPP8zkJILGHTWX+4l4hMwu0PIRiVhPDfJoK99pkZSwS5UPIDX5wdmIgbiCXEecRzGlJqpytz4nRm42OHtxBp/WWs/TpLMsv46ANvbxP1L6O+fecXOem4aNg2W5ig4EAT3VUyCwCLUQ2yplqZZhgf8DWKgijLOdeDlvADvqRZQC7rC2YXHgFXJJhw/lnZrEAcb25Ppj43VgYQ8TL0HzfGhrmi28U/p8g6tDmx9RDndi519VDoAFD7cYpnnvS+HeghoCYXjeBpGPrC4Q8kMtRrn6tUjwyhX/klPB7ds/YuFRwYS6ohVgTUM7JxLNQW5dAWJiBdHZurGXKEbyWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am8hJtkTiPDT8vVp1mxVXBoJNYgwBg9fDaARfBxNm1A=;
 b=GAG3Jght0yHirr8XON3N0gDdJqXYiyiGE+m6NaV6PNioCN3IDJWOH14T39/jnmGMrmI3tT4Tws2Ez2xbeFn6cZKBmEo3gqDbxIs+KNvP3wEtKaQQZ0slOmKQY0HIBQmUMXbbt+SB4hYht9SYVu/DJJQzHoLAG71iMd5Oe39MetPzfjwW44ssEdzMCM2Cd4Mlwu28RV7wn05KCKYfdXkcCt+qZ6GMlEpXD7boArY4/kpzaGDtBjlfnUaulBxkErqLq4zGm13HWkaatcWPaex3u9m4DSFTBsFMxsaY+YCXuHj/+AiwuTTSeMlXx0UbyVbSBvp8dBgTU/GmuqyZNoHiHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:42:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 10/29] selftests: mptcp: add chk_subflows_total helper
Date: Mon, 25 Sep 2023 16:41:49 +0800
Message-Id: <e3811cedfae23f2486096957a95ae77fa01e2181.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PU1PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:803:2a::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 01395d68-e7f6-40f0-a0c7-08dbbda35c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VIQ5QBQOTGH3GsdoCyEaxoM3TQ3hzib9nS3BGCBSaYoXoLTvpoIVlzNvXKhj1QTdv7tNvkrwWsRdiSnH2Qn+Kse0NOaGET0/VmxXLEdzPNkyI/i3dNZScXPmw8YQQzCa7PfxsqdA/Cr8/eoUS9EyHf+gDitPNE/RPokW9D3C3P4X0ZYJTxN155tmaIs3Y/Y3mMdUURzRlD8fIPuixuumjFDIF0Dh3KZupE8AMCHEDe3IKM4L6tZLNYUTY7p2lnJehf8Zasl9ewTQbMOXJxaDuxxvUMstXy/YbC8HI8w54pP4VSKA8Ya3W+fchClQ5Vdbr/Q5DXXoWjPNe86YhSVMsBJuQIa4mQFIyEpkJFT33qELY1Ab1MQ6+OUQZVgXfyoBk4qneVSy1wOu7EInW+VQXSH4A+AxTwiuBwXbDGAw4OI5t8caPhqLON2tjO7xxpYRhPvyjIOPKxBNogtqk8tiR3aW+x3Iv4RTWY1WA5SSj8WCugG94Tn5Kzrk/FF81JUiGikF+yuoo+N/f4j/yU8dp5ZM4DKFQoqj30x+ZLvD/xcqyrrp05H6BgT3pLtV41vN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVA5l86TypbtkFvLAyUDkEcgbIGG8u7xoxkEMv5MFK6zFxNdSrXJ1qiinYe5?=
 =?us-ascii?Q?WkTxMQo2zEkIYYRSgNjOTwzYUXujqTIDLwc/nkdL3Hk/hdCYuABTfludaXw4?=
 =?us-ascii?Q?7LmKayhBRkRw6zAgvx4qwxeMQRVH90GriDlELOsBu3v13uQ1Gy0Zl6rqKFwk?=
 =?us-ascii?Q?gXNFYRI207TPMQYUyVCCd1gPaeLAjP7Bt3q9lZ83UsBSc4xdipZczsjG/czX?=
 =?us-ascii?Q?9T68cDxE3hEfxvfbktCrzzwc7p2twW2N6OwQ8Ax7sSTIrUNK9rNKKNUGBq8Q?=
 =?us-ascii?Q?9rroH87yjLWG621OccKks4kGcyAbtCyGQYzRAGAdjoYxq/O/WDWo+zzGeq5E?=
 =?us-ascii?Q?g4ski4icjnTVywVmaqVUpUd/941bFLn3e2F7819CJ1UADU/hsSPa5evMdo6R?=
 =?us-ascii?Q?0DKmMDTh6Tn0uzNIpezj+okHZ0KHgVy4qplJuDJ07R7nkzkV0MKiUU4kAWNc?=
 =?us-ascii?Q?qgl6MaSNMWgG9JkHZP24o0avxPqLswc7OoTfnls8PCalUhNRi/YjDk9k/JLo?=
 =?us-ascii?Q?ScxTwaEF5QTsfcLVtanHo35KuZrjk4j6FqMg852ULdntTn2SBKpyNDY/kirI?=
 =?us-ascii?Q?dZN6Z75q+KdgJyDlqlYTd79FMpKPNFDUx2wqHVE42+nJ/DA2AvHM+VneUL/K?=
 =?us-ascii?Q?48LxyLf8YvMOVWuk7O2qOuezKGouaJKcYxF3wQDGBKKfFZf82VzAYJTiSo0s?=
 =?us-ascii?Q?Uc7Jx0jfHgqeakpeZsBpjxqhXrdlEdw2Hzgmt89pNKfiPt9SGFLsevb2SyNQ?=
 =?us-ascii?Q?m3lcy522KzQCMjU1OEAii75WZ2mCO9OlrfObijcaPMDk13LmBXAxdcK5uDqJ?=
 =?us-ascii?Q?BJ/vgInQQPOEIo5FOHRHg6AQL6w+kpbgH3qG1KKHbU6dEi9m8/rX3klWwSrR?=
 =?us-ascii?Q?0KmrOriuD1ywtjcta3S8FbQ21r5s0+eRWDbNv09PT5AkXKetUCZ9dXtkB/gy?=
 =?us-ascii?Q?qh3JUyR41orLV1l9K8EtdxI3L3ziykGXYHNb235u2oB41KqMXB5pHSJ+lYJN?=
 =?us-ascii?Q?qp5dmz3kXq6GOyMJ5hbRSpAB+K2XjNMThoSbRxJqdv4kcnFgFWal5a637/DR?=
 =?us-ascii?Q?eXi8+4/MXzv1+JX1H6TtAVsPrfQjBM7UiEYz++7VNbrtlVVgXKg+poss+8Zl?=
 =?us-ascii?Q?TNjYexWNv6a7zV6mKxlwG4Kv7dOQNjy31iBevaMzvO6jdL6la0wwULxSV2H5?=
 =?us-ascii?Q?WmqQAugsmQfnDLT2LQMSq9kgdKs1VhfaSyx+MoPnV+l7WLaAn1VA8BNUG2Vk?=
 =?us-ascii?Q?Wvl9g4kq6RG84OpneECp2A+TQ1yADWGM8fHB4h7YkflOH5d+rQ2bL2l4Z2P2?=
 =?us-ascii?Q?/4YHHA3nHPGzKRyfqJTCJqzrWrQluDQZIbgo0lSWLrcm7FEDndAGt4ByTrcd?=
 =?us-ascii?Q?bA/55f7Av3POmyNQU+cyn6eAfw0PxkuRRGxdqbAeqrQOTIrGItf8DE+H4nmF?=
 =?us-ascii?Q?YLJQDcwDn258pKxV+SQBXkjAb7acu8l6FS/V6Jq5VrmNVV56FkQMTCeRm34w?=
 =?us-ascii?Q?eHdYdwsNYIkC8s6VmPjaGC8mN2JIwtJkB6IoqwcwmWmc6qKdvv7Ms4k4O31t?=
 =?us-ascii?Q?54iIDenZoZIDqmWUk3F/+uOTlASWGcQaDkVLnq85?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01395d68-e7f6-40f0-a0c7-08dbbda35c10
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:32.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MoNSONGp2lfDA1HSSp7iCW8CKrtDvs+S6Hhf/EMl8bPO6hQOA28RAVq/rX/YZTaM32fAul4BEfSqpiEulIFBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds a new helper chk_subflows_total(), in it use the newly
added counter mptcpi_subflows_total to get the "correct" amount of
subflows, including the initial one. To be compatible with old 'ss'
version without this counter, get the total subflows using this 'ss'
command:

        ss -ti | grep -c tcp-ulp-mptcp.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 92285ef592fb..3e24ab7bc221 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1862,7 +1862,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1883,6 +1883,37 @@ chk_mptcp_info()
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
@@ -3407,10 +3438,12 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3427,9 +3460,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

