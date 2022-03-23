Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1161391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJYyGSsWj0wodwpQT60HtMeFh2A7sFxXkUVmALFFzsg=;
	b=e1DWNC8APcPZmbHmLPpITpJAxarAZxmmePE97s+PoHM+Mr0EIAbO8o2yk+Nq9HNjAI65op
	fsB2rdEJ/4w3cbCsyvlfBtZHErNgKwiKcW/Atnu7vT4a1kt5vtbMeX2xbOZ5AIoirteQ3M
	no0ADLnty3gYPDUrN0noUTT3q3poxUc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-QY-euDxoOiKa442F5h5KRQ-1; Wed, 23 Mar 2022 10:09:53 +0100
X-MC-Unique: QY-euDxoOiKa442F5h5KRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5GvdteUboy4t06BqGfu5H4Z3E6kUPUqCicCECXesWNKzc/etsV6YaeBc3ArkhWVSfza6M1bmHX2Ps4FE0irE0YPSk4mDFW9GJZHDcl3hoQiQBU3g91VxhZfbYh0BsJ7hPVr7b4MQAJmXNecdlR8pJjcKq+MGkomGEx21xEMciCjYe/81q3XwZxtTii0sgV43OC+WbZY70xcWpQLtZQfL+ziCiZdL+PP/hQrDUye/3Ig9LCXD7B2DBUxpohB/NvIpBxepwYXyV/csyP0/DXHRkPQRlgGFm3TMxwe7aEE6ZscEn3WdghtKLbXQw0XylayEjGPDmPVHArKwmT6KYGwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlL8awy2RJfx7Q/FKuwlRux/DDNlPWAmzwh9Zyg3HZg=;
 b=AVyCNT3FgJVZoVzPyoaIrx98XTUIPmvka66pDh95crHkmZQwT02ign0AS7hjGMSf3Vb8BKnNX9C5N3vLbZQdf7VsdeAhBpSUQni+JitPwtvCFmFKwr7GT1c+ClSinjVg0C6PWs6Lgk9lEJ6yQSEzLjwtBN8bj3RQLZwa8JfX55zMQOtVQUiTMm+JJpKwAgjNiOP2SvBGCIZYkEKXlWUf7MMk+UJbMc6efkkocXLeiuCsI8J/YmhbqMPqI5x64BcA+IE/CcmUpz54QJLo1ZQpLHs3XCJwY2hUXCgjVu/eSZ3i0Jahhev9jbONwaQvqrWUgsyIu/x/UMEMqCnL8ZWlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5988.eurprd04.prod.outlook.com (2603:10a6:208:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:09:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:09:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 2/7] Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Wed, 23 Mar 2022 17:09:31 +0800
