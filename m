Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A17362
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645519925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sqyMnJHTMDLaYql2mJdMHwx5JbEpthf+tNrB4jhmfgM=;
	b=PDcyF+JmkhDS6oxNFdjJLEQHtSaOy473L+RNcTOobb/QiS2gkP4OQWyV1vB1dBEfkGSdXN
	GP8GnDhWJnjHsnj34kCGB09aIjAXiypP8wcJM76HkcRHh7R76NhU6rf0xuDMk52u7AT36a
	xl6K3mtZo7sSjC4MDJIcxsxxjVJAXeY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-wDu8unsNMsK6P9VqsBGELg-1; Tue, 22 Feb 2022 09:52:03 +0100
X-MC-Unique: wDu8unsNMsK6P9VqsBGELg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc8iIds8unngrkIa+bX4d8j8SuZ+nVgOQo+pfwCmMUImcVU/3oDlDALZEpkAqn9os0D/pwkO8Z2ujFWFg1NxAjn5Hq2nJqNtK+/YhfRTg3yFzr082TulQdIzrtWF6ZVsqW+DCVbBFvKccdmJmVI6/l1nsNUY15nGl6N5Ec6UO5h8DS3fAXPO7Tp6G1RIBzwr9EC4NwWa/C60XkCcBgQ3HaSV3SOYe5w/FjZ2bdFcVLWua3wxdx5+i17Z37lXFFzh/RI3gfmpsuTcG0OVvCGFh157Qoon9W9beFP1ZMY+rbVFQkfI6HRNxn3ktnX5I6F6YyrOd+JYTNY8HPnSKOsXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84qge4mTWce9N7hLUSt9vTUCgOWzVcdFGTyAsD4eSbc=;
 b=lVVvZFuj+HPTZBfhO3AWKJOueVFh6Dy5p8NoWMIJ13f0UMVPSQL1B4A4boPKAAYqQMRXVp/caM94lVWW9/tJJU5n20Lmfswtwm+mMjtlerGlIlWBlRSgQ3ZKVAA90Y3qmsr9QIMjEgRypfYInPrT6mtnFLkFoucBCERL0rCo29+ALucwZ/iXplejBVJwvXku5PwylQC16DO9re3G0vmQpBQlHMYJYl6fCZaI/ZEzcmw/rzemCwajy5K3ioQwXo/QJDgZLq3o/qzXxMRzVjC6fH3wAb5Hkzb7mqAAbbk1t/fASIuwgWw+hLBoNQm+G5zqPUVBl3NF28hs309Wa4NYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 08:52:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 22 Feb 2022
 08:52:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4] Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Tue, 22 Feb 2022 16:52:31 +0800
