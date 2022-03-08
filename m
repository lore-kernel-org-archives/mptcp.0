Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF67C
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 10:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646736477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0MPY+WSQNwWOyp5VgV0CTw/sHdvnUiJvFilkADeg70=;
	b=StlvOb+bqkRUkBhJYdZI6CfPqCQVYUaq6CmIBTPv9GV3ENHzyZxVyn+JECrls7bd2byUTI
	qo4CEinavX89N5isqf/pX6SQAUjTad+sbKAXcBaGUzNqoe+NKnQn/T64Sm44Cke0B184kN
	AFJVF1A5lG+7H81VxGB85s5p+scJwkg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-ih68IfTHMRqRMFxYenX_lA-1; Tue, 08 Mar 2022 11:47:56 +0100
X-MC-Unique: ih68IfTHMRqRMFxYenX_lA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+oGzTcjFGNaJYYOzl9JshdaQO3f8w0Ovug9mQDhWOtw+9030M1FbSRD1uMJFzjBB1tHKUPABszKocwkq1N0yWdGhJH6YZd4p1FqyPU+8/289XynqYzxeCrOb+jmRuWmblO054+hOsfzKLgnekmkKFoBsCyYQBfhYPs+Q7XGF4Ik0L6AaKSESjmHqxk4GkawkeK4txoW02TbyZLUlvR4FAXrthr/TYb2rk0pTS+MheRfhabZKHba9sov3d11TPPATFOqzWLgmPNSMHasa53pvik49h69MA1kB/7/dCQeYbmp+8RpRpCaOb3VvrJ6NHXjCJsqGu4Gxv77PNCNmeyvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V/CJY3nSxaI4fRpLm5g7E3duE0JKWPCKp+lNt1FwUQ=;
 b=gX7EkKX3Z0/qVLDSQlOWqG3qTHecxA+FLraIVHYqwWtAP0KxpmUtEOMWSkKrJU7AKoGP54xM8/gRfL4Uk/FY1znHZ5xDyAtKlz4hAU5+X7uIP0lYjgrEqV6LyTOTussZBrkkPzPQA/dMQE2nIHTst7gNhZd/izQMvADXxdS16EzaNivl907JoGwYLn/yS33xpdd1GWdXtzJnh0axisB9ljlNB1QmvseVnpeHBP9/bi7JzXUIMGFSVvOsi3ioUQbEZ+NQ/0rxUmAWKMoXbxqzbNkMNnVeCfRQm4eK6H9cbcshlhZNVquPuq3mri3SFOkvwPs6VJWYI+DPHtC5l2X/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 10:47:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:47:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/5] Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Tue,  8 Mar 2022 18:47:29 +0800
