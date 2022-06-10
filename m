Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D467A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P84Eo0oQaLKE8T3Y/Wrod/0kiuooR3c8zhEOnFfMNQkOzNMrYEbewD1pXTw0kfB8n++vEnk+E/gL6Qew0O8xZkTsidam2wmQN8L+lx3hT1N1UcoQWscF2QYEoSbRCe6xRdqFrrVtEQX5IlcK6DNdmFTBuu9RSwkmnv3PZWU8U2ifa+4ukSAWoRKM7F6ndNap2kDfIkzMDmlpIg2c4Bu8iAlXm1eYviO4SFs9g1aliGj/jWm4SD4e1yqiFRiu4eIt0Htjlwfp5KCVnDntNZo96RhW4bapI+IpOLq6mBhcflyovRBBZJTLF3NwlU/u9lohzXWmILX+rZdOAsUen4nwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLGcH3CwasmJidIX2ZumZq+K3bw9z8vgYlmk256tK2g=;
 b=noVSCs4Do6cWm9HkZtMKx7FafllOwR+TjF76JVLml6N6G14XZEqT9HLZoDqUp5naMoCG5tO2dGupPf0TRcjxOqJrTOoqRFEtilTcADSMek1FMBMtrBG7CD6HFiKX4BdSVIAvntNe6IyyE6Fbc+nBxJId57HyIJedwI8ymeghDKr9KfAgzzd68gFMdmwLoBd/Keh2dW30ctJ8JRvvWkNRgRAsTnLr/qSIPp1WWq/EOSZNDCiFdQ3ndn78p/3fapFD40d0GyhCPE4L7zV6fsGOxm97NCD/q5DXasQR6ZKmrwOSwJFnyZqWq+p687AriFigI486kMaY8PRDcxDnWfQfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLGcH3CwasmJidIX2ZumZq+K3bw9z8vgYlmk256tK2g=;
 b=rUBFFeVgGkrf+i5lmgbsn5J6cj/WgNGVjYBwnfuCVbbsvqIno1nBzo2P+86tjdsKWJb8BH3Em3DNXo7lcokKrXBvptC7a+ZsdebL3afc6AlRgOe78ntFmDHvKrVZMAELSSVvyspOs6W6g4Ulc6vNr/oWDrhTfBqWJKqnirdTS5anirp3s1AYKwDgfC3e6TPdxoVfv9g2K0qWNaRW4ODkcKvM9bJQDEahhSFKpLZ6zt7foBp05ys6JABe0pPvvZo6weBlpKz4/FuqFHPX/LtrrgyBx2Vj57+u1A8teJk0OwUY+OK3vPa31VKXlbaY8HdSkzwlJVty88yyIGOXixKN+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 6/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Fri, 10 Jun 2022 21:05:31 +0800
