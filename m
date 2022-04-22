Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72623CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DABSxmslrLanyiYWrPdZewHwkVXSaTgZV1PHvlEmlnU=;
	b=hS+aslCf9g9eOXjFmrrLOUnrKst67ReQuAT+wbJKAC1tbGxHtfzdA51YSGbDMByAXujUxB
	6MAuWjl5/I3mPHX6DUVk9kIBFXHNu3alYZsgalRy87tIppUxQY3mJUPXfryIERivTA1+DP
	mEw579GSMQRUaKEdCUvYS2RsPgZXP/Y=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-9geqiJuwPQSh7j7GT1dWGA-1; Fri, 22 Apr 2022 09:43:35 +0200
X-MC-Unique: 9geqiJuwPQSh7j7GT1dWGA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et9vZOZHjgZobYvNgGXsoe8aNv1JBLOL2e2dcjGqpu+PwlRUIR/qwuAm1ibgEkZd3BP079QbSZBrQ/G3Wfs66Rb6XILbzX23tY0g4xI0ZDUc35QOhQD8eg3zD8DIHI9jHgtpEXXPGPCANNwgCIqXaBzHQBOqcAOvcTz5pMdkZaaPhNIi07j3Bw+0cCrAfOv4jJyCkdJyEPDC09E9yZTrronw7K4tME4oia7hTLP+vcFrYzmFKpabrz9Ti95V8NI5YJNxfy48VoTfZxbrL4HRDTSVWBzzoNm+KuhpEE3qpL0hVuGvY7bdOhbG6ODKSvApkao7ykrHSy4grZ0TXuBdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoyYwrWaBS8oqg23iXUsce9U/fWmr0Fc1DD9hF4Kin8=;
 b=WBmCGGe7K6YQqQKlssXDlPeKdqB4vvWyIVu8UeEw0i9UWwBsimv/CVHB+Md7xCcY7osSHY3/a6bmpCCG0tKa+VgTMqJREoAtdqDg93bj1UL/M3ANFbVFBFJCGPfZcFfomPSrbcXJ4NU2Yg0g5IWazPEJflDfMAPhLHGTQ2qhd5LcKIQJswDmrKrsoochYeN/TiN3s4tK9ZibPC+HY+nAZIzB8k17pnZUGmwqv6BkxSY/6ws7b4ekwsmAHbSMKOJcKa93kwNGnY2DV6ojAcHCJxtmBDqNGvdRnQWbFMNPHXLDxDvFlKDvO1osPhenEZqJC9gBt3mvn59DEDdtID118A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:43:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 6/8] mptcp: add bpf_mptcp_sched_ops
