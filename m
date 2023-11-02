Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45448125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1IWvhxqX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbhqAxWmc8r6ZmjPc0v7ohnPIva7telWgSiQ36kvCkW19wwt0BCj63vpDyhGdD474Oq/6xMe8IMX4gZlWaGgLHX87CqN3+7aVyxOmBs+1jq01qTPXKVK7k/ZB0aNuYLcCJrsYX4tGfY8LQm/dMAl0Rox3nWuhAboFGFQG8QnW39mIDv+91Va81Z4i52Mj4UN8CnjXaZpC5OoiY036tfunCD9SBk6MeaGDOhkxXTqBEZI/BX+wH/tfZc+uWjjtMZszGejP3GI2eTwnRbz719y8H7VC79B6RJzY1QKx3T+nxsdfDeLlSt8oaNXPRUAmhjZHT6/lQGzNVsInde46qukog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7+Oi9ylmqP4l6oC3QYHJsOShwKN87155I48aTXSmRI=;
 b=EV3lFJPCA5ZtptYu+U8ctEvAHkiTSctofixOhgBU5AS/jt6VYUL93BlGKFfgQd6FKFvwdfq6ac/3OzGG+IrULrf9yltrHxEpV6cYwecQADLufeTbTZkIxXBc2Uuav6afhZHwYyUFxsZnmsEzIvl3Pud5oXPWakLcY8MtHTy/O7QHT276uMp+6qxzlqfPjgUKFOf2qYe1Ai4OXSefDn6CWFOQMRmQ+HFixKXZ8ri64Nl+W3j7vuu+9iJAxpe0UKc3AJH4EinA5ZyyIgcYFtfJlfnxt2bRzluIgEvorpEI3Fu++A4JlxbQqTaB8H8abxb7h8hs8enJuPg8acBJdxdJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7+Oi9ylmqP4l6oC3QYHJsOShwKN87155I48aTXSmRI=;
 b=1IWvhxqXVzEm9nxnVusjd4mbrKv5wPwIJXWsqEmkVIne7JHdf9YNZC5u5U+0gRePmMdbtIhIMD3pFOcT7IMmn0Fx1XRDj63p+60v/TZKWy5/khN1du30yHSyP4rlTbjQmNhKfuU4iP9b99GjqzJyn6tn+zc8N6XpLZRw8edKC/ZyRZHsSiRRtpOiv2ljiQHY3f050D6htH2hG8p87RbbS3MkZbwTMJNHxRcrkzIv8Nu7MEEQocyRplZ+16a4AsB/eqI5gru5coyFN7vtv8UZPWSmIfDFvBTGu6QQB5fcYlZFoQ1ysnrEJoAQ9p44asiQHOqvZ5oNhvRN32LJps316Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:06:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:06:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/6] selftests: mptcp: rm userspace addr with randowly order