Message-Id: <3f26b39e0cad06e80451f4f6be2cbe1ad21b2532.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933698ad-3e55-494f-bb0a-08da4ae20c80
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2725A25FD8140155884D567EF8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jjCNenBPUYDGIbhjwNZS/WKpPH3K65oa92xWLy7W5ZNf/rvlxqrsQQn+3jbEnqGQaN0cxKrHpXYJ6XXaYwpJ/9e6Trm7W8HwQ0eOtICUMj2KaIPU4PjDiO3XGjwSVzLtGGkHx2AnQo+Bdur2e5c2czRmEpJSHPROyX59NZklCnXeVXHXGUqhpcT1WKgAfX/bvlDrVqq5BD3pRnDKHoSnVraZNVW+0Wr69ezpfyv6Kw0uTVuY26LCTD0ZjnHCd7pS46ls6eiFbJXyi4yihYvYIdxEuUkzBEUZsGUdS9XtSB8sOXp+V0uIVwZ8kfelQLN9CxbbjYyj86m/Pi4VxWPvSCBy/b4rw3P/74o3zko3zSCMY8WLrIE+eZ/oMJI16yf6T/Dd1iMqWRFhaBpgXwhKiyX5uQ+VXohihHPyhCa1+kndRiZ+5ePMslxXYd9iiyuRsWYhrS3kE7Df3XakPRnjM7oPGMBxBsG/r+OALtdz3S0/k15JIQjaU7q99yoqIhAelQ97rJ5WIgSgaBLw8G4oQpLOeunZKc3miRE1iWQ3pcVMgtnv/eQYBPP8+lt3tKWSnbiimk1Y4CWKP4ZshoHmK2SV6z8OSY4dE0ZJiJ7mdmU8vBGSryTU8e8/EMlAVU8IBYgDTvn8VWjHGMYCnGn7wY4cqqVCiZJLvlFV2sOIjRIgRFxX/A4+jQcLrgamaszfsgfduJRMbowljlfUm4jN6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(4744005)(44832011)(86362001)(6486002)(508600001)(6506007)(83380400001)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0XvP4QQzLRZ3y71dotrWRa4CSoAyDwtwJyZ/6ReO1XS4OBoJrnBRVVM32t8?=
 =?us-ascii?Q?MKgQcYoUGyG/6wnI+78t172cirqA3mdzJs6SYySAvlkBI2+MErrPjjBFVMem?=
 =?us-ascii?Q?A7zV93PC8g1S7380sr05U32qCVy7Ury/HC0hyHgK8EH4DLOBYafN9WmeX4OM?=
 =?us-ascii?Q?CsTHYHxdATPdGTeRvp2WtpTD7sMmQHV9C0ChCLOtUUVXj9Ot/HAtXimOrOpn?=
 =?us-ascii?Q?AITVWht8yKO+QdpPearVXJfy10P9Z+FlAoxOjFM0Krs286g2O8JA3j0gkQVr?=
 =?us-ascii?Q?uUeiGE0eh+7TlgAt1cIP6Nsig670d7N49y2qK8L2ZMXjddDkQsNIHL8zpy3Z?=
 =?us-ascii?Q?YidPcCJNkuii9xDh/bp7uIVnvJ3/a1OIv9mfK/+BqvLC33cpjPKdnAto0kK6?=
 =?us-ascii?Q?/Pd0NxYjwlo3nDP28jQpmJ/PeCemH7Cs1CD2OUwAnMzOJr+vcpuMpI9NNFNj?=
 =?us-ascii?Q?vAxsUDlDbW/c1yZleOqCQGJoYvu9GooX8kQGYdnVe77f9cGqs70HZnrDiLnN?=
 =?us-ascii?Q?7PDJgn+6VS8hAeJvsBAmet3DmsK1Q3NG1edNW0YRcbN5vwNbT/hMnRf/NXi2?=
 =?us-ascii?Q?Z09bEAnXa/P4apzQL8gAzwd7oiNiBw9XZ4PKeSVnFrcPoS9097pD5AhlhVZL?=
 =?us-ascii?Q?v5i4tp7NJNVNo+fERZKxWMaPwOWio/EI0DGWRtEtigNanZiPICedENevXlzM?=
 =?us-ascii?Q?+PHvS5tvTln9RapR9TrqKIFC+0MRUDLiiSVa7C8V/ZcGWnUquFZZUzjL0lyv?=
 =?us-ascii?Q?kwU59HYK86mM/R4M2QfvOlg0vraB87U2qrX+JB+OJMYYy/qHYLSJ+OCErL7b?=
 =?us-ascii?Q?1Bz8CeLltOFkFkwSEdfJSdQNvTtzec2lmyy3JfZtTTnI0jdnJHuo7xcB9lya?=
 =?us-ascii?Q?CzKA63JNvNwX4EphG7iEDexgp3hWhuwci0foGFDh46GImVzgVmmn4U7LD6pG?=
 =?us-ascii?Q?+N62WMPosqiTOpcJxwndE/GTPFBgghpbPsAjWyGioZf9PDHfqlq1wyMGOjq5?=
 =?us-ascii?Q?itpRTTSBCfWixLf+SYdB5gnV6/FDQMZt4wDlOxFLTabrsYqJXFF4I7ToYl49?=
 =?us-ascii?Q?oSlWmYqLLYO1SqE74UgTnNjfd1rVr7fCva1qh8/O69zDJMMayptvpxMxoh43?=
 =?us-ascii?Q?VnnQTGmP/9m8jfZCwHabT5O74TOboDAwH6yUPfWxhm4Y7WU5I6H+ZJy/QUG2?=
 =?us-ascii?Q?+9pVi8PPLVeMwYqnI13SLnH7NS96vT4fvVHBkDhmXTXApnjYJCCKem7jCSV/?=
 =?us-ascii?Q?0LMAvY77BJ2iYJBqjMF24fKkufDZkkrr4k1/nDu+3hZqNyoy5sy7pMhVhpj7?=
 =?us-ascii?Q?xH89mNFqLd/HkSROqC2SngE0PyNGTNoHXUhrCiClt6w6HbIxuc1tR5sXbZuw?=
 =?us-ascii?Q?GGa1HICIV6pAb7JLmmJ7pI0vcSvsfYFuOhrjt/cZ548VsXbcEJhNV3Ya5q5o?=
 =?us-ascii?Q?Uh1/noyoBMegGw+EyjDwdt1eOkKvIdtH9RAWAAKehBCE/h5UdKb4okql7XPK?=
 =?us-ascii?Q?11ooLY3y0aoxpbI1mSAEhBfRhxQOQXSvLEoz/5E/LgLxidprxfgEATE5esCy?=
 =?us-ascii?Q?/kALZSIjQ3JGGcA8oyWfdPCrlg30fJyadKPYjS006jCtxXAZjTTedkToAGEg?=
 =?us-ascii?Q?YCNeOWevD6pczDcYplmOIWYk6J5HmSZ31BPBXBhz+un9qZu1Lb7ETRNF/6l9?=
 =?us-ascii?Q?rRN8MGhbGKNGJ2IUQxvxhZ7L9TpjdpZ1MHraXOhHAVulYszbEI6tj+Hmiq8M?=
 =?us-ascii?Q?ia006lQlh6M5NGsWY0g2o1h+env/SXI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933698ad-3e55-494f-bb0a-08da4ae20c80
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:35.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8NsmHTSz/akG+JkDSQlftTM5u7mlSl3thI8dX3s429BRhSY+ibDv36Q1XwxSdii+JCuFNuAR8viJas7k6UMug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

Add access to redundant flag.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e86dff4272d5..66cb9d6051e1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -125,6 +125,9 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 		if (mptcp_sched_find(usched->name))
 			return -EEXIST;
 		return 1;
+	case offsetof(struct mptcp_sched_ops, redundant):
+		sched->redundant = usched->redundant;
+		return 1;
 	}
 
 	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
-- 
2.35.3

