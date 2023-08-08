Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C4639
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 05:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxQ4YiojBl36sAvgRqk8rPNmUgnBdvwOZzp9tqnlm1/k8qA3GhTRlggmS0hbJf6gZS13orAJKjcWgH0l44LF7vnOzUSzipLwHVSCdWNRibrtCD7tpauJBrjo47ki+JNINr2qDyg/7EQ1ERd9rWeQDFZQpwmN6fDkrOvmDc5M46KnuhfXVaDPDZEF3fZBrBQvfPaRwiK4Zbf7kUgZPtR0PWQDN+5FjqcpGopLzOkxiGGt8jLO+4lqLd1E9nS9D9N6aOu+BlADLN6MppjmuVIK0sMPDbpRp3lRSzndCLzqOiN/tomwxRZ/lpBHVoaB2AFkBYQ0IHKjTNdqbF3JMrFKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdMAnVq1Ul7ZBmuQ2AsqYk2P2DWHPWcFIOLasDdMIQY=;
 b=HJzZcrW55jl8Z7MbFHN7a/RSkfwzNLjZN+t++BsCebjRGaQCsvmCpe188BfMiWCiJI6HixVGQBNq3JSTFk0woL9t9pDJ0pYI+AIFEgkmWUFDbHCDcBumhqPZbViWU3RarpLa/L/uIUQUYhrZd3JxcBFKwNFhskgsasEG8gO2frCraLeYeq5jCax9mK6OGrSa2/Hrjx+hpr2F1vtnI41kslRzDMBtrppjtDE6PYmMwKI6gYd70gVQFVYmTrft2iVzr7+ZYSh8nzTu1dCCaVVRz0oDsSWQ06V0s5j8f856AtghZ35NQDR6g6wafxHClYEt65xnpQ/oliKgJy+nk67SVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdMAnVq1Ul7ZBmuQ2AsqYk2P2DWHPWcFIOLasDdMIQY=;
 b=GQeLz2e/8M/fLMtlop5rDg7q4slYUdDco8Z+1nRvCPFjhU+onJps01msgRmGk3+wrb1QycZyxfgHjdL5ZB1uC2/rJN6pcFK1VGkHX4DgkDen2HX1enXoIjsa8bQJGro1AZKSUizsGFOpHMbcTiZi19APOniBGfEshlb4lQuCwBRPY/nXnfW63ErPExysrlN+1a+7YYRipsps11ynLrOFeJMegQTXAOiI7p6omZlaovu5CDIqjZpVQhQaYOzvt/s6uhXJ2frrod1GkhKEMzYaFboSZg28v0hyrHDzytMJs3I9kCqVBY/c9VZ82div6uv2ARHY0EqqCVMlZsdHxL80Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 05:38:42 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:38:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: remove id 0 subflow & address
