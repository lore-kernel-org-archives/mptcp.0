Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD65364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJjwiRoH9atwj19NdgKMXLtcnQ0MUBNfQpyItENzuAbN+P88jWFRLLsqK892b++/sZt6XojkpIm9XaX8StOiXSqZYKDjlKEndSXnih3flhkjRPBH1aB2sc8U9nNIfPnd1mj4QqeDq3h8jrFu4rac2z1N/8DvA+Tsi/oQ1jU65c9/FElIbkaDQlQt7lbuiN4/S8QRJHWPH4/2iIprkZHD5sy7YE6hJzTThVood0RUuAS1CEIecWGQFv57mf3IMPYFjaAxY1mx4wnzKJiGiypRFTQ15i2FHgyl9jR3aJH+3CBFnBCQ9qbnVw7FmU8wVsxWG8OPPDwbRRXZ2VEu3Apfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=bgl+Hx4ZPc/DQRxmPE9aDdWwA1zK64sUlNessIhh677CRYiOuAam63LmIzi0cYNg6msZAUo4GAKVbSNaOHXzQ/EIF/Gq2wEWDzm4Ul7bTP07iqRUhccaDa6ORzTG12V7D/52ztISyeiRfMYwLvoAg6OdExGYjB92IGrbbQzgoCE8y90vjAMLiTotMQy5RRWdkFxI3xO/OyTvhzwnPGHt81ARehjjPoP629J5nbRSz0leD4/DxfDL1YKFl6wHJROyPEo/ses1bKmVbsJ+JQ82B0CFJv8yb8Poyfdw49LrRE+HWOZxH9+zBSpfbjbmLFKnh+SKSCeJ/slpmqkWEiR08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=LlUPJtuc7vwHV0qJi7WhXa/VaIMMzX6GBNIxwKGUOC6djHAKRXTqT2NjezUK5X1pDJs8d27w+O4xul/e9Iyk38w3rAulkPGKqMSXETN2NGPQgDOL9CS1b/nEsD23DdPDdY6BAG/EVWKnm9vlXu0ZmqPbXsKiHBemErI685+yXg128TKW5XRaVPeR0UPD0+BBLyoRKAN/XpdZW2gddNsJv/tYthdsUOiaKuQsxOJZ2lD9DSH5Oojv7nIcnk/RRY8fNP5Ba9eUqUQJLYP9RYGbE+yGP+uy21oZonIBVf+YNsthS9Ft2XRHYQuEyokGepn5seQcm66dIlVReFPe5j6VJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:24:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:24:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 7/7] selftests/bpf: Add bpf_red test
Date: Mon, 28 Nov 2022 11:24:03 +0800
Message-Id: <5ea0584d148efedf545cbd2a382c87d8155ad7e3.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 371b90b4-5bd9-4078-d9c7-08dad0f008bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nc+y+fHpDiwcEPFZj1yQWkXYJcl3CLygd3rexKO5cXwum0/gf/1vDZE6Fok0PRmKnKvFzg2a3dco/Dd06LDxbkZYFknav+wYtBjQN6vP4NSxZM2rdUP66wYg4pokQXXxIsw2nADvXVf3Mz8tMtKqKzY7Kk10hTxtIQq7Sm34nfT3ti1S3XdaM9D0kySOXqI2D9/lkzxRFETTWKfavBwzWJr+zGu9EpJLqJujS80wW2E5UmGErCn163pAs4BVtsAoTwM3f6bJHG7jwoezpT5pRUP6ce7aYZuC1qIXM0rE4cyuZ2TAA/PSdAcu+Xu3wefxkpJBDv4Balp5erWibzlUsEkaT51duN0Ndk7SwRLALrOcna8sbq3QFCKzwoXW1wck54LoWYEp5A2WmPaLRkHKKPnlPHxweADg/+2JITR6vOSKwDOI9P/sLmLp1Q9r9LlnsjOxjyuOUTIdsT4DDmnnq0/e2y0HI/KVzLYp49fkbjfCuDTJwTNU1qI1iVBykFUqyN4pxXrmC+v5PHBtx5p8wL5b/Z2fAvBwdFk7cPnaVY4EtBkQB72nuo3ByjaEfGpbETelT3yeFJ3xDCA/Rl6sfyFmTpgfAS0mYA1o7LUZFWNCSu9vT15Kwvd82s3WDAOP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZdtRHujG0RyQWGxfPyddSDgzfamQL8EwQdvJTdPdtWG51OfUXAlJKp/wvBMw?=
 =?us-ascii?Q?LvGNjXrjHNv8uJ5Fmrx624APPxVP3LXhRU1QiY9SvUPf2KPLR8LR7X8WoMHo?=
 =?us-ascii?Q?cE4oViF/xDKgHjmAR/QOrwIKb+2Avcjpy8MZGtPe0KgReWsiQviAfhWyILwj?=
 =?us-ascii?Q?AsQ8Ml+vedfyeuPqrDqDPPH/6wPKfxH2UMpY//UlCG4vb7+A5na0k6ZEdMi7?=
 =?us-ascii?Q?Mnhu7xbxvz2vO4/Acfhk2oDZkrT9Ca80sAYLz3jmjkp8aR/OecG6juYS8YaE?=
 =?us-ascii?Q?wH7p+mlHL44eqIi509MmEL1mOkhpIGnDOlYszGQqvqj/RabI3MpYE55sGCRt?=
 =?us-ascii?Q?QH4vBzPPYzaxxpvYNgRjHPIP1Sx4BH9jVOGpybrXpUSQCJpudNOh66qQ/iJD?=
 =?us-ascii?Q?UW+hlMQkAcpwve1B6iUCvRNtYeqFMTRQFCjUXcXadBML8Cmwm4h/RCm4koSd?=
 =?us-ascii?Q?zW+R6m/QiWiiPHA0PJLZrLSqyFbm+UsyTtEXswRpBxXtOEbPR8H0GkthlkRJ?=
 =?us-ascii?Q?XrAt+LslVdLeQP7hksg7uAiw2/1ZSPW4PTpnZ0ejBQN1jPYcJ+NG9jFcApQC?=
 =?us-ascii?Q?yAlTi1dgM4CGsCf9e6ry1lzGNKMcwWqSOArlcxa6k/WTJnN76nYRX/sRKGDG?=
 =?us-ascii?Q?hVLe4rXEweQiVP0MZ/8/T6NhRb+grI8ylntOFHIhCXt7EPd1IPFUDZlvitVQ?=
 =?us-ascii?Q?bhRY0qjaeeCwdbYBk5FclqtICzlaPZm0IIFcC6J6CFMSQG0AyLbP+JNTsmNA?=
 =?us-ascii?Q?QqFCEG1CJo6Nzmupiw9/Xazy3HwDepYqf0UpqNC6aeHdFKo3YPatiT1SBPAE?=
 =?us-ascii?Q?/ExqqZom1VFAnkXsX//OElvIEu/4CmzGKsmki9cmjr0Z8zkbbB7x1cvcFWlr?=
 =?us-ascii?Q?wtwTIRQvBztDIS0y5L029A0tZV9V/olOLcMsACkqrpUeOPfaZpoMw4qkngjR?=
 =?us-ascii?Q?APXnTb3irfcwYnqsttt5SWYhxd+jeJC2oOwProO/6njZ3805Le/885i3esUU?=
 =?us-ascii?Q?SUyWty8YTOImmZ1/3IMiDhcRXxXQ/rdzNBrngN7d1v6og+b9PNOCWov0avJJ?=
 =?us-ascii?Q?QFgTchbZFD3UrEuDGNnJC8b44xQ79UJC9DCxXeFDT7Cj/J8ArCX9NxVEqrUE?=
 =?us-ascii?Q?NhpSZFg5+/gUt4Xsw0gBWe+GiAfWRk2ue0NdauWlnnCZQ2dLdKwK1DA38I24?=
 =?us-ascii?Q?oizPC/9iBe5pOdIGhnualAg1BjC7sDVC7iHgE4eW6bs1w7HTW0jp9ufJ5Ok6?=
 =?us-ascii?Q?kfT3oyPu8e7K+diDmbwb1I6GXisJQwTQjw4J4CQl57X+B9kS0cXbyEthlFVW?=
 =?us-ascii?Q?5PJ9B04ZI2P0Gql/q9PuH6vHxqVLtEfr5rZEUA+Vu5TWG1rlJAKw4B/2YosZ?=
 =?us-ascii?Q?ia+i/skY1xrbF072X/8S1L99v5zRrN5sWMYItuDDugYooIDWUOynI3HmCZqT?=
 =?us-ascii?Q?EWlUeFvNE7hLv1dNBK3bYKftFuJyecKrrSAAn/FdOlyS/mK1UnSjhK9DqL9/?=
 =?us-ascii?Q?boGASvjLW9slOYQcWvrEsr/8xEtLoxurLJoAOGvZgrXiCm39V7HRLJqe2wwm?=
 =?us-ascii?Q?Y1rs+ljtuU9z1HOLJ4U20aYUZznlJutqTtau60nxP8KUDV2cPBwgj2pOhGPi?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371b90b4-5bd9-4078-d9c7-08dad0f008bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:24:18.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Gz6Xa8WYlho1M46esPN9+c94WUEOYzSxhDQVaSFbr3kXfd5bO8OSfYVKgb98fDlG10JfmNSiwy10W9Kn7mtRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

