Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943A1105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+1KL2ueDAx4S8Prt9idBLxdy2zjkGGIiseax9aa/oxgpGr39NtmdF+Eg4itji36ppWvdc4UYAx7ftC6az84pxvs2Bq05RfTBD9vla/66j6cgvPUd/2LxXcVaBvR2/sfD9F5+kWCUpiq0K1FvKiCgNONlkRfiSsN0DDqMrVBgAihrlUjMMsj9YB+RhjFMduyaZeAhvWYiTe01RBIWgEiT59U5EihjvSz3iJiOWrc+bj8zKOLSvvE9fpOzDo9JpxHiF7WFlaxSNyr33VYnxDGw72IrVGQdzXf1o6MO+QDBhPqHoaHYCOgV+10HmqjpJdLyiO/urDjvWINFD//UmpLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99v+QSvORPwZbVigoNZcsUkc469ArmlwolxENm0pjqQ=;
 b=luW29qqVReLqETD+xHwRURIdHwCbGZdNvLnKYqiPCQgWrL0km0JfkWmqS3nYCZI23lBke9D4BEvozjYFxISnC5xdKX+hrjNiRjZ3l3skeNtIpRoLR7w110K9VDyoObZGHB7ig8jfP2ECgFHl0PVGS85QDTOkHTsbUHVdG+F0g5UBq48n47M4MDeJB6i2AqR2I6Y1Vq7V54jvFEDIycjdiuq8oxgBtf4DU0uJK9koLuiRB1QQbL66Gb4CV1EvIW7AsH8hwrkVVpaS5oqAALpzFWuN7OnyNBD+VGYz8mT5wrGfmq3VLouVSYET2C80t48gTo+l3mEnp47N0Q+95jBV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99v+QSvORPwZbVigoNZcsUkc469ArmlwolxENm0pjqQ=;
 b=yq+MGYvNV7Xl1GbA+HeaXEkWOPZd9KhgEMUs/4nIpLlxOlrBX0Juaji9uDxTOhw1GYH38WvJ4n0dyLaPWGaqors+3MOkLb/afjxKRMGb3fogOtiK01hzt0jU30hSvb2wso0m5ifmdmoVUH28kwUQ1Y0sL/CblAx9GlO3p2kgkf5Z2raJqB5cobVIlio6bziZ2QvUe+6EoQdlzEXh7RwF4mWoe1S18v6WYH53Zk7prtKA8V7bj3Foy98NqRN2c1eGDuI0reNDb0kSsFyncVuhmRgDhZVhrruTG3m+FjGPjPR11wChbzWkdbXqd+yRCayfsobyAC/ushHVmlcygpf8pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 08/12] selftests: mptcp: check subflows infos
