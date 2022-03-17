Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601E2F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grcdMS2N7Pp41aFBDIXXHigkqVAfXMeFh1AWipxkJaw=;
	b=cC5oUJvb1iMx3mu6EYEV+ZK80oaxa2dPw+217JetBImr/hclY4RgELQ2KEQLCAEI23jKfV
	S5hVXubrJl0oa0CAmMaQAjIZo/8+Co/FFwwLHzFx/D7p4+jGicoYud0iNWJTcmDAj0omsT
	TD/3rfmEphAGCHRshsI84Gz9yHhQ4ME=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-c4srQp5lPXue7ly5QYrfXg-1; Thu, 17 Mar 2022 12:05:08 +0100
X-MC-Unique: c4srQp5lPXue7ly5QYrfXg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiCmd13SAfqK4hgsoh6ZlJI0BYuahq5+uU8pBT9JJ/gwZrmsiXXxQmrpFEJ4EUD7Sc2Pz8CMja3X/tjsMwA39nfuo9erp+FBsPdgalTzYaE/AKafgQISJ3MuUASpOReI2rZV6sv+isyUjFPQnHr5K0NyhMr0ywvImtZhmiwB7FX77+T3wwlCT/A9V4G92ntMqAcox4wrIxvgcFvHIcZLdJAlqwQOPJ15ptXNZyAmTsGSN8Hd8Xl6A0BfbR6Km+7OaKQcOwbWT3OFhyMFtta9Hog3rtfgndBHRHcNhHI/cT+VqX/FPQVofIaM2LQEKjchS9MvWX2ycjQLCxYf1j3Suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/G/QSFKdupfUOdH3RmTK+MYz4usRE5bHtUGSTosJdQ=;
 b=QW/Yd0GNNBg+h0sicUnx+phT3lBiW/81//2GBVPVBpm7DecM24Zup/z6VxoPHPZgkzixU6vC4TeUAjzBGN3reulxcPmZeC7nxvFuMA9YywQHBc2QsUW8KMrdiGKMtmSWJgAFEz3kk/DQET9gFBLl+my4sl+XjLSNyTNDyE8w74H9nK1QCtqoAzWs5yI7tM1mLtr/4qm1iDTePHiwdOQEuCc1/fRt4ZB3zFO46MjXDQ1dOZ1uKXV2P976EskkDuBDW12KJgYMdIFEiiWHg6PQ5OfDOXybFMaaIRUGSSsTllIt+EB3QuRtLsWT/4p/Z0739xRTFRorsg1SR/wkWMPGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6256.eurprd04.prod.outlook.com (2603:10a6:803:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:05:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:05:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/5] mptcp: add bpf_mptcp_sched_ops
