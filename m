Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE17E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arraz1ieY2w+kiSnmj/tb5GK0HLjH8HloooXeFip14oKESapG/izNO0ZU6PQAn0WYeqRWSwR3p2DMXcCiN5BU4K4HOmu0C7XEnJ4ITbvY5Vuz0zM19zJmtP2DKZ1GORWxby7kfrf26V7x3pzmC4NVchdrcwXesAGulv6gUE43/NxwTByWWapjOMpgR76QEtew4XQNHOVzjHzR1IfJXy5LXm0dMBrcQzjXf+p7SN7q5eCIsMhHnDwd7S6j0G1PRFgIwQVPkEJrnsp6CUh2F/crZvDbWks1dXyx+9e3HPkwFB6oWu2mLW+9WyUdF7N9wgrEmBxm6pCs4SRAG0dd1rEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4Pp3zD792H2na+yfpJrWTHXil1mDD0gJgcXU4c/ZlA=;
 b=BCts+pqUI8uFQKc9u9OVlxkPF5Loe3Be9kWbkSyAPuLEP6NQTuSINMHBXTjd1OYOHyXB6wZg7hppIOK3SfKCCg6c7MHupv0qyIf3Qv4lbnG1fGTUzDHa39dXHnrXZ30+ZM7LFnQJ7N6LGDrjybTfu/0KQNA6FLTUhtSn7HPgkYmSp2XKC2eJigvxR87g8Kv49s2P/9fBOp+yPblKcQfUr28ZtDWg8usj/yqY7vp2iVpcKvWaoWiRuKXTdea5Io97lgn14I0qkEKRs73aFduiVMxld47P8EiRTaFULblYTpI2RLBBhXXxTjokD/4rG7WC1WJU+NSdd7o7ffi1cVvxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4Pp3zD792H2na+yfpJrWTHXil1mDD0gJgcXU4c/ZlA=;
 b=vJDP2Cryv30uGXElFQrFz/ljw3fpoIoONxzBP44QTdWuf3Y4ukVLjjEynozLM7Q2LoIDtCdlhV9qosjbbFDB68Lc9KS5gnTGp5NvFL+RKPa0LlFTWuO9iBidfC01MiEysb/q5Lk6xMDMAVsNB5CWH0Vg0IIie9nDT8C+dHlRUF3UO5AP71h3pfsuG0Ib9uJiOsnbTx9oQ85k6oqxd7gakc5s50g4bTO/hPdteBUJcVCz6+WeI6hscv+jGrXPmojvCd+4wjpc4HZIz6VOnm999A2/OCMkxlHfUTnFMByjyyMECM+dzVPjfPyTTW/6CyGu8uJn/vaL8APZ+dfaRZhqsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:52:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:52:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 10/10] selftests: mptcp: simplify deny_join_id0_tests