Date: Tue,  8 Aug 2023 13:38:27 +0800
Message-Id: <da02f0f5c092e1d069fb0fcca92653e9fd4adea1.1691472939.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691472939.git.geliang.tang@suse.com>
References: <cover.1691472939.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba4f44e-d0af-4b77-314d-08db97d1b9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KET6uv25+NdM/27oOV5Fpwov8e6EBZN64eYm59Z7dm1P31mf4p/3n+H4xoPZC/6xm5sAITt/HuFvg3xvMp05OsWR9LVxzvoRn/EFRd/tG/fCcIGFs++fEO5Lbl0JNtggyRvweQYtOytIHveQj9tTddBaLlzpURWFrtAH5bmjJihJFLftfGOiQX8nV5TGDCAyVx8xGgReeVOP+59p3ct0YxCcmiqyeiw6Vqk7cpA9eNiZVEVFvRiR/NjBmTy5+IiEjzSQT9xVSCNdnQVNg+dCXFuV62KdeQvBU4/5VpNxUn762siZ2iVVRdkliZHuJOnMrqVgPKxDYI9Jk918aUO+/FsEYmzGJxaGqb/jldHksN+JLNOALmE9MRICBWiR1aAgQG6ROl3k1j8nBYyWreMh+T5NYSYswgDyto248yDQhYSrVUw+5sbKgluSCXAWT+mPylQBP90jO6jUGNK6c8s07XZzCgSL6RiRdoOMMn9SO+9YdpAFDEpftT+EGvLlAnb68AzgpCHGY0YbeHFH3tbBunP/avHO8x8u/aTqkdKo58KQDtiV1MfRkR4AR6EaHjkvas+nimcoF7qQ+SMiZRUB65gaY6lRJq2V+u0/2XoyS4Wqx+tb/GWNdJjsbg+mKy2FPWde3wy2nUygyc7ppERD7QgsAwyfXRJ7GcKktRTdHC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(90011799007)(451199021)(90021799007)(1800799003)(186006)(2616005)(6486002)(86362001)(478600001)(6512007)(26005)(36756003)(6506007)(107886003)(41300700001)(5660300002)(8936002)(316002)(8676002)(44832011)(2906002)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4eSr41j2gn2a6ivz2a6S0CpFMZtL7Tt77yAFQu/XjideSeWl6Vb5ptamaA8X?=
 =?us-ascii?Q?J3qXsAhbGlCaHUAo55lD+GBe6nsUKEfiR+rSe8qSQmr0J0usXXePXMmKOQKZ?=
 =?us-ascii?Q?jGc13lR62xhocDQ19QVJLPbwEhwNHhAB3Ph4D0V8xOOd8lc3ZIqgVaO5Sms9?=
 =?us-ascii?Q?8jVjS1D3zboxoUo3HJj9v3OT5BC0m5/ofxVOrdTsRMROUpVsPZboTEJNNL+t?=
 =?us-ascii?Q?jE//3zNqhRbENu3+rBZombIp0fSwwDjJY1sZJs+6F68qhAvCrpkM996geHd3?=
 =?us-ascii?Q?++ACTq/9xDjNBg3uF+9i4WWX1/if0wByp0bujkkhnbfGWaexORWYrh2r37Gq?=
 =?us-ascii?Q?JJLzmn4WJDoB1VDQniFPD98vuOZ6NkbCiPG3ks/EjN1oK7Fii4bLD/FwHuCF?=
 =?us-ascii?Q?kU1ZzEyiAkqms+BAG1/HWrjh4RrPmJUPd0UiChXld967RgWUAGNI2XhHsUxz?=
 =?us-ascii?Q?jklqQh9qNBxA8lwToWZEZOx7aTuax9iKiLl7KXYnWDe0cYWvCWvBZkdZ14rC?=
 =?us-ascii?Q?kyBrqlJjHZ2dSl/dLiJp5Sel0sOVm+1fv2ujAxEv6XvddsIa6h3BMYdpL+VR?=
 =?us-ascii?Q?7n3G7HRc2zStMtTb7i6bj5QbNiQpUHKxwGgK7MnCcTcsUUIDXsosEbf6Ve99?=
 =?us-ascii?Q?jX7/P+Rj6qgQvQrpBFEyOZiXfNctyAPM1bsXKS7fhHWLx5PVnZ10cBpEKdM0?=
 =?us-ascii?Q?DlNhU1CyL+miBwov7ncYuG9aCPvAgxdM4mSSEg4glgxU7cx8CH+4tdpVGSEy?=
 =?us-ascii?Q?py2ku1k+wmuMud+jiwALsxks+cOLIxJYfscEkNV5pSWtENzcUSZzPqx+kWB6?=
 =?us-ascii?Q?cRbdBRe2uti9YwXzHzNtmi1A7j7Z6WcG7iATxYQ0JroE9GIT80zNCE0AfUGy?=
 =?us-ascii?Q?PMgQynKyUQ+QzammkwgnoRx8Pq4/B/X5lq+nmRK4EiTmNs4AY2B/8SkL4b1r?=
 =?us-ascii?Q?BXj3uOygN6Eb3m+tbGZOOPuK6BWnNdKe3NZMB0eaalIqZaOO5io4NWg6wPdo?=
 =?us-ascii?Q?vwszWnzfMVvORYJf1Rl+ORgGK5WqvWFVXgFlnr6LRQfQR7SE6wUfP4HbAt/i?=
 =?us-ascii?Q?kEGjI20V34PZokUBOxvegnB64RCWlpE6rFj3dt5ShGzubKborMqE19re5Kgt?=
 =?us-ascii?Q?BFqK2ZmYaIBbFNt/aBbfUAI/b+XFxAemRCqbjIPzsH25WH8RmQU0FC3Rf7am?=
 =?us-ascii?Q?JctOOR5o3OXxeIzQPuMyi2V9BAw5rbkiBkKPsfcje866iPuRETfhlI7UaPFT?=
 =?us-ascii?Q?63mvr01I851r0rf0aUUAP93FqhzXLS45+WgfnnMRM8DjCyU+RqVI3fL/oh3n?=
 =?us-ascii?Q?IjV366B2dTZ4PNGC4r2aG6EdmGTo1bHaFWWDvLH+77FiV9QKHg9lhMJFk7IP?=
 =?us-ascii?Q?yOzxtUv25PdVGMVJbyCbmOekJ+p8EkgQgkpIDUmxPVBseUBo80DxUyXJy9vX?=
 =?us-ascii?Q?WpTT/q3AdXqdGkeeaO1JGsTxe3NrPcNAe5tDJFsI/vsqJ/Hha6p5dZeGuLB7?=
 =?us-ascii?Q?7XRLPtxJFtxul1UXVF8ivpHhtTerxcHTowBg90h2UYF9zjF5IoUAgaBnQApo?=
 =?us-ascii?Q?4RYL6UNtF9jqgi/LVdP8tvlga4XgL6QUOuHDuSu3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba4f44e-d0af-4b77-314d-08db97d1b9a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 05:38:42.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vstm4eJHhISNtfEyjH1fsFi0J41sOjEz5ipmZcfxZllMa6aqU/NGinULZ+12a7BM9b7RUe+/yxkQeLVrIgXZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

This patch adds a selftest for userpsace PM to remove id 0 subflow and
id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..9bcfacaa4124 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3434,6 +3434,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow & address
+	if reset_with_events "userspace pm remove id 0 subflow & address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		local tk
+
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.1.2 0
+		userspace_pm_add_sf 10.0.3.2 20
+		chk_join_nr 2 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+		ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
+		ip netns exec $ns2 ./pm_nl_ctl dsf token $tk id 0
+		chk_rm_nr 2 2
+		chk_mptcp_info subflows 1 subflows 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

