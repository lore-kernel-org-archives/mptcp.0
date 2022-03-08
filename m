Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF252F33
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 04:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646712207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0MPY+WSQNwWOyp5VgV0CTw/sHdvnUiJvFilkADeg70=;
	b=AyWIMcu/AhGA/6prabSnLCJregOcKggAJ4vzknZAiuHibu46AoxDLceKsLiX9Sf7bbiOiY
	O9j6/GGgYzcGlFvHSEPW4jNDfoiJt35mQX1loweZmuwpa9AjjKtfJbpSW2fxMxVvgW198r
	omibdGdW+ToaPK1JeM9gJs91fzrABQE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-BaRln9bdMFqOwOZph4OEPA-1; Tue, 08 Mar 2022 05:03:26 +0100
X-MC-Unique: BaRln9bdMFqOwOZph4OEPA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYHY1FSxgTynHuPCVX0X337rl+9CW6b4QL5paLbuAQP0iYc/gLNVFytjx9ePp5MnPej0ylGY0h+p5Q8z4GBNt8BkysM/4mqfSvNt4qY04DEiJvTMYY+qq5D1DDPAtkspeNv00N9MzLBsEVQL0larwCVWAcc7KSbNqPPp9fqoxqGAbpy2Y6HK0JqfSjqdEIwFmr2bjNqHBusuLCAYqdQvTmUTRCTjnGtCBUC28pXCOnsaqKdp/56qx7IQtzaltHvRdcBvU3bE+uBSWQMCBK1cRufxRpwCoaeldVVpbY03JGJS+GGiX+oT2HaHczsa2lCpUzDjsxb6uupvq09pctRgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V/CJY3nSxaI4fRpLm5g7E3duE0JKWPCKp+lNt1FwUQ=;
 b=jM3RXrzEiVRQlRyDIW/GkV9PST6P1GKX1UrMTxPIo8ScpDaijdIea6No5n9o4GOByI8eIxtcJPc8BCytaOiNDlK2Vs/tBVZuk7L/xOYNriVQLhkJHeuDjgrndWgNSUaGF3K8d207V47Gsam7Zqb4HQ9EHy0IKvtWb7mSNzj4JBwj7u3qwRu715or3UC/EgaprlLukCYjWS04Vc8qI7hODyUhmQGbsS+YA/Mgat5Dby38TZgWhkTlzM9bsE8LJ9W5L0Uk777uUBzusOXJ9RCDulhcdMrksIptkjto/oBsg7Y0Ytwk5Vmi2IfK+KulTFTGPT3z3DLa9OSzZ1zOSc5X3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 04:03:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 04:03:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/4] Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Tue,  8 Mar 2022 12:02:51 +0800
