Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFD625
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645510276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sd6cdniXMTUQp9o1bUVbYuWLFmOV1rmwaD5EVwMCkCU=;
	b=PxqkfGqkLinqS+oAf/cgMdumbualT4ukE0TsqhMh8ze2F8ah9z9bwhUJ5SHaN905X7PEU+
	kKGTpzyXBnKlnsjknrENB9g+QbIrBW9QU7lpYEgREZfh2ixJBPQo8gLCcgsgyQfIcxK0jw
	G8TsZ9+di3Bs8eF2+1yW32pcfakNXkE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-WlTB4QVAPWKPZsVIkjmd9A-1; Tue, 22 Feb 2022 07:11:15 +0100
X-MC-Unique: WlTB4QVAPWKPZsVIkjmd9A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlomZdkffmkJFm7PyoLoo3XqVcZjEPSXPGyYYerJ1Rl35k4/UcPYupadFCU3PWgmZVTnqNV1ZiH+KhU78KN6f8TTghHK2NcY8d6kGQrNNgXpHojv+Cx7bUp8dTFgWPI30IZijQPlziuePiDHhIc2HvOptfH3HSCJvBT8OhePKqNumXzwO9Uez/qBh9Tr2yGzxFL519gQJo4HiJtqfKW5Vsq//AdFNCv0B7CweoQtlyp2ZsUiB51AY+HsXSpWkSKU3fY0aKNSkr8opQrm+0gR9HSXMHSU7sywybpa/ar4Bjdz8CU4EHOUf7FzG/Vk+YThe6jwV+7BgI4vi3MwpIYj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Risea2WV0K+eg66R6WcGr+75rv7zuOcE+Q0jk0OHd3A=;
 b=nKLkVLgiG6OUCek2I8VyiXaEQmCRNu8UfioWRIem1P75jv20TXIGRKbp4zoSqUHcLzturG24L7S/gtO1uZjKbKw8wN1PCN6TTy+pAqxXvndkU9Ghl1KmxgcyfaTeEaNT82do5IjgF7Z3A86Y7++huK7+VVPpDWS0MKNXsUCB6fL2jiKSuGrpsyRY19MYiwapRpmUYpWqq4JsKEh6GFjPjrb1YPTCbgQEI1fvadc7ypHnlrsrNQMw/cLTvV2XU7gIsQzVcQQ574y603XZi9VddXd2cluNOklcT3Tn2z8sEVx2r3pYTcVKfvMadJaNTxw3XlIpsS1RYbk2qTm6wFOuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3639.eurprd04.prod.outlook.com (2603:10a6:209:19::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 06:11:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 22 Feb 2022
 06:11:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Tue, 22 Feb 2022 14:11:45 +0800
Message-ID: <a355682307154e5fc4f26fc0957f00f931460905.1645510267.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61642ee6-f169-471c-5105-08d9f5ca20f5
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3639:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB36394A2AD4F5C35D4907FD98F83B9@AM6PR0402MB3639.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vGcSvdc4mDCpB5c3VhM3YqCDpCBg/SxZnnWHhNG8HbhfdAZqdst3sUx+bMP8jnsh+yCc7Nb/C9O/QBsTzdeztkzr/6E0+m37lBVNGrGdUryKJJvtazTL3vt7lrH3KynFJdEI8nfO5FypxrU8pwMBcvnUBx8p5iqinYo2+5n/amUp97xva747CXATQpSOMywCfNfZmCeL7alZuXo9vciaaB+32dzs4Yu2T2yh+y1az3NaFZre542WiDkjt+tvBIY9zkxwdhSlOcGuMfaAfHVrpCSpbzqDnD1pw3hxke3yjAAviGEG1vlrR4jn7LpXGznGWBWB3FUhvI2DWQ8Axb9hEYb7ecnHzqjWp0jlmQxz05CROn2bhcStXsr6Ls6fImUMZboWWZ180eX64ZrJw16tH2uf5UQbEtRmtqMWSpq0PYb7y0vdOnTNkaFesQS8Z07UPg4nT3oHUAchqVH0XUzSvjxgz8Yuz8SXsbgwaAwexNvM5EPGoHP9QJuKid67apI6w3iMhjUilnCfn7ihM+I2WAauLMRnThGtqwsOFS7kaDCk2ouKslh3exwPofy62R+DnWYForFx6qchu3dxS0VdKTuAGUJGroBIuGB1g0UR3JIpnVJ+IGP9GG2m0TlhaDeu75sueM+efoqPT/pog60bOgb56/nGBa6ncRp0roAEBpNSqDuTe7cmjz+ZMG0e8ylzPxbIN/5idhwOrD98Xa0hQ26OvgpZhfIRkn5HmtDm/6o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(966005)(6486002)(38100700002)(66476007)(66946007)(66556008)(2906002)(6506007)(55236004)(508600001)(6666004)(107886003)(2616005)(83380400001)(316002)(8936002)(30864003)(5660300002)(44832011)(26005)(186003)(6916009)(6512007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIoflSNb+a5+BNhaK3Sa1ejL2kKpyfghPgzBEqznPvOoPBv2hKyrjnUGj1Xp?=
 =?us-ascii?Q?TG3Qf3pPYmAN0VQ+AbDaU34C0XK9aC07SH+metbZQE46iY5pHKzYYTHXjjDL?=
 =?us-ascii?Q?jZYCdsyRPjyCSS1vofQHgShhU7NWgGn9zxMBdG/8+egkybbokuWS/1FFOFFw?=
 =?us-ascii?Q?vQevam9KiBMUUbEvq8V8wKlhduyNHqG+PANNnvTdasZhsDOPQLjsz8d+Onaf?=
 =?us-ascii?Q?DRltzdVBN7zP2j66zNgY2fcax5L1cO1ItKIf0nwBPbQnj1vpctbAZ15qB5F+?=
 =?us-ascii?Q?C7lccrrXYNFWo6UhtQN8cgeZHBWyRLmyLkAu1vFeura5cQlbJ3D+2f6fojOB?=
 =?us-ascii?Q?Km+qedlRSgCKbYBHFK9MTX/WAfhJDTdmS6DMt1DVEiTx1ZJA+VFWQh0xkMfM?=
 =?us-ascii?Q?NYN1g/LJ72VRAaErCank5kco2xz7/viJ3Uc0JBl++DJzQ+tOp2CS551PwGHn?=
 =?us-ascii?Q?/c/FLXByva1MFZrf3tb27DzcNsyRwgT0ovqFN2bZuZy6ygC1Py09FVbJc9FW?=
 =?us-ascii?Q?7XC9FcazRswmQ4ly7Xt0wiIbWdmJZQ9AmzAafxRZbLhCQyhT7yrt63+Cqa+g?=
 =?us-ascii?Q?UrlTnF9rMk6ww1alXSGodp6Q8vFiDwJpDVneB4Vw3PifubvCS+XiMNbpXNph?=
 =?us-ascii?Q?LMzyeDdQsMLArduUHoXi32Xpgv0GUc+cHw10ultEI7o1AmubQWnn3qxPgPpr?=
 =?us-ascii?Q?dRcX0cIV1KWbaSvGtJVAtxGv7oc6asAP+y/eptJBU+yKKia/o6r98Snj3ObU?=
 =?us-ascii?Q?kqPZ1ssVM05A9HbsV6u7BDuyI6Y9oc40t1367ob276TFHaCJYNgBFcr08hMx?=
 =?us-ascii?Q?0djrQyUQ5mbuETWneETnVPon1Y1S+S62xFnd2GuQElUOy5pVwGUYTLWE75Am?=
 =?us-ascii?Q?XePTtu1i5xg0V3ltOPXEPnwJfB1xPXHgk2mt9xMkDZPumVOFmQYTpGDuqMiE?=
 =?us-ascii?Q?KHX4R0FabEknJpQWSszMfmbYoEKU4SXNUAtd2t16O/SF7tZQL5fRtwxIrE0D?=
 =?us-ascii?Q?djRozFgBC0E9iktlvw3NyEwS5QSDNmDb7/II8A559VaVjp6Hn6jM2sgXgljN?=
 =?us-ascii?Q?hjbq2bJLOdxrjATD34rhXjfedKEB/j2AjJORBSYJcwoaukdgoUD7EF6HtaJT?=
 =?us-ascii?Q?nD7yTqhaWT4mXOiLtKrvW7CIJAI3InzvV6+7Ie4V5DRwwiXDsKl6gSAcSKFX?=
 =?us-ascii?Q?UJ1rihlGY4eo13ttgM5KRrT96I8qo7NeeZT2lebgT7ZXMBo1FD3CncmDo6ZX?=
 =?us-ascii?Q?w2+65WcDzp0+vv81Fol+rj4/xOj0TpRadcwaK/IEqHPeME5+UUbtcO7DcOIO?=
 =?us-ascii?Q?W5Y5gF5HvkWnTinp41jc0nNlKb4b12snSWs34dTMJ8A1+TqyzoDUQ1SKmabR?=
 =?us-ascii?Q?AhjIcb0o8v8vHS1i89Gi0XXfoELOIJhtKgyytH1N1b1feBf+xqdP/PfdDNZs?=
 =?us-ascii?Q?TY+ZY1bzE6a8roF82/Pjl+4wa8P3uzmmAvryYWDL4tE0Aw3ljieDQ5Doe1gB?=
 =?us-ascii?Q?fsVHwH3K4+edEOm0gVqGC9jBDCBSDRK99YzVMP4mD7vREzhfJiRdf7233jLg?=
 =?us-ascii?Q?tjm38QlT8QTuwpQTuWzmTWkAWUxFuW7jnlcR8KzeC/4T9wIfOknqLZOXsfcB?=
 =?us-ascii?Q?GaYCEwJxbaKCWDS6gQYL2XQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61642ee6-f169-471c-5105-08d9f5ca20f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:11:13.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrRRyuoUtIkdqyoj3GgV2Dm4qPh3NAG3vvoj3ksfbjr/fgg9rRE9p1UtqE4L6TNx1j9qOiTHlwBSNwxVL7M5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3639

This patch addressed to the comments in [1] from BPF maintainer Alexei:

'''
On Fri, Sep 18, 2020 at 02:10:42PM +0200, Nicolas Rybowski wrote:
> +
> +BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
> +{
> +	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptc=
p(sk)) {
> +		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);

Could you add !sk check here as well?
See commit 8c33dadc3e0e ("bpf: Bpf_skc_to_* casting helpers require a NULL =
check on sk")
It's not strictly necessary yet, but see below.
'''

I added this !sk check as he suggested.

'''
I think we shouldn't extend the verifier with PTR_TO_MPTCP_SOCK and similar=
 concept anymore.
This approach doesn't scale and we have better way to handle such field acc=
ess with BTF.

> +     }
> +     return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
> +     .func           =3D bpf_mptcp_sock,
> +     .gpl_only       =3D false,
> +     .ret_type       =3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,

In this particular case you can do:
+       .ret_type       =3D RET_PTR_TO_BTF_ID_OR_NULL,

Then bpf_mptcp_sock_convert_ctx_access() will no longer be necessary
and bpf prog will be able to access all mptcp_sock fields right away.
Will that work for your use case?
'''

I dropped bpf_mptcp_sock_convert_ctx_access() and use RET_PTR_TO_BTF_ID_OR_=
NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as he suggested..

Both 'bpf selftests' and 'bpf exampe' work with this patch.

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp=
.thefacebook.com/

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h     | 19 -----------------
 include/linux/btf_ids.h |  3 ++-
 include/linux/net.h     |  1 +
 kernel/bpf/verifier.c   | 20 ------------------
 net/core/filter.c       | 13 ++++++++++++
 net/mptcp/bpf.c         | 46 ++++++-----------------------------------
 6 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a17c1e3a6bc..6f840ece0e96 100644
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
@@ -2364,12 +2360,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
um bpf_access_type type,
 bool bpf_mptcp_sock_is_valid_access(int off, int size,
 				    enum bpf_access_type type,
 				    struct bpf_insn_access_aux *info);
-
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog,
-				      u32 *target_size);
 #else /* CONFIG_MPTCP */
 static inline bool bpf_mptcp_sock_is_valid_access(int off, int size,
 						  enum bpf_access_type type,
@@ -2377,15 +2367,6 @@ static inline bool bpf_mptcp_sock_is_valid_access(in=
t off, int size,
 {
 	return false;
 }
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
 #endif /* CONFIG_MPTCP */
=20
 enum bpf_text_poke_type {
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index bc5d9cc34e4c..335a19092368 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -178,7 +178,8 @@ extern struct btf_id_set name;
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_TCP6, tcp6_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP, udp_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP6, udp6_sock)			\
-	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)			\
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_MPTCP, mptcp_sock)
=20
 enum {
 #define BTF_SOCK_TYPE(name, str) name,
diff --git a/include/linux/net.h b/include/linux/net.h
index ba736b457a06..9c1a634e5ac5 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -238,6 +238,7 @@ int sock_recvmsg(struct socket *sock, struct msghdr *ms=
g, int flags);
 struct file *sock_alloc_file(struct socket *sock, int flags, const char *d=
name);
 struct socket *sockfd_lookup(int fd, int *err);
 struct socket *sock_from_file(struct file *file);
+struct sock *msk_from_subflow(struct sock *sk);
 #define		     sockfd_put(sock) fput(sock->file)
 int net_ratelimit(void);
=20
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
index a07b28997ad3..a143f7631bba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11143,6 +11143,19 @@ const struct bpf_func_proto bpf_sock_from_file_pro=
to =3D {
 	.arg1_btf_id	=3D &bpf_sock_from_file_btf_ids[1],
 };
=20
+BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
+{
+	return (unsigned long)msk_from_subflow(sk);
+}
+
+const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
+	.func		=3D bpf_mptcp_sock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.ret_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
+};
+
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id)
 {
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5332469fbb28..6877fa5b5c66 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -26,47 +26,13 @@ bool bpf_mptcp_sock_is_valid_access(int off, int size, =
enum bpf_access_type type
 	}
 }
=20
-u32 bpf_mptcp_sock_convert_ctx_access(enum bpf_access_type type,
-				      const struct bpf_insn *si,
-				      struct bpf_insn *insn_buf,
-				      struct bpf_prog *prog, u32 *target_size)
+struct sock *msk_from_subflow(struct sock *sk)
 {
-	struct bpf_insn *insn =3D insn_buf;
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk)) {
+		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
=20
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
+		return subflow->conn;
 	}
-
-	return insn - insn_buf;
+	return NULL;
 }
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
+EXPORT_SYMBOL(msk_from_subflow);
--=20
2.34.1

