Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC01D53E
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CpuLrLm4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRoiNr6M5fFiAN3zwTJW3wykyH2pFta/Bf3wZ2mPvsuL7YK36+xOmCTan4Shh14kTkfvScZs5LOocqoDKCvG9OytR0yvosgOTIlze1oalsSy1rgnMJ01ihL0nIZSg6c3vcXd1UjnI+MoizN0qn3tqFmv17CFWrsp25upB5Txmn7UmBP2ogaKwC/6hNUbQvvMXxm86YWYYCoqU6Va5gaHJwcA5J9Sv7fSSyn+u0fiLHjh9dTokvVD+3kW4jkkvMBd9l7sRBUAuAg4hoJUapCtVXeKXMFHzy2cTIEGP/FTM21yOzzCk6aUV8x1uQO4sOf7f2T2l1ldbu9HHEoMpnBf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WsKAPn5tfQTHaXstcyjLXin2TuVuaLR0ZDswpYnZ5s=;
 b=bXzJpwKgTj5MniBq0Tr3oGD5bBssHfZX2gWkdtBF+7UdhKjXCe0mvca5rAzDu4jmj1wmLYuzKOovMcdUMTmNcs/ue1qb1Sg0femMkz4t79eDed9SOEpQVKUF/KNieAG2LkLGvkxS5dBmVrA52VfO6J/jZdTmcNFOlR1/NDfiKT1i6Wf9v//i/4i3pVhnS3R/zWGBtLRhKeWbU8R6ZcJzAK9Iu90wHDd7KgMMq1SchV0RlilLZm4pKV1SAQYoK9d+0lyLVXPEaMzVkG6Wxl/pvNqblBSB4iL5MIzntN/Gs6tM0HNL82PNFTzTBSD5ZBdlMcJFKNbitiBLqxIUBP98Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WsKAPn5tfQTHaXstcyjLXin2TuVuaLR0ZDswpYnZ5s=;
 b=CpuLrLm4U+gpKprPeKCX12loOdJSf0p/LTQv7ow8KpUE8xPiXy7NBS6lehwij4tp5WXmunj+ElDDT82FtKgWZQEhat/9uMBb+xWhj2d7nqwkkTHp4Lk67YrxoVjqd6mbBrIo9hun2LtqjPbUYxCewrhR6xETDm4U64Tyyh5iFJVbaesK6dUS4tsEvl5ZXTPMCI5IqUv52s3UIZt5S3lFw4zWL5nPv87VXRQMgtG+efnmHnLrnjSRGApii5uzK/Zp6jrBaMDt4OWrOG/1Q/KyPh8hFG1nUsiaZDQTMHky5eYMsHjDJ0v5Pr0536RUdZYGWzkc6IKuhFj2hI+6/FAkJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7923.eurprd04.prod.outlook.com (2603:10a6:20b:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:52:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:52:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 7/7] selftests: mptcp: userspace pm send RM_ADDR for ID 0
