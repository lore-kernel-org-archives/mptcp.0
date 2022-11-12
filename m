Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206D7E
	for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 00:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLW0Y3+TQZ1a7j3eyJq8x51yR4T/+EbyAKV2eQabdWutkeSfxa4W02R+8ubRnCj4iJmB2qZJZglUEoBiSBJX/FABvi/sj5/7ZUoU4KEwLQAIRVTlNFlqGYw0gDBWwbGpWaVIomZ9EpZx7AKqVUqhhrnzng3U3r3iz0ODXWJVZn0UifjoVBa/QKdhabpcD98ExI5BGRSUdzm+vebAtB7WKmSlCk5uZiXuKny4RHZm/2vfp+JnwyvaGSKrIStbQSMzUkcM5E84wewHJwrrVOQqERaRrtJU6/w6dn3Qfbuxav1p5FYy/dSqmxi6X/Hhi2SLVr6NPPCbyXyPvpjE/tQ6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3aJLhhc5TdUWk+6L5QhDbbig2eqJVvTccjSj1QwDvk=;
 b=PiaLjWUj/ozbJ8dSeI8rT7eeSh1QVzqTw552Ehny1Zx/7M96cisB7J2M/FrSZVMgwFopFwq0C8Sqx3hezh5H+An9D0w18C5ycpVQP4fRBxVODzvNm6TUIWRsOaDBucnbZSBn+dt/6E0ZLQJWWYUNMBRDqWWjq8xtbbyLjoiWYdZ94vPtxbaDQyuYccIPXEXPJDx9oho1M2tR6vPRQlhqAiSmUqGiCKhFBQZwGWU1w9zf5KH3zkIp2HZgG/ssnAHTSjNx6lyZX3I7mmIfxzwdb4JtlKPWg64UoOzncPWwoxxqaCSPWACLP7nvKZ2zIp7KPRdvxByoEugLqT6UccUoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3aJLhhc5TdUWk+6L5QhDbbig2eqJVvTccjSj1QwDvk=;
 b=dZwfohpoV9wcwfRs8+L8knY3uiHxX0kd0egotcvqkSCThhig0hxKSsCoLYBtiAKglX7ONJAbBjsWy1uEnbkPrxxV4EVcbXOeL7sDaADhEyDSKN3otXG7PtggBQ/frf+ouqM91FN+30ZDQ4QW2BGKJHBerPmmuGPGofU1xn6/YfvzhRTduonm75FbSrfYx2Aievse0NKvdWns2T4POMgF+BSwV7VUvvHDL0J+hNl5r8PSHS+4r9wArOBpm7XEHiqfXSbGIASxkrMfNq6W7pPajte5MhvEZmu0lEvaor1xWVh7/P8qILF8M+geYt5jbQW3k18mXvPlI4CDAB6PEJcanA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 00:31:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Sat, 12 Nov 2022
 00:31:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: refactor push_pending logic" v19