Date: Fri, 22 Apr 2022 15:42:54 +0800
Message-ID: <fb91639f50d18e06a1af69f48cfdd0f8b614cf77.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00d3d2af-aa64-4db4-726f-08da2433cd7d
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB587644980F769DBA6F0CD1E6F8F79@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mo7YdzAin+MYD+a1h2q4911D5E/pNf+63T+DV2IHKOzoQEnZMOCZaFWOU4KB2wnU8m7DG16jzYtlD+TxT8w4mbpA1VCGwDiUfkLmjuHS3yv2VgQir45s2exsVPtqaNVhkMBeJkTe39gTZxv/02z5GAcdR4D0ew7LjVNX4zO/xEAL84saBsjsR6/2I46jQRzShHqjBe00LExcCVPgjy0ht5soaEkBgoxNNcGnXFIdXQvnOS0TIum7q4r627+sTma9ScZIKnvdkgErNedVxrIRGLW2RVzqQy1HsSiP7B2NrCPFcQLZGRvm06ggU3Z9ROuSc2R77JiKee9GMaEjs7F7GrRmovphs7Bw/5AmrmvZr06soP5VIpdM+S/z7aw1RbHVl7tsrKwt1hWmnVfNxKoa9NfAD0KvjouLEz65dUBS8nAh+g7Dsr3mXmMm271Fe9QmiOrOlZ5vGpzoSBVNS3X7Iqazn7AkeupObqw9f8BdlnDDiaWWVW4kPxX2QvbCDoIqr7iOKPJv33oy2GRnfaGvBhyQbDQy1F7lZDL/4ZwvyrEsvFTIMEmCBSR3qPGlqsWdmPrYHjHTCT7vUprRmQU+2JutVz0k7JZaThMFtxWMwBySn02uDte3IFduZL68H6xDz9SzfPnl2Kz4B6zqHeX819u2gbxCzkEdhLzpE22sC1slJpLV/VevfFqpKndKUryMn5EQCgq5I1VMo/bivjA9mA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(86362001)(5660300002)(6916009)(6666004)(8936002)(6486002)(44832011)(4326008)(38100700002)(186003)(2616005)(2906002)(107886003)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(26005)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4G3HfRh0lNzbRh1NZNFJj4riOBWQNOkIqhFMG+1gi2OcBiEozM2DhppOGLK?=
 =?us-ascii?Q?UasPy81q/DF1uUoUKl/U6togVSFtk/bk045d3wp8a41YZFfXC8rbLYZlT39U?=
 =?us-ascii?Q?cmYg4v27EsWPWYCu5GUu5Qx05Mqf7cOXDBRIrckWMRG7cE/9CoxwwXmobbOW?=
 =?us-ascii?Q?gTttYy3UkzQ9YyfN+Ydsk/429o7p9NkejhwANKmw0cVLU87innHGiclkRupU?=
 =?us-ascii?Q?2Wd5z2Fkn7TaO+xaVj/visfVGHQOpDPJAgUsm10RsoFqfBletw7SORtaYOhh?=
 =?us-ascii?Q?6C9Vu+P4jqr908VRkOnzHKeeBY6yGAFBpdDPM+Oj9RBEyeLYQcGOowb6eOe9?=
 =?us-ascii?Q?N2ok9Q2YK43dWG5XasxZ6GqzyxNpl/ycBXyNhVI6vFXUfMYniVT8iEm0Trz2?=
 =?us-ascii?Q?pH0frpsgnmzQ/GCiYqAi6qY0uyIyqdplCnWadRiPjmoK+gmjcGp1iqzAhyAE?=
 =?us-ascii?Q?OPsZ1IqdSPkVVQ9fBzVt7K1ye8SEx8QWqkUnj+mVseRlEq68JmUyOGNbaJgN?=
 =?us-ascii?Q?lYsJLvDoqbnoFpJercBj5UJJ+rpCIQONPNYXkcK2wYmO/JXzwB+zcnVIwd4C?=
 =?us-ascii?Q?WhfdFUZvwd7X8JziK9OgbCJXmC1SN11vKe2Ys5IhIVmcXkpunWt2B9pHZhtw?=
 =?us-ascii?Q?P6Gauy2plbcvPZhfB17LoohCrkq8VsNdShfkLaRgi0HdQQBeBZS+ntO2X5O3?=
 =?us-ascii?Q?g3XXk/QgJ0GU71Z6GvTcCPxueWtCr1+c7ewL0AbT/5tUpOQtBa59OLgFJYb3?=
 =?us-ascii?Q?G9oED4ENDx2BkYjwzk6hwUyt3R0E1xNgzGNV5fN3PkQzR/Z1EhvTM6PZSPel?=
 =?us-ascii?Q?mXxMsk4ztbV5Q8LKrGG3TeqiHi5a03tO3aNAJ+7zDxoROm0uI8F6G2eCrQ3F?=
 =?us-ascii?Q?ucGJ1aUoeW6UUV/TnJCMzHq+1mXcTKua5+qonz8NLFAV+z03PHj6s2V1ifuP?=
 =?us-ascii?Q?y/PGvFNRakCrZs27e0u7InH0jW/+u3H6YXFXINGKGrw2lAmJWcRe12XXLr1Z?=
 =?us-ascii?Q?NhcTsAAj+FaXVA30QN8o1IZ6KsrAGMIER4NsOOzIHRnkTw843i77udl+UtQN?=
 =?us-ascii?Q?p9C8jmhwVqhBwit4qax44SgAigy0+IEVHPMAseqnGBhxn3DL8fXToMKvrC8T?=
 =?us-ascii?Q?bcCVj/qIoEq1bxOV4xPnDnKIe45KmR5vpGlcHWfl81yQ9V+A6x3Dus7Q/jLq?=
 =?us-ascii?Q?V8x871DCJZ5ZNwVMT9mKSYgO3n5GZbZ4b445c4VutgeePoWmj8CMopBcBITt?=
 =?us-ascii?Q?LHgTuFYGAd64U3AU2agvda/v+iV1vO29dFLSVj9r+hkC2r7opwc3AFPkUZOM?=
 =?us-ascii?Q?r2hatEGM+SVUSigaBe+evRnHwWrKudYApOyiD4v65C5Kjjp2AHZovhfd6boF?=
 =?us-ascii?Q?ccTjqU3JU+ERZdGDXyNbER1arUdPXXAm6ZoiyMoz+U8udqvXum2V3MzYDazX?=
 =?us-ascii?Q?qZtojfsr0mhBfvmmdDrVsZJJskL+oNAktyrvGJJLsl8aak1lV9OIygH13nkZ?=
 =?us-ascii?Q?qrcRZmd+YWBck/YjLi+kl2vqVJVtnoyAv8KClahm92b95MMVCs2nYhHhwVHT?=
 =?us-ascii?Q?a6DomVzRHvv8aGrrp7Wy7j26cu4cq2FaRj5TiRJQ5eJrxT7HrlpC/U6DbftE?=
 =?us-ascii?Q?ZmDdwq+7fLNvOSv1yCOGx9/5oKe5JMNxyuPTG46Q7GOD7jftRm0F5HebEKp3?=
 =?us-ascii?Q?J4OD4faBeThvTDRjhu40awpOpwB56jz3jutJF3YTNdD/OSCuS2FZnRvuu4c+?=
 =?us-ascii?Q?uRW+hzUlJdnF+Mes3qduZhRKE2ShXUI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3d2af-aa64-4db4-726f-08da2433cd7d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:33.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDXFQoMHgZmCS7rG4fI9vfUZrB9gvXC8h8DjnyRvf9svRr6N1Rt7OgOPOPTAnoP4uaXJ6NdgJwDTAQSE00qnGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
