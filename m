Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8E7A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui4dhnrb7AUXsVR73s0E8y4J75RdJTeiDSqWv6aDrIA=;
	b=TjBnrsY5OLivWpQaNOtwFz7Qln8BxKDocA552yr/goadcRHHVphGTi+9GY8sRoZUTN/0tg
	D0mWEJSDXPsRpGapkMYuct62RJvhGhs+wWIe5yX8xYeig9G9C/XpP51bvW8kn7fEi3BDKv
	t9X7F5lu4/X8M6svPL0cJWrcvzUJyXI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-O7PJFss2P6ySoDAPGn3hkw-1; Wed, 20 Apr 2022 06:57:12 +0200
X-MC-Unique: O7PJFss2P6ySoDAPGn3hkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRpoKSQKJLJF2GHgbUPOMkO0PpjlTihvHvylzKxucjGf8yh9QvghatrpTeOPEsEnNu7HZOaN+WJp0ciiKRlSQktOl2NXRUDxs4zVrYGzYTCe6S9/xErJivpttU18KhXvnmYKgz5aahhawt78hBr2FiGbHDWiX+yFKV7PlPvEdoKUJuZMad/MGZu6corZe0uD1t3BkwDSI3dJL6Hm0QEZboLlcrpflWhoBlAC7Cx85LydC0OfIl/2ioT23h9xhUIueU9UypLSQBf3IftFn+AqW16pw033cl1biTlXCAlb2SRKfKzAohhm2eoPT8sh/gFZzh6rSYx0eJbursYPqLKoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ59QC0aZwOg7J30AxhyHriPVAK85ta3jIWojdTaQJ0=;
 b=S74d6XiFEW8HNI0e1POkS4b+l7/1MhNhgIiA8U5N22jgRXIj+U6GlajREKhw8nf6ZzK64pcjdIXzct357KW1w4sAYHtjIV7YVgGEPUyZrvo6jrYEnr33AJgXgunL/phm5NHqVpBZ0d7BqthbIY7PoIntGifX7kPZnXuZzp5JQwQs+IxWacg3L2YubpLS568L2b4KmN6RZ/hCcStLX50mu+jNu07E00bKW2UDaZCoETn4wUa0YHx8/Y0D7LrnHlD4Zvsjax1p7CCTdO33oknhJGlCXpo/BAWkfVY2eCVx+4o+LmSWXOitLIcXOX0WWEdAdbzfZ7zqIJbtNN/TbUen5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 02/10] mptcp: register default scheduler