Date: Thu, 12 Oct 2023 16:52:05 +0800
Message-Id: <befa0cf195bb4ec5f638ec8da893173fd0e805fd.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 965ce97c-c38d-4055-2a59-08dbcb008483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1dH0xjD2B1XdIX7F4Cdn9CMmfPYGEXmHYVIEuLBs1pR6U12vG1QmTYbQrejye4WvRLQkVu49ehl05pEL6F+I54WhBx5SvNVPdQgIsU4AGsMiefoOCsYBKQfimkMWbJHXoCFpPpc9C48z3dKM4qsIV8atQyxtmU5QNy0q9NAfoCSq9YsLDTuADfmDnXp5z4sM/eCmGnEX62DnTUmgMtOjuF8iPesYu+/TLzo2xIAEhiqg7vr6f/7kpfgrjr9k4meM8FtGgJ9gz5gBdCutbwrcfZD4EsX4A2rC6O9QfntftKj4qDvD/eMBhAeJsRVeeaGL1htHYbaUvypVd4PtozocFnCFWEKDoTBNdu5HCkdt9/o2d5bF7GXcmznbM67MqyNVNUpB77GTiaBVwT8b58OY4QJdWB+6h74nQgRFWVnZHo6x8NTnwV7u5qsIShCTwuqZhnnilOwPz6HMdhLbwqL6+TU2FmRFSMAKN88PuCbZTNPSKCJLz6GDoAsg5Uo92MGQC+Ej+swSTDb0PKfmLqx68PMJZSoA2k5G2wY0VtzG3OHYCtJa+J5dCjywedv+VX7e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(107886003)(2616005)(478600001)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+LS7Qwp7oIslLE84g+PDdM8XrtK3Buiu6un03kkrBUtvvxm2qGjzcR2LbEG?=
 =?us-ascii?Q?OxP3FUAP6WoQKbolb5bglTj7Cd1VIh43R4I62kGncTsVZowQBun7cQmxeTem?=
 =?us-ascii?Q?B/uuu91Ysm4M9yzxlani0KBobDzSpIqcvb1mz5obyxakXtHgly52WA5gALl0?=
 =?us-ascii?Q?FHRFeJzkW/6e+Ztv+pwM5SgXqsgJHTyBxjpJpKBO7HUy3nzdm7W/AfjiHL5N?=
 =?us-ascii?Q?GBFXExAxGCZjFWuN/wwH0E1z6Y5GBWoMhNfoQ+UaSAmnTqieLEynIwtEDNUr?=
 =?us-ascii?Q?xPpYNeQ5Xw7XXCUSK1pgL5zxKDiMtsi0fqW5ukLvAXJ2O0jYVb+n2ZzokVTK?=
 =?us-ascii?Q?Gw9dw693Fce+RztSbU3X203zvDeRu/njJJlGECNPoX3n3BHZZneEVhY/OwtW?=
 =?us-ascii?Q?w4pNcE/hk69Qx7uhU4qOMKjFQQ9Zf1QnX0ViUTs8yEhaPkMmp/YtalrMgCRa?=
 =?us-ascii?Q?FKUny0HBzWfd98+3JM1P5vgNna+q2TtiASncr2CQ6nrQqUID4Q6AsyZagsjk?=
 =?us-ascii?Q?xJg0PDYaSueS5Oq7edFuGN4ZbunBZ/c15NmyJxRWMWq2SiugsMAuGcPmJbbf?=
 =?us-ascii?Q?j3iLgn3HBxAUdTg2ym4A3edcSUmQy5hvMHRtgWqmwjEjUDQDOGTyCfffey1R?=
 =?us-ascii?Q?Q5MV2swVtJhGQAnypT0Kho+zqwgY1H42t2K+kyykIQ/DoIHIrB+o1lMwoeB6?=
 =?us-ascii?Q?tzBnMVCUA48n3OhJwjFV/iiJ6dD0VKjMhdgbCcL7uzkTlEDgaqz+QjQpezJT?=
 =?us-ascii?Q?gCGpqIaBBQ3X+qfcpX1GNiGwtnF+aexBVJYGavDAPR1KV1a9IGVLgPWth5mC?=
 =?us-ascii?Q?ZNrOrW9xj1SZP8aZL+VlItG8GMrafdKPNXeOIPSzFmKrfoaEexRsW/Acss8M?=
 =?us-ascii?Q?pqHALYqUtFDejmgKj7d+qig0Zem0hkt28lmQevwTsGBEBCN/WUf4nYF0eHNR?=
 =?us-ascii?Q?+vO7ChQjAMKtSR0Yb3SNvIdJBZ+bCR+p1bMdrerP+j1Zmg9wbK4PuBuEQc94?=
 =?us-ascii?Q?DQCduvKAl2MmDxxrw+nGqHCm2mBB++gZySedAhxNrKZdGlbkpte8DpPRUI2h?=
 =?us-ascii?Q?khdtXUiDVjOEsjFa31lz8Tszr08v/QyJqRqDjsKclRCTCabYWKa9r4+Zy1Le?=
 =?us-ascii?Q?Oc9DSQxCg9r3uSh/9e0Cx9WGorgRG4ndWFHqgcI+tAZm3W2EaUAkFdDayo9x?=
 =?us-ascii?Q?0f/ttxY9RaSEUcFwnpejpYU6G50fQDP6OzgESepTvIX9Dg9KjrsHTuNZIASk?=
 =?us-ascii?Q?xCUMLED6QzOn8WB5py9zorcedNrLcurOGdCfHfJZuCEsNL7of6MV3zaI7Cgh?=
 =?us-ascii?Q?0CgWFYOHZ8ffDy4Czto/i8tbsYogce+ByxwTahp4QxG/TkwRAll2pEp4INTz?=
 =?us-ascii?Q?qXLuspTlK8GPYrb9YF6VeuKAk6DR1wG+JX1BOCRalSvm/vrCcEr8tuTNfnaN?=
 =?us-ascii?Q?6DUOHZeLeHzfC4vZOQGktAUHfowQpWWeZtttm89S4PMGT+3WqmO9jFUhOX4q?=
 =?us-ascii?Q?RBVDb6iMlu8NxFQI+/ZqiRh03zTYVbhA6xsDDCa+EQiKO3X6O8MiEYdrdK9X?=
 =?us-ascii?Q?SWdHvM1w5ivl2jWXrG/s4A6rWnzNfy7o0RHMHjDGdCIaxo5pBhDToW7hCchX?=
 =?us-ascii?Q?9gklEjckO3gfMd0JQQD4MyMw5WR3gYEmjNPSWZ/R1KAL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965ce97c-c38d-4055-2a59-08dbcb008483
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:52:08.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zX/EGF/QeTXwn/YzhN03LGRof4TLB5XBAw2G1fgFMftwtBN2GxNi8e6LZCtFBzI6vRh2/m8EvU2H0K8MZ6NMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7923

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 154978481409..0ef6499e7539 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3533,6 +3533,35 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm send RM_ADDR for ID 0
+	if reset_with_events "userspace pm send RM_ADDR for ID 0" &&
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
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		wait_rm_addr $ns2 1
+		# we don't look at the counter linked to the subflows that
+		# have been removed but to the one linked to the RM_ADDR
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		# No subflow removed in ns1, one
+		# subflow has been removed in ns2
+		chk_subflows_total 2 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

