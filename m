Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238AA3207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvNYILZyG3l6FiQxIWam1p6297ME1Ot5Lb3som1wFgd/Bcahi40jfhSC4rWvZepApsojTu9cXnHT4z3JKrw0kByXH+Ogh37tvkw7scGBy2AM50ER4x42+BZUXvaRemwxUK6nIeUVr0Tv/bMm1OIZ8rHAQ3dtU9H9s5n57uPsaexYH7SOyyy3K2jHCA4GY82BMbjXR5p24kbrooZS0MabDf/GOBQTguq0O+gqb+cFscCZbgRndzZFaZbhM2onvpvfDZuQmLiCvE3elY9AhfxTqMLgp1I3IdOeyWMRHgi5nT4oBExdAiIZa1vIImJk895vFg0FjU91FrKqVeR8BQSGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHVTC8lzTkswW6zaA2ecpn4GIqThVEVuYjRMuZUQDFA=;
 b=JgSqnjl+OUVu7pqFV/ujnotwbTffV0e6i8dyTCbg2PLq3IuKycjdBYJnCoccj7O3bJkPg0mBfiN2rGZNK8R8c8Ve2AN8CeL+CrNgLko1cxBrhrnNrYowiQ2gSwJQ4QcRf83ov/z9nrLge83Cld4pXtPQJoC44FM0gffz2iwDTzd/BFrbmPebgdDOL0qnSEfW8N5rITPzYGh53vHhKY5E50z01aaDwRTHkUzVlzLJNV7oT1mjE0ybxJHyRvTcUYjed6Q1PJ4Ykj/yqPW/hTJzbQu8tX0/stzKv8ZjZQby4LXD/35390/b9rgK9V3jxQ9bX4Gea2nNYo1rkfZdBspR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHVTC8lzTkswW6zaA2ecpn4GIqThVEVuYjRMuZUQDFA=;
 b=IJe0uXmTrmqVkuayZyOhY7WjXacxKRPyvMm4pB0hb8PZ8bu1KJg16PsLxDa0LI2w13KlR0OwlyEfmowsGfZD0/2wLokD4urTR49Igcg+O4ydOVbGCHuHkyGHP3WfsFBi9zimTdCDIOb448RR3WVdxN9fi6oPZfzeLvg+xCOPlYLPEvn2hmzOxw4grda8CCq6aY3W2gz484t29bOtQ28lPx8GxGj7ipBJNPOkjIeesZr6BGO0bx7G/HG7cjnw49pNtYML/FF2ZL6zFTM1Gosb9qcTysn+MmN4uRvUKSei2dM8nGeRJMRNrdtwDr4TXtccPFD5O7PPRCW7KhF4boUvxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:02:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:02:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 07/13] mptcp: don't delegate sending repeatedly
