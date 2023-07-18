Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FA17CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnhO7eHcrGFzujiaXJeNkEQbyNehpMej+MDLodXkLuyeQdOncXraFpvP6iI3kDbCJxxIqhAgqUZwPYZDnZ1y8920xEdg8U/p0/NvEfj5Spcjjkv8cVHKCa/0jizUsURrRMJjxTf/Dj7pdJCwe6iPFnLSNxRD7zZMOST8I1arpm5KZhcKbU64pmPas5fkLGXoja8Dn2PL+06MO5ZipwFWxO7ngE7nnr1K08MBybDNwWuXD/xLtNTGbBSjUPuq8ffEUCECgCkwZ0yOvxxnFtDeksqsNApLOmPKLRrpzi91Kqlv69q8E2rkDO8F1Cwh2dWAGcmRe2JhXx4vD3UEDS6nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwBVvnCGaQ8kTQXWiLQn3aPQmKNgAgWn0EtekHKXaFA=;
 b=nrq9yREWaTAWlC5KL+3WY9aLzfhh7WAsCsE+iSS/0g33i+vStF/9VdqmaDrg5jcV+lQzHFSoTCEq/rlBUDmxpFNy49OFQ7VPNdJDYGr4uydrt3KCNvs5kdLVeDrXbAszNehWxXi3M/HTTjuAJDiCP6oyMcy7eYvKFAwBlbi25N7BNrAo5OAgyxzCYtuwjDnx9mHhxQwDj7RVw93psm7kKNuIL77uh02h9aU1d+CAPHtvWg42LxASGVATHX+cj3XGbRbFIgq2Gtv0XWrvezOJe9qUOuuLxbHNeU2/8vnqZWuOEkK/RiYYvY2bBCt7UUzaZLWHfUkGkbX8tUOPsdVt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwBVvnCGaQ8kTQXWiLQn3aPQmKNgAgWn0EtekHKXaFA=;
 b=HLRX5E8KHOX23f2g/x8rCy+iE+zzndA42EXOtx5HDf3RiKCdFTt4TXfVSK6uy6ZwOl1m3XPQwvLTAtXTxwFvqN636Em9jZBX95hBruJCZLQvtc7LKCgg9nvCoIFuNdE6RKUW8OeFz9XmVYOfsP9CuZFm2VF5hMFBpTa+gKqstTbRRbBUCrOM7VO8VhXeOh4GL6UVmoIm4TDapxckHb+lacNksfsF6JyQCnXAJumVekoDLR0CwBsllX/T79CqlyvuhCEWUal5brnK24DPtFn5ZD/W4RFrxWdkWcz4A8oVZuqZDWlC25Djf2n/McCZA/AeTxBGv5ykgrih/DZ7V25eeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/13] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Tue, 18 Jul 2023 11:36:42 +0800