Message-ID: <3aeb872bf754791a944b2b6ac221d58dee53a8cb.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 763b473a-ff09-4215-4184-08da0cace33e
X-MS-TrafficTypeDiagnostic: AM0PR04MB5988:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB59886D781668DB72E25CFB2BF8189@AM0PR04MB5988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1/VCO67L/xdLfjR4iOFX7lRIH7sj10qp5ujY6o5dDRNqmoCuiZQKb1K6K3gIP+H/ijIzbcdv/6XKi0SLViuir4mP387/IrzOjlUQI2B1HstA93gI1uelTv3SmmINUyVeKrOJQCITypR/6EIPGQJk3Eaug/u29rFE2nZhuHRWrtqqxMkw/hSgtgNixVFKOOv17LCQ6HMR6rkzg3uQzilzocHd3xlN7YQ4e01FhX56nLEImRWZN6LflOAThcrGUa0BENMgxdkiXkpdP2+DK3ai+LBiNKK1zD8VO/Z9CHDdCVrxtOyKwP0XJXOp7hnF7D3QsO4Ueuo3xp9UdI8P633iwEsWtAm3CcZ4vTT7rISfh9gPi0IoYB6rCJNgBMecnyTAo2KRXhd6dooXwCMtUJEpIK92z2XgL+08QSYPPyldueWzLl8Hu3HaKptLQTKIXU7I9LzDWz7n6IxFl5DpW4+nljsAKRVV7sqH5ExUekrzH+WMNzstPG1Vx6jVBW7mzTxThyhDNYdP7oAyOblxe6QLRUTjB9vobx6c3JgeftO7J/Kd+NdAeq24vkXh/wtlCG0nFFUtutvtFQyDIEgjDL/W65AaVj79Qn8Pw44EsmT6fFPPy4tn2X5pEun6EtGryI/R6GFQUUHcvs5eVv3kr5fvO1RrQbrsNb7lm7d0LeR6LiIuBM0gs8+s0lxvEYCwcgrKiJe49KtezDwwmUoW/EBpnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(2906002)(66476007)(8676002)(66946007)(186003)(26005)(2616005)(107886003)(5660300002)(44832011)(66556008)(8936002)(30864003)(83380400001)(86362001)(6916009)(6486002)(316002)(6666004)(36756003)(38100700002)(508600001)(6512007)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMI9O3LuNP9w44mmRP/W+/GI0X/2tfOoPt5xMZwMakJd1oGl5u3aCitcdCKA?=
 =?us-ascii?Q?424jhUa2BKuq+I9ntIGIrWFAdkC9N1VDE6Haj50WbvCfPU5zf9VxJPFsNE+S?=
 =?us-ascii?Q?wKBpSyA+GZHvYU7v354lxLE5NeCnsvW+6YPw0Z8gvfLZJOruePDfVUpQINUP?=
 =?us-ascii?Q?AOLY/UA5y8vuUL1bsPXSF+XqfPartccnPYxHFDzvqkdoEZdB8nG7r6ZzAULL?=
 =?us-ascii?Q?G1bZxeEI6cebkwtXxHXjJ06QY3MEZzxolFJTtATCqavH5wPrS1cjnPpZtvA9?=
 =?us-ascii?Q?rTq/DF/NtrbDNBv52u2SaQkocrVGQWmxaftRf3aT8OaCW09rbOhu8IU2/os3?=
 =?us-ascii?Q?4twucPVfVStOr45ca2dDRrDMvTu4SYK78aWjOpeaYXrx2uW5vz34eX6xRLi8?=
 =?us-ascii?Q?jM+tQHu+kgygARGcGU758vqmRfCMSmqA7Kp1giYsfpmldp3mB7cCSkPEv7ZL?=
 =?us-ascii?Q?WLu9thTlpexW0R7hRUXZn/aZ9/RqX4Ev0adzHaNqdtT/aATOcJL6xgSb+2bS?=
 =?us-ascii?Q?QQyWJ7T7wtnpMsGGHDl7PC8LraGnmfOH7W/KCIPSEnx7T8Hk5fVd8YzalrMb?=
 =?us-ascii?Q?MM9q+mFQ3qYvA2VWLJkx35Tow/ZE+3s+Y/ywL+SQQ3CMLAnE7eegMnGrar8x?=
 =?us-ascii?Q?ghLNB3WCQWNKl6ym39n48FoEML8TfiRyctwJYxIGcB87BEFJVv1VYXPSZyXk?=
 =?us-ascii?Q?v/TEvhXMBx+C/3KNWpn/QeLuEWMQsi9LkhtLNGsReIcyzNL5CMVmvHcIYZEQ?=
 =?us-ascii?Q?NbPLB434ftevyqQVwwPsA+HnhVF8KrsAUETPRN3cXUeRINMiXoJw3r17s1a9?=
 =?us-ascii?Q?vxOND9PII0CyElBJ+1YBZih3mUdQicKZJrqG62BUgaxqJJcKS2Js4Gnu6puD?=
 =?us-ascii?Q?48RDHnlnzU4yHJDNlr6QQ4b3jqUDNn36yd1m47aR1qRw7unpxPsXQoQJg/vW?=
 =?us-ascii?Q?szCg1yreOJbLPqy4GrSMQ069m2WinvxBH756ybw1lvwCYgeaAyov7dBkZDpp?=
 =?us-ascii?Q?f6G83yDOxzwThonw4MzN4nSoSKW+HxYTa2hbKLxYcecVNMj8T6+MRN7A/VWY?=
 =?us-ascii?Q?bSqIdSAMw8S9qcTPhkrNTwzqR/aOgWXvN85CtwsNE3jIJlvzxVGlxA/osTVP?=
 =?us-ascii?Q?+39y62dvXQDpr9htlnFUVf/9YMkKZ8D+2LRd0ADGtxyVtiGmDgIgf1hBv4CA?=
 =?us-ascii?Q?aM+nysmmg12KQGUPrq5tVCLFPDMS6l/sbZBV5/U4M8d6T2lGoivHSxyaLG68?=
 =?us-ascii?Q?v8JE+Lu3IZAg5CAHMjen3HUt0YSg/c+5iDyZE/Y+K7GwCcv6QB1XMsMPoRud?=
 =?us-ascii?Q?Vuy3zuSwMNPRQ8/j+Hkd/6qz2TWyUW7vdlXfISzndMIL2hN7b7YhJw5SvxTB?=
 =?us-ascii?Q?FlIzJUifis6PKljyr/L4bZ3Co0H0C1F/nfkRW/GODnb+jjMgd98InDcTkP9V?=
 =?us-ascii?Q?iWF9Wtg83KKKsweenNrn7TPVUbj4Y01TQ/Td4ZOA0MBotxvL5s8zIw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763b473a-ff09-4215-4184-08da0cace33e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:09:51.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho67hgbc/3WfvTE1+6nlvWT+ntiHDFjgp3tCTuSZmImvmE63+KEO3gI8v5l6huVej9j37XUt7iGRS0V2z66CQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988

