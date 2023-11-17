Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA063DF63
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TzvQlmgd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ1lcVfCreEzt5GecDPMN6QqmgsttI6AYvzObGZGRp70Efn75/GGW9w7POpSNIn1dSRqFkx0G+8K0YZO0iPA2E6kq6xon+Ug4DgyPdjDj4fQPxo7PcRpb6pbX+h8ojFUlfRYWLbq5jIwZdh2ZRszKZo4ozks/Cm1K3ozAQCkSZUoHTHDOHeTnZsHIZPaQ0WAGHaW2KP1vVbERNmF3alajnPQlU7HRk+fD3gQrUnaNj25iQDkMokyl9cvheLNTRKJ22hl9wTFEerQGe/JR+g/kruNu3v6S7nrkY0gECE3wD3o4cH7A2ORXy/QIMxc1Ly6mvS2TrMlLgZ3Swqk+1MTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pRRG/uzx20UZku1L2KN/kSoExoO4ddINXf4XvewjAA=;
 b=j39FgEVHQLjeZu0HL8MzU+ssfPhc4yQd1X+fC3tcGCLnNsJQd/xpz7iRkfT4IHjutzcZg3dbcIAw3Z8D7vmVy+quqwY/lGCQ9hnBZDvgItkbiAH6rCFCKRcw+lCo1+tj56l4raoZMwz3ILsdLdj4+XPoXwSCMcpQcAWI6f1Glv4n64+67jh214edg5YwHJUZ6HuhrEQXRLywawT/3Gklso7Ml7z6u3kv/NSXVC6ZvLtViJLW+iOijzSA9hqe7W56SFdB5uMb+HhssuYMXx/gsFPndZ+GoZpJ4EBU/E/2J3OCAA8LJO5OAY814uarOo4dQti4b70Mv134BFvTK7GxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pRRG/uzx20UZku1L2KN/kSoExoO4ddINXf4XvewjAA=;
 b=TzvQlmgd7NaLezRwVIAmvxI3rOTiFkxwEgGkWCf5dEG8MW9303XyHj5zj81ZOHwqNxSC+kHpkQ41m8sdBoV8dUrVtCuKqxQ6//dt1Y1sMsmU6HiqcikGMzrT59hiWBDZ50CM4FK6EPUVZ0M6aOD059O6W24XFG5E7LU9yb5N/NQXkkACYA2zLYxF/IbGO96CbuGc21bOQ276jt2rWNltnc9d0GB6eXSlmRslV9hYmKQ1uZ7kKGcKhBbM+TDjb5WTYaP+I59DYESTHW4ew/cGM08MorAMOQsTOfjeu+UbhUQmOX/N/g9NROCtB9B/S4X31n2BfvljIajZGAn3VatmIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 24/26] mptcp: dup an entry when removing it
