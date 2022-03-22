Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD5A31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grcdMS2N7Pp41aFBDIXXHigkqVAfXMeFh1AWipxkJaw=;
	b=WrObP3+6LeVSZi4VHP93gI9VwRRQWFwM0A3T20aekE5ppxa3GFZhs22i6etU3Ue/er8bxm
	YhF4h8FTtuu+IGAAdSJLmYGSwFzjcbbp1H42+ApUYFnqyxLEfrZ9vZRmPvS3yQdw8xZBeM
	K+TGXnHYeMcqkWx5k/6iKGYpP9tkMT0=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-fj5OvCbgNZq-U_kqvYHS1g-1; Tue, 22 Mar 2022 10:53:36 +0100
X-MC-Unique: fj5OvCbgNZq-U_kqvYHS1g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMloC4O+ikEG2BYY4ntKcYY6rS7l04j7WmchLoGyQ0gc9wISBRYwydqkfw/CjK0zkW7h9bzHUoeKThEN3KakNnIaVqp1AnqmZLaCkSkS8z9tXkbQ/g+cig0DCc1Df3IT5GEH1hgqguWK4VEpL6yH7mRS72x70pngNLe7MH5/LDWEeYpycdyVrPbV/mmkphpQx1oNtsdovOfpl7ppbjzfESy1sWNyHqKIRoNUDR0YS4jfwD0h93cWvr79P2GZB34kQFEWlhWPt4A38OAUXLyAX5CLz3N3Y69HzYi9cHfuoZ3oGX3B4DsF/LoWdxC7gfPx1kEWQG7iH9iRPciiHwjieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/G/QSFKdupfUOdH3RmTK+MYz4usRE5bHtUGSTosJdQ=;
 b=oPueoanzCdIxMpiBSekbUij5BuCwW4bnyAB3RPitgyuSpZBzIeLUC3lHCOtDlzUHJ/uGQVLIF05EHbm0FVnJ74Cxna3zMzoeOXsPU3vZcSgcUhYx8RpWm6nJ8fTDw8vE2jY9e1vQSHEIRPGQUl62RMb75W9fAa1biFDkV1GxokaE4VLZ2STS601DBDsaapDuXQYwLRcMsY74dlU0lBs7/JN6uX1EpsLtSK7087a1hGutVRKKQG2U7fQAIiWsPYIPkvAWLJkcRLpJ6qhBr189dwSBc7JchQvKeixz+A87WvnVr6Kn7NSdk/2LyftL7y2EDF/t1rPnErea8jGpwoCigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Tue, 22 Mar 2022 17:52:41 +0800