Date: Fri, 25 Aug 2023 11:50:28 +0800
Message-Id: <145bd5b3fbbcf5db6e2d7ba65d8394a5979bcb25.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:404:29::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f72e92-08c0-4a0c-e886-08dba51ea3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	unTwYoWPMnRsRmTi1LXcex/jpVaRvH7aycqP1Z2ikne48tnwR4dVbMG/P/xQ2M+iYiGumfXatcjDiRrtWZrUW9dS5sP+VHa5AKbkIAqIA8KsSrml4X1xtxpm8c9bgN0sCoeIyFn8prU7CUN8jTIk/y+1X7ZmPyIOE/Vh3IF15ellUI8DJJPToCjlGBzWuN0sDJyGr2RQYiCtaItSMwFQBbQJ0L9naYR1PwIEWmQxu7U5UXK/zu5DYh2vtpvIoLnVamjhWHx9M9k2UZ/E+Upm06dGqm6sWaiBWZQ5Jzbr5ExET9fQIEF3Wbn5+aYapm4lgtDGvB3o8DGg7UsraLdswLcRh/QEzbqr59raJemPPZI1T0cRoDGq0Tf5fZYZYHpU/DgQzACgAi3LH47b+/DDFvnOOv133IT/Y3rPtJN9E9Y7FUQ+bV2mcBUC892dRNPpop9u43+vnmJBAqk0PZK5CDA4eF7CVhETfeKTOo/jZ5muAhYfJs5phzDh5S7RKmE8ekMexYzrGX9rsu51txPwiTu7jgDsCtcrKqgiCPuxpz/CsWfQdxdTT3Qp+/QAbQbzi6QHzJCFNEJAAAlk0GT89hvkRUwMhWfdkqPlz/3fulM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vSr9GBFO59K5yAyiM54E8dySFyDUhgLKvCX1YGiF4nocy/9cazAqDpQfaRz?=
 =?us-ascii?Q?YKZ1CRMMrv+Y9GpPpMIpcmLAPuTzQJkQ0G/heVME5d5x6IMkIIjY38BBy38t?=
 =?us-ascii?Q?uwKMs7q2b6lO4cwJH+OGfeoDmF37pLN7fmI2+eDqgSLDkTMA07f/OgLHN+zD?=
 =?us-ascii?Q?FYeK8IBJFu/1LiJgdxlrWUVg101BB+GY39fpg3xQzixEkiAMjB73lCLhG4O/?=
 =?us-ascii?Q?rSe+B139VUXTSJlSxtZT5BexYI6MvMwVJbPuG7T66XA9WFYKfagDCR2aOSkw?=
 =?us-ascii?Q?1I9GphJJUAXpcP3e0WvPBerso20AlSD6C/RCxdi5+arFxqNqg5DjR0I5SngV?=
 =?us-ascii?Q?pZi9uYHsA9rQoxMaRX3lu5SYDIiDvygf0rHtNG1ILXJJxwRn7wM305UPduwa?=
 =?us-ascii?Q?3SM728cIWxB+bKE03Tluvt0lPJaAufO60nwrZs7uiplAnW2KiKCTT9Q/j29K?=
 =?us-ascii?Q?4EuPGEwxUyLUMddL3/k8BzGPhO/p5WaEyYoaGhuW34uQYpbr/sNkdXcaYAO0?=
 =?us-ascii?Q?sAMu/dih9iTqZ8bECw9AClA7MbuQfNwpWiiI02tGqVj82AXxh4+fKEoAbtEE?=
 =?us-ascii?Q?XVMEzzO8uI160CxqnszAoqkH5hsVFDzMoe5otIeNfkeTsbjU46fpPLCLEN2S?=
 =?us-ascii?Q?8nYo33vKrRYdZyu9JDmmz7DvVviyc43lRrxciYdCHuO9Jy1lE7VBL4Sk+Liv?=
 =?us-ascii?Q?beAiNViXukpBfKi0yWKD2D8nNqQyEwEZctQhJYp4B8G77RKuTiT6EYeuzCEj?=
 =?us-ascii?Q?8erwe9hgydpFubm+R+QT67Zi989pHItuygBbmKrD9mxcu6kBGup0xpX7OAZ2?=
 =?us-ascii?Q?8CA5UEZQYwY4ONVUckW2cJihY1R8Lfwgy2rHndVb9ITxNTSww9tex0g3eAOE?=
 =?us-ascii?Q?Kgsrd6FHKSkQMKXgSCPpgu3XpiLMHbF3jE97QZv4wJKf5Eh/msNdulkv7HJq?=
 =?us-ascii?Q?hq6oB15crdFfqwk2zD2oM/3Y42FJ0HYB2q5WlPf7wZdfx5K0VOI52mD6s4c/?=
 =?us-ascii?Q?RSJQvJKENw0mB0LWzuRxfZloeqxILiIwCumVCVEGu0okBlPoxPXlL5b4/hQe?=
 =?us-ascii?Q?Hr6jnNpuqkoYTyBXKJEs99SzEEw7AFE4D4WoiLrBdza3ULKJMwmO3nq/LEPX?=
 =?us-ascii?Q?Rs+ZwZpaPPAqEx0spaiGEa/qxiW2tXRSFmF5mD2mhTsyPnlVOe6oD2GJjuXD?=
 =?us-ascii?Q?7yXI/4JtPJ7fswhsIT/lV2ruhPxzWBb5ykjAT86DKpQ3uGgF3/fjDmvzOd6k?=
 =?us-ascii?Q?ZPLRumYvTLSUjiCCWqSOU9IuCIpnVtT5D5cnS99S4i38sqdLMbEZNdGIE9Dq?=
 =?us-ascii?Q?w0sbKiS/APZbUePXZlfFGDMjVW1VamSuaDFmSCE1Y7FEvBs1ls5fNpVOfAIZ?=
 =?us-ascii?Q?1jEjp7gPJo489wT/F2XhOYceVTetgK9S3MBymmFP/HMjuQ0pd7mE6c+YCmmt?=
 =?us-ascii?Q?gMTjZN5KysfoK0D5spduu1s37FfCDwsezyIg94Nlcl/YoUihc9dD8vppOAK/?=
 =?us-ascii?Q?H0Yu2O5EvP5K9a8pAj311Ovy9fHUgUvOruJ9p12A+0+6hKBk3wSoM2T8u3cl?=
 =?us-ascii?Q?OxyUzb/hitgkrIgH8HAqoLi/tfzCibC+a5GFE1Uj0Yhf7sUGZdf0pHS8UdsG?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f72e92-08c0-4a0c-e886-08dba51ea3ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:52:02.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C88a9nfpDnM/1+mWtOKQprnsDwtuTbSf35XHScn2QCJMGVrcVWsy887dK6AtDVVQnau3wtvknJlHio8cXXJQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

