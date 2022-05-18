Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD71852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDer4OqOAnhFLKe6qZkMc2yuzSwSKgMjXWqfcXB39rE=;
	b=gDC98QHaoq6SVUdRjW1N2/p4jEsMnRJxSCa97R92Yj5893DBMiKu5/p7cAjl1ekkps70Nr
	BtEW/M0G4C1RKwfIC/D17bNjh6j0svjeR8IcPxk2SjmF1Br/huDWVDXmJsf0/EqH18RW/1
	D2ozmiXchslXd4JN74EslQMz+M+RAKQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-noPZp3f_NzOY1o_dnQVL_Q-1; Wed, 18 May 2022 08:11:04 +0200
X-MC-Unique: noPZp3f_NzOY1o_dnQVL_Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNl3vEn7GmshZfra9+0EnOvQpqaCO43fbOUckxZxLKu2XzqyZLT/y3zU8cXhS0FAFODbupuk7+6OpGtwfywM+YuM4y68tkY3JJBowDrOKuIo67wVK78MDXA2/PS+zljtxKxlJc31RVDlU4H4HWQRAWuUHa7dCdknZQXHh80iyfpvSpldMWt5uHWMzS2Y/9DvnaBgE7eC3Q/JkZpNxugnC/ZeDur6UfP383jBLu0wVA7U2K77zQrzDyTQ3pL1TjCFaY1AI31xJAN0FoEMYW2CoJQRhp7CZLrZwd0WbUYN28pq0gUf6ZkOCurNGs3yyVAMZIE3DNQXVAA/NDR8OGqZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGPqsItZ23w38NKVcVgJeRqxVq3mbEJKY4hYVDAJVbI=;
 b=Gq6RPteGEZ277z22ju0/9jnBA8DZbYub9QgszQhQq2OyKKJg0snTi261Gak4WgY9Dyw1ptE6/g/eT3wBw71NTENlCa+a1imRqXXE2TrDrvLSqJsm3NC9AWXofMeoIlpKnX6qJNyckmPYKHFyOEMxuA7Ti1zhaygDrMXKwRMReTZWoUlWiArr2dBU1WLkJMeZzU3k9UfcRduLa0Jnjw1tt3Mh6Lp6lejBVvfv0bwd34F7TNSXY9sUX1w/imrIFaKaASI/Wfq8VJtGJsxbVZiExn0oVRXWb+vV3tFlLoS9t3rA52LHJSQMN52z33NMH86oWQhgSRLEBL3tDM271zwDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:11:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/17] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