Date: Thu,  2 Nov 2023 18:05:56 +0800
Message-Id: <4e77eb069315d106bb928ed2d9481a398b2dcaf7.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698919435.git.geliang.tang@suse.com>
References: <cover.1698919435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 781839ea-2b6c-4a13-da4d-08dbdb8b5d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+ETjF3rIVVs8OqJt3eYcBwOgoXKJyOCyVukhpaqTqP2yvxCAwCmfWlHNyTbBsIcSoEYT9gJUQGI1dk5PTn5M4VLysAJhUT2Ql4+XMY5P2lqgpZNBes9F7HltPfpexligLQws1l1ksnn/dF2DBAO38J+k+UxgINHB+bbDZX/siOXSymOJKOuw2VBNRhPjYnhyMexXaVqsEhHb4DfcSNIdb338wt6DSwqRtL7n06Kg7oj/Wwd32sFUvjNMQrdS6QGZlg2kdcsVTLKxArg4dm/InppuMAkmZTajctNAdaylI09sH6QD2Pyh65n0CXehtHiPZfWkut2Z0yPYjVnCsQf2aE788HDKcE644/teY8unc22Ljl8BWSOKmUUFbXfI1asKtyvGwlpgn4IcAb87gHC3Pos42+BOkKO+j/s0dFK9g5vCtd6eZ6rrRIwq9IYTA+qxER7a5UuvgUiXKg/iYI76Lt3UvmZqS1XwvbLwjG+nO4/ZWubmTuWH+L/IBgiIe4QDaDhf8pfvSUtREG4O3yRdUlvyMJqUxvuIaDE9SMVlZzCT20g2E1MmfQDUUUCHvVMRUk6dBn4hZ1a3bxNOlEIq9xinevp8JqeaeL50OhoXy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(36756003)(107886003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bIOOnwKF0TWlYuEPnR7JAEOu8/zqKCku6nFT5ZcAeU23hFdBW2euUvID/N+?=
 =?us-ascii?Q?0FbCBxSFLXVLt9A/f69Z72UkVG8Nv4RhbQxiPrFSQ+Afifl1aDO/PinGDklG?=
 =?us-ascii?Q?VchkOPIj1VEXW+cPjzTz+XiCgAXwaZuczDvbkhG78Ng09j2YerAtarFRCGkN?=
 =?us-ascii?Q?DtVo6aNsMQoe+o4bvWu5m6S+/xIQz1EUR0VQ0MhrkgBrdjXEJxd6mde0Avzm?=
 =?us-ascii?Q?z+Uqdkpp5PuOdf3NP76VIX2zB3M/VtZnJoc//WaEuSazcoWiG0C2CLxQu7HE?=
 =?us-ascii?Q?ZkdyCVmjNWDivxhzSUiKGNechKj4WYKFOEp6vZUaBfgLAXIAfvu+tD0+xHtS?=
 =?us-ascii?Q?dqHZKHA/GjdFRV8xNWmpz+k3UIjy9PdNkjzq946u6oBswUpYycngCKXG+q0m?=
 =?us-ascii?Q?9lrr+zSxqri8yEwGrD4WrhrD8iPfiBpVX7EF0ZC9X6H4vWAIAeERH5xLKPOb?=
 =?us-ascii?Q?zTp1cVHb68cOcGcIwYHx96LuHZ3X0Pj5SmPfEhbCttvm67YHtFFuvXxDk6kV?=
 =?us-ascii?Q?ioIQOQPTQwDs3+UO4/iHqS1m+aL/XhJhQ0242hdZofIDLPPC4GxyLpLK7TYO?=
 =?us-ascii?Q?oVXcfXbTLkRB3OYFuSYYq5OGFGacp0MtmkuA+wPp4KcbXJBpewhRr9bgAsmp?=
 =?us-ascii?Q?N6UNTgq0gmiwOn8UnpeW5wYIJToQDQcSoAxh74UDsA0BpJ02Xf334u9O9Hrb?=
 =?us-ascii?Q?SNz26/VMvUXGRFCIvBWvx42rONMN5TV7cIjOhNYW7g6h6VwRL156j+HBHwth?=
 =?us-ascii?Q?GYwk+vFmEKHNL0Yj6DSqVuRjPmL+gFGgqntrtog0YO0rlKxQ17pd8FtohD7M?=
 =?us-ascii?Q?rLYmpfxQxm2CnlQsBGWHgZYXKSgjjH04nq2q1kkL146gN6zU0iDSv2KUMrz0?=
 =?us-ascii?Q?Nc8lFIcRs5d5z+yW/swjdpPBQ2eIfCTXLBRi4LAo/R8G9cBkXmuHYNhoQGC8?=
 =?us-ascii?Q?M+GEKTnoBrwiZdFnFt2+kiNDcog4fRgnlgAYgpZQOhXedc+lHTB6KiLirhJ+?=
 =?us-ascii?Q?z87giSDiArqOhYh6NojSnNC6R9WSp+DLuK+4i4z3z+MN6z0kjSM+t0f2pGh1?=
 =?us-ascii?Q?VKVRStq9QdS/Xf7DudLkOraYNMnituqV8VTkra5Saj5MIBOO9NvgcSG2Raw1?=
 =?us-ascii?Q?120yP8AxzKdHlKHSDJ2MnAzKCFXhROY84j9x9wMT76PZb1qmU0k4z/Sbf3Ir?=
 =?us-ascii?Q?uTqOhOe+a9FSSyu5VqtvgpB1erbFwrN9hsGHMcFCHyo6B6bxM/ZX8cuOgXr5?=
 =?us-ascii?Q?Eirtdce8VO64RyHG91QltpglRdClOSpV/qTeq+SRUUSowIpDS3ULXlCaOZkc?=
 =?us-ascii?Q?OrTTF/X0M5nqaeb05BKQ1UF50QtfeKKE3t34lEbUIXgqGhlm1OAHxlbfgszX?=
 =?us-ascii?Q?z1UNyQd/IKokJpToKsnf4r58HAtO6UkaMcwUzCdeKQ+bNCWFZkJWsbKSav2S?=
 =?us-ascii?Q?mrXe8m9qc2xk3XtRZUiUDTyy0zVcdtXGUgoTHFny18DWUFBmQV9OBEPr6Hs0?=
 =?us-ascii?Q?Yr9V8f7UMRpHTLkrl2UQESl3BcTe6aUuxcJa7O+uC6NGwxswCZ/jpiM+aDok?=
 =?us-ascii?Q?7XXl/BnjRT8rps1hPbOqtBWyrqphFzNVUjlBvvtsc8/08EGvG38143iW3OPT?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781839ea-2b6c-4a13-da4d-08dbdb8b5d67
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:06:21.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1V8f9rb/4+xc545bbBuIDZ/fYSx30NnlIzerSc/K3yXZna2YJFlqmRc+wtDwmZXMz5DRnsQPlqMX5wtg01Ing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 040a4d1bfb53..53f49ecf0f7a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3394,8 +3394,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns1 10
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns1 10
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3416,8 +3421,13 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			userspace_pm_rm_addr $ns2 20
+			userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		else
+			userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+			userspace_pm_rm_addr $ns2 20
+		fi
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

