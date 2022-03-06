Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029510EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646528528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0MPY+WSQNwWOyp5VgV0CTw/sHdvnUiJvFilkADeg70=;
	b=iON6ThC5tCZrCrvWX0bEzTdBpgtZgQEJUOYrl/HXu3z0j3X2bv6RlR03Y9c+cRhNhOwn3O
	x2d5x2zbskVBhaoA8qMXEvFrV8W9U2nU1zdmI5AttjxAo/YROz3jXiEP30FqgkW78BRY5q
	Z+i97wcVORPcLOPDqePRhucKcC+1ljE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-7qXHklJVN4yyubx8FHj8Qw-1; Sun, 06 Mar 2022 02:02:07 +0100
X-MC-Unique: 7qXHklJVN4yyubx8FHj8Qw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZkykSZHbyqUClpOnxpiEWkBvkjad3x8zeN+s4T106NgltWOIgkZJfD4uGtihYDcydWylmxqJRG7XKchY8FB3vn1sNbrfyFFBx2AA/+PeDDhF07JPM/ho3Sarst6Oe6klduAdt7h7XwuBFYP5KaazBwh9W1sAy+Crs6dURzp6vatxkRHIA+T0POKKf2SQ44pqfQ8NvKMkbObRQdB+503og+kZ3pFrk5qRIretv3/2VxOkzMD1yEshO1WUPxEe30IhjlkmQb90FlvkLqwHo+agrEAxiY4ocfFrFLAR8U69Gf+A8GHF92keGh5QwGgPZfRi5UAZsvyZTE7KGr3qiGQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V/CJY3nSxaI4fRpLm5g7E3duE0JKWPCKp+lNt1FwUQ=;
 b=c9WOb1n3LUlso/FfDL20d8ZKS/PFpWgeGtO5ld7VYIaSBhhKPuYxwYohugbzz1MdW5m8M5q6TQTSiBM1IIoEheIgZBi+z6bgkQwdio7eaavXWDzdMF9G72765WEc2za1NSF7X0/IpxRcl0/L8Tm9SHufaGsHr9H4Co0oQjpMaITzwQinnCAjZL2f8b1y8j/RAAq5lqXx7PY3pfqjd0gxsjJ06Vb6hJfh7vaQXNjWkQceTiDrFJSMlkzs8Ut3OrrZoxctQuqeARPF2cFAXPrFwnReqQvgD5ndnGySf0/Nxa+9WR2Otl0ESHqHEQaGXdLUKLGuN/LVEIhdLXAcQuQJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5724.eurprd04.prod.outlook.com (2603:10a6:10:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 01:02:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.020; Sun, 6 Mar 2022
 01:02:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/4] Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Sun,  6 Mar 2022 09:01:35 +0800