Message-ID: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:3:2::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac75bc02-8cac-4591-0e5e-08d9f5e097a8
X-MS-TrafficTypeDiagnostic: PR3PR04MB7338:EE_
X-Microsoft-Antispam-PRVS:
	<PR3PR04MB7338B4A415114E7126725D0FF83B9@PR3PR04MB7338.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q6g3YyGurUrcN5MlQj7tV4R3jXecujizCkiQuy9+dzY1uKXiBv3nXV+KZtRn5FDKwYoMaHodLCBAQTtngwCFAM4Hs0Ks1dbGro52w1fJw3MAGojvYGF+WdjleEqB58EEfsAf27VJA5faBX0U+tkeQwMqMw27fFSEJrBU32qF+uyA22u6Zp6oWwiO6X+6LJh6fc0IkqHGJY1cWIuwKhjq4WhK/0sYTDI37aLoqlfB3qNZOE49rzwBsHZbQUbXFKUDHYHXYwrN1sp3BNYa054RIrPmUTINk/ZNwM4Brw2gyA9hE+7JMzh9t+1aXvniBgu5vau1q4JY2FoAgEjCg6Es3O+/qI3jFdX5NnTcfuBAE0UCWXDK6kCck736TMiT4kQoG1qW9zK2/vMHkeN7IS8WJZfzkedJWsmFxLUycFK+bRlTy7g+MoatLUj0k3xT0CXoHUTQO4XuJyA2G4edhjA9DnKtgeQDPWAftlr/AQ4S9lOkV2OkAe4kmBMG4Nef/oeo45vfbPaUxzCSOy5W4/oIHRDfY3bWWsBWbn+P4mD1yy5NVxavsQBXyFYN5aIDlkPKOVShFWwEJ+HyZsS3L/fA2OlZbCvbNgl6YE8zQRok/Xy2lOGuE4cf6Oap5hhNuJzm8nad3lJ1aJA9x+CBB29Wrmhx9KaQOth6iaRHKqneLG+8EM//GvlW+dYfVF8MoaTDRIuEgzZliS4Ggqe733DDMOVTYiBAhZmBgNAtt5Wh09g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(86362001)(8936002)(6512007)(966005)(6486002)(83380400001)(30864003)(6916009)(2906002)(316002)(5660300002)(2616005)(44832011)(107886003)(8676002)(66946007)(186003)(38100700002)(4326008)(6506007)(6666004)(26005)(55236004)(36756003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIQQLv7FFQHQSY/sNNVD7DelPPD4YQFiLOu5fuH1leP6o+2OqvSsciIVh9oE?=
 =?us-ascii?Q?bApgJpfop2p5CoK7971rpFGjmKhqHdilBw5w9FEl90eFun41d/H3kKpynARE?=
 =?us-ascii?Q?80AXtRSc2DdfwWr4xBuNQ2dPeMnYb0MZ38iMgrTGECx23cdZ/oSGru4ISeax?=
 =?us-ascii?Q?/sZnUH7+Wxk8dY+NhfHy7fNluNVpuSPe0yFtMxtAKvFSh8fdKLiLdc47gwe9?=
 =?us-ascii?Q?dTM5oL4ot/LBsq4F0vP2fbE+yG3tOt6UVMLizyBAEAqjEqcM0LtTyVsJzexE?=
 =?us-ascii?Q?0Y6BbWwCIJtoGMuV/T1nPJE0mShLd4FJEzVRujbL0YbKKQXLV0Cp/EJ2FDL5?=
 =?us-ascii?Q?iUUUnU7+ffNANBxGO/u9WjU4fPCp9eZY437Qu8vntankLcmgVQlCwav7OqvD?=
 =?us-ascii?Q?i7K1dRocl+iZiNlxKN3iWQJweMdDmXE5lV8uV8IBAXs3jA9BE2y+PngBqYU1?=
 =?us-ascii?Q?AYZu4hDeeYucO6hd4U5uNLejB6p1CyqCkuI8dsLLzY6wKdK6e05+tktjF7PP?=
 =?us-ascii?Q?fnL0pl3Uy4FdVXu/85eqNvpjQ52MAJOjG5NMG9KiShrQ6WH1sitD2hdBu8jN?=
 =?us-ascii?Q?aHJlCRU2iDfA3zg1hlQFg9svzKU2rOntlyBorzI7ClHRNC+T4MvoJAYyDepK?=
 =?us-ascii?Q?7DUgBT+4jBObhi1/vqPAMLcpoJA1abp0v+WZ+Ot7EHcgj6FCPZ0AWw34v7MR?=
 =?us-ascii?Q?7iE47dU2uPsn6HSQV5JLCKObA2+5qSEcFx5lga1W39BgBszeFVqFxjBhZpMp?=
 =?us-ascii?Q?gU4sGI0vH3CiyFYllshF4gWc0PRcyQj/FLrRQtD4oNOjVkdUti9ZGHwiv4/d?=
 =?us-ascii?Q?Ew2fnibcagZ9MFDjrgy/siY5qSorfY7hnd0pTnP3Tta12IxbL7ie4C9v/hsE?=
 =?us-ascii?Q?8T+mxJZcxRmWONqStA5C3f/yW9QX26DuOXmBRiAM8hHU4kCdrEjqmn2VRa8X?=
 =?us-ascii?Q?M4pcqgvCcqNGvVZvJeVzh2vHW7IMcbhXg6AWS8eIEZYiziSEHhnhgChYoTEQ?=
 =?us-ascii?Q?rzU/b8KtOoKtcaG11DqTMTBxzqU/Re5svLN0sHGqU1h5S72wfZqEuKeMaEAw?=
 =?us-ascii?Q?Gy1HNUWCCreTvCSF4voluM5BtuCaotFy3FIDdUk9Dhb7bMmBUR1T9yhhkBaU?=
 =?us-ascii?Q?pivyxeQDG2gUPmoG6WKrlyMLowaCqe1Vnxl8I/VGK7dOZq3xBJsBD1Qbe7KQ?=
 =?us-ascii?Q?rKYYxkbR5Q2WSBKFe+30RSoOM8f6DmXwtNB8OjFPn8fiO56mQhBuYZjFISUG?=
 =?us-ascii?Q?XE8/+Sg0A8CcqQcF0UBext2WSQxffkIxLdmu6Xh4TeP692kB2hdtgH4NNcjU?=
 =?us-ascii?Q?HbzsLBe+34hfqXhkAkQy7H+N67xDtCknB43vkzBI/wj3/fJrrnsbi3RVTaG8?=
 =?us-ascii?Q?NfqCnvETT7vcWhyVo1FewkHu5EzHsgVcOqyJXWSHWxm1ImzmFkjaHNfOCJma?=
 =?us-ascii?Q?qYHPYDHCs8spFm4cTD7+5ujjg8si8jPugnjpCBXUEWmIv+2CMxQrH2Yh/cf5?=
 =?us-ascii?Q?iLQHNwJmTuq3/bnGgYpk7WroItxqnZc484ecIhzMH3EqGSr0j0ap8nD9dGUs?=
 =?us-ascii?Q?f+2xO2f3wCX8HZRj00yymJGVquAZGo9uqurSMjA1kihXnw4Ggys/Yq15wj0d?=
 =?us-ascii?Q?X7g8015Nub2527C6szi2bMs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac75bc02-8cac-4591-0e5e-08d9f5e097a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:52:01.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhQuA/qjxP/xZnTUYDzhfTGMLu6uVXBVz19FTg/LgaV54K5YpMrPFKyoL/GyHiEkev6L7cR1wdG0b65Ry8/ZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338

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

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h     | 20 ------------------
 include/linux/btf_ids.h |  3 ++-
 include/linux/net.h     |  1 +
 kernel/bpf/verifier.c   | 20 ------------------
 net/core/filter.c       | 13 ++++++++++++
 net/mptcp/bpf.c         | 46 ++++++-----------------------------------
 6 files changed, 22 insertions(+), 81 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a17c1e3a6bc..f1b1f44c68ab 100644
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
@@ -2364,12 +2359,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
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
@@ -2377,15 +2366,6 @@ static inline bool bpf_mptcp_sock_is_valid_access(in=
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
index a07b28997ad3..43fbdd5e602a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7395,6 +7395,19 @@ static const struct bpf_func_proto bpf_sock_ops_rese=
rve_hdr_opt_proto =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
+{
+	return (unsigned long)msk_from_subflow(sk);
+}
+
+static const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
+	.func		=3D bpf_mptcp_sock,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.ret_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
+};
+
 #endif /* CONFIG_INET */
=20
 bool bpf_helper_changes_pkt_data(void *func)
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