The six join id0 tests can be divided into three groups in sequence,
with two tests in each one. Both tests in one group are similar, only
different namespaces used. So a for-loop can be used to simplify these
tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 104 ++++++++----------
 1 file changed, 46 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 59f613c6d387..084d7a8088fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -383,11 +383,17 @@ reset_with_checksum()
 
 reset_with_allow_join_id0()
 {
-	local ns1_enable=$2
-	local ns2_enable=$3
+	local ns1_enable=0
+	local ns2_enable=0
 
 	reset "${1}" || return 1
 
+	if [ "${2}" == "ns1" ]; then
+		ns1_enable=1
+	elif [ "${2}" == "ns2" ]; then
+		ns2_enable=1
+	fi
+
 	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
@@ -3054,65 +3060,47 @@ checksum_tests()
 
 deny_join_id0_tests()
 {
-	# subflow allow join id0 ns1
-	if reset_with_allow_join_id0 "single subflow allow join id0 ns1" 1 0; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-	fi
+	local ns
 
-	# subflow allow join id0 ns2
-	if reset_with_allow_join_id0 "single subflow allow join id0 ns2" 0 1; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# signal address allow join id0 ns1
-	# ADD_ADDRs are not affected by allow_join_id0 value.
-	if reset_with_allow_join_id0 "signal address allow join id0 ns1" 1 0; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-	fi
-
-	# signal address allow join id0 ns2
-	# ADD_ADDRs are not affected by allow_join_id0 value.
-	if reset_with_allow_join_id0 "signal address allow join id0 ns2" 0 1; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-	fi
+	for ns in "ns1" "ns2"; do
+		# subflow allow join id0 ns1/ns2
+		if reset_with_allow_join_id0 "single subflow allow join id0 $ns" "$ns"; then
+			pm_nl_set_limits $ns1 1 1
+			pm_nl_set_limits $ns2 1 1
+			pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+			run_tests $ns1 $ns2 10.0.1.1
+			if [ "$ns" == "ns1" ]; then
+				chk_join_nr 1 1 1
+			elif [ "$ns" == "ns2" ]; then
+				chk_join_nr 0 0 0
+			fi
+		fi
 
-	# subflow and address allow join id0 ns1
-	if reset_with_allow_join_id0 "subflow and address allow join id0 1" 1 0; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_set_limits $ns2 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 2 2 2
-	fi
+		# signal address allow join id0 ns1/ns2
+		# ADD_ADDRs are not affected by allow_join_id0 value.
+		if reset_with_allow_join_id0 "signal address allow join id0 $ns" "$ns"; then
+			pm_nl_set_limits $ns1 1 1
+			pm_nl_set_limits $ns2 1 1
+			pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+			run_tests $ns1 $ns2 10.0.1.1
+			chk_join_nr 1 1 1
+			chk_add_nr 1 1
+		fi
 
-	# subflow and address allow join id0 ns2
-	if reset_with_allow_join_id0 "subflow and address allow join id0 2" 0 1; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_set_limits $ns2 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-	fi
+		# subflow and address allow join id0 ns1/ns2
+		if reset_with_allow_join_id0 "subflow & address allow join id0 $ns" "$ns"; then
+			pm_nl_set_limits $ns1 2 2
+			pm_nl_set_limits $ns2 2 2
+			pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+			pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+			run_tests $ns1 $ns2 10.0.1.1
+			if [ "$ns" == "ns1" ]; then
+				chk_join_nr 2 2 2
+			elif [ "$ns" == "ns2" ]; then
+				chk_join_nr 1 1 1
+			fi
+		fi
+	done
 }
 
 fullmesh_tests()
-- 
2.35.3