Date: Sat, 12 Nov 2022 08:31:33 +0800
Message-Id: <20221112003133.27153-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 229a2fe3-1caf-4c28-081a-08dac4453890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KYwaF5QKoXzsUAJhMyNsuLSE/ibN81yS9g78Vs/E2jn8AqFEBfbdiPahjmlZCqDcNVjPnQaaIBIoRlSCCNZcURPfn9U7BZpaWyMpHvmv6FPPVaSdtu10JzUuWK/85LFvVvsB2JOKSSlK+Grw1DzmSuZDA6VYiNSSIe9tHhe93WlM5UN8DqnWH9gEF18Zode0KHPh/WRHAJfn/I8JZWzQhON1sMYF09nQVbW1pNITApyqyNmvqxp/oK3ocEL45xq5Tw/xNq1YgP7o7PEqywLvOW/iWSNT/MegqZkRdRna0y7xGEZwt8A4yRo1e6WBDYfIuWMPhTCh4LvNugNG4jEnkIUSNZZoHhSxZIxTAIXd7W3wD+aUJXn8a1LaLkQdHbZGWiOr45af3okfrovq5U8/9x8xIoTQZ83gUzKKvYjE2Mxk7HkB/q53nOZASfMNv38bwXE+PLWLQWOiNtMPWd4z7OdPJqLsl+I34Hg6NaQCEcJSg/EHG35NbO31Wn24trVeOlMqPptrhsli2uabAWslJh2Ux3BaoG1ngK+uOHO8aAojN6DTmVfHA2UIY45qF4JeqULxh2vreCXLAGALqvTLSiRm4wpelaP3kLfOdiKLn/KK1SEEIr2cedGjb+i2EY6LCoz6ZbbDdGlirLLhhvLYRwF7yF0DVRTuT3MXuzc4J19Co/GRHiA6ewa0uZx+nDwnPl2r/1BxyjeN1XU+YJ2l7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(83380400001)(2616005)(26005)(38100700002)(1076003)(186003)(6916009)(6512007)(6506007)(66556008)(44832011)(5660300002)(2906002)(8936002)(41300700001)(6666004)(107886003)(478600001)(4326008)(6486002)(66476007)(316002)(66946007)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJrIdCZHXok54bP83Dx21pZJpb4JbXs8Cvr9bjHFLo/U/pQJu/oHx2vRph0Y?=
 =?us-ascii?Q?09oXeAzbuGVBaH/ZxaTe4xPDqk5nMuINWsUOTu2ooGEKlOvTFN/TtIwk2rf7?=
 =?us-ascii?Q?EII4n7e5LRxpaO6Cvx/ut0Wa1PhSwT1KiuQY2My4+LeKZAPcNT8ohahQ9cu2?=
 =?us-ascii?Q?p76XIJ686FqS6CXZlU33pAUhYxiP2f4OA7XBNCUVEL5Hi6rDBnJLw2wrVFN/?=
 =?us-ascii?Q?Rp0dGDTeHZj97BtG71EfIW8d3JZgBuyx5lQT20nuSMhOaOKVK/7xN4UeP3wD?=
 =?us-ascii?Q?BkedPFxfuqRwJ+jtkciZDtz8gP6Yoap/9Rlfwq8KOzjiwr0A/CPa3159WMfY?=
 =?us-ascii?Q?+U8ien8wm1kMjvD841ZmwGxskPzMkkIXTGbjFFuTJR88vHYhAm230BIksNyM?=
 =?us-ascii?Q?O2i/VPZl9rNJxcQZbpXuu8/LcwwWyEx3rA7guAdFdLHUpywzf76FB2GQ+wEx?=
 =?us-ascii?Q?1kdRKLTZRQtMnuw7CKrjxABnwe4RLq/ju8+FGB8Kh+QTBzPbLjpyary5VfhF?=
 =?us-ascii?Q?dzchsGVLysGE/RWjWa86o+1bdfrC1n1ENouTA9bVva9nyGforHWF0g9druNX?=
 =?us-ascii?Q?6Jv2rLV1UZpozzcQfMA61DImlcaIG2chj4hFdVQYH8PqL/GFpKvwE5OJPxmq?=
 =?us-ascii?Q?FGYxURBqjaGJ8+8j1eQcZ2wu5mkMO+DrjQKKCSk14r4OKT3myXawbWjeH8b2?=
 =?us-ascii?Q?AoEyQqkQkyA42WBB/yG86djbJRQmdj/MQ5EUNV/jAB/GX/tVIWlr0pp3gmAD?=
 =?us-ascii?Q?nzIpx1BBFkIb8tIICj3oZ7osCceOghyhfQCoXcW67MQcOPws/e+VewBf6slM?=
 =?us-ascii?Q?V9UCf0ealpX3C4mJjbuLsawvJBFIzjcavJF0F22+Aj+bWkS8hj4Y1Wua84Fn?=
 =?us-ascii?Q?FwFYx6RO1825azb3go1lkOkzmYThthul2hw/9sDFKEtR86fKYLFQ6w06lOPd?=
 =?us-ascii?Q?2apOqM0aappdHoeJDCnsQSCvAbK6AgiBTd5hCNjsbsIO7uSlQSvNtSD+AS3z?=
 =?us-ascii?Q?DAM2x28cfWlw9QrmK3+z9UkKDraOhv08Xsz4qpR3DJilbdP4YMHa7V6JsqBI?=
 =?us-ascii?Q?t4gaDW4dGYYCszDNM6w30Ik113c6FiLkoHI2VF2BL4wyrO+dpbsnfqa0boM6?=
 =?us-ascii?Q?Hlyi6b6gTLFHA+lbID2J72+D+mvUFo3GAC0+gw5H1h/YNlg+inQNaQtaEfN7?=
 =?us-ascii?Q?ilRVyGMIP9vg66JA8IJaQ0rPjF/8mEOPg2VcqD3Dx8qVqOI+1jRjz9m4krGP?=
 =?us-ascii?Q?kOLgAk77BPkEiGEiXQszhtQM8ukS+Z+tODz4DPi2RVfNCuPSGIiHANozoYNo?=
 =?us-ascii?Q?+tdCM+5h9TzfOCksMqPRq1Fq4oWptXNr7z9jK5J3RPckWJ4DqzM7mZKCDMOT?=
 =?us-ascii?Q?kETesmP3uwquGDGJqm6Vz1bLNFAU47A7ZM+O9wBbYakjYgNTGWOss7rL9P42?=
 =?us-ascii?Q?/+LzS88tkmW/M8FGMQMvNfAYraLrcwHQDgjc166aLUf0b3ZcRDSOSQuJVpkT?=
 =?us-ascii?Q?HwZUnofCDFTV7awbemEHETNvd+VRpVlMiChmPstmc8l8ef+yjzurHfAEAMEd?=
 =?us-ascii?Q?ojysJRRMdMjcDlMfNRPYcxr1Yga63vgNsxDJ2FMmZ4Pa1hi8FYKb9sRxvc0p?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229a2fe3-1caf-4c28-081a-08dac4453890
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 00:31:20.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRP639GJibJRW2La3NAunT/dvJV8c9h66TemYyA5+tWfWBMVLCFInbJ0tfIyvlmDPiaNxJlE4jsZG1WXF02eZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8868

In the "msk->snd_burst <= 0" block, copied will never be 0, so err will
never be EAGAIN, drop it.

The orignal code only checks EAGAIN in __mptcp_push_pending, so drop this
check in __mptcp_subflow_push_pending.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a60961d0676d..2e60165c0eb2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1548,7 +1548,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			err = copied ? : -EAGAIN;
+			err = copied;
 			goto out;
 		}
 		mptcp_set_timeout(sk);
@@ -1638,11 +1638,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 		ret = __subflow_push_pending(sk, ssk, &info);
 		first = false;
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
+		if (ret <= 0)
 			break;
-		}
 		copied += ret;
 	}
 
-- 
2.35.3

