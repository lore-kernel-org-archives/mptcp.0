Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AC1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZiYM8C4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQj0RaPf1WvZ42oe4pphw/q/pRC0wE/lPoO+wsWGYkhUJjYJ62uR8poSCNznOqtlTparGZw3plBjhqw93Tv1NGYS2CZ0p5zzRVIA8k8G/ZqL62ZO/dZmzh8zYyxA8263JaREcaiW+4fg9mKbe6796DCDyae154zRTuUOL15qU2NqLxjKGFhvZFvhbYMGvgH9PIOd7TbqHDOKXpL2ZZEbO0og9xGHOFdIKhZqyEtcUpEa6XwzlRPwjHUqGGgshyX5j+fcEACtFRhA99LoAcp38TMl1O8w8QjHh/LI5kFlA0WXfGT7GmACnFW04ozAhgEl/9i0tNkDuoB4XIxITy54SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+/ZuAXfHSyv1DrgoNaqFzwvPPcuB347ktDYa5YTh64=;
 b=JewFOTzWwI4Q9TJ3P/fH1Wj5FQPCK3nP42r8CvSR05YOZqoxT6uxrlbg7ebKQYf9S/58bWITRO83wnQ4jgqKJGjNTjzXJWMZ9dUyr82d3deEuaayJ3MxenytoyQspNa6DZb4rXTFJGgNgC186XGy+WH4Yjl0ZxsdiaQ7TeBKgR+cjtRvN7GqiIL1xxvxWCQglr2qnzJf3W72U8Pxz4Vy8fzgvSaZG4lLQjhxrFZreUCadSLZemxCA2XXY0dmaqHueVPKM5/X0VbxG+ZmqBu2H0hMgA2Evsi7iq3xPFSpCYky1iSXLy/QfZr4jQ+UbaWRflD+hoJG1OeqgDJz0ENBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+/ZuAXfHSyv1DrgoNaqFzwvPPcuB347ktDYa5YTh64=;
 b=ZiYM8C4qaHgUVL/wf0uw49A046EbCCxVkpxF1vU7AQoKi/PAl5EOAh1dglHze5lLCbk4NolB2ZC/f0l0YKZzdH3sQ2863keHPygqaWAmKyaQU3acgs4wMyFPchcX01iLtQSgD1M2hJZy0CnCm9ou4/3Fo5D1Zxb9jHP6rXqeBCJxYBBtJmHV/52rr2ih0PHFPx9q+5629B+GWUGlSfm9bOYFKwnEc4kDTjS7uUo7UVdvIiH9sWXyjw/JTXaXVLpdJhYG3A/SBVeFT9KAnlDma2fJDPxR6aViHVT2kN9fsdHyyXHiyHDWBcYjQR1KZe/V/cZb/uzCicG1wMseGmvohA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:03:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 12/21] selftests: mptcp: flush and dump userspace addrs list