Message-ID: <faa5349e674c53eea3fa140442c7bca5ae25f64e.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41049ccd-7633-4bd0-2291-08da0be9d501
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2282E1057C54D10D36F1B938F8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r8vPYz0MmAFgr3EH3zjTUfZStyl9Nrk2bBQfPTCR2PgyBMzzsGjxccdWsuqcxBrICOiW2CUCF1nmg2LcC3gfKmFDvYjm5ruqfslQXlIRGaE0Pt3xsbmPXepWf37ZKONf39YAnHH/+XtXWCuZoSRxOul9xLSukiU1SnAVQmAiCyUTxJIrTuBJo+8c0PDptq7N+6Fa960hCeKiPlBFYrpZaCNMocP+8cChiidm46oXcBoOYCHCbPtoko5dxTbUixYTRuy+YR5A2NDJ06E9Y208PajgSeWN5tsVkcyw6p4Ege5wmRpqvx5JoBi1zxiuzx0qPY2G12VvG+rBd76JhDMRgzK0Uy3orYsaPV6AGzkrrd+koiNXaHsO/SBSkZ+VAsFNYB34bkkCh6RJOTLrbOO0UFflQQh22fJ1CUCTr9wtB968lahc6FcoFXY5MuIXN7i2iM6A+AdogawqrcJPHDRsGixjpsSHbTyGnpr48zZi5C9xPug1pC+YSdGrQH6f5WCbaVx1IV9e7uDJfbefLcEUGDreUWBnN4s3VQTFi6ximG763//nqBOePqOCyN0RIw7ChX00rWk6WadARjBjFi6ZYjiB4bpbslArsrpZqakfbOobPRivD5GQhu5+ayUWANQPutB77LllanYN7ar3483lwSd6PL6+9zaOLp6Q9Cxg1iDEw38CBwxCKPPZfcAPC3K3/mJDMtiFCgPhydgfngUvYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RC4l28XJGMnKi5szm+EL1JqLuvTpsPYhkh8Q1QoVULMFNO2ONB4e2eOkkINb?=
 =?us-ascii?Q?3dLMagTR33vNe9XonIyw2J+GPepDg9+h661vaP/EC+0cqs+4NouUhoRVIRit?=
 =?us-ascii?Q?dd2nj6ygjFs5wEC5cN6n49bPMHbEyZ7TegzTQ0QP1JoOUBx2wE+5cf38ml47?=
 =?us-ascii?Q?AGShgj44jTOIQHaO4pFSjIAmKQOJExXeIBf6kZuBOn9NEAui2jidh0WXQg9G?=
 =?us-ascii?Q?PiGNtS+VW9bOfqLpWYQXoUVZ/xDvIILJm3luADubP/Kfw1h8R6rK+9eiaTT3?=
 =?us-ascii?Q?2wzim5SJzBynIdioFMUswII1jybddUW5mNPI2dr4QHIoKW1FnIJIW2WK3+GH?=
 =?us-ascii?Q?dYWjFAFFFqh7yBBxPQLR3wX5+r42j5CcCf7kWo4JYxy81o2j1X6pgd4CsiUY?=
 =?us-ascii?Q?3py/XkxUbIdaSB2b2/gO33Jpd1BTx5jvZah2MFoF1tcg8PKyEf1aZ/v0bbzF?=
 =?us-ascii?Q?uyv8bnUAwNM8LrZ0i0QPGuXXTgS/zWBs2jMjY+/cyPdHuj86MVb7BPZ26gIO?=
 =?us-ascii?Q?rhMNwtXUfbM+uQWm3T2hW0MnYdDg/Ts14KBbNTdF58SFY/XQC18kOqXXDOY0?=
 =?us-ascii?Q?g6oLZP90xcKKPL7S4g+bGHEHorWgdpopDDoAbsZpt4Vr0v4qQcbLP7hqiXY1?=
 =?us-ascii?Q?URH5z4zCm3ueCUa7MaxFOP5w2c0PYZRLJ8JASoL1rlcuVlduNlmVkw4Ug6q0?=
 =?us-ascii?Q?JTQcYyVWlK0KymND9aHUNCzZHiatW+itWpCR+GtMAlKNH4hlcnm46s76KloZ?=
 =?us-ascii?Q?dSPXJ0CYp8CuC5gs9DY/Tz9b7ncUGNM7QKa+6Cdt18xd6WSgrlFQOqZrEkPT?=
 =?us-ascii?Q?srWRa9bYWwmTl8djA79K+l2cui/wuPiP7mDIjGn4ncqv4sBrsl4AHMPeDD6N?=
 =?us-ascii?Q?tq4AL2H3oSwVSd0dD23qX42nxZOIh5hI/FtLnEwJB+I1EBwL7Dl25VsUd0Ag?=
 =?us-ascii?Q?0ZsvI8H3JBO2KuDNhFFg2uTw9gAMsAxcSsGxRCz5mZjfXOxX7jOVk8PJd7Xx?=
 =?us-ascii?Q?voylgQJ3EaoTIOykbAWUxrn9qSWqCSBfHjqCuHnR+nOLpWAtlOo8EYM4+jun?=
 =?us-ascii?Q?kr2yoft/+lpkQ9VTjl0Qb30cXkP+B5awAfqH8tygnQUj1wvl9u0f1UxI0B2H?=
 =?us-ascii?Q?nK3nk77AQIlUEY7SaaCsw95E3VbyBj2XbUm6ARAaEIY3d86IjKawee8bWx26?=
 =?us-ascii?Q?gWQ+x6dysxvMF/cj1HHZdik1dJULrkWvVk9lBRHZlXtrn2UcPNidVrXjVXlr?=
 =?us-ascii?Q?GI/xPKQimYgpALs6LEa0mTz98FK/XJWW60N8NqrgGQQtxM9lx/EzUIQmfOBR?=
 =?us-ascii?Q?kDkOLkojrKjXOFZGHKvcM/cIyJeA3jCmhC5d9KLBE/lgWxVdtLOxCr/e+M7A?=
 =?us-ascii?Q?G5471BvH0N3srF4YoEbJwdouw9y/7YDcHenptVBbctWSQD79oTk6CmK0UW1b?=
 =?us-ascii?Q?x8sp1RP2cU24fz3HfmR2mNOmG4U1mwu1WOtugkhrkhrkOcFm4yqSWA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41049ccd-7633-4bd0-2291-08da0be9d501
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:35.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bdLQlc+4XM2veBSX9YzwbWO2PF8ZEo8b6ROAOtsRmjr07ennGP7lqw+tFrZEWdBbjCbaWwyJ+/7yJImTBDeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

