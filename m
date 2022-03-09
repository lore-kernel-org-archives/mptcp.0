Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CD6476
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 03:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646796987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0MPY+WSQNwWOyp5VgV0CTw/sHdvnUiJvFilkADeg70=;
	b=THGgfDTeNUeTMojZtyJT2orqqoeVjqQaTIIFMdiMoaWBULbZaTksXXl1weShQY89WePkYU
	A2CaeRcm4LRJQDMIb7Qosa2hrSiPKbW7O7tQ7pKVSjn9L48hiICH5z9JrNMIsU3Os8zTm6
	7GOPJ2QNdoV5RikHxI333LfXrYhfnj0=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-xN6Q_FmfPFGQ9QOGt_btOA-1; Wed, 09 Mar 2022 04:36:26 +0100
X-MC-Unique: xN6Q_FmfPFGQ9QOGt_btOA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKdwkCkGPvYEJunqCFcmQIqY53VmM1DCeCVk39S+9z/rK7RrWzlKGtslnCdRVaTHySvdjP4txbo11c4rpGZ/OpukkJx/qOpcYW71dG1b5uXUZdr0cb86bDpYnW2xjJhynUoQLolacrB22L9YZt/BYEh4VPVWqCChXI+2ntgpZexfhVPWg6A+JnXiky4pvetJdowIEv7aZeASup9TVw6XZuxfzxPWXmZa6PoFIPTAXwl1kT74trIu3has0JbG7Kw99vAal7xoJHF9G/YO940T+kyi65p60Fids9RMEtwFUOtjPYg5a78OoUzhCTTy9BWR3rYSa00yF+tJgEitZ2vCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V/CJY3nSxaI4fRpLm5g7E3duE0JKWPCKp+lNt1FwUQ=;
 b=XNKiY/FzYxSKAC3QkeEmSh5Kily/Kx1ae4vaKXnDVUcXNgvrhx6YMv8fgUqZ6kLMqWaKxQbDkYgL6KDPqt/OJQ4/oWGl8IwRdmD9+y1uMAOIAnI8FTK00zkMzRyvJEf5YvcNQeY0pF8yof/F4jCrNV2dhCzVo4dY8mqTCvD2AwsNna+T1sH1/kXz9XaAa+XhEKUoynEMfekSREdJC61/L2scCsaa1qprNWcVxJFr7vZ2WF4p3C9e7rRgVkrFu0otjKq/jxPGd216MBylY4JM4emmAhw61wpWwFklqpqeqBkg4cUATcdswr+FavZA9MRzB/ReMl2FTHPOg5qa1lBKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6333.eurprd04.prod.outlook.com (2603:10a6:803:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:36:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:36:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 2/5] Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Wed,  9 Mar 2022 11:35:58 +0800
