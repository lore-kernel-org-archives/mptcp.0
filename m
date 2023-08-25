Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0C7E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT4SLPuD4bwG52EJIRL+q39jTicd4hv32/9f4YtsI6vXQ7SByq5+Xzqi4HyxehDLHlfGFhspWXll0/Vjk9ZBfJdEpGUrXmHvZTwUguwz4Pnsb3CZRTO1AUD2a0EnvT6+8ekl/zAq/tkKMGAmKGYxD3xpB5d2KdCAzM3J68+/O0moO7gcQgmgiXvdG44vGmpU0u08X9TT7EoAT1koAflcrQgpBl3WooWzAja9kv8ZZ9fT1YcBZFULFp86ApkLUhFGgt6d1e3nw/IquYyUvwNf/fVGaQOLDXE/9FVhovUKJkYkdfDQ5/zfDMJA7PEKEOw9pbuI1bqvZ3UiHyraoY1CbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ZCAg5vTQSBoP5M1xFuOpAFWKzfgsVrnWK+Uj4QDCw=;
 b=RmI7QnO3xYl/31tPs/T94McsK2LgKsPHGisS4IoziBpGKHG0SeYGTqjFHbkuD8Glxlk38LsHVdfvzZVXqFKl2z7+gYFlem8xOQPvfEiNkbpy8HlIcpVR/zBVfpkbqW4GADKckyzssefU5XSQxSHjAOQjwIc6GqNR7rGQTDPvevIzBBzDhCw00jTLxBj10kkAdmbyLZIfpe4wMnWT1t4KkJmLrkjpd6K1tD4E8uQojRjyTzDD8qchNutEmRCXNF1OnCdxhGTpp3CZF3unDrzN2iwRN8h0EdP+MYw0ppUn28POe6NRFjPIA57lV+zGl7bVfN+VkjV62PgN9n41NTER8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ZCAg5vTQSBoP5M1xFuOpAFWKzfgsVrnWK+Uj4QDCw=;
 b=Szuf6cIBQNHsVxYRHv5NtSNvoNwpRgwvYKhyBQL8FP7An8Fne24Zhrei4vH6iG0hH3lpLiJTKbCSWNJ2802aeBfajLRtrB14QVbKcyz+4NBolT8bHxf5eGX/RrtZmKVEdHMSfuzkUWxXHmhNqU1xeGeYpY9Hj34ChgxauUJOc+ja/2zCz/Y2TvRXHgJXNMGw48fCEGCMaIZBbAC/GrJn5MXpgCJz2mBmg3Ifwyc+c2F3eGY+25pITBcVccroRN1ZTiYxyZNkTJk679OgJJjCgiaXekXhOX7KbRXmMffjO7RRiuLWxeRKO/gWFXxgagasNGXzRrgQpqzPEkjCSDCeqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:51:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:51:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 08/10] selftests: mptcp: userspace pm remove id 0 address