Message-Id: <860ce049383d29483314c55b4fd098420fa93055.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: ae410763-c086-4704-f32e-08db8740588a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yOw2M56Wy/0CnpbEAJbp5AY9R5mWB6lWiHm2/AxNJVRv6IOjFtfMBsgg43gRAfcH9m5SCCS+7QlJ/hkhCZJb3Bi4Abegjk6R/rURP/CR/hwthso6Lqi7/SLRuIMXL5W0KRW7Yr6jZyHuVzM7sy8fYMCR6ffHCcq2CCmhWcFWNUXaOjZVuuTtnxOGDxbMyhF4Q+gPnvqSBReHM43Yn42Nje1v2yYBwXo8sT7WNE8w1Q12uHFyWfVEsm19iN0Ph9DzzUjmp0NUks0Dj3KRGYVlUZMiX9kmjgvnd0otLmcYk//+YeqYpAyVznKq1hUp5hhhw7v1r5o7G93KMR0R6lvIYRkvbN8UTY8UhZFEAB4Bg0U/hz8ytiK2SwvEgO5H+uAWIyHY8yMX+sKBJ9T0J3LuxDPEb1T1mizI9SArZCKeOi2H15gezbAMzx/oWdVbXI5lVA/02BopDHE3DcbQziXNFanR0mphHJriXIo7a5hsjJDrgoGB/g9ZvSIwUlIayMwbNUqug9uRb6xvmzwUm3QRQenxi0Vazm0Zw0SEH9Lh9cw4VKzVk87K6rRmgRBB1GIL4AdXZEsD+lJbifrrIJXIdZsF5HfmaiGTJqf2tvBXeYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(4744005)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s21Y+/0xWARBvQBuRjqJz4VgCGEUDfQPR67z6qcy7QsamN3Knx0ZCktxfo6i?=
 =?us-ascii?Q?0S5c+d3CCx0X9QU5zXWsj4WW23oY2ls/TNOObK0npka+8WiYMR9bZ9wicVCz?=
 =?us-ascii?Q?pnjYwQ1FHh6EEvYyBvb01cJ4dKhS+/t+GEryz5Q7X09GMg/QGcHyDrHVHTkp?=
 =?us-ascii?Q?0VuprSyRYk4qj5qyPYLuQAn9TK+HTtzLWGxklhxWDiuxWXrHb4k3yRoqNGEN?=
 =?us-ascii?Q?yDSYl4vdN0NnviH39uKcXtt4T6iu0lDxciWSdL0zNxPQRhb6CRrSOC61X8xy?=
 =?us-ascii?Q?7yQcHS/yFNUT7SxLnxzWIlNO6PFCDgntWqBTk06L5oNPsdqQyLcYrB96q1bU?=
 =?us-ascii?Q?OFxAKZM2eydTSfclG+OCQ6Ok9io+V5/YJ5u8PcbuyK6OFbiFeX6f2+QaPg/6?=
 =?us-ascii?Q?QJnQlGAgVBjrsXGYn0WJPRPy4jmtfKm5Dw0UgKSvPuBgO3MkH9+QsAIlhK5w?=
 =?us-ascii?Q?UTfVghI7GtuaDYCpW8RzoyxJKjcXNMUvBC8FZxuZ72RkNakG8ER2qgY4XLE+?=
 =?us-ascii?Q?CwbBI9aE3o+WD5lWr/yKogl1oSoZpAtteD3IrQn0ZD2QmD9BfsnlBJG4bBrw?=
 =?us-ascii?Q?sRbs+ilqJ0A0S/5aBXlZE5Z+efmb//OVYTqaSyfQK/uV0iRy7F+AFkJvIA10?=
 =?us-ascii?Q?6JujEulOcNNZhhe67HwS8CSxCX4ooUaPdws5e/pOiWCeRGwIyRuUmwg7Dlyu?=
 =?us-ascii?Q?+u/3X0LnGu7Ite9pN1glDr3fHWVrQodrxASXc4EH7dMVLAnPkghrK9B5+6j3?=
 =?us-ascii?Q?zhBm1hkM8JFbzQddGpNLXr8SRtoWCod0sHHjn0NnqoLgwhdYvBsqk+oPF7PJ?=
 =?us-ascii?Q?A+rSEJcNMkvlO7OgzukaUTByOwtxQc88tWw/VukEfOyayt3pCBntkukz1nl8?=
 =?us-ascii?Q?j3E8B7JEA63nEGd8Zi7uPPU+AUH35nPDd9ItmymDz7UVDwuhb3FTHh0cSc3R?=
 =?us-ascii?Q?1Kf5PXdBH1mv8hcFeRaKgfYoby7Aw71JLCvy4QdlTqj8xsOFqMWuBTKVM0+H?=
 =?us-ascii?Q?KqUJ9xnUHgAYXgF7n3mSri5mwXuC6NpYO+cTSqpJ2UIppQaun/bjQPVfotIl?=
 =?us-ascii?Q?L/5KJbElDXNO9uitBeferktOl8jMVqkfDrBHPbRwHOBd8C8KeW21kaRy+gVc?=
 =?us-ascii?Q?4MJrwY1nrgvh95SUu/kyBl/NAz75a69DjYUd9DJhPxsHyyfcKsqJoCCvg5tJ?=
 =?us-ascii?Q?dmnj4OdFklvaxnjinOOCvaeIJGDTB6s9qvU4cFRtQxZh63tiBEwU65VOlNHZ?=
 =?us-ascii?Q?glMAFslN8ZnLjLMx8F9F2L4EzjgCpf9wdcbjd+BTPyOh73nFl5QdKEdbxlVv?=
 =?us-ascii?Q?YIxnxp+eotBdpwBBEnLxmyBW/i9ERjCc5bWsG0zcInftWm0ZnBYm7JjGYGPh?=
 =?us-ascii?Q?gsyG+MUEOIeFV60BrLBikIOsV3VAo8x3vaBXuElEasSXlMbveSLxcg+GhE6K?=
 =?us-ascii?Q?dsztI7qkM/4P6/YsbmNzD7ZStBAtb3eyMQ86dwhctQzU+NMTH2SFHFK2faFo?=
 =?us-ascii?Q?2cD6QE7ugBIeqlk9Vu8tmSXn0rVXYpz+l58VP659N6x2KYlEjSbRdxfSkFN3?=
 =?us-ascii?Q?Q4+wQhXYPnRvI0LmmkQNFf+dRR2WWvVpQCyJj5Ve?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae410763-c086-4704-f32e-08db8740588a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:43.7494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmZ8kqQRYJGs6GupoW1io7Zp5mXjvfyERAUklS4rkBh7y696QPvxIORYnHZOVpmHMkvxon71BeZfUfLvHDT/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Start server with PORT_1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f09aafdff43c..f5443c3d2d97 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -404,7 +404,7 @@ static void test_bkup(void)
 	nstoken = sched_init("subflow backup", "bpf_bkup");
 	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_bkup"))
 		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd, "bpf_bkup");
-- 
2.35.3