Message-ID: <5d0f38a0fb220bae4f170f2debf5a8b8a031ba7e.1646796538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646796538.git.geliang.tang@suse.com>
References: <cover.1646796538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97eefcd8-9ed0-477f-bc3c-08da017dfcd4
X-MS-TrafficTypeDiagnostic: VI1PR04MB6333:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6333F7EEA63802BE312E2E26F80A9@VI1PR04MB6333.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q12M9IPlJME98tlWLQOQXLYw+nXcATkytBI5LqXfowA5SLdjx/poncxHhNP3p8hLS0UXGmCZnFZKsxmkXuU6HezhmeCe5VbdMaeDvYmYZcWpxD4aBicieMrPRwvCOHcCEcT8Jw7Vpcz0axriCoU/o6hx0FfspZReakxXVhqAZigWgfiOZ1Z9JTp65j3M6KpiO5gYNOW+xtYH3D+gmAr14nr6pbz/CYWbUs4OwHdfGOSGurPHBniypZDPlXL2nbSVAEj0G7RvdV9WDH/rGhm+ae6Zto8IPTmlINTspIkjhlEPD0CQaoWOZj+DKfaK6lM1bJwxm5T+3fJRVZi05aUHrlHPQ5/6RFHzmGz0u917JyyMiVgynshgwZP5fowCRCBHUQ8ZCJvgKNiu15Wt5SvL6n/xAK1YuajlxkoI6yfj8dqGb/bmEvONTSZ+ABDaYfTYVMJXTR+pQ3CzOYG+xzpstzawRIGq9vypplns2TIXXwdBPb7lFZyxIgB7D1RnuaMvviJO6noucaa6P0AWoCfqSBo8ZM7Vux5YdZWISjiLD1JbAD3YbbrVw4DmUPuA80brvMEDJWGAo9aHnYkcwjXyVBrm2h/QBImFJT1xwAw99DmzjJKkrEo37uHE0fc/xoV0Hy8fGdf3uLl0kxAbtJ4JrYGy2MMou4iocX7W8gEEB8PejWbz6rQdRPGpXvr61gWxy1maiTM5Uyz2E2KJuBAylA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(508600001)(2616005)(107886003)(316002)(83380400001)(6916009)(66556008)(6512007)(86362001)(30864003)(44832011)(66946007)(66476007)(6506007)(8676002)(4326008)(36756003)(2906002)(5660300002)(6666004)(38100700002)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gHL5zzdGGz26O0sa2xXzvGUHkYg3xVNeGJU4m0Rtl+nRg4G8CcoxAW5QUnXR?=
 =?us-ascii?Q?LBxum5O3S5dvXu/0euVQSsqg2b5TNot3/zKdMQr0rHjrss/fb53dcP5/ISYF?=
 =?us-ascii?Q?vJG8mqOLwWj3NQjb4N8xsCGgF1MEvkDkEajBn4CH5tlaRPMa2DORAUhICy4U?=
 =?us-ascii?Q?sj1W84HgMdv3/Flpri3yGZ5bzEY36RV06FB2erIx+jwgzDrO978QjPyWs1XC?=
 =?us-ascii?Q?QWvtOHoVfu/GFHMno3ZRpjWanXxzpSgmSnIX41UyawfyfJWtzeBTY77AA6Ou?=
 =?us-ascii?Q?d9Ddpki8/RCfnJFbK0omaNT+TE9T02eUl0BFUz1ccrrCaw3G4jg+jLycv8/a?=
 =?us-ascii?Q?9e21S71+6iqXvOuNtXpe8Af1xCPIrCY5wz8vLJBsxTD20y4WzVsQPgTjhHFT?=
 =?us-ascii?Q?ereeWurzJ1SWanH3xhGjs213HHR8J3QGdZ/PvQotQH8AWhXUKhsrukVFbGVS?=
 =?us-ascii?Q?hp8fndKDCQpxBslNj0qoPSHyiKPpMQvdNR9L9x+VunBAXUKSnG3Bkaa7wpG+?=
 =?us-ascii?Q?ZFX4NEGpxgmR/k3EJEYyAUpFoD31sjbxpVK1F6rHR5qFT/m3uHfM4h0u9Zyh?=
 =?us-ascii?Q?KeHJfrgueCejrFl/bRUGs/zJ4tSSi/jepkcGwbVVN4SsLcZwr+iAlEFdRZ5/?=
 =?us-ascii?Q?xFhVxowns/SulXoWducCk08UgbwVhN4MR8Aiy3BXRZeTY3RkoYFhviJESRao?=
 =?us-ascii?Q?lKQN4Aob2r3qj819KZCySW7905NbtF9J6gxblD+pz5I3pFmrMHXkjXjaLuR2?=
 =?us-ascii?Q?c2j4gPpBfuGNTKF11MIfIam/yP4vPtjdBV63TNRJIJ5wylDu5JMW+NNB5ao+?=
 =?us-ascii?Q?kG4rnvd9RnjXMRu88510Yg9A8bTqS7whwyr4If/NX5XCCS9N5NGLXF8YIbgS?=
 =?us-ascii?Q?nDWNxjgmlB88m4styx87YzRyiX52wp19UFCYtmh///LK3weiFSLwVr+ZOQ+Y?=
 =?us-ascii?Q?ZRVCGrs7lmdySeLwMYLftW4Xjl19CnOwNz5IprGSsv31b7sUH7k2JWg3zXxJ?=
 =?us-ascii?Q?nEdOMe6N0mzFuqOvbc/QnR62IhiYuJPNytv0EnDvNjTj2Adjsjrg27RZ4whh?=
 =?us-ascii?Q?M0PMfei+Ik+POuPUnFDEEyyYuD4Poee5yCCqqs3Aqd2Sc/sfk8gIZpaozhMt?=
 =?us-ascii?Q?vaXlrsuTlkIzAGq6PrdTV/2ST5/3hMn1rIY/iiYI9+lm/Hsy6vnNJdPxTmFc?=
 =?us-ascii?Q?x45eBE/qZcSDqEEi72e7z2I4i6x0Ch0rclcfzzi7pe+/T6vpDCeu63xZ/aS2?=
 =?us-ascii?Q?eNpuKtV72EdnnUcRjg8bLZ55XuqDWHTorygkY7DWlmlC1cN39HzfXlqr/rBc?=
 =?us-ascii?Q?OwDXPfsyQm/nqQfJh0ArMQp6tem40y1JLrI1LYCxtRy9n5ojDrljzkwuFId8?=
 =?us-ascii?Q?fnQpENlClrF3BRef8lbedmivCvTfvfORcD5s0n1ED9vkv0By/6clFo+SM/6m?=
 =?us-ascii?Q?Z8ChopMyl+emTFKR0cP7Qi8KPa60iQrX6a3nbDu6KmaFPQqIDLvIjgRPjg8P?=
 =?us-ascii?Q?vV3bhPreUWIWPUPdpGOTDABKzEwZt3OJjpdvbZBAwc45a34gVKP2jOmSjX8X?=
 =?us-ascii?Q?hYsoq2a2wav0IGe5A4+OA2SAC5LkouD+jVm8srK9AT3ZXg+9jiE0YS91LIhh?=
 =?us-ascii?Q?qoaYlYs++Ix0pB3N8dFHRyY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eefcd8-9ed0-477f-bc3c-08da017dfcd4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:36:25.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbXPEKJcPU3yn6xTZEcY2sa66OQ4IVgiPLkaVXuAK08dpuyIlzTkYUniHKT1e6NAfRcZdTp1s8aV529/0zRaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333

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