Date: Tue, 11 Oct 2022 20:01:31 +0800
Message-Id: <20221011120137.5475-8-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:4::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: f528dea5-de7f-4ace-2e71-08daab806a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jfiP3ObCVCEqiI+jynTkjhzUSWCWDHh21WGsZFl+GO9YJCFmz4glefwnyUzAipgUrkenq78NRl6niqTtre7NRW67fXEaDePlrZem7VkxEfT6T411TncJrgvrRCjVeaC8MvcTvonHwV+EgnXOSS5byx4KO5u3u6pr/ykcSBlOrSgV8vVMWHnoLid3MFcX/RE9Sczer1KtaY+SdHbS/8WXcSS7AgNmNy8pUDM7FbZWJWX/iqKqjky6YEKtxxm8JWqAch/9pnCuWpUHEdBS0588fu27uaOyDBuMMh1tjmGJVEhLgvgE3be1ZIgDC/x3we9Hb31ys6K1jMneg/cU6BX+4YpXNijfoZf4i8nlrBhOrWjjgLkKi0vXtsAoryhZlh9Ko8WH6pjddco7EDFRN83uzhGcT/5m6jSONzpBQmsijQB5N9mDVfFNpHnx8HZnOho9C1d8JZCizK0rsQmsubpoO6InvrmvsVWuleIRcdBPEOC1umxmQ5sVeikpszF8nNqiNg2hzm1ovuxWEW/p+WlteIpvll8Cz06SnXS0is5OF8F0Hyv+8b3aLmzXomyk6ZrxBCkzUFGVT0hV6NpH3HDobe0Y4L9ba/foEP7nFc5Yx5N9Y8DfDtE7ksUeTAuLRYrn7anOpqk1EuTyd0t1S4PfFoRctNIg2oGNS4KwvTZpN6zC4h/Un+KVqOJMfrasXKMXVq33tn0HvgUohncmKlmawVXz4EYMK+OfQKzzU4k2BlayKbvi1FU8OSQJGOr3qQbc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLbF3tQ4riia1/PzCKUOnwgERq8dohw2HhTePd4IGqzpn2Q5uaUSPkM3d2Er?=
 =?us-ascii?Q?TEIYEDb294GzkJJRuwhSmjR5HLp2ofnS74dnNAGpcb1+nAtq8d70RGaIR6hr?=
 =?us-ascii?Q?PtzeZBDAwmJlNLywQQ8OdaVRKrm00FBiRuCRia3fGc8HFBZAQVrPQTOq1qDG?=
 =?us-ascii?Q?rLq9WTXK52o5hdB7Ewm1yepAubJfgAFMceW4f5pxXamUcwkwJr2VOaBmqlgZ?=
 =?us-ascii?Q?+tsCSA1Qhzu19XvIQIJwff/AohiEwP5CQEDcvTDCeXqS76dLfUgIMxPXK0bD?=
 =?us-ascii?Q?5Xz6XF9ZYn1F8ROw6s4y/hyPZohPteQ53pW9ywmYLg7wt15wJb9Cef5jTZo0?=
 =?us-ascii?Q?6NSbfLtO3is4K0tpLFFqYJv1EncV5PudWT1nsBcE1tO3gt0jO6/eXmFvr5gm?=
 =?us-ascii?Q?zTsBKYsUxC+4HUKzUo4b+K/E2akTMkXqKes/AQwJiBrGJuvczb8LX4Oh0wT2?=
 =?us-ascii?Q?VDYkl+grHozbp6C9pCVn1vQY/RxusKFvl5BPtkMPHY1nnrrzPXtCTw4IoBQV?=
 =?us-ascii?Q?cUZNyOAweNjBW46qrM7/i4El0dNPtzz37pPdmSv0CJSAS5xCVEK9fvLjwPBu?=
 =?us-ascii?Q?xD7HoqjQEG2L+hXwxfCKhjri22w6d4HBrwyFyZ3610Pn+QhYh+nBc5FUq7qp?=
 =?us-ascii?Q?IV64yk4/jj8+S/1fyq9sAmgpxy8CE52KvukLomOcE6rVwUFtG2jjUCiPEpuB?=
 =?us-ascii?Q?6MBWyBxxCZRYYMW8eOmFFBacl5oGgLUGB6wwCdQL81jZdTshdVZm9F0pkWWw?=
 =?us-ascii?Q?vvPzEBdzQzmwmulHhmnGwCnnxF2UBnoNb4HfST4BgxMptBSMW3EpncpOn5lm?=
 =?us-ascii?Q?O2T0vOWNqHQxB469R7iCte1T0IXwl+HQjyg4Ysa1joFcwwp5APs4kLLV5HMA?=
 =?us-ascii?Q?Wmv1C0zO3Gd5dIp/IyeTrT/PDwLOXfFC809nKKnxU4U4ULIKb08dPMezApPn?=
 =?us-ascii?Q?9lsZqGu1+YjVYDwCRKz+ITHpeRfns3ivG0FjRxvqC7LAkRR16cRavi/QTQ+1?=
 =?us-ascii?Q?a25/TIfllm0qzreS61wSe2MUCuP/fGklQLWSNI1ktp+J4OxkNTS28rf89xXq?=
 =?us-ascii?Q?Aye2AXVcI6dfModA+jrLAu7pT8tvCPedG5azlLmLg6WulDLlUv2RaGJU7sMA?=
 =?us-ascii?Q?pyn3h/4XVbfOzvYOsNBZ/hkapR9s0CakoBJHaFyg/mhJtv8nFCMLbbWZ4uho?=
 =?us-ascii?Q?CGWld12GXEHOFEqb0OlNFEQr1uCaEB8IWUwYo2/RAyS1Hr+KOYxrvBmlBNE8?=
 =?us-ascii?Q?BnYrlTysxKzbYhwS44/87fZhrJ9IFd/29SIUUQMnJBkTHEC8vdFpDv3L3K3u?=
 =?us-ascii?Q?I1WteeT4aEGPCycBRMfumiBFYHm7oLbuD9FRYRQncba2jS6b04y7TLpEE+5P?=
 =?us-ascii?Q?E05gYPr0XS9dpncxtA+UM5LbMei6uFB1CdVwFK9qQtc7qSTEU0f765hl2+UH?=
 =?us-ascii?Q?Z0u/eRIKnpmvanQ1hapRGJNXRtJbaytJaXGGvq306Seb+0BiAMtwnJ2MgWoW?=
 =?us-ascii?Q?AXgTe7TQh39U24R+gBxRIW0H5sVmZ6wR/Bv9sWuCwJtXbLTWaufnPbCQkb3g?=
 =?us-ascii?Q?s3AnEt+Cs0y1l5qIDF28pL95y4DV3GE5oaP+qAv5pwHGg3cx2wXALmeq26rF?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f528dea5-de7f-4ace-2e71-08daab806a53
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:02:05.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkWNT8pHFFKXfMrAh4ZkYhdZmV1rwowQpRy4RrCzgTNRgPInBOPEdPk9YnwyrauToSCHWJj0c4/TcwRfcAAiOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

Do not delegate sending to a subflow repeatedly. Only do it to the subflow
without delegated action.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 86ac38d10bc4..6f55b51e10eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1600,6 +1600,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					 bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
@@ -1622,7 +1623,10 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+				subflow = mptcp_subflow_ctx(xmit_ssk);
+				if (mptcp_subflow_has_delegated_action(subflow))
+					goto out;
+				mptcp_subflow_delegate(subflow,
 						       MPTCP_DELEGATE_SEND);
 				goto out;
 			}
-- 
2.35.3