Date: Wed, 18 May 2022 14:10:39 +0800
Message-ID: <9128762ee54d7f8f5755067bbdd7511e1ead1f1a.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0682c465-b0dc-4d4e-1789-08da3895303b
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB825673B415D65D2A2F25856AF8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jRk3tFrDovRWlrzDa7FgAvri+ibu370dR9G+B4p+AVVSk797Ki9bH/ah7c+wyVzWBiAi/44S9RD31JLM/W1hXCbIQtVbkCbOy5VW5vcfkavJVl0IEgyOopE3lw9TeboXmBtBJA1pdwQeFa6n9tmlZW1x513GzIOdiLseETUfGJNv8IusaIq0MjD3bs6J5T51LDJ9bmnXSD8oKAkQNvkzEyqM9ndisbudkeuspQ5F3aSe2Wa5rTYFH7B5FhZdtLVdVpLaKL3/WipK3oZrirrcgzWcQVM3tDmHnW6Z0rakn1pt88a38pWP41gyW7mJp2CLHNC0NKdl/YPFZ3BFusCWSS4HAARibk6V+fc3H18CQxo4kTqTLQaflaiOvr/OGKRoxGa3LXXtIOD830dLGBOaSTrV0P5ZZWKWq/VnqnynEZVQLY2zoXif9rS7N+wfwlSpwJ/GbCijpoSJcetMa9mcb3B9BjAipefquYZaZPzjEtEu6n1vlNh5C6GEzLMd03olGDRHMWZLPaAy244OHEZREKAVHGIIAYO7ZBxCYbAUPPzeNNpt9keDU9cKuX97K8PJlNERAWNeKCGuFSMlmEIn6jlWHAxf2czeC/ARnl6lvnENlj0/B2NGLb1Rmvb1f+cW+G/uoPKISLCOmIRKBuDzQs0L/6cEfIUKNR2iJxf+gLYXx1NjlGG9joMUL6kXOSEblAOqj/FV0Ba+v175G2Fi8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(6666004)(2906002)(66476007)(107886003)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(508600001)(8936002)(38100700002)(4744005)(5660300002)(44832011)(86362001)(2616005)(83380400001)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHvkIXZgP3Lo0J4UadTmn+uE4+JaPsp+20372U3u+ffv4pGecW0G1Ngk85jl?=
 =?us-ascii?Q?/N1qqj5VbHN3SFSjcPkk1g6NM4sNzF5Xdx1PCNHHZ9TqLE0mBB1NP6lqMGpw?=
 =?us-ascii?Q?X7+ES9dRR2q1A3F9tXv0Fleh0E0BjHs3J1DBcgZ1rcu7iXyF/onUXe4kftcu?=
 =?us-ascii?Q?X4M+po+24iW6dbDTCZaNmyqGO4k22P0nDpMfX/xusFRL9zFC9jaT8CDTkOWi?=
 =?us-ascii?Q?M1eugEABP+7URjt2xtBrTlqPVA4qkEaItAtbJMGXYZAdXI+B6Opjcm3nWz45?=
 =?us-ascii?Q?uxVPT/RB4MlzPuch9ln5JnZGJiMZfktCCEOZM9RrnRwcGgxwyJxPIeQ8ygmr?=
 =?us-ascii?Q?6xLWZAI+QQZiwiuQkEIGRNyq1LaQGygRd/m4STiWL5mcNn9X+XLp0eAoC0Yo?=
 =?us-ascii?Q?goJID+Z21SpWwHcQCUpr0iIXfxuzTJvKQWmT24m6RPzC10snI11brm8sEWNI?=
 =?us-ascii?Q?t0BXE26DaLCFqEfMd8NsFIIp7RlhfViM7tV4Q8N1pEcrkqPI6f/H0dPhautc?=
 =?us-ascii?Q?acZ/IENUjfHe+6xgnIRRUsqe+jMs0EqySGZTj7KK1X8knH5QMYJ6rrnzhU9D?=
 =?us-ascii?Q?8UpjHj3wWxYfxOx9bd6MFC63PmEtGE6rzibOM/MCMWPLGNm62ciBqsOKBJE6?=
 =?us-ascii?Q?ngS112dm/8gZOBsIoXee9CSNYI7kAEJERcEg0YK+MGLrVTY7GfMMgfVW0bTA?=
 =?us-ascii?Q?dapsPln+GyMHV3BXUK7JTMvyChffU4BzPVo1L46NUzU/lBx3Ho2GvTBS+BsB?=
 =?us-ascii?Q?c4L3qnuFgyWAuKYucqJrovbMUIJSvppZihOIgbK9/LwN1jbJgN6pBQ7oc6Ri?=
 =?us-ascii?Q?ps3ecvjCOfnIBe0EYgZEjEbdcVBtz6Kp0NNWjpWTNmpbO4mWNLKisHO8mk6E?=
 =?us-ascii?Q?KJjdq5eQpUolE+Ndaisinx2oiP5v5WYW472OH75wmr+CQBziHoN3mo0gfzao?=
 =?us-ascii?Q?khx8bpRX7zD9EoPMpbVmM8tLvIIUNIXnddYtx9M4j+0FXfXL4dqBUueMUkk2?=
 =?us-ascii?Q?ivbqLKmXL5iFKkRXXYVaw0oB4H9pWzu0aGyVg7F1aitVUSMx9Eq5feiQbN2s?=
 =?us-ascii?Q?MA5hjB0YAuWs5/7EMI7aTDkvgoWBFIgIJp/ayb6BMFy+XKpyk+0nMIFCc4vd?=
 =?us-ascii?Q?SNPuZ3oJ0L6eK16T2/KXjVOXvtyW4T8+9/qYe3dm2m7UI6oTj/A73ffgrIkw?=
 =?us-ascii?Q?D/aMAEwiPZPRJ495MKNGWB+Wmv6jiZajB2A1QyZk5tF2exFgCmiik7ahsmHG?=
 =?us-ascii?Q?9AIiYBecEHgDfBj54lAyr/q8YKw2EMPoc70Xnl9jOzhFe+7NXYK8H3rFfcJE?=
 =?us-ascii?Q?7L/q6vq47uGzse2h/de8kxDigCZ/lydznTOlgseWeaXcw3+NhgGhpfwUXcxL?=
 =?us-ascii?Q?8qku9P01x6Tr424tChuQZbgZhhRQNNetkw34keV5Oh8x/maODex3ajWjqf0J?=
 =?us-ascii?Q?2sEw/lRWU+B+woM4m12Yj9bzS1ohx8RvV40k4GMPq4E3aP3aSMrIEDyx5fYV?=
 =?us-ascii?Q?NQoBDzRiJn6MneeL5LZyZ1tchdF/CRwNiCP+zv0AQz8jdYoYOTlSZ39pr4kr?=
 =?us-ascii?Q?Ub5oTP1PqzavMoWySp1aiy/Qurwk3KOaGUg/+VrbAL5u7KBDImDnT60BdEvj?=
 =?us-ascii?Q?mpR6Le5c0iCZnDSXNEkMlX6pGL4S70P2PY4MPVe6thbuZsTo3VDvwPjzttxv?=
 =?us-ascii?Q?22061QFtn2pCSn7jkOxznGGAMBo7l9gJOO/6PovEgAOhbfsLGMl8FNly/izu?=
 =?us-ascii?Q?7qH9p964AYlmoAvq2A1yEP3P7itGjII=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0682c465-b0dc-4d4e-1789-08da3895303b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:03.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cxturAXik1RoWLsOlzufpGLk2qhLsfBlLyazXK75ECDRyGhkAkRIsSJdnv/ygKXhzoE+JQQ28lhK6qGUcp5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Move macro MPTCPOPT_HMAC_LEN definition from net/mptcp/protocol.h to
include/net/mptcp.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 3 ++-
 net/mptcp/protocol.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d4ec894ce67b..4713757e36c1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -39,6 +39,7 @@ struct mptcp_ext {
 			infinite_map:1;
 };
=20
+#define MPTCPOPT_HMAC_LEN	20
 #define MPTCP_RM_IDS_MAX	8
=20
 struct mptcp_rm_list {
@@ -89,7 +90,7 @@ struct mptcp_out_options {
 			u32 nonce;
 			u32 token;
 			u64 thmac;
-			u8 hmac[20];
+			u8 hmac[MPTCPOPT_HMAC_LEN];
 		};
 	};
 #endif
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 200f89f6d62f..8f03775a2f22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -83,7 +83,6 @@
=20
 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
-#define MPTCPOPT_HMAC_LEN	20
 #define MPTCPOPT_THMAC_LEN	8
=20
 /* MPTCP MP_CAPABLE flags */
--=20
2.34.1

