Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90723CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbzSGA+iH1UTMPfO0gY5qXAAu2a7WWuKCXhIIo2bPgs=;
	b=MltWkRvFyo4csQjlV+vKX7PQ7sXYBz/MMFAzw+J11jrGaLQ0JmjBr/4VF9CjRDcDOpbaBv
	ab03i6c2AIL45GYi1RddmyUbWeO4r6UjXbkteWWrlnKB0aRAp29y1hp9WFnas5a6zClO/o
	ELXhnLPcX5NPnaJBzlQ3lPAuYPf8qn4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-swJjB3DDOSuS6XViVogrLg-1; Fri, 22 Apr 2022 09:47:09 +0200
X-MC-Unique: swJjB3DDOSuS6XViVogrLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr8VCW1FMT8935+t/SQS8VXgYiuKBDsZeP21MedlEWEO+AKVwoPehyg4C1X8PjvtZP644wrvoW7EaVrHPIHAhPekz1ehNdW1AuiCvN7rB5HJe/V9k0pss1zLmXE8mvlvmMxrbokTVXox9qWNt82SZaYjp+Uwyq8MtexWkFr6Lmnw8sLDyzUeQ/p3XK6gNhbp1mL7HG4EHfWrOd/HsWH0nJ4rg8FQgG8N/yc6sWeyX0ID9ap8qCfpXt2ATPxnfDzLvCQDdSaWBJtYjMETZlvWBD9gRy0uQGRN3FJTnvNviQJsSONX+Vtgx+sxN+T9rBw9RtRXp1/mhjDFwKKxPKLROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2EnaME/1QYATp4zZm7138WhkgYnDSGzpytFi0Hm5SA=;
 b=CAFcAWI7/fpRtvkjMYIPRP5FVhT+/FBoSD6vT+9QXv0SNdYFDBpkxHM2zIhEWz95i9jm2IQ9xj4APytOiNQAWo20HmDtn/pVBvD0gie0e+GnUf6BmQE1cQaIWYCvBtXptkNAK+Ii4HTR2Ti9pIj3GCGZNJBXuF4rYQAiAn0QAF5cpkxhyQ184FC57IG+6NlKs6GgnljZ/y/RyrGJzGgY89/ScbOhA5dTGw1bParRcWr37kYdxW43p6OyTYRGu3J8SIC9My+b12RpnkRgrH4w+SgWMi18UuXAW85uU0nIxRScGtNnrtG1hjPNtvNDxm33oz/DEsQ3seIh/rzqctFmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4899.eurprd04.prod.outlook.com (2603:10a6:208:c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:47:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:47:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/3] mptcp: add bpf get_subflows helper