Date: Wed, 20 Apr 2022 12:57:01 +0800
Message-ID: <bc968c3df6a787f0b01b5bd0e4fbd5f78c0fc270.1650430388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf763b8-d0eb-4b6b-12f6-08da228a3ae1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB575230534B5335E232927248F8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wc2VJ1PP/hr99h29J70HEngrMFc1p7cSZm2Iy7dnRaGNHiOfdsP6t+cQl58wfirvNKqm++wY/1330d5+9bctK7nrHy8VUGd/rxmN659EDD81Q4s17JO9iIBwp9eSn7Q9nM2SgexxzWsoS/taAkFrajr7CIrNr67/2SWvq6skj6Ic3SWy9imCV5qD2OcwS5kJmV5R5aHaAFMsHT4Ln7P84couOfTs/pZTSp3J9aB5O92Rsk+KygF/zzF/VwVihcvOxwm5Ok8yBfhFKryafbMKIRzdtaaPNaiFyiKwRt4BOTNCXCbGhEjmn0aEmyaKvCe+6y1uSZvrih9rMu4D7DxH0IfT4UJlCFXoAMzOrpsZTgaJaMDsz6Tx1OjdyyX5Bqb//m92OgXSM2smMmakiGYoL2DMqtFL+B9qJY4V2DxlDCTf12p4obJ6ylMXoXMg0p3/yBQPbEk1oMZR3fHwk0ULq0AM0fBYl3UjAKb43mC7oxzU9jEjKYirZgUb56A1CFtJAKNePJUegnW2pwk70qPuQ0nku0II2v5Jqgl9awi7skaUtWXGFygfWTkGlfcGB1XX6MQBvcbrZeLav171Wig0yGQhSCNm0WNoZgp23ZYFWtDW4fyjq2fyvgG7l2hehFhYkBw6vVr+Qa+r68YjFzE947zrODaVkE+u/iNJ/CQJ/tXcaggxL0toFXTrqMbDP5gI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyonDLN1yoY4E27Ph8F7kly6RNhyW1aPtH3neugmf1t/QvSpyN963lCmyicS?=
 =?us-ascii?Q?SOz9Za5UAs4KlnOI60vZBCTg7zyEfMRN07A7lvK8lkG5ozuZ+qI41X+xGbwL?=
 =?us-ascii?Q?bjTXzd12QrPdZMGOvpQSqkogfNyHOFXzP8dARpxwKN8axdpiHjSCwPitGzcx?=
 =?us-ascii?Q?cl1533Qq0bYEA7RREm8fgYAf4SVE5GS0WsXn9sb3EZ3UuCCIobPLPkRvwWeh?=
 =?us-ascii?Q?1hBoBklsFyDFfzCW+FYvw5kUTFlLEzDWiYQE4LclOP/+u8wBYLsil2L0ywWG?=
 =?us-ascii?Q?FZFiE/woC0XZtVM1ww44Mmp4QrL7SCR9H5saFTo4+uO9qy0T+bnDg8JRjJH0?=
 =?us-ascii?Q?8R0vxYp2jr8Kj6O2PsiiO7uJtTNccdxoImkq0ZVXweQNeBSQhkg2w6nbm7zv?=
 =?us-ascii?Q?ElineZBrZjAcCic6D386rbupNEkyyMM518H6cj09ilgspWXXjVCywo0t8vHB?=
 =?us-ascii?Q?NpLTSveuL1DmxI5lq3eq+PVKZqMpuPBJ066uKspsquiFUCI5HGTEV4xsV3I6?=
 =?us-ascii?Q?G19/sY8NXliLGNEUVKUe86h7DhCTWkwuCd9yoBI46w5pjl5O9CV2/i0Uw3BG?=
 =?us-ascii?Q?OBKphaHyO+hRuOGJqtb+piPsINo/sYhXqJmuLNTEB2yw6jttTQyZ90uvssqC?=
 =?us-ascii?Q?yM/LTXCPreTWwRDpvHRfK1LA2hjAx2PrSji1qLLTRCGaLhDg6SSkIN6AW9xI?=
 =?us-ascii?Q?km834YQYHcdeFMCCTLlv6N70EY4fCF7qfz/3yM0gaMecn2gL8V6v3b5HMcuw?=
 =?us-ascii?Q?kwyP8wy2YSl7FAqaXk5onwxKQq4I43OTnp1mtzli/we1gm000cXDYTGuvDx9?=
 =?us-ascii?Q?5kHDHDhJLUv/6JNqhrgLkc42w5ER2ro/v4e8Kn4pu1GX2QBn7EoxdFkSH5j2?=
 =?us-ascii?Q?KmaoKRrmuwtqZjxDYQe/EgpDCPMJlZ4Zlt7zIu07Ms42GlNZAFFvG19qX88F?=
 =?us-ascii?Q?/Jf3AyhCqFHxjNA4nreF1oCkZTcth6j5w/R8wtQ3Pnno76rWy6AAEUZGsd+g?=
 =?us-ascii?Q?j3d+eCS6zaFgqrphVWL+vOVdUw8xHsPQ2vPcyQ1JkT0Fr3q4nclKKM64J//A?=
 =?us-ascii?Q?AbhWRYFE0KYgwRv/a26ECYBTeJ6epyWiOkAmliF4TmeCJ6dcc7TklqnjG27u?=
 =?us-ascii?Q?hvSAbVaA/VGaT0uHYARB8CBAvhvVHZk7EilGVLx4OqBiWMKDELG7DWtIZXA9?=
 =?us-ascii?Q?Nnsh9aDwNs8e+VoNR1UlhrWCkigzqzgNr5sWI5ghighOq+y6xTuzRgRBj/DF?=
 =?us-ascii?Q?+SmH+gU766gjtLNx7uPSQwqfdp8NZ8vMLTgLwfiyc72v5LK+X81Q1MwJlGlJ?=
 =?us-ascii?Q?u6ibicIRZhsd+mhIRX47NU1rv4BvazFiz6ePKLc0veSq6FMzgFyFMCQlHjm4?=
 =?us-ascii?Q?Cvs8sO7klh8/g8/wlsKs+i+2UmTXsAzHxjMxMGowPJS9a/OrThMCNLrpIumI?=
 =?us-ascii?Q?BA7kV9gNRF1X0CReGoeD5xIaGOCB2yEXgzWVbeqMvcm1Fec26kXDHL0FACRE?=
 =?us-ascii?Q?XMlCfKKeyB45/7MOEMhTC42i8VjXQS2ZpNRIe7+dW5E515dcL9Xox2JBikkV?=
 =?us-ascii?Q?/jIzXGCYeqlNjs08WsaRb39JW/RSb2lX38LNX2CLt+dNl0OAm5jUYYhWmdW6?=
 =?us-ascii?Q?gZl4aeD7nNzbKTOFwDQbrvtQte4uleix95ZNhYcZu6ksHx3r0XYn9oF9/uwE?=
 =?us-ascii?Q?h2sikaqVX1XzlXSuKhKvC1hCXIDpIN+2sOOW+g4TVivFTEFrzJqO9HhR8Nx7?=
 =?us-ascii?Q?wTolfHcN4aWesuR8zvgq3cSMpgCm1OQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf763b8-d0eb-4b6b-12f6-08da228a3ae1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:11.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +83z1qltVrPpYdLgb3t56S1fTHWAgQrEn2Biu8T0lgrnz/zXCKnKgy68c+oLrN9QsclWWbAF1PK5Sdb0sHVNhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 +++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d59bfdd6bbd..8679289a8394 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2251,6 +2251,14 @@ static struct sock *mptcp_subflow_get_retrans(struct=
 mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
=20
+struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool retran=
s)
+{
+	if (retrans)
+		return mptcp_subflow_get_retrans(msk);
+
+	return mptcp_subflow_get_send(msk);
+}
+
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
@@ -3805,6 +3813,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f8739bbf9c..9fd4c689e423 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -624,6 +624,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_get_subflow_default(struct mptcp_sock *msk, bool retran=
s);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..bd0beff8cac8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_get_subflow_default,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