Date: Tue,  7 Nov 2023 14:01:56 +0800
Message-Id: <deb3d6bd67e58166a27446f15ebfeaeb999859e2.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4580b9-6abe-43ba-857e-08dbdf574019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/IJICal53lfZu+dxGlQLjyIHCwv/y370DHCNBIpqOEotN5sJAed8KbMpkaGgPF4lozrb8ioLObOKUbfjeS+bMM9Z5wAXuLz5YI4QA0A09E8NLBfjoiQWs/fAYEsr4habqN92ScexKy0sHMtS5XuPPHdXU+euF6XY/4UaGhfTgjdfjGycds6WqXCY8JVbTdDD5N1jdBbXhxHZu0vH6+rUYLRbONDpSIEV0D9mwNd1+hvaPmWbjnjL71tos3jfv4IkMwsosyupiK+/XFZIDgQlgIsiItGsZyICKZaRJnFIoArUPj0xX/gKvhvKt3YW+RTZ1QLa8S6ivjHtG6FubjvPxlQrjSnk/R7SiANFA7aoLpXzm6N97pE1O5unI5+AYP2C6X3Yoi5r3IyJkO+ER9aTUMqJq1UKwQITj+oAYibk84phu7vh0lngldoMsOo8oscKnHQy6F3pnY3jRs66H8v9hUynYnZfhsTjA0iUXtmo2HJOIwAj7InHt6USW92kusuTeFtgPETRKQjFVTiUYWUFZIYmN79OGW8l32tybPoe6Fk11ugzOWymPNqf9al8lD/j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eEXvN3lsfV7RcHXoxy+sPzIJmfeDq34OAQ+QB8FCmRNFEQod4VW6pXTt7xJ?=
 =?us-ascii?Q?iBNJXBBoLV21EchOPrH/GB7+SgIY+s80BTPUbSOhK9GX+GPalBF3qV8JCSRE?=
 =?us-ascii?Q?YBfa6ebg+dkO6hzaNCgaLdWVNF2mkojZj15qgUCfaVZY9rRaQ3O7Fv/j9AWa?=
 =?us-ascii?Q?5incHe4Lx2Ob73mh9WfDsbTfjdAmsr+YapBTGCbFXAPTz8tZ7LAWA2yFRFgq?=
 =?us-ascii?Q?Tq4KwGuA8mdrG1Fpy8ZyKtmaU2d0kfqIfSFUjAMGon6LV/C5sm++p47p2qWP?=
 =?us-ascii?Q?2DWYisytzVTQ2DUApFwaGonxHnAow8jysfpZuJV7Y8d2HOCEJn7HQxHUox7k?=
 =?us-ascii?Q?L7lONtmks9ZBWNbCMV1opTFU418y2zsf0Ae2hAwKshWvtH3W+OOnevtxGvDh?=
 =?us-ascii?Q?9sYYK6u8yEblKgpf7n2jwpoq3Dd9Lfq4lzQrduBs6UJ3EJtA5vXhowz+wba2?=
 =?us-ascii?Q?+H1UEO3ySLOEdeUhRZmpCstXLTA3defamM06A7ZX15Nc92AXoquYRO09+Mxj?=
 =?us-ascii?Q?PYKVU8xquEnPyLJkQig2EABPdSUt9ASY5tXWo//byL6kgI8hVqzdLbaZwDTG?=
 =?us-ascii?Q?V006r1gFgEoZzD/gfYbwpKPg7TfcQax9Owwu61fjMSPKea9K/jJCT2NS3Fz4?=
 =?us-ascii?Q?ajakH95vmM/OEetIRaC89UpDDqiQ8GIh8YV0wE1EKCwb6PHhM1fxna9w68Hk?=
 =?us-ascii?Q?Ry4BbE71p6cNEivsr9LyWsuK5Y81bOJXZxQuhlslMybzaz2iJyqHofBBHa1g?=
 =?us-ascii?Q?Tb6qtvsX2ZzdzoXKPtZJg1Z+UZ0kHzO+7Bg0O17wPiNxKpk/DXWqerp9HgY9?=
 =?us-ascii?Q?t3d6voikuGMmiO3oDaoDK/L6G8gfEgp/Lm1jCkW3L/vca6mynUhq3gYbpbvH?=
 =?us-ascii?Q?3VhG96alB6PMqxbzKHYib35MHx0ZJicY1UUZObLU9z+tM+CqBav4ekgIz/h/?=
 =?us-ascii?Q?SA1dGZnm3IUuj9uVn5zRq1qAIfSZcxR3F2q4srUv2uEkcVcMb0h5vg9bVXwf?=
 =?us-ascii?Q?W0IZ0A+SgkOEK2Jo0eh7Y++MT4E0xFCqM35kqgEfUhN2/ma9hQ6aKVTHQoNn?=
 =?us-ascii?Q?eRterIBFHet7Ys+9joCOSHsHQUomBHIFiVAZaLQ9C3VpiHeAkFiIBF3gypas?=
 =?us-ascii?Q?JOp/ObyX7cZH8DoNnxXIHj+MSd1MpflQq3Exxz21ExzOIRCNnzmZYtDJZYvh?=
 =?us-ascii?Q?YyHmRgp2ADrVg+mqqFv5sVqCFw00qsMPzxYzhUhRU0vy/mtg4QJIo7NmwMxz?=
 =?us-ascii?Q?b0+SXFRC6ZS6C/hh5lz0iNzH+gNXT5VtEdSz1lDfzMA6/ZRkc+dLiSKECWGr?=
 =?us-ascii?Q?Eccs2DqQPUJR7loovNQ00iXXfH/DUC3J24ind4AFpkPji3NczPo4qqkuG4Pd?=
 =?us-ascii?Q?9slVFBPQ9xv1JSuDivIUjVjtms7FBxt3pXWc+g1ABkrT4Bf3fQ1A8JYsp4Z5?=
 =?us-ascii?Q?N9ELn+tXJ2NVeEo5o15ny58AQ0mlF8pZP+9HcrHfFShjBj2n8J47Nwz7lekR?=
 =?us-ascii?Q?vF/FB6nRbnhRIbvfyX6qn/qnjA08SODwAodJw9Yv3xvSfnnxPtrxN+MgYRQH?=
 =?us-ascii?Q?XefhUKqrbEUGEPMcGOkvg/+Tb28qNIengL5CEVYz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4580b9-6abe-43ba-857e-08dbdf574019
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:23.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcoEYMD0HGsfKPYpv7l859LrGBFvUr0Bf2KEyJKFELFacYEI0Gg6JIMoGMvXCwbwe65DfIkxcIo9LbTOUm+J5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch tests newly added flush and dump commands for the userspace PM.
Add these commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ac7cee3f4dac..634b51e40435 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3389,6 +3389,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		ip netns exec $ns1 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3413,6 +3414,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -3440,6 +3442,9 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		ip netns exec $ns2 ./pm_nl_ctl dump
+		chk_rm_nr 0 1
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
-- 
2.35.3