This patch implemented a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the mptcp scheduler in .reg and .unreg.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 ++
 net/mptcp/bpf.c                   | 102 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_=
types.h
index 5678a9ddf817..5a6b0c0d8d3d 100644
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ b/kernel/bpf/bpf_struct_ops_types.h
@@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
 #ifdef CONFIG_INET
 #include <net/tcp.h>
 BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
+#ifdef CONFIG_MPTCP
+#include <net/mptcp.h>
+BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
+#endif
 #endif
 #endif
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index da79dae559b2..5f7f9d30ecd4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -8,8 +8,110 @@
  */
=20
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
 #include "protocol.h"
=20
+extern struct bpf_struct_ops bpf_mptcp_sched_ops;
+extern struct btf *btf_vmlinux;
+
+static u32 optional_ops[] =3D {
+	offsetof(struct mptcp_sched_ops, init),
+	offsetof(struct mptcp_sched_ops, release),
+	offsetof(struct mptcp_sched_ops, get_subflow),
+};
+
+static const struct bpf_func_proto *
+bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
+			       const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id);
+}
+
+static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
+	.get_func_proto		=3D bpf_mptcp_sched_get_func_proto,
+	.is_valid_access	=3D btf_ctx_access,
+	.btf_struct_access	=3D btf_struct_access,
+};
+
+static int bpf_mptcp_sched_reg(void *kdata)
+{
+	return mptcp_register_scheduler(kdata);
+}
+
+static void bpf_mptcp_sched_unreg(void *kdata)
+{
+	mptcp_unregister_scheduler(kdata);
+}
+
+static int bpf_mptcp_sched_check_member(const struct btf_type *t,
+					const struct btf_member *member)
+{
+	return 0;
+}
+
+static bool is_optional(u32 member_offset)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(optional_ops); i++) {
+		if (member_offset =3D=3D optional_ops[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int bpf_mptcp_sched_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	const struct mptcp_sched_ops *usched;
+	struct mptcp_sched_ops *sched;
+	int prog_fd;
+	u32 moff;
+
+	usched =3D (const struct mptcp_sched_ops *)udata;
+	sched =3D (struct mptcp_sched_ops *)kdata;
+
+	moff =3D __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct mptcp_sched_ops, name):
+		if (bpf_obj_name_cpy(sched->name, usched->name,
+				     sizeof(sched->name)) <=3D 0)
+			return -EINVAL;
+		if (mptcp_sched_find(usched->name))
+			return -EEXIST;
+		return 1;
+	}
+
+	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
+		return 0;
+
+	/* Ensure bpf_prog is provided for compulsory func ptr */
+	prog_fd =3D (int)(*(unsigned long *)(udata + moff));
+	if (!prog_fd && !is_optional(moff))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bpf_mptcp_sched_init(struct btf *btf)
+{
+	return 0;
+}
+
+struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
+	.verifier_ops	=3D &bpf_mptcp_sched_verifier_ops,
+	.reg		=3D bpf_mptcp_sched_reg,
+	.unreg		=3D bpf_mptcp_sched_unreg,
+	.check_member	=3D bpf_mptcp_sched_check_member,
+	.init_member	=3D bpf_mptcp_sched_init_member,
+	.init		=3D bpf_mptcp_sched_init,
+	.name		=3D "mptcp_sched_ops",
+};
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
--=20
2.34.1

