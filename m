Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25F15AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grcdMS2N7Pp41aFBDIXXHigkqVAfXMeFh1AWipxkJaw=;
	b=Q15UQ//gr4T61RcTGNQXksdMx7cNH3G9utOYvLh3m11dh9dwWju8S9bxbSY6+hK3upNG+I
	qK71gCgFr3Tvl9yZolXDG2W9NsWtPQsYsXfg4FPYwcVEq+5Y/Nri6XgoxaX0DxnRA5IkRe
	NPsIPo+V4nyVlxDlDUd7rJVu8EzleE0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-xnvrtFVZOoWev8cje0soJA-1; Fri, 18 Mar 2022 03:59:04 +0100
X-MC-Unique: xnvrtFVZOoWev8cje0soJA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6ODO38NTL12K/tZuPOZVeLxTJzueiwNrlf0VJ6aNtGmSpHlEvQySB5plCKcL7dt+odbvptqEzYXL5iDqBiS3WjmA/SqcMR8qadsd/MEm+enqUvuixNWVEZvM4YS48ISsPWn25BzZeUH7N1lrWuAkglP8F9TUc1lbbSwj8OqBG/LWIHxGyEL8s4C3GEqAh8TirUwrkFjuUF2s4GdfUsMg9ESpOJhc5an8mDSsKJx5ieZDOlhbIXFKesU+AkSWDuh9PblFXw6pZC1xnCRTHF88HUvTSb7umAjWyZXMeCmT3p47rx4pd03BhRw8x6nz1bsuKXJkYpnozaTTPsj1IGuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/G/QSFKdupfUOdH3RmTK+MYz4usRE5bHtUGSTosJdQ=;
 b=oXZsXNlcUY56R8EFkUiKCpGLtHASS4sxhEKZG6n3htay6EqfgxSGqjz1q/IyZ81jCl9XMxsHDx2raHpRsDMWrTJQGCxfWqR3l0HzjGSfbIP7SSXx+Jomm2XIgEYo3lKb/7wqutp1E62P0i1K3KNllQeMFNOzZJ9hyQxCpeM4FwsuHCt9D+mol1Vs4yJOTifXiHIT7DDUUV5WK2zytZyY/x2PRX/dqXBPlJjf3nDnz+SG9nBGaO0MY+uP3SsX3CgPHQTHFXnotpyqWY6sl0rSBfOvTr6Eoe9e3CmPhWg4dwd+iR13MZCBZS1EemYrLzMhdFmC5kY48Detk6hQQSDwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:59:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:59:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Fri, 18 Mar 2022 10:58:08 +0800