Message-ID: <5d0f38a0fb220bae4f170f2debf5a8b8a031ba7e.1646528337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646528337.git.geliang.tang@suse.com>
References: <cover.1646528337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b66c1576-8277-4067-d822-08d9ff0cee48
X-MS-TrafficTypeDiagnostic: DB8PR04MB5724:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB5724ACA1E67F9410AF4DDD82F8079@DB8PR04MB5724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1c7+jvfrquNgIAdVycOX3L4tV+NNX7SQErV7esks/pN3OJ5vBBA5iIDbAIHPI74NsH9ioY2DQWiqT+K4cwAUlo6p2CMRn4oMcpZqq0WMWpOyl733a3B9+gkP7q3DLw5IxLUjVrgYcLQ4AgmTVmpoi5apZYVWNOy9CNIo392/liD1XV2sEuRrAl/NsUV3e2RQeoGgf72LchrVqrZs14RVvxkSs2AlT7pS1SE/0WYLJwGDkobxy1Mf6XGTFlfWYNDCQurNmXLtAMfy9GU6MQJ3i6jhFx+yPVB0xsUKpNwL7YUlOcLsu8K8EUT3oHrtEonJjHhKKYSzGUyf8sonpqKYhoUtDttwX5D/svHNhuI2WT/IuBzr/9uf4vWnmiOS4HJ64jMhPZbcUzlBbayN7FcadeK+Hsff+7S9RNb/qs5d/MtlrkeUNJpUBBWEyxEVgUPKqrrfSpYbg4f6YkIMagXZCdYyS+MvT05eNU/LqJk5W/m3EbCyfZmezK41TgbOE+g6/uTLJ7lKUWfWUttG6wMvNpvJUFtfupp6Aflp9gvNVoxFrhExNpZ9pqJGrSgSE+7+JfNzcU5WZ8mxCs5wAULq6inMHuQQ+Bm3tKwUeaL2bevfstyZ4bgg2h2s/y0VnT+u9XER/wm4cHZTMrNAEc+Qk8GDEC6NKtZ5l7bgEESLiCJSXhDlhMuew0gKqM90kQQaU6EDw9KnvKRdG/kb28Dy4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(5660300002)(86362001)(8676002)(4326008)(6512007)(66556008)(66476007)(66946007)(44832011)(38100700002)(6666004)(2906002)(8936002)(6506007)(83380400001)(316002)(26005)(186003)(107886003)(6916009)(508600001)(36756003)(6486002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NzNmfWbfuGiorCqZwS5HwefgGGuXW/DJ9jxrWVWWCb+OLgtCt3fvZ5uU9M6?=
 =?us-ascii?Q?WSXjIVyI44uR639qRltqKJzj6I4wHqsoVLBx/zJ5w477IwQxWZUDhuzniXZn?=
 =?us-ascii?Q?hPfJH7ALRA4LxQeVo+rdxwnkVyzfwWAzGh+As5LjZeqAu4ng8wYPRsv7ofKv?=
 =?us-ascii?Q?OTjsWmXLIndKGO3zasdtLyT8X0Hj/LymQD9Z0wtGg5m8lCjTgp03VyTpByPp?=
 =?us-ascii?Q?/+oyvZYDy89T4jZOWsT3X+anGedHbq2VviLsqBWiS81/FA0yuL+yx0Ol0K7t?=
 =?us-ascii?Q?hDXwrMvSxO46beUlsRctdT4jkLcbFl/KmVnHIupGOuF/0asp1xatDvimgy0O?=
 =?us-ascii?Q?C6hz6lVKwzJSVVGXd2bId0fp4FxnUN27LVcfu4q1IE8Bo8Vwy5RX3biObsG1?=
 =?us-ascii?Q?+bYOHC3S5ftHdai8DeF+kS0UFgZWkPPMCvNeHuWzY01N4yDFm0IYibK8A/xe?=
 =?us-ascii?Q?0DoCBkoiHjtUAXcg1Dgwbf2A0PHCzfcNp1PJLDtpbdp5DySDpWF1g5FNqrf/?=
 =?us-ascii?Q?T0KSXFaeEUsDPtyVZ8ptlTFWmYdidy7Lxe6ropNi8T0nmFD1vj5o0xDbr+dW?=
 =?us-ascii?Q?R3gX0czOoKY55E1zubnjndac1ln4c6G4NiJd/Liw++xRK2Yf5PYjghq2doGP?=
 =?us-ascii?Q?ML6rby0oJn5KD0ZLpcMZ7PFUXZqhEiHHe1OV98mLsZaYykSl5wqWSgI/+dxY?=
 =?us-ascii?Q?tJRflBTy/a0in2ECS+u3LQmBV2z1bh+4ZT4cKh4c3gB7ByCGONy/Ljzgj/JX?=
 =?us-ascii?Q?Ph9UuYIVhFfHyl1rab2WDuZFGaC5OhjpGho6VQxSmgETpwbv2RFUseTlNXoG?=
 =?us-ascii?Q?z1aICdCNvgdnDPun8DXoriX1uFnkfSMSUK8GFKkj8LHOAvJm5GjH4H9fSKea?=
 =?us-ascii?Q?/vs4w64tM+gCcIHQ8m2ZhKoo6xQ/IZeEBsOdgkNnFK8DGLuWcrR5hmZmxYnT?=
 =?us-ascii?Q?7okYt5okB+WcgJ6/Cd2Y57mnAl33xELwavQnWEi9nY67SGAksgOf6aeJCdmI?=
 =?us-ascii?Q?hqz/JvRbY9NZcN8GWtqmNidoHWiJBnPVoTIp6B1OEmY4quxm9zlzO9fJ0Jta?=
 =?us-ascii?Q?ap334Fidrpyv4LQQj5SZ+Hq+JgPEXh9FSeKXZ2x/I80qglS05k9tYaoaomUD?=
 =?us-ascii?Q?gqQkLxhaWNk6pgrIlQKYYefWOhEziPRViHQa1xHI7C/AbrRVkeLRRqSMmPUt?=
 =?us-ascii?Q?2Rh0FlBd3EXSV54jkN6/c5N8nYPFkhbilTG7J3Ua2FJptbSX0DifBrO643DU?=
 =?us-ascii?Q?3NgdLpN65VWQ/yNnijzu6KXaO8ahMGKhW99iRmN++DOTRAuBahY6PebOWxP4?=
 =?us-ascii?Q?ol/Z6j1q1Olfn5D0ywKZ4dZxRce/LQ5AUoosIJ9ushk4yiz2xGNvgHuUpN+J?=
 =?us-ascii?Q?kBl+oF5IZtrFNQZcP/1TcRVNr46EApTC8EKR7UIROE0QoxHoL170v6BeUdYc?=
 =?us-ascii?Q?NUPjBffolsmpl7FP9wkWB4CuBBggs0ciJUXeQYzhRr7ULluWgmkRgz8m2S2g?=
 =?us-ascii?Q?0zzWug0JvGxdFT3rNIbEnJaLd3AKImcFcb8xaveb7Mp+pvtWCIqMCnFTYChF?=
 =?us-ascii?Q?5IHfXjNy3PvZv0wVNPBxnxsQ19BP67bYy3MZlDxjDMK0Efm/sGhI0G9dz6kM?=
 =?us-ascii?Q?wCH8spliDBF6IYFnu2iBgqc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66c1576-8277-4067-d822-08d9ff0cee48
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2022 01:02:05.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWLcTjXsf29qbnELUh33j0s4Yez8TKtUuqvENXjSiJp1UkeZQpEF+jIPqw24KGWL6vrGirxBK7hQ52EjNKW1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5724

This reverts commit 2ee22ce38ed4c7a416ce887eb6379aaf157634f9.
---
 include/linux/bpf.h            | 34 ----------------
 include/uapi/linux/bpf.h       | 13 ------
 kernel/bpf/verifier.c          | 20 ----------
 net/core/filter.c              |  4 --
 net/mptcp/Makefile             |  2 -
 net/mptcp/bpf.c                | 72 ----------------------------------
 scripts/bpf_doc.py             |  2 -
 tools/include/uapi/linux/bpf.h | 13 ------
 8 files changed, 160 deletions(-)
 delete mode 100644 net/mptcp/bpf.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a17c1e3a6bc..f19abc59b6cd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -407,7 +407,6 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
 	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
-	RET_PTR_TO_MPTCP_SOCK,		/* returns a pointer to mptcp_sock */
 	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
 	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memo=
ry */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf=
_id */
@@ -418,7 +417,6 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
 	RET_PTR_TO_SOCKET_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
-	RET_PTR_TO_MPTCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_MPTCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMO=
N,
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_=
ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
@@ -499,7 +497,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET,		 /* reg points to struct bpf_sock */
 	PTR_TO_SOCK_COMMON,	 /* reg points to sock_common */
 	PTR_TO_TCP_SOCK,	 /* reg points to struct tcp_sock */
-	PTR_TO_MPTCP_SOCK,	 /* reg points to struct mptcp_sock */
 	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
 	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
 	/* PTR_TO_BTF_ID points to a kernel struct that does not need
@@ -528,7 +525,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_SOCKET,
 	PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
 	PTR_TO_TCP_SOCK_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
-	PTR_TO_MPTCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | PTR_TO_MPTCP_SOCK,
 	PTR_TO_BTF_ID_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_BTF_ID,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
@@ -2221,7 +2217,6 @@ extern const struct bpf_func_proto bpf_get_local_stor=
age_proto;
 extern const struct bpf_func_proto bpf_strtol_proto;
 extern const struct bpf_func_proto bpf_strtoul_proto;
 extern const struct bpf_func_proto bpf_tcp_sock_proto;
-extern const struct bpf_func_proto bpf_mptcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
 extern const struct bpf_func_proto bpf_event_output_data_proto;
@@ -2309,7 +2304,6 @@ struct sk_reuseport_kern {
 	u32 reuseport_id;
 	bool bind_inany;
 };
-
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type =
type,
 				  struct bpf_insn_access_aux *info);
=20
@@ -2360,34 +2354,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
um bpf_access_type type,
 }
 #endif /* CONFIG_INET */
=20
-#ifdef CONFIG_MPTCP
-bool bpf_mptcp_sock_is_valid_access(int off, int size,
-				    enum bpf_access_type type,
-				    struct bpf_insn_access_aux *info);
-
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog,
-				      u32 *target_size);
-#else /* CONFIG_MPTCP */
-static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
-						  enum bpf_access_type type,
-						  struct bpf_insn_access_aux *info)
-{
-	return false;
-}
-
-static inline u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type t=
ype,
-						    const struct bpf_insn *si,
-						    struct bpf_insn *insn_buf,
-						    struct bpf_prog *prog,
-						    u32 *target_size)
-{
-	return 0;
-}
-#endif /* CONFIG_MPTCP */
-
 enum bpf_text_poke_type {
 	BPF_MOD_CALL,
 	BPF_MOD_JUMP,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f2e5c7bd4f10..3f6dcdf4b915 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5086,14 +5086,6 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure. On error
  *		*dst* buffer is zeroed out.
- *
- * struct bpf_mptcp_sock *bpf_mptcp_sock(struct bpf_sock *sk)
- *	Description
- *		This helper gets a **struct bpf_mptcp_sock** pointer from a
- *		**struct bpf_sock** pointer.
- *	Return
- *		A **struct bpf_mptcp_sock** pointer on success, or **NULL** in
- *		case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5288,7 +5280,6 @@ union bpf_attr {
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
-	FN(mptcp_sock),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -5637,10 +5628,6 @@ struct bpf_tcp_sock {
 	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
=20
-struct bpf_mptcp_sock {
-	__u32 token;		/* msk token */
-};
-
 struct bpf_sock_tuple {
 	union {
 		struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1bb1b5d0419d..d7473fee247c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -430,7 +430,6 @@ static bool type_is_sk_pointer(enum bpf_reg_type type)
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_SOCK_COMMON ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
-		type =3D=3D PTR_TO_MPTCP_SOCK ||
 		type =3D=3D PTR_TO_XDP_SOCK;
 }
=20
@@ -438,7 +437,6 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 {
 	return type =3D=3D PTR_TO_SOCKET ||
 		type =3D=3D PTR_TO_TCP_SOCK ||
-		type =3D=3D PTR_TO_MPTCP_SOCK ||
 		type =3D=3D PTR_TO_MAP_VALUE ||
 		type =3D=3D PTR_TO_MAP_KEY ||
 		type =3D=3D PTR_TO_SOCK_COMMON;
@@ -454,7 +452,6 @@ static bool reg_type_may_be_refcounted_or_null(enum bpf=
_reg_type type)
 {
 	return base_type(type) =3D=3D PTR_TO_SOCKET ||
 		base_type(type) =3D=3D PTR_TO_TCP_SOCK ||
-		base_type(type) =3D=3D PTR_TO_MPTCP_SOCK ||
 		base_type(type) =3D=3D PTR_TO_MEM ||
 		base_type(type) =3D=3D PTR_TO_BTF_ID;
 }
@@ -554,7 +551,6 @@ static const char *reg_type_str(struct bpf_verifier_env=
 *env,
 		[PTR_TO_SOCKET]		=3D "sock",
 		[PTR_TO_SOCK_COMMON]	=3D "sock_common",
 		[PTR_TO_TCP_SOCK]	=3D "tcp_sock",
-		[PTR_TO_MPTCP_SOCK]	=3D "mptcp_sock",
 		[PTR_TO_TP_BUFFER]	=3D "tp_buffer",
 		[PTR_TO_XDP_SOCK]	=3D "xdp_sock",
 		[PTR_TO_BTF_ID]		=3D "ptr_",
@@ -2778,7 +2774,6 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BUF:
@@ -3671,9 +3666,6 @@ static int check_sock_access(struct bpf_verifier_env =
*env, int insn_idx,
 	case PTR_TO_TCP_SOCK:
 		valid =3D bpf_tcp_sock_is_valid_access(off, size, t, &info);
 		break;
-	case PTR_TO_MPTCP_SOCK:
-		valid =3D bpf_mptcp_sock_is_valid_access(off, size, t, &info);
-		break;
 	case PTR_TO_XDP_SOCK:
 		valid =3D bpf_xdp_sock_is_valid_access(off, size, t, &info);
 		break;
@@ -3830,9 +3822,6 @@ static int check_ptr_alignment(struct bpf_verifier_en=
v *env,
 	case PTR_TO_TCP_SOCK:
 		pointer_desc =3D "tcp_sock ";
 		break;
-	case PTR_TO_MPTCP_SOCK:
-		pointer_desc =3D "mptcp_sock ";
-		break;
 	case PTR_TO_XDP_SOCK:
 		pointer_desc =3D "xdp_sock ";
 		break;
@@ -6762,9 +6751,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_TCP_SOCK) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_TCP_SOCK | ret_flag;
-	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_MPTCP_SOCK) {
-		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type =3D PTR_TO_MPTCP_SOCK | ret_flag;
 	} else if (base_type(ret_type) =3D=3D RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
@@ -7479,7 +7465,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
@@ -10854,7 +10839,6 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -11385,7 +11369,6 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type =
type)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 		return false;
@@ -12810,9 +12793,6 @@ static int convert_ctx_accesses(struct bpf_verifier=
_env *env)
 		case PTR_TO_TCP_SOCK:
 			convert_ctx_access =3D bpf_tcp_sock_convert_ctx_access;
 			break;
-		case PTR_TO_MPTCP_SOCK:
-			convert_ctx_access =3D bpf_mptcp_sock_convert_ctx_access;
-			break;
 		case PTR_TO_XDP_SOCK:
 			convert_ctx_access =3D bpf_xdp_sock_convert_ctx_access;
 			break;
diff --git a/net/core/filter.c b/net/core/filter.c
index a07b28997ad3..f64454722a7e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7850,10 +7850,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
-#ifdef CONFIG_MPTCP
-	case BPF_FUNC_mptcp_sock:
-		return &bpf_mptcp_sock_proto;
-#endif /* CONFIG_MPTCP */
 	default:
 		return bpf_sk_base_func_proto(func_id);
 	}
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 0a0608b6b4b4..48a9d978aaeb 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,5 +11,3 @@ obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
 mptcp_crypto_test-objs :=3D crypto_test.o
 mptcp_token_test-objs :=3D token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) +=3D mptcp_crypto_test.o mptcp_token_test.o
-
-obj-$(CONFIG_BPF) +=3D bpf.o
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
deleted file mode 100644
index 5332469fbb28..000000000000
--- a/net/mptcp/bpf.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Multipath TCP
- *
- * Copyright (c) 2020, Tessares SA.
- *
- * Author: Nicolas Rybowski <nicolas.rybowski@tessares.net>
- *
- */
-
-#include <linux/bpf.h>
-
-#include "protocol.h"
-
-bool bpf_mptcp_sock_is_valid_access(int off, int size, enum bpf_access_typ=
e type,
-				    struct bpf_insn_access_aux *info)
-{
-	if (off < 0 || off >=3D offsetofend(struct bpf_mptcp_sock, token))
-		return false;
-
-	if (off % size !=3D 0)
-		return false;
-
-	switch (off) {
-	default:
-		return size =3D=3D sizeof(__u32);
-	}
-}
-
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog, u32 *target_size)
-{
-	struct bpf_insn *insn =3D insn_buf;
-
-#define BPF_MPTCP_SOCK_GET_COMMON(FIELD)							\
-	do {											\
-		BUILD_BUG_ON(sizeof_field(struct mptcp_sock, FIELD) >				\
-				sizeof_field(struct bpf_mptcp_sock, FIELD));			\
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct mptcp_sock, FIELD),		\
-							si->dst_reg, si->src_reg,		\
-							offsetof(struct mptcp_sock, FIELD));	\
-	} while (0)
-
-	if (insn > insn_buf)
-		return insn - insn_buf;
-
-	switch (si->off) {
-	case offsetof(struct bpf_mptcp_sock, token):
-		BPF_MPTCP_SOCK_GET_COMMON(token);
-		break;
-	}
-
-	return insn - insn_buf;
-}
-
-BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
-{
-	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptcp(=
sk)) {
-		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);
-
-		return (unsigned long)mptcp_sfc->conn;
-	}
-	return (unsigned long)NULL;
-}
-
-const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
-	.func           =3D bpf_mptcp_sock,
-	.gpl_only       =3D false,
-	.ret_type       =3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,
-	.arg1_type      =3D ARG_PTR_TO_SOCK_COMMON,
-};
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 6ef5c44a2a9e..096625242475 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -623,7 +623,6 @@ class PrinterHelpers(Printer):
             'struct udp6_sock',
             'struct unix_sock',
             'struct task_struct',
-            'struct bpf_mptcp_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -683,7 +682,6 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
-            'struct bpf_mptcp_sock',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index f2e5c7bd4f10..3f6dcdf4b915 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5086,14 +5086,6 @@ union bpf_attr {
  *	Return
  *		0 on success, or a negative error in case of failure. On error
  *		*dst* buffer is zeroed out.
- *
- * struct bpf_mptcp_sock *bpf_mptcp_sock(struct bpf_sock *sk)
- *	Description
- *		This helper gets a **struct bpf_mptcp_sock** pointer from a
- *		**struct bpf_sock** pointer.
- *	Return
- *		A **struct bpf_mptcp_sock** pointer on success, or **NULL** in
- *		case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5288,7 +5280,6 @@ union bpf_attr {
 	FN(xdp_load_bytes),		\
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
-	FN(mptcp_sock),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -5637,10 +5628,6 @@ struct bpf_tcp_sock {
 	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
=20
-struct bpf_mptcp_sock {
-	__u32 token;		/* msk token */
-};
-
 struct bpf_sock_tuple {
 	union {
 		struct {
--=20
2.34.1