Date: Sat,  6 May 2023 13:08:56 +0800
Message-Id: <faa5c3f738b4786d1c1c1c402d92af4c340d9a36.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b732e38-50c0-469b-5cb1-08db4df01f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QjGRw5mvDohn8p0leng3VGUx7CGRd6Xf7s4s3khG5cx2NlHM6N4O3bQkOLKPPjHFfpzZSmW+Fshvp6Ab21jRxvdLju1VrUy4KL17L0tyG52T8gxvHnQY+xo0cF5aDVOipza0Pwefa07D5yYsPMKdGhRe0WwuATVyM7TOjVguq0E5CixYwTSW6rm4jZ0x9RYRPvFwBPbnf0aFpdSNTCJh0WuCpBc9k1vfRGYQ0oYloRuG30EqmvAGZzOo7KbJ1GamvBz6grTOy2CPtUEuV5uHMfEKN9Ol3Crz+Ai2YMuaBeem16vW6EepkFd9GNCtstN/OkAkXLbzL+99NXmph5zJ6eqPJOv1v1DcUvZIG4XYdnwRQwuKxo98Vaqbs+wOo+siUVuXCvlvNWa+U7kZc8W7gkE8AEZ3MxLW3xe0wqwF2Gz0CQ1wLx+pU8YVZhHvR7cGO89/JVSKBbGpoShpYqMiMhja8/3afUzApfuHLfZ9YxwNrHmEs05x0zAcZUXlDpzHLD+k9V/412q8M7TbllTLE+wpem+3WoH6dwqme+z59puoPmIGJNhVgHwJ0K2ukrFL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ud5zlvIz4cKE5r8k12h3KdV/I23pjtpOFMD5v64WrUJP2X7KZG3p7cCHSd7E?=
 =?us-ascii?Q?ORMC8d50SVSbHzp8dh7pHVLTCCjSnMmvumzW8tsiFJzDfQCAZvA2IAqZmobI?=
 =?us-ascii?Q?BBxsjLJQZKUDyPvJXdZ/P6f2Mm8/0Xg8O+MaEKv9E296tYmWj5rQ4HAPXvOa?=
 =?us-ascii?Q?lKm8J3cQKZDiajNtHhJ2M3OSiNjXwHMFHGbN9zgcTlO0EWtjFk6yUXX0fpEX?=
 =?us-ascii?Q?5S9Uqmz5/kWWtt+XipaPcittaF0mSG2VMypO2Egs6qqresQfYGwsRhyvenVt?=
 =?us-ascii?Q?/8iOtwTH7zpTC/J2cIGe+l/CdF5tV3zdku4nI4vCUpKkc2EWozt1BCtbXdgw?=
 =?us-ascii?Q?BQ4GnPqNtuY4fuh3477WowHrdQaCFLjLjLmzGQtiYwvz0X389LeujUyZzJHf?=
 =?us-ascii?Q?zeTm2d34lx26UGON/z6tmPttYTb5MtV+ahQB/OPjD/rOLTTIk+N+XfPDGpdC?=
 =?us-ascii?Q?BqzE8ikhKJp3zJu/0LIblXobhrDIbaG3GR4nkatpJM5afkyLZMz6RRWktlYO?=
 =?us-ascii?Q?HW34/sBM3yDUzdhJf9cO9NMBi7W6hTPCeyGyUhOiINcKvieO6n+P+R5y28Kq?=
 =?us-ascii?Q?Oj1TYejqNArF8T6Ooqp1Z0xiOQhuFbrBLOKeMXygwmTpTzSncgFtYAXOVjHY?=
 =?us-ascii?Q?y6i5UrLqMbLpzgT7/pvgwXq2tlqRK2aiZDu87imMfdkAojYg835PopqCvcZ6?=
 =?us-ascii?Q?1C9eBP46HJx7eqXrXO24qZL1NZ2HS+a+yUvnj+tqZRRcNyOumAfhap/vgskx?=
 =?us-ascii?Q?8Q0D+ragqlNb+0DfzGx7Oj4W3CDQtiuTGIHiYLSStSTVejCFKKdqxJgomqYy?=
 =?us-ascii?Q?gq5D0Q0jJlfqoPVtVfBZHoFIX/RzjTC5uSvvwnckre2QzeooPVU/KDviBkBJ?=
 =?us-ascii?Q?zrZgFRX1/0iNSBGIdHQnZbaYEu6t0Q8u4RVe6UcYYFCqgWNhBLsdgoJJVjiW?=
 =?us-ascii?Q?ugAjxjGiCIoSLKaiqyHm3BUgaXrCQjqYTw5Xz8KL4HEzWrQ8l2Hr3OJ7+Suo?=
 =?us-ascii?Q?igvrSb4SsTo0cDhDyfiif1ojY4CR105WXgNK760Ics1gn+sjQopAQ8wBaPUn?=
 =?us-ascii?Q?omEnfjXWe3k6h4guwgP0Jxc9uUALUbuOFd9nwoHQlgfWlrSF8WYsGj3AH/RB?=
 =?us-ascii?Q?DzsYYpLJYc8n++2R1lrppSh+ANd14eR1nsmKf9JVuhbSb5wrb839oRacMDrk?=
 =?us-ascii?Q?Qy/PVuFd8ePpZv3l1ICW1isWULFpDWUKTPTjJU6Bz0v3gsXNoNxkhwfkUlw/?=
 =?us-ascii?Q?bFbTIvG7XvkBc+Hh1Vl1VmxGElNG8FrPpLX298PFAGA751KJYIPaTWZTHu2X?=
 =?us-ascii?Q?xJfmxorr1aQ0BGeLoag6PiQ2jmCb3gttIoLrWpigLhFc9z6RdQZQAeIb0UEi?=
 =?us-ascii?Q?LKKLLQXcQqGi2e1Bw+xojIOga2GvIg6MFc3tQn+Yrqo78MI8JF4GfBYWWb8U?=
 =?us-ascii?Q?iS6izqIa8z75ZXFldPUiRKQfa5sCYPVwQIxAnWGG+LmHGQofKYJZ0oOL5L3M?=
 =?us-ascii?Q?1hQ3JUR4M3mOr5bvcYwRYU1o17xVvhZKy/x0zP2TcJ0FoTFhzLNKSMU/Bmj/?=
 =?us-ascii?Q?jjAyoT/dCGFCp7FkvTmPhbTq/mHbZjFghlNSxs+k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b732e38-50c0-469b-5cb1-08db4df01f7e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:52.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaoMV8zR0pkht27ZiBuDF2uCT/kxI66xB26l0oJiwGTVwnWDL9zrm1mNfaIzopEPdB7PjVjgwR5m+UhvyG+cpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

This patch invokes chk_mptcp_info() to check subflows infos of userspace
PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 92b226260ed9..e0ae26670809 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3164,9 +3164,11 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		sleep 0.5
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		kill_tests_wait
 	fi
@@ -3181,9 +3183,11 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		sleep 0.5
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_sf 10.0.3.2 20
 		wait_rm_addr $ns2 1
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		kill_tests_wait
 	fi
@@ -3201,14 +3205,21 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+		chk_mptcp_info subflows_1
+
+		pm_nl_del_endpoint $ns2 1 10.0.2.2
+		wait_rm_addr ${ns2} 1
+		chk_mptcp_info subflows_0
 		kill_tests_wait
 	fi
 
-- 
2.35.3