Date: Fri, 22 Apr 2022 15:47:14 +0800
Message-ID: <95f8ee4b211b3cfd0d372080ca81fac1eb50e415.1650613515.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613515.git.geliang.tang@suse.com>
References: <cover.1650613515.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0027.apcprd06.prod.outlook.com
 (2603:1096:404:2e::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c01734b-94f8-433e-7f10-08da24344ce2
X-MS-TrafficTypeDiagnostic: AM0PR04MB4899:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4899CA237161AA323F6E7233F8F79@AM0PR04MB4899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BTBt4UbC/XilMqHbYotBRUbIpbm5tQu4ZfHOAJ6VHnLSJUcfHVRCsP6AwPfElRlZELas/PGKQJvmd+cw/fRbjZQ3uL0sjxoqjN93yN2twDwMvpX/yYvZRjxkFtiposiQM5kpRDBxK91ZFQbpsmXzYexO/eXo6ZG/6gCPq6qE1oRHscDMaKXLY4Uf9q3QEA0nPjanPfkuMSlkCfP+0/zpErGOTAjbZhDCyTF97ihvURU6hi8OsPWuXpOaPSG8Gb3AV2xDU7atr/n7JySJPIfCgpxB3ErvTglkOFsz02FD3JK1f220LogWz6WRA1Z3VWyYZjI/bGdCM/sCqjzErTXLysM1W+T8wzG+NSNJ4wtnP36J0gpcUPvPLTdQB82G6GA9skG01qeYConHfHxNdiK95IiBTjys9Rpl8SMa0maLO9qhKtrEOp4A6qlZg13oUlkEYJPUEGPGK2ZW3AzATWXgghMmE+Ng+5IOZedHNYgDiPiptgc0XQlUAJT5qzEg4n5AlXGpU8QC36Gq5Ssub2dFacz6iVczDHtxZJnzOBM8Sc633iu6GaPwPl7XnGIfsVV0ATwJ+eeprrncHV28A34oCrZ9ToCYMHPoU54OyeKa2oU04QsCBaPfv896cJjnqI76HvfVod0WyaBJE7acTm0MlJj/30lM5+TTRpl+b4YRbufxuJS+2JHQxjfjXHvf4ku+JRxmwklA8kRWQJ/1639wVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(508600001)(44832011)(107886003)(86362001)(66476007)(6916009)(4326008)(8676002)(66556008)(36756003)(66946007)(316002)(6506007)(5660300002)(38100700002)(8936002)(6512007)(26005)(6486002)(83380400001)(6666004)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MEWcI6jgMwXzqP4UMNoAeXJUAW4fGws32Lxsl+vFlattNHrUWWdFC1+wP1Uu?=
 =?us-ascii?Q?z2rVr11IvVFoX9OkOcU6s7lHPbxrGPwNv9jm9HKwdTZ36ts0EhiXEyD4E0tV?=
 =?us-ascii?Q?rj0gJZ9XfglRkf8pn1B6jbWXZBjViJXmNFXkRPWpkd2ZPVg5DWc6iMOjZdaM?=
 =?us-ascii?Q?UU007jlvLpoJYUQZOgnbLVnco6g4SUTtL4/bb3sHvfcaHLQNtJgnGy2y6uW9?=
 =?us-ascii?Q?oFZ4Z23VXI7m5QYQGuFZgJWahoD/h9jWLlGXw5g1UJyyoqhYVDEl9KRZPMGC?=
 =?us-ascii?Q?wX4qEzzUX8fK+jhXNtFtTglWodIgBqb/8GYME8NE5CHLXtZGEVJtEW2GoH+C?=
 =?us-ascii?Q?SSi/54VEf9/6tCR/M573aW532XcQfFZDFT+yRZY1sPETw93HhKhMzn7Ojpsv?=
 =?us-ascii?Q?i+UKZ7VWCvUA0SkfF02O2Zy1DoCW7TQoVRPkjuALpgqXULmBmAM54myPd9sn?=
 =?us-ascii?Q?zWHwLDKzQYslhScp15fEzEW5np37zmhYrSVAXmR0CsVyfLV/cvJuVfwZ/c9U?=
 =?us-ascii?Q?SCTkdimue6YlLLQ6ZBU91MIso6ijkaPvAaEjUeN2oJJnp1FQOq+Dybhx2v2+?=
 =?us-ascii?Q?nKPvHR5UGVVtUX+pIiyC7sSo06OKtJG9LDHj9BgSs/xY3SClErh7bL1bJ0pr?=
 =?us-ascii?Q?VTOzrDS2SZ8OFaC5fCDHwpzphmz4NUbbLSWLXmGD3mB+9RWN5oMPZ8sXwGjk?=
 =?us-ascii?Q?EmkOnbsXPdwEh8RMhCLW5p4CNQEP4+MSRBoGhpHF9z3cJWMXwLOJYuMEm6jR?=
 =?us-ascii?Q?3+TZBC084l58nDxn4+qPl/dTi7ZgQv7ejKpiPxZdYb38P5ileCsYB0r8cifZ?=
 =?us-ascii?Q?vUavf8Q313Z5qbYY3JbL9GDmNH81Yajs50OavfP0XiqQuSBDGSXxuSSLQK5j?=
 =?us-ascii?Q?fSmxZHePv6jIJABBhwpU5l/an7C1KZURRAxHXXBjZb5Lu7qSM145ICFm23r3?=
 =?us-ascii?Q?n3zJp4oXdPoFbrBRxV5aUBsENCVm4S3/himB3FIU8DJFs/K5TsLDWzlFUj1m?=
 =?us-ascii?Q?9y9/VszhiiqbYO64u6+kXLighMIaPYqc9dA+sBWY8RhX1YjaYeS3uhnNp/Sz?=
 =?us-ascii?Q?+uGdnI9ZcL82ww3iEb4LqHf6nZtiQ56R4Xpnz2D4PZ7+JXXGPAYfPX+YgMMT?=
 =?us-ascii?Q?2YnaRezqLJ4jvRTJ7q6dym6NDHgvAthhh/T5tlZ1QFs5jv6Kz8W/RoHxC6D1?=
 =?us-ascii?Q?WWzFeKQmrmbCH8hZxWUFRRGeBt/URs+VT7JdcxOyqPpr1p0QvMl5l7LN1z7P?=
 =?us-ascii?Q?3M1DvpyGV6C71QMuK2dqmue7UskOL4s6UPhzG+Wd4eZHml3fxzKk6hs7Rq9P?=
 =?us-ascii?Q?1+eUf6zAZ4VFotQvWISxd5gvLdzu+HaP9mPLR5cGzQwiwfT6A/7uMiwiu8R6?=
 =?us-ascii?Q?tbMsQVmgBeDG+03tah5gdCc4SJJ+B+0ykXvAoR0elxjeMypgRC8+pLu/xulL?=
 =?us-ascii?Q?6ksS7KsHN/uLKjiQfhbSuhWi5JEzqOQheVoYFAuVyBQi0UIsU54AIyM8PZM6?=
 =?us-ascii?Q?IbpvF0A6iAR1bg2N6GfxUfMAXnCPbvZpKheu27JSIm7Ieg2eBQ6wai+5fH6q?=
 =?us-ascii?Q?DGqdTQ3sCFEqCaZYZgn9FsOkV7H0BcKBQA/prX8G6mSqT5nssNiFIKgiFYrw?=
 =?us-ascii?Q?NrOiQL1MNz/pY+9xYzInvqb4xhKR6utgn9CSn8PdPULcHP5tXeREAWeCHMcd?=
 =?us-ascii?Q?pKQc5IVaQ8JI9gE1Sb+iLlytyKhEihccR1J9wVBL3dUnOErTdvyO1el2zVCq?=
 =?us-ascii?Q?KqVPy1IVj4HP7uL0o9QKIuHDwix9rv8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c01734b-94f8-433e-7f10-08da24344ce2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:47:07.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6GudHQ6ScF4tNXl1V2924o2IHQKHyeN183ghNI5+UdRqrPiMVKotpmxvf36025L1XloTqVfTqu6Ot05ZCqxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4899

This patch implements a new helper bpf_mptcp_get_subflows() to get all the
subflows of the given mptcp_sock, it returns the number of suflows. Add
a new member subflows in struct mptcp_sock as a pointers array of all the
subflows.

Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 47 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  7 +++++++
 2 files changed, 54 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6c01f6b959a3..3367541b353c 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -160,6 +160,23 @@ struct bpf_struct_ops bpf_mptcp_sched_ops =3D {
 	.name		=3D "mptcp_sched_ops",
 };
=20
+BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID(func, bpf_mptcp_get_subflows_array)
+BTF_ID(func, bpf_mptcp_put_subflows_array)
+BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set =3D {
+	.owner		=3D THIS_MODULE,
+	.check_set	=3D &bpf_mptcp_sched_kfunc_ids,
+};
+
+static int __init bpf_mptcp_sched_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &bpf_mptcp_sched_kfunc_set);
+}
+late_initcall(bpf_mptcp_sched_kfunc_init);
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk))
@@ -168,3 +185,33 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct =
sock *sk)
 	return NULL;
 }
 EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
+
+struct mptcp_subflows_array *bpf_mptcp_get_subflows_array(struct mptcp_soc=
k *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflows_array *array;
+
+	array =3D kzalloc(sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return array;
+
+	mptcp_for_each_subflow(msk, subflow)
+		array->subflows[array->nr++] =3D subflow;
+
+	return array;
+}
+EXPORT_SYMBOL(bpf_mptcp_get_subflows_array);
+
+void bpf_mptcp_put_subflows_array(struct mptcp_subflows_array *array)
+{
+	int i;
+
+	if (!array)
+		return;
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++)
+		array->subflows[i] =3D NULL;
+	array->nr =3D 0;
+	kfree(array);
+}
+EXPORT_SYMBOL(bpf_mptcp_put_subflows_array);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 006914cb78de..c42fb54298ef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -500,6 +500,13 @@ struct mptcp_subflow_context {
 	struct	rcu_head rcu;
 };
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflows_array {
+	u8 nr;
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
+};
+
 static inline struct mptcp_subflow_context *
 mptcp_subflow_ctx(const struct sock *sk)
 {
--=20
2.34.1