This reverts commit 8738c0bc4122c4d2390d2f1e8305e8bebf199f14.
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
index 3f368c8b7e48..57cb6af3177a 100644
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
@@ -2232,7 +2228,6 @@ extern const struct bpf_func_proto bpf_get_local_stor=
age_proto;
 extern const struct bpf_func_proto bpf_strtol_proto;
 extern const struct bpf_func_proto bpf_strtoul_proto;
 extern const struct bpf_func_proto bpf_tcp_sock_proto;
-extern const struct bpf_func_proto bpf_mptcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
 extern const struct bpf_func_proto bpf_event_output_data_proto;
@@ -2320,7 +2315,6 @@ struct sk_reuseport_kern {
 	u32 reuseport_id;
 	bool bind_inany;
 };
-
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type =
type,
 				  struct bpf_insn_access_aux *info);
=20
@@ -2371,34 +2365,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
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
index 2a82b9353bab..4ae3cac94fb2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5117,14 +5117,6 @@ union bpf_attr {
  *		0 on success.
  *		**-EINVAL** for invalid input
  *		**-EOPNOTSUPP** for unsupported delivery_time_type and protocol
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
@@ -5320,7 +5312,6 @@ union bpf_attr {
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
 	FN(skb_set_delivery_time),      \
-	FN(mptcp_sock),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -5676,10 +5667,6 @@ struct bpf_tcp_sock {
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
index d40982ddd255..a57db4b2803c 100644
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
@@ -2784,7 +2780,6 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BUF:
@@ -3677,9 +3672,6 @@ static int check_sock_access(struct bpf_verifier_env =
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
@@ -3836,9 +3828,6 @@ static int check_ptr_alignment(struct bpf_verifier_en=
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
@@ -6768,9 +6757,6 @@ static int check_helper_call(struct bpf_verifier_env =
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
@@ -7485,7 +7471,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
@@ -10860,7 +10845,6 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -11391,7 +11375,6 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type =
type)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 		return false;
@@ -12816,9 +12799,6 @@ static int convert_ctx_accesses(struct bpf_verifier=
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
index 7c177f247d0e..f195cf034e43 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7889,10 +7889,6 @@ sock_ops_func_proto(enum bpf_func_id func_id, const =
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
index 2a82b9353bab..4ae3cac94fb2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5117,14 +5117,6 @@ union bpf_attr {
  *		0 on success.
  *		**-EINVAL** for invalid input
  *		**-EOPNOTSUPP** for unsupported delivery_time_type and protocol
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
@@ -5320,7 +5312,6 @@ union bpf_attr {
 	FN(xdp_store_bytes),		\
 	FN(copy_from_user_task),	\
 	FN(skb_set_delivery_time),      \
-	FN(mptcp_sock),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which help=
er
@@ -5676,10 +5667,6 @@ struct bpf_tcp_sock {
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