Date: Thu, 17 Mar 2022 19:04:44 +0800
Message-ID: <5bbd1d25b99465a8657a5b270eced7c8687cbf1b.1647514852.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647514852.git.geliang.tang@suse.com>
References: <cover.1647514852.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98f26515-e185-4daf-e620-08da0805ff0b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6256:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6256A857798939C3B3333280F8129@VI1PR04MB6256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oLR49inwzD13KkBHn1WHfQj63ud7nC2wFWW711bT0dZIS4ykm/UWoav8rYEcXI45BtRAoNzlPw8PEB6JLUprxv+L19J2+dHzLVNbTslYmhaL4hHC8/8ISmFTN8R42aI1Twff8XgEjJbpB2JcGRHgyRXQU2Wa7jp4eLOmmC+eX2ma/AxW5StKVWV6W8I+jx/kFSuMhTuJ/1AcSQlKTd86k9x6YH357MhhvCMsNgCSfCg02B1UmrZKFq8Rv1Up3oOmmrMqyh0dpjr2JJc4P14X+ljkxMa2Vi/SeIgiz+BwO95EugONCpo/+ye4EJjFqC9/k5lnscUlyAKKQq9xOw2TB8M6uPjnRbprp8tr7Lq18xfXW3qmUkFj/3By8rIlHTWeVMSyxqv9yiPZgN0RNgkaceINNieGQXKJOdQfFA5rex+IYcIwBr0nCQIltKnqUfWrxtP+F21qygCG8z8OcNFayPhPsb+A5HuHIuIeG3LpS998GRVwt+RObfOdgeQ8iqQmSp68GKBKIDBJ/FFOFjPxsKggGCAqkFXIOU0YKdScRasuYhKWzzFULN/J9UJPS40Aw2tk2oxZhcHRfZlgEtmdB5p7PVMLYrmXLLscbRBaPeYJt8o2kOxieVAibinPVAO2IckFD1zW61KxhCIRJ/vflI2mophyjZ0OjEx3iX/yX36Ew/LsnJbuGvJDXl6/dUzwBXlEw5eo6peYZKEgzuZujQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(8676002)(2616005)(107886003)(26005)(186003)(38100700002)(4326008)(2906002)(6666004)(6506007)(66476007)(66556008)(6916009)(66946007)(86362001)(44832011)(83380400001)(508600001)(8936002)(36756003)(6486002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kskzAG3KHx1xP5vUQLmLh9Hw4mjaTtSJYF7vufnkM0gIj2hFFSQTsDe2Ib0U?=
 =?us-ascii?Q?A929WWNri21iEdXgdTsWDtkw0bYpfl9RzI08A7FbpTgk7W5EssPbn9syx8kA?=
 =?us-ascii?Q?P+7ddAN+3Pd+g0Y9UkfXMmxBoqD2x+1zIuDKxs+CBntXHl/UknGGHbu4s8Wi?=
 =?us-ascii?Q?sEJdyns4TCWcLky3EP5IaGvKjN55edAS563Pen5N8sKnp+KY0HAWtpn9YbOr?=
 =?us-ascii?Q?0yHMb5fKXHb1WfZnN1mWTm9b+0ygcKLMQut7LMDD6TEX6jY89Cb7Chrn7z/+?=
 =?us-ascii?Q?XMrnwwmplmXv/4BWMEmLDeO8EOwnOFXWh1Ic46wH0f1Xa4U1ga7ECy0kX/dV?=
 =?us-ascii?Q?Ak99g6jr6fjHx4wpZDvxsHA3vTahxkLNgQ/wTYXU3mEKW74EJ7A20RQki7jk?=
 =?us-ascii?Q?8ot4SfT36pANIWn7KQpcm/Q3tgKi9JisacAcIh83wV0GNfkOyJ76uXHNnmiC?=
 =?us-ascii?Q?JUouRH0dGZdRxfEq0l/yh4p/W4vEbcrb1nup+DSVNU0tJ39hLVmG4PT70eD3?=
 =?us-ascii?Q?BC576S0HqmjYJWbM4sugDU+35ou7y4+mQNKCyNjYGvsKhgbeDuh6nEzxfeSf?=
 =?us-ascii?Q?fElrk7YpA06aJugnF47pawEVWeBeVVSc1s6dO4YglbwsjEpYygGL0SNli68Z?=
 =?us-ascii?Q?EzdLZzNH1qWn0NbMxfFc6o5RRmF8pSFIiFbqY/IHnSgjwlzFkVc8F59fnSjb?=
 =?us-ascii?Q?xbTlCEEVBvyQS0ZsXDjANck8BnzxmQJT7LCcGhCpJ66PT1VLTDQ/mIxLZiY2?=
 =?us-ascii?Q?aGYyEOrByipDoLfkpSVDeu2g/2QkPKY29m7kI8gepPxbGT4r+WxaIrWtXixW?=
 =?us-ascii?Q?uvWdAkr8ZhCuRuV8L7K6mOn2B+i03w9HHcor7rgvBsW8HZ818o+FV5fqzuag?=
 =?us-ascii?Q?TWLckyhYYfQrx0CBIrYwx3dhEmv3YCds5jdWYiE7Eh3KhfJsrz6RYE4NUCnc?=
 =?us-ascii?Q?UEuBHashtYBOWYuvIOMTszT85xXUN/9aM75RUVvb5ZhMU7axJnl6uy1SsT8V?=
 =?us-ascii?Q?ta5oSwX6FT2ZyYew6JyhrFMaL+4WsB9OG0McoFZD3s+gkukHZsGyAiOTA0Y8?=
 =?us-ascii?Q?j8Tx2nQ/lolta+v3vpdK8Yh5wH3F8r8nQ32EnOQLpI4jrAAPV5NjaDgtSOCE?=
 =?us-ascii?Q?8hp78RldJ53VPnLTXSZBnldkYF3gZ9y1Slnh/1rwip4xX5dYTjN8LfLPe9eo?=
 =?us-ascii?Q?K8spvJrwCttiHh5s98czck8Kp9VSQJTHw1hhG0b3OWx4TzkKcKMiDQXEeowH?=
 =?us-ascii?Q?oQ6JRMEkz6cxWYrSEU/SX2oazaBYWGGi+7FnQ4FFEZjVlSB074Mjv5ePcT6/?=
 =?us-ascii?Q?AoIMq34Xwk91IVa4QoGpgC2fUaP6fEOmyxrEIAHhd5NgI/VbvjQGsa6kGjd0?=
 =?us-ascii?Q?kY/x/RAfn44jnBo66UHAFCXnTKs9veiD0IZeqJuWr+vQcVFDw+ZrIOxxc2MT?=
 =?us-ascii?Q?MHwyW7SQQ4UcaGd2MCA23isHY+D+2QhSJNVRQ1rjTdUa9jTPiSKQ+Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f26515-e185-4daf-e620-08da0805ff0b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:05:07.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFSJ0vb3i1S0OXZAr49h9q7eBc+CEs1L6aDxuz6r3pskR5jcE/mhYNm64U2r/nRmYl7Vw4w5qvsTU5tWR0UgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256

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