Date: Fri, 25 Aug 2023 11:50:26 +0800
Message-Id: <2eaa4771101756d93cb808b920afcc4229d46946.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0215.jpnprd01.prod.outlook.com
 (2603:1096:404:29::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: b32ae69c-1414-4db2-c652-08dba51e96dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1IzkCmVJoqMEhSmo5A8wZH8/O+m8Otv6SjDe/BzNXdvX9kgi9u6xHwspXaT7TdShnW1FYrTRO0amqsqzbEOthhrZtW2yR9PxUKeq//NImMnGN67hOq6RuBCw5jYIgupu8s3U8I3Du0WwLAj3HtxFXNwci4urLL02oLDm706J6F9duO1tXFwRea1v7/fsmyZ1KJs1MvZmTOqFEl4fJThSo2dyA08aeO8uTCi2lH/+oTcGdAnj9vWc/+PGpn/cXPfFCxA3lW/YUhIyG7mJR0KJxdCUxVhGYPDIShuGjhOL87UuWd5Yf+7B+4p8FboShQcPLMuvkLq5Hqr3kV4knWJDQ55ZzeLSPJXW8+r3zZ4y1eDMvPhBUZf5XgIex2xannEPKrcPvhsG2neqsuRh8KeE4NtbRcy3tPd+CsfWqRQYQ8S6ZuXrlvdnMyY8J9vpls6ZAU3Q9rtfspQ0n1rZP+2Q5rJSJiWbmBlLyPBWoDRKsDgQ2TkOhYqPvgUFNQVM0WHhG3qSt2SDwDtTmnPPAnhPs5JbbGPcmJo7GNQQE/ZJWKv0UPlVQxySNQys8CNZr+Up7agZV17LJII4ycLpy6vyyUjVA6yFoVBpTSu4veTh378=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/4w8hZ11nbi/rEFbkbT5wMqKSMoWPaU07/p+Xqa9rDqgxOrJvi9cPyTW06ae?=
 =?us-ascii?Q?Ay3FV4ha6f+ZXXOVA+wXe2t6aeCUp9vJIAhIdqYNx2SP5WJ+d6KtYht7+ZJl?=
 =?us-ascii?Q?9BK/vUNeCugr60XAPKPyDw+fnwVWDWsl/72V94Nl9eaIt7wnygvMw/vqpRx4?=
 =?us-ascii?Q?eWHErxnzmXfH/aJLr+dYWw58Q6TLOx4gVXbhJktldbJvuOpB4TJB+z52/zIp?=
 =?us-ascii?Q?c1ZuvaWJlRlyW1jl78nZZ8Kzl0ZNY+RMWToueQw8o6PCy4/nhZcqn+MPDmaY?=
 =?us-ascii?Q?oI0SjDitZ+PWeV58Er/tac5x7ENREn90X/MyUBp3XxwcHbKZakF0C9bIC9Cl?=
 =?us-ascii?Q?8fdER4f7cjQU3LAL/XZPFgv78LvwmAOCCxHJxiHvCxO1WkI/zTPXV0LjUJdh?=
 =?us-ascii?Q?dY4nf2Qsz6vu2+GKiCeyV7HIUHyQzyAji9N5i8KlerUkojup8kcwhkjDcCyl?=
 =?us-ascii?Q?iJ0IeoYmVijmHNn7NYbCPnE/CBhrEbY/9Y6CTLGmApOPjmALuUoG7L3QNR2t?=
 =?us-ascii?Q?n8K4Y8gd9R0opIIb7i4N7kyfFAlyR356ANnB1tDFsK3R33ey/UQfRe4GG0t1?=
 =?us-ascii?Q?sgdzkuW+soAiH9mUIGXmP7VjmxLxBRAynHaFTJ8D++L1ouTKAxQfrPjqDxKp?=
 =?us-ascii?Q?w/shn400g5qSOjLgn92B/zksioIp17A4bhwzbzU+BWUE/WxRLOdz99FMe8eY?=
 =?us-ascii?Q?/9gSQT1X2vXe0B9n7UDPeBo7EK3sH039vJJzc1MBKfiTDgrK0ve2If/QWSzt?=
 =?us-ascii?Q?B6bGmr0ikysu2O/f6DuI19eMpNRSDJb94lt6cEz2EFf34GYrDnlm73jwFvlx?=
 =?us-ascii?Q?G7npkX8pXX5DIysbB/69oeq740byUsbizE5EdOzb0Gte/yABOYpthK/ckLcj?=
 =?us-ascii?Q?M7DZptPT2nRNBY5nWKUWjWEcXqqGOd/BcXQfluRGmy5zUq38i+HIlqgiFC7k?=
 =?us-ascii?Q?7gjakxRnfu1ZAh+7ix4MGPtN3hDQRNwMF/IqH+dhl/sovIUUsz+FLIPNLZvW?=
 =?us-ascii?Q?3vS5rBpJy+dXPS8tMPbFvyjJJ5KgjnjmXDtWc2jaMJa6ZA8HOyxVvob5tFMo?=
 =?us-ascii?Q?zU6tAgT7dqlrEwqI4NBGFaXbr/GVB9R1nD8H/mkCcyMYVLJH0dndzopKZ6en?=
 =?us-ascii?Q?4JsqUL5SK2F5/xzA3JSYTcBM3W81JK01mIN00piEUIO0a+Q1ELxc4GfaKg2Z?=
 =?us-ascii?Q?v5tdUmz5HlgmFcHBijPwIadvILE7qhczlApjEkYX4LY5scR/bhyAs9p04xc1?=
 =?us-ascii?Q?0535sc7itfmbhn5QKhp8PuYMUY4urq+UTKtQYihji1yKgZq5GBePHBYxoony?=
 =?us-ascii?Q?SE6Nr/4LS7PVcpIKWnxYG5ZPIcDrFvxiThRi1jNmjVhXRI4pHmgDn0XkSpT2?=
 =?us-ascii?Q?MBZsQCpvwQ3ldwaNgk7TPDRYs2ywd7RdTB4B/6nyK9CLaIa8w9ucJ4Xt9s3t?=
 =?us-ascii?Q?72jWYr7yTXsI4VZubD0EMigQUkB1iXE88CWzma6gv+GLr7DYBmFqdCEPF5F+?=
 =?us-ascii?Q?UZFOxzSzsu2xYCmJFs1sr5OQrzqRtekHpsuylrU0wBMuR+OWXz3wg03DhxgO?=
 =?us-ascii?Q?F+YgLoZOAE4ZwPKI0JXx+DdilS/gRbRZllbAtqQthlBuFvVvM8UADJAisUjf?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32ae69c-1414-4db2-c652-08dba51e96dc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:51:40.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IprXmOlMSzZ8zs1F4IxoHds4LNxGgxV5EaqG2uZRrvNNQrnVFJAeneoTa1i6uouIx/WUwHIJn9yME6aBnPcNVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9862a27da487..83a625c36044 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3507,6 +3507,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