Message-ID: <5d0f38a0fb220bae4f170f2debf5a8b8a031ba7e.1646711943.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646711943.git.geliang.tang@suse.com>
References: <cover.1646711943.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c092c9f0-3331-4a59-0540-08da00b8982a
X-MS-TrafficTypeDiagnostic: AS8PR04MB7862:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7862ECD0EA3487DCC0E8DAD8F8099@AS8PR04MB7862.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	glvqL6DZYbRFZ+/1N3DQqCU0C7gs1+d31XEgGcw3T5Bp9iEmcNkV0osPyl0b1GDFF4EZBp0rTRFvlHMKzZvZBPWWNMf56tgsHSQ593yWCVQrbK+lZcmew783fbk/xuFbfsKQth4PKWxJBbaNi0QJqL0Kb6pEfWD/EI0MFXm8CxWpcot5aNe9liWCrnvo0jQVDseUgyskeIUCL666B3bQy8oMctEnRCgdUAUT/lOvXbWqESayTMmaB8Fb211Qw4Liw9LiRaR2rKR7FMIopqNxEPY3+GzBCZUsmrCPFQe5ycEWnKVpQHu2dyQZgzxi+8ae238Oog+7ddGhcBAbkYCN7EKs7YrTvjaxY5h91VNKZ3sK9yXXAUwWphL/3T3DJrwRn/kux0ECFN1JpmCuXrHl+93RILj5MciiktfC0ugBpVVPuxmd3C7Jn4xfMOYtFD3kJMPWMfat09o1n7+jlGXghyhoN+ewfUkrPPhsKGwEX5KwbdpWKreX8sl4mTy1ChBK9ky6uuH2jrqmfnE2g9uPMapdLtTSrUSMdWENSPN8tNAo2hZM/Ts6vGDyzZpDvmmNsjsrueua37otCRbjyhgg0nKQsZk5TCh6rVdHISkQfyk9lPL9IRnfvnR7HWLzN+rwQyyKOoFCG9bVl3aklvS48zpILtrJ0R04ugWMa5qH3kSz9pqjdBjRnefAbHG0ZXsnHrESba2Z9BIgu4KMJ0/DGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(26005)(186003)(6486002)(6506007)(6666004)(6512007)(38100700002)(508600001)(4326008)(83380400001)(86362001)(2906002)(44832011)(30864003)(8936002)(6916009)(5660300002)(316002)(8676002)(66946007)(66556008)(36756003)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4hRiLaZlHo870lJFKn+CEvjablvCF3QUt4bKrneHn4pdXxT7quxBJJNLcK0T?=
 =?us-ascii?Q?JOKY+pUohELy+1hi6oFZl2vY8Cp3HBSlyjGsaGqxhdymBBIs3hA/dIy71wGw?=
 =?us-ascii?Q?fXJVd68V++7hG2KkBjq8GaXKDSexf5pWRmxnaRKCYLiKJ//6hT44BKzA/ZOx?=
 =?us-ascii?Q?pZ5iP0XAawsuEW2kJ6zD9dydm0Lrpug/mccU/OHLwOKiWhJPQkwhAdfVlvxd?=
 =?us-ascii?Q?PeIJ06JsVImqP9c/WJyTmmqsDQs4Ko1rEgvEoMKvx2DIP0v4p05XQCESE5iu?=
 =?us-ascii?Q?NrCfzWfyxAnzd+P0TWIGiKtZ8ZrcxomlGATrnUl4Lu8EOJwOWUOMebHYAMXq?=
 =?us-ascii?Q?lKUvz2vOFobXfIPrl/nuVlY4NBf3P6mboXul0YLIgwyjrwADLTnm35qgDn6W?=
 =?us-ascii?Q?s+vhBJdtLyiAZz7aVMLgSRqmfSKeJcoKE1CXfVLNlGhQzYVIGPYINtY8Nny7?=
 =?us-ascii?Q?QrxR8+6njttRKd/4SU6GDyonCUTHwujjqgsFIuJCbmd69R+rNP9AuVmou+ZO?=
 =?us-ascii?Q?I9iokHcshpsph7DBHcV13XstnqFYvXFyKOMNgzVOtPgBUfOUUb0O3EFtz4pV?=
 =?us-ascii?Q?69ksyIfbonh1nXUUIytMTFbSh7E8G2EwJe1TwifeTwO4ACzQae0+vhA9gJzT?=
 =?us-ascii?Q?1XFMKQJkkCb+yf+ied2Q+I7ipfKImwf3n6zBWmYKKi3xX0Bv+Mjxiypxbwck?=
 =?us-ascii?Q?z2QX2bMxNmCpXRumsGwutj6sx9YG2I2KRludjK7CQmHkXPWzrHkWqbSmgrv2?=
 =?us-ascii?Q?68BEoOyXuAEvQkI29huuBL3MvOLeUOXVwuMjj82WeuxTWIMzc6qnwrI0SGn5?=
 =?us-ascii?Q?C31o9xUV4NJLllSIZ764ytn97NFU6fSATFZdnsKCjYG5aOALn5/hY01Rvx+E?=
 =?us-ascii?Q?9ZZeBWurfQkTgFA/CFtXk9tcNQH9oNNRZYPxXaw6YNN8LSX/auckWCBEgW5w?=
 =?us-ascii?Q?mRw5bJfLDNxUr06Cemb4tD78u0H3I4dE81rLtwSBZ5Biy/tuBKomMkIbdv9U?=
 =?us-ascii?Q?vqDd7V+pUFBb4LGQXSuQK5rUmkIHdLQIipd0A8ooxmGtMSx7IhkapvCTDYqx?=
 =?us-ascii?Q?PO2kmRH2RtbhCcwTsyTXGBjHUHw3EGB9YfP0FIuKtDoAv4pPtfziJcLGLFVq?=
 =?us-ascii?Q?nXmh3iGC5vKo89w20Ykga35tgmvFaGghhUDMw2OzJDamWZdwwepOR7EWFooX?=
 =?us-ascii?Q?v5jTxJd0mntP1PHHk+Bb3EmOyfc7IV6piwdXXmX9ZXtOT8B2ocytGKLI7x71?=
 =?us-ascii?Q?HKgKsvmzeek6Oms5qRl2mQjj4zuXz2A+Z92/JukdPld9rvPh8enEKn4zm74M?=
 =?us-ascii?Q?h7isvIphHp7ppFgfgqPkW3oxRHCRGFaEOO5O8IC+4vn1C+gR2ur0Ay9F4Kpm?=
 =?us-ascii?Q?hcleZ9Mk8HMCpR8JkmZgubVM2EzOekOJqJ+WZ8NpUL86c5HBsQdPAt2AK3Pi?=
 =?us-ascii?Q?gEc+6l3Gwg5ESiFNNlSmbw/oEzB1/JGtnvmygIpJoLdfPnoRV1vuJ/JEBPFO?=
 =?us-ascii?Q?xpfGPPw2tM+ZpuV0Yz75g4tHSqSCkkd9vJ9ZQlezDHjtNlI5frUfA6qtrUcZ?=
 =?us-ascii?Q?H8YPpGoF2H7okbwyTt5fsR4N7A2h4Sz+MpdqqxgLBqaExbKIObD3k6WmVrKd?=
 =?us-ascii?Q?A5PiaovJG6QYnDDQ4cBtfdc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c092c9f0-3331-4a59-0540-08da00b8982a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 04:03:25.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIe44x4vItwneSqmf8OLq0hJhIRmgDiEbx8eP5/CN1yg5EXE3OM5zEJq95LqUs9urDayIre92r13pglNltulKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

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