Message-ID: <857cc219d855b207a0061f24ee8623a5bfe1628d.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e6e252-7a4f-41bb-6ff1-08da088b4227
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB83211A5FCC2C4E8BC999FAD0F8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ffpSk0KmMhbxEDueT15gbmHdVE9hJX12/oyACrW2o5lN30vXtZFwg0BK4e+HPsyP0qanc6ZR8LhOiF9jVzsWCevuNMvwcLhNwHwFKrj8yB3xhXN2yc+IXbgdAle8qHgwBJvRODvr63Ebv2Zi3PKCBj+pn+8psTMZG+F5Zhf8KTAev1Zos0fmHH9ttth3bkBD9qyL8i1s9kRff//W/YOLlniEEtC0QbXlgZoFoD4dlPdQN90J6I71sG/nqfomWIUG+4xgL8kVmpDx8uLQOsHpxbMAzk/pg0x/92nhEl9J9SnhmQ3Svf/eZlD1GiidPJlpBmFjjl5AwKBQ64N/EOcj4Mql9gMFWwRfjo9DbJgHOlkJylEJhfO3QAIwqbsx97m65AfjMW775Eu2Bw0MFt3JlLbEncRtRT9AfLdJr4l8ip2APO8GAeHAR23JqtZOclItL7Wt4AgIw6Notvmle5tXyxK2HZIYLgfx544PNa22izzcCIgBJBVP9d+CbJjf3NlIr8DwmpWgh0PZbwC7AW2A1NSS33RwqEoDzYGSUsVGjeLU/zNfwIR/x0ZLweBALKLvfL6QJsl6Uk4cLd0Ckz7/YpG1HZPZUjGr4xCHWqBPU//7yJzoGv0gE5KWA8glU6prgOf3ERgFeJ0bR5eNN9hnjtY2LUbgHRomS5Q3OfFpMGt4lwqLn5VYNyZ+mUbQZe4Y81UM9u7dqo42XlsDBTAeQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(86362001)(44832011)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3sBVvm8MJ9DkYV51YNy9lH5ZrJTjVXcg/WM5LVYcNoRfpgZTreMUxsC/JFUl?=
 =?us-ascii?Q?8eL55Iice3x1OQk36UQRD+vW4JrLeyDu5wsUvOzOFJcG8dzKJkCYacpTgC/C?=
 =?us-ascii?Q?MLgPV6rutiIr7ATDd2eyxy8s1fniGxiIS7+3DC80n7t9u8g7f4K2rVZdht3P?=
 =?us-ascii?Q?NQ5bKIpGf4+5wyeWG5CtSD3Lm4Kkx0HeqUxeQpfQ3OnDNwm+/UmMbDDf+bVz?=
 =?us-ascii?Q?7J2Mz9yRC0YB4nd2v7oxZ3/6Iw5dnXICH1bFJhuoV33DmAl6is1eTQZdltWn?=
 =?us-ascii?Q?Ws3HFoCAZo2CVLNOs7Pgf/UZoUXTe1Rk86j3/7wE1/yDsSioNU6xwcY7Phjx?=
 =?us-ascii?Q?a4AhTB3aZPJv+vZnT1Rxt9X+/E4XNTFxVG5EFYOWEs1IA/LuAn+gYL72onKT?=
 =?us-ascii?Q?Mnymh1Xi+CIc7MpSZt7jYK0Tu83Pzd/5e1eqBs0FN1uTRAJ6KRj5dnGme7Mg?=
 =?us-ascii?Q?Y9F1cCyp3768mLuf7jsVylXlxHXN5uNhhq5PBpaNlfHuM55wHqf5kwSvdGs0?=
 =?us-ascii?Q?5iU3eO2dVMusrfVELOOXad1QULSpQ/HdtKd6LCPANT7aZvhj7TVWFBjoINJW?=
 =?us-ascii?Q?RfFpAP/sesKX5bYJ4aOsg5PrWWtt8YYcJyVbnzlYBuxm5u0nKwEytkLO395e?=
 =?us-ascii?Q?CxmYDM2/CdljiNC3wFCOnuXWJyR+bY3rWinJZ7NylQesAekNosc7EgTYE8OQ?=
 =?us-ascii?Q?WpX4Le3ue5n4ER08b/EU6TV1BoX4W8kZrejyio1Ec2EknMuakuL78qjIb2Ev?=
 =?us-ascii?Q?G6l1qYtXQFSgtClwOjf5TwMbtJzOIj0Gn/qZyzYDmM/TJekTvmJ058BQlnEk?=
 =?us-ascii?Q?GuAlZJHdOqE8bFFjDorgJJbsjnJpfffjpJb003cTBNLfgkv6UEXyMMCus0QX?=
 =?us-ascii?Q?Ernsfoh5xxXnQ4Nn8UshWk23+2dVQQGO5oDD/TZZM3bfWRX+1mxJxbJ2WNiH?=
 =?us-ascii?Q?15e4CHjNEW2WA0w/KR9RA9H5RfMdIiAmKpYK/q1jHIL0qGe5bu4g+QVf3qGU?=
 =?us-ascii?Q?9rye9OB28CfWvGj93H5s+MWlWFmexaPdlIh+Hb97bzW8d/qvn/PPf04RgrRd?=
 =?us-ascii?Q?/kDXSgSiUX8nXX658AB4fS59ehwCPSGdbAHi6ikfvg4Ur5BPxDJKY4M4HyP6?=
 =?us-ascii?Q?G9ve9hGkOg95x6ukF+CxF4+B/+jmAK0ZoqjGwEkItTPaMagTLJ5lC6zLAmtn?=
 =?us-ascii?Q?QSqN46X9+R/lG6y5XLTxK2LxV7pwXNy8haTldZfMnB/mlUPo1Sy/SkSUh7Ge?=
 =?us-ascii?Q?swyB8xJbrQGldV3Fw/9QENEjKvnQV4voehpgGU20fVButFD3RXFSgd2RTcTY?=
 =?us-ascii?Q?Xh6w+yvW3dTqF5qhBXOHqtSxlOQYROzE2VH8gtteelidYJgU7TrZEcMneMjy?=
 =?us-ascii?Q?k3X62Ahwq5shJsWL+ImHaePYt/NiXKXHDYH8v5uSPsihawWWIbjIZPBNQfyA?=
 =?us-ascii?Q?rdocxXsW1Tr2owtJ3ZReevhOpMRlGSyJvGhnFkodnJVsLNUPJbGcqA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6e252-7a4f-41bb-6ff1-08da088b4227
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:59:03.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt/dzpKbj/5Mla6f5oH1NHO2OUn9/TU9WYn7Mr6gUqAC5ih9+RkP3y+QFDtYlmsnh2MDJR0QGcZMBghuw0LO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

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