Message-ID: <5d0f38a0fb220bae4f170f2debf5a8b8a031ba7e.1646736285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646736285.git.geliang.tang@suse.com>
References: <cover.1646736285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db10927a-eaee-40e3-9591-08da00f11a15
X-MS-TrafficTypeDiagnostic: DBBPR04MB7929:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7929364AD6C667323FAC0C2AF8099@DBBPR04MB7929.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dJpKLUdS+Bg0sZGPtwkz/QlniV8bUg0vUGa+7H3WeQgI9yj0mzIZWGd+XK0gCUalTV3M6STNVgoTZdx+oEZYnGQ0idjGd2Pjz7EnB5SFm6zgH08K9Wg0IInSApLeKr05jWpcHD9FBJ/jWIfm5dqK5Il4+VI3iv3CjIkpw/thkIUpv5m9dFygNB93DRvGxGiY1rlDMCSkGegLrNqGmlKuGBwVqkU/OlFadZb1DUNKyMk/GwYB4d4QmEuWs215klJ+JQm3iYN0KVPIYTgZ+qBteuKxiVQc8RhIS2kqwRE8y5k48WDoTHIgxYaOEIr3Cvv+9nj2/tYmCQPwZJ5dAnPkich2VTBmavok2l69NZtA2NASzgFRUIgJgW5qX7krTfED9BYOmFSJtFP/mdITVvK0klcpMAfyHlvziigTDMieiFdIb7z6ZZLJ5p7mAbWi16d4rB6/gxRLxolbO0/uFXJluQC6/dHMNI/p84ugdSNGGgzgQBoyagr2PQ0+TOGV4Y3ounZxUZ5NJjeUKUwag4hTD6YUV6rCZARjcST9c95s3IxHVzBfY1rUcANxES4a6b/3Xnxfo573tjBtsBVJR7+9DdCvT5aDQmQGlZTTCAEQun/6VyO8HfeMzzjOotu2j7LEGzsA7MRbJ1fH4CeHcF2Rk9n9Cnm+mpNMEqOw/0X4rmzBwNGtwWZMlIa0ukOqiTVi17uZqa8y30Pe+TGAkgt10g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(107886003)(186003)(6666004)(6506007)(2616005)(38100700002)(83380400001)(4326008)(66946007)(44832011)(30864003)(66476007)(8936002)(8676002)(5660300002)(6512007)(66556008)(36756003)(2906002)(508600001)(6916009)(6486002)(316002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWVc99yyao3Eb0j7RjA8JMt9Dz1Z0n/5ISepMZh73xgm4Q9N5UVy5T+ihCtC?=
 =?us-ascii?Q?PkwSzCRwHxRQyI9fS5onTBsRQVt4J53BczCp5z3fDtZfpVtu7MGr9v6Nx1b5?=
 =?us-ascii?Q?MowjAPpnMcx8zEI78kR09AdDQnS2wutEfHvFSL/9gKuOn+MiNh14C13midqH?=
 =?us-ascii?Q?Mldx+r6vMaw2ij+JJmN+LO2Hrt1QryiUhtLPPHqvNH5/E5zX8k2koFxg4e4J?=
 =?us-ascii?Q?Xix6s79F1HdTRPP36mFJ90ZdO90+nf4ptLsE6CRBnlAhMvJnuyXEdeWGAeIa?=
 =?us-ascii?Q?rAhnwNEVny9PEaicLV9QCLnkT1bBdH7BgLfDv1LBy1309mnDiR9YujYhpJe0?=
 =?us-ascii?Q?z0mbcyv1f+SSmCxD7at648GBEkVg0seAc62OGEjnc6BCqlNUtQc4Xigb4j40?=
 =?us-ascii?Q?C40DOkM4ZIHT8IwkuuiOuhRjZCxP8QVJ+1P6Cp8rdd4+q64MxVQ9f5Kyzvm0?=
 =?us-ascii?Q?nDwJu/LUzOHKrB9yyQF4tjfyjhd4pOyP0qnAcvjRyGsxp7hQ//qtvx3URCK0?=
 =?us-ascii?Q?YvQxLVfYZTb0uVElmMd7mWCOonBWLi0dI/b7zcaKldnNUDkz5bfz+w1WeLpk?=
 =?us-ascii?Q?FCjOh2CwZ6Hb6gAVt/7fJpbUSSpOUzdAabxoW9wSTHqokbbmvtVReq+i+Lfn?=
 =?us-ascii?Q?4Rza14QbRIHC67qnBIkbrPpD4wBrvBJuoPSaaGY+Z3tph9oQRfbDGBIVne5k?=
 =?us-ascii?Q?7pMA5rqPPlDmFzgU1eUFAbKuaLt8WMB8lhBKO2hTxWFNOrltD/dHsoEf5Hxv?=
 =?us-ascii?Q?TUGU1qRnE5hFvExpLRx8e9F85h/bHR7sYQTjnMbeRp/C+44OhMiLy1Mx+mHi?=
 =?us-ascii?Q?kgPwYmnJbMT9/8Lmo+YOppmHGt7naOydNBdtmuA+m9isfazv/UMAq5R6zFAw?=
 =?us-ascii?Q?kjdYiZvT2yTE9x8FBHjvboqMr3GeinOK+yJyLXOabhdj87aHmfDpKwW5Nm3L?=
 =?us-ascii?Q?HsZ8jGcANpCfsqS6yuMLLE/cq3LbJjMxe+xrK3gOae5fevGJTDBtu9Ja83c0?=
 =?us-ascii?Q?H1srWbXseyFs/0brxf73Tbp2Mlr3OE8PozMh77ur3DBwbo8Xj/aZYZ/vYigE?=
 =?us-ascii?Q?J2NWtQsxWE9j2tnUBr1tCmjA0+PGiCovUmSfq70cdS+WTBm24+j2YIHcIH/I?=
 =?us-ascii?Q?wL/OXGffVjiT9ZgTz7tllxC3fnLMryQptj67cuC96/D8fogYTVaC81g5xLYr?=
 =?us-ascii?Q?6CQTlib5jBf5sVM+CQuc6gdFJz8NDBub3oTUAN797PFq5ysD0VDZztMglIW0?=
 =?us-ascii?Q?fEjUK6Cy8laREqSDKkuIrayBI3sFYQ9O3cTOELs3n95nW/sAq/O2AGdWSX6c?=
 =?us-ascii?Q?r338DtjugZUx9wGlLgBASQPauQjTFh+n8VSb+uDAdmXjr72MfTnf9OxLPCMV?=
 =?us-ascii?Q?3Ds7LVNbGVgrluNNm2NOMK2iBt2DLHDhiyF4QqdCj0NSTeNEhQbUIBDSkLGO?=
 =?us-ascii?Q?wF/YJvF/hA+iqZnyhpXS7HidT2Ikjk7BrXulOfqkM73j22qiTqNj8GnJmQ6u?=
 =?us-ascii?Q?A5yHahxDitwYHBk0R1pcoXhzwZ7Q9OpkGo+FVNGi/rGR2Xo+/IkjkFABX/tC?=
 =?us-ascii?Q?uzCoAD8kpICBMPmLZ4Qv5Y2wyI/3HkILNSXwDOnbGCVtJnuo+AMnI9IRLyO+?=
 =?us-ascii?Q?GQT+ngdPYgsSuHajZ7mNCrM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db10927a-eaee-40e3-9591-08da00f11a15
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:47:55.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB16h0MUfZpokU5EaJExUooYYbxrfhxWPmzMqARvlkJoay0LIYIAJ6pTRr08jhrNYWYBVDeoGS2MCH9nN8SlWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

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