Date: Fri, 17 Nov 2023 16:56:17 +0800
Message-Id: <8c381648a3b4a5c65e539d7c2b462aa9e8e51be4.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da6def8-cf42-4a32-b3d4-08dbe74b6ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pf4WOFerLpIjw4Ac6G5S0Yy1TBeNbZLRSm31IyNKzfalcmYoIrCHxfm6+c4tbqLJXGl3DpkR8ZzZOWRDcEUVPEAAsJvkpdIThWAGzLsnCpXU55j0wW+W9PwGdP4YCyKte0nJKXeBdX+Jo9MxWNLLS2NEM6ntCCu3MzTVBRrrK0KIQDJkhOJ922pT44KLogocfrMdaEQkX1CXNUVRMMldAME9FmOF2V5H3YvfqrK4LU6+kwB2DoUKDcbWyW98f1P2nG8nhNYB057Zru4WHC7MfvTwtqCJuaMN/0jB20xcjEiAN+2YZZtiVC5jrmDTv8RVcU+5E3iJTFJNEo3czvBuqTY86TptmFDCHGHhS9MtTki+OzCYFpY3wwQwuMYhewQaCJG5ZknsoKkCyAXSrbmWSv1+QGyX7BodjnK6H4Wc7gOolXjTo8qzOQou1/KoTyQ4K9+hy/ip2pmgmR3ecBGoIbQmGybgPBKqEQPRmPgp/3Ftw3G2X/6m7F44N3vcbpXHsfTqDrBznBrR+6Z+WTL7GgvoZq7I6FUXKORT4+Lf2oo++PAAd11sltQbAME0a8WL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(107886003)(66476007)(6506007)(6666004)(6486002)(2616005)(6512007)(4326008)(8936002)(44832011)(5660300002)(8676002)(2906002)(26005)(83380400001)(4744005)(41300700001)(316002)(478600001)(6916009)(66946007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmh3r2meM/GDxYf2AneM/zz/guDBvcFH0+GPUZIBTkJcL467cNuDACrYhuIS?=
 =?us-ascii?Q?Wzyx86UuL5fkJg483+JnAtBIEJ8XHHm0QS8FcEMm8ozIpkEMLQQ/ajAQohla?=
 =?us-ascii?Q?g4Y8LBaBVZvvOCaLhY4plIuwDBkzdoog7/XVcjL61V/h/YSHecW/caebj6Fb?=
 =?us-ascii?Q?rTM88AFqKJ5VIK9AwziwQkYclQc1da//PxxOIZMKXN4d44B5XEYLqVado4E7?=
 =?us-ascii?Q?ftR1FVf8Q6fTECRe/LlMMpgLiSpI1YxqLUmWz4eUdSaSd6Am0Rxiu7rytA4b?=
 =?us-ascii?Q?+qiLVrEBVSVGLfd0SRvKQi4pA7+ULjZCkhFIukthouFZpXRprrIGVaEXdOTe?=
 =?us-ascii?Q?+1K+U92EEiYLb6cy2SFzeiZubBDyKJPIKpzD9C701nIZHbpBF+/Tt9jMHrPe?=
 =?us-ascii?Q?MF/4CaLvTyZOH9cOmXdzcH6Zz6LqLsZY0Ut0Wu4bonvzBDVopp1opAW6TJmw?=
 =?us-ascii?Q?78Z5JEoarlpWTyjs+F2AcC5cpG7t6iTlNbAyVUuJrwBfr3Ut79WU+EGjv72G?=
 =?us-ascii?Q?9w74fzZ5vSL8WDw/Ynr5mbGOoYawuDJuo7ZWYbRx1dKJenoiPGkm4wAzw5aO?=
 =?us-ascii?Q?pZHKI7qYhRC2cyHBbmAM9urNG5f/HP7iD3KSAbq/wcoYBSJLUBXCQWHI2Jc4?=
 =?us-ascii?Q?wIcclY14Pc3eK2BqFM1DxnQIi3pvsVp5lA6AwCDBNnBgUIuoy5Vjy+p5tafs?=
 =?us-ascii?Q?Am7lMNE4fWG4k9pcVc09q7ifMOQm3qepDROMwUPqwn94dP6ByIZDIWP8YCwL?=
 =?us-ascii?Q?m+mFhxMjTBLU3ls+MimoIhCQ9LV1+WVrQxb/ZaAcm/xrex13tCRcaicV2LIo?=
 =?us-ascii?Q?la9Ontxp50KUFEsDHH/wdQ+EH9YWVrlCHrf188De2sG05jjNIbGtNrVksP8w?=
 =?us-ascii?Q?RI1LJneqXAJKQhej+HD+wMv1M0QPVKIcszTz2DIVWcs45dLL+1SCxG5Hgof4?=
 =?us-ascii?Q?1Toe0Z+kVGll+ftdKTHmHeROIk/1gaTCa9ZF0F4reksxWPvtBJVc85DKtvri?=
 =?us-ascii?Q?v7paL5aBRrJmyI1N+ekO1c3BEyhxEz/Dx99TUPUNOE5s3dGk2GvV0+Ea18Tu?=
 =?us-ascii?Q?orKL52m14dljqajmRyLX5TYvcjh8FMozMb1pXFAwrXUX3Gyn+3c5+kI9W6Xh?=
 =?us-ascii?Q?NMA40RhCoxbUVnBg30K7eZdIkKUSPDTip/4ZI+Og6qeFBDYz9Qc1vCI6Y/tk?=
 =?us-ascii?Q?n/CtxGEpXJEyhN+qQCG6jIuYdQ4X0KQkB7H2+yFN3EJ+IeZ7caNWQIhQqEMr?=
 =?us-ascii?Q?fZZEZ/dZfJ376ZEuVflIU7hvysFBsWFN/QK6GwXe5CO26B9WiUWo2yInOU88?=
 =?us-ascii?Q?cZQCwwj+QBbHlMKvi88mGG7wZfyp3kY3MJWeOKYEwI2WfmnkjBbCNX2Rwpeo?=
 =?us-ascii?Q?0MioQqxcRXZjfIkORu4r1zAbYQe1n7jQ6QT5v118EPxmUSFds9TFTznCUGpM?=
 =?us-ascii?Q?F6YOuOi752+qX9zwiugYGtWAGAlkWt8Myy8nVzuDAgXQjUvWmoFpEbAXvaPP?=
 =?us-ascii?Q?q+XotNbI8+3sv9ENPosIsNMUE9c7/6lTcYvMWmZMOswf8a+9NhEm5oSJHQL3?=
 =?us-ascii?Q?tFed3o7j7yGWIRfHhHnczjdnfSAHCs5nQXvA2wsLMpkGpjl0CfvGg1GpYXQs?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da6def8-cf42-4a32-b3d4-08dbe74b6ab2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:50.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZwAvBftKjPsR/CWSZnJ0RLnQCj1goyCVIsZqJbeSOCuW20qtJdC0Rr7jnvyZKIc53M77y3+N6oGjjeSFlXQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

In some cases, the address entry doesn't need to be freed. This patch dups
an entry into the free_list to separate removing an address from freeing
an entry, so that the refcount of address entry can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index af9bd7950fa9..8879792ffa7a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -311,10 +311,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