Register and unregister the bpf scheduler in .reg and .unreg.

This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 kernel/bpf/bpf_struct_ops_types.h |   4 +
 net/mptcp/bpf.c                   | 148 ++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

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
index 535602ba2582..6c01f6b959a3 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,8 +10,156 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
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
+static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
+					     const struct btf *btf,
+					     const struct btf_type *t, int off,
+					     int size, enum bpf_access_type atype,
+					     u32 *next_btf_id,
+					     enum bpf_type_flag *flag)
+{
+	const struct btf_type *state;
+	u32 type_id;
+	size_t end;
+
+	if (atype =3D=3D BPF_READ)
+		return btf_struct_access(log, btf, t, off, size, atype,
+					 next_btf_id, flag);
+
+	type_id =3D btf_find_by_name_kind(btf, "mptcp_sched_data", BTF_KIND_STRUC=
T);
+	if (type_id < 0)
+		return -EINVAL;
+
+	state =3D btf_type_by_id(btf, type_id);
+	if (t !=3D state) {
+		bpf_log(log, "only access to mptcp_sched_data is supported\n");
+		return -EACCES;
+	}
+
+	switch (off) {
+	case offsetof(struct mptcp_sched_data, sock):
+		end =3D offsetofend(struct mptcp_sched_data, sock);
+		break;
+	case offsetof(struct mptcp_sched_data, call_again):
+		end =3D offsetofend(struct mptcp_sched_data, call_again);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at =
%zu",
+			off, size, end);
+		return -EACCES;
+	}
+
+	return NOT_INIT;
+}
+
+static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops =3D {
+	.get_func_proto		=3D bpf_mptcp_sched_get_func_proto,
+	.is_valid_access	=3D bpf_tracing_btf_ctx_access,
+	.btf_struct_access	=3D bpf_mptcp_sched_btf_struct_access,
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

