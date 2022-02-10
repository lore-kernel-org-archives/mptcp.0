Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729692F21
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644490996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hqy4OngcBwibPIpuEA8rBoJ7F0p0BlihAlHhFjnPKpw=;
	b=hrNoMYk+zMJtxl7Bs9YtuTI1LFHm8KaCuRYtr59UY2EYvqFwIMhLgzqifVbHaIiaLyC/WM
	HFXa4u51weSPG8bNkxLuBtheaMP1yrlZy/sOSuMmm36gnodH/VvXya01+2aTROZhjUkCX5
	gLpSRfrO/HzXHeIvX/9RKnXV40yeQlU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-4Aiil4o1PkWSW9CBx3mElw-1; Thu, 10 Feb 2022 12:03:15 +0100
X-MC-Unique: 4Aiil4o1PkWSW9CBx3mElw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhawK5bxUc/T06m2bX1ANAGEyutsJFH/IjDS5yN0vAjaCAUyKkrczDuJCsVnZc0MCkqM42rEEYlHnbbunUVxmkold6aNxPB0IVu454Vx7xnXRdm7hjTxVqrBxIgJQ16l6PWK6t62m783hm8G+ccUOfgQg/3m+kFm2aOAtxg7R+Y2YBFwhbTE4zyww57/eaE9zmXMjL6c3ORS4FpWM6JTF9r40fy/xT7bV6h+7O9HIm2lcnc5Fjm+PKw2nbidHbxCrNrrU0S9/QySNdIqvVIiDcCICbWuoWOJKq98F5laA3L4S7zRHXd/TiLa9fpNuEP1aJZhDiUJ3r3hsWv13okUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaUKLXH7er9e+FflroGVy8vm0bKCiDx5+LraQk+clak=;
 b=NNHlOLi6/zFLflJbnzaMP4YRmSRaSYHpTDv08iNnL0ckJep4wxHxXv0dOYLVoUACatqG3t8S7GDkN+1nv2l8Lvf/HqQ4C0WsY+hp9HYnkjIcNi0JN6QsI1/1/XqkTl1jXH0vowFNE0Og+/szf3o2IQNcTEZMn7Jg7T0czsSXyms1ahZIDSB2r9MWdeuLTEZGMsZwo/2j8MBJRI21F9iuCVIV0JPrubsWP4a35eIwEOgpI/0q+EeII4YyXNQKzAzgpQju0JB8Ud2XcjOMJs532zpeLlt2NElRy3NDkdvuX28AGnZ/+DCVNibokW/J6OJHkud6re9r+TQO2D4mc6h1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 11:03:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 11:03:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Thu, 10 Feb 2022 19:03:33 +0800
Message-ID: <8b35b6817474d6b5ea0a3e5c8be617af6d130867.1644491001.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3231544c-8e5e-436d-f5cd-08d9ec84ef05
X-MS-TrafficTypeDiagnostic: AM8PR04MB7441:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB7441A938FC489EA6A67D29EDF82F9@AM8PR04MB7441.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oer3o7NlKdYXW4EqKbVOPgHcsIZdZjHr62FQOvu5FvRO3rmGIGxEhL6rXwzeECWSdW8Cqv/9jTt+nhPq0Am0nJ7yDXheooQXTgqwVvrcSIcvhAp+F0vA5Dp4FBStO+eyfr5Nkr5u/E10GMWhc3G1z0aOifQX1HBAavxMixfwdDveBpKGKtGZvEVlDhJ9RnEvpfHEljHx4F6kmRStL5sHG87MDGhlw1YIhkrTx50lnd7f7LyyvfN9iKte3I5M2PIY4aNndzCSIlnOt48TPa7dKc2eLzQ/qQAfAyYT02Z3pkHTjlcHW53Q8GfIU1B9jGfq1ze1OOv9Qd3ld/PXu84gC9mXAMUbU5GgKfegGizfse+mcrO2w9FJXNsn66lMaUNdq6xVoeAGzov333ZewS4XJH+9FUKw9sZaqk5F4vRETgcs6JP/F2lAMKMpFhdkCvpWWUFGcus1omgi8LftTyiaAd0qpaW2lj7kz0hXBtKseq/+tPlERAoVCyKVOr/jPotNs9dTwd0KFi3x1z+ZL4JF0h/LvgOi+KqNlKJgIBCyYzecgdDXqhom/kOkMaG43nOV7hulazZqGjVd1QTjVclhlEyD80JXm4+sr8ZajeVzHEZCeWTb31wPxTdhpzwMY9Wpfr6lD+Zs8tBy15WVQ1rHnPR36dYzGr7Ri3kShuE/FHH0eaE5VxRVGaHUxgSUXp3FGl7Mk5vEceYKYJWQFhXT92X2H0fbQWtJ+QsR7NuWK8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(5660300002)(66556008)(6506007)(6916009)(55236004)(6666004)(86362001)(6512007)(316002)(4326008)(8676002)(66946007)(66476007)(83380400001)(36756003)(508600001)(6486002)(2906002)(26005)(966005)(186003)(30864003)(2616005)(44832011)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLU5ZXWcdzuZo78s2fGIVkNewG17qHKccU7GwRS9391YQirsfW3CmWoGT5Dq?=
 =?us-ascii?Q?r5WUpI67ZfLB5Zua3eiD4lUy19/9NE3DoFJnVD3TFIhFjgqWsFgawJGSpxYb?=
 =?us-ascii?Q?pE7CBn4a87wjSawwIUdaHWJJU4ld59I0v3VenlH/NyQ1kPWPr3uBxVHf7jRQ?=
 =?us-ascii?Q?t1i7z8JXYdt6qo1+veBoePrhiVKVXQWL+ev1z46G4hfT8UFAomUNtozyC3QE?=
 =?us-ascii?Q?MZ57FwbbBGzTtPZFKNvc+/NE0quOiE3QyKI5+5JhelMKsyq71M4tlEZAwjPD?=
 =?us-ascii?Q?zRMvDVZlmpihazAJIUPAa7rZDuwfcoD+TUbKyWc8wjSAX0Lle3O1xw6AoNoE?=
 =?us-ascii?Q?M4/n+SmjzmTfmcTmQ5jjBJkimK4i+SKhIRI/00gn0MLM7d/pc8C7Hw0QMZwI?=
 =?us-ascii?Q?Qma9GeC51bd/O98WzpnwgyAEDOPBSa5pVbNk2VMWMciCDh8RsoyQBL0bT9MT?=
 =?us-ascii?Q?eO9HJKN/dcTvORTGXJlpGncsycxEQeKqE/97+CNTtE2vTlMqUiClVNUpt5ik?=
 =?us-ascii?Q?9qCMBPeXW/yG+s6aD0RT2KFOB0h9MUcMCGTcrHdqXJHWg8eOD8phhef7rlb1?=
 =?us-ascii?Q?P9Fpt+PjCohmmvnOxFI/DOjIXOtQoiT1SsfvvBN+c/Re6tX+puLRUZDveSdz?=
 =?us-ascii?Q?aaNHJq+DxT5xM8wJKwKi5WQg+g6wwmTClr1faRvdDsyhdFPtb7yqiymobWt5?=
 =?us-ascii?Q?C9hVSgkD+pqZa8R907qvVVD5QtrvHmqkGKQ1dkm56mqTryjgvUSh48zfyaiH?=
 =?us-ascii?Q?ssnWQM22P0hkIRGSxwNJyba9ra7pV5oWtw9XC5iU5fD06qerJQF4H7KqTaUZ?=
 =?us-ascii?Q?SD4FrDi6t12gk0FYAfpp1Fkk910dsdWLV7ygRmAFqB7nOE+W1BsSzy1Hke4S?=
 =?us-ascii?Q?lTpTdP3wJYkmLUPSIyjQixoEyko57aGThvcApALpWF1XD4h2iXI51ITOlFzD?=
 =?us-ascii?Q?89s+DEpNHBvNVB/JKunhS+XAz0xCwt15DXypCIARmEvGJAz01JBKnvkT8Ggj?=
 =?us-ascii?Q?2Y2bVNjuv3kmgMiQtBBWgXXx+pZYxYybaBHQYUhMhDmf9dFHACTdPswQYoRq?=
 =?us-ascii?Q?DSrnlzh+1VtFa1j+hXs5LRJKhY22LwWKlpX4oh0E5hm7v+0hYpEt2LKa711f?=
 =?us-ascii?Q?sypPIRcqYUeOkptcbHh6WS4K3zuZtI0s7b0t7L2+ej7cl+iqL+LBjsYCCLHI?=
 =?us-ascii?Q?E/OuVYISuPoAGu+OOS+CVqb/glHOms4SjaNvVR3mVoCC5dkItvnJgkS4d922?=
 =?us-ascii?Q?zdSxDw06ENuDzZu12dccxDpfFf8EiFxS/+xNbAGluG2usZOmIAReaqNKSqwe?=
 =?us-ascii?Q?cBhsiMVI/tUvQvQhOoZliWrUWhbwRNzlOLpOlCF4ibOOofYUie3DxG4LdFFq?=
 =?us-ascii?Q?RLf2KiuTDDB9LlMVR2ME8H8sU6QvEBak0443X3gka5iLGERuk1D/Ud5EpqmL?=
 =?us-ascii?Q?TGVnX596YjPDkFI49b/YJuGsQ6B7o8UrISkqGKQasPyUJLP2f7E88CsV3hJT?=
 =?us-ascii?Q?/ZtXpjteswj7xs0S3Y72VsA9w7C5ZeN3gHHbqqfhr1kNc/KkX1gV3mn+5Y9L?=
 =?us-ascii?Q?s7UlECh7wwDRtbUJsMIfPJcR4fKQan4EHHh8nj/qo1UUsjFDn7g5AN0bA/39?=
 =?us-ascii?Q?M46s8eEwQ2IO3uNPbjdVnDk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3231544c-8e5e-436d-f5cd-08d9ec84ef05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 11:03:14.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTRL9QkWafe7Q3t1EIXiGNnnoX/u2kP2pTkhfToFbdBG4d0wthHg1cUabQg7uraOTlt9p/+52IaRFavVuAUBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441

This patch addressed to the comments in [1] from BPF maintainer Alexei
Starovoitov:

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

I dropped RET_PTR_TO_MPTCP_SOCK_OR_NULL, use RET_PTR_TO_BTF_ID_OR_NULL
instead as he suggested. Drop bpf_mptcp_sock_is_valid_access() and
bpf_mptcp_sock_convert_ctx_access() too. I tested our case, it works.

Now only one comment from him I don't know how to implement:

'''
Also this new helper is not exercised from C test. Only from asm.
Could you update patch 4 with such additional logic?
'''

Please give me some suggestions?

[1]
https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp=
.thefacebook.com/

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h   | 32 -----------------------------
 kernel/bpf/verifier.c | 20 ------------------
 net/mptcp/bpf.c       | 47 ++-----------------------------------------
 3 files changed, 2 insertions(+), 97 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a45b91db8477..0427b608990d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -405,7 +405,6 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
 	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
-	RET_PTR_TO_MPTCP_SOCK,		/* returns a pointer to mptcp_sock */
 	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
 	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memo=
ry */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf=
_id */
@@ -416,7 +415,6 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
 	RET_PTR_TO_SOCKET_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
-	RET_PTR_TO_MPTCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_MPTCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMO=
N,
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_=
ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
@@ -497,7 +495,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET,		 /* reg points to struct bpf_sock */
 	PTR_TO_SOCK_COMMON,	 /* reg points to sock_common */
 	PTR_TO_TCP_SOCK,	 /* reg points to struct tcp_sock */
-	PTR_TO_MPTCP_SOCK,	 /* reg points to struct mptcp_sock */
 	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
 	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
 	/* PTR_TO_BTF_ID points to a kernel struct that does not need
@@ -526,7 +523,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCKET_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_SOCKET,
 	PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
 	PTR_TO_TCP_SOCK_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
-	PTR_TO_MPTCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | PTR_TO_MPTCP_SOCK,
 	PTR_TO_BTF_ID_OR_NULL		=3D PTR_MAYBE_NULL | PTR_TO_BTF_ID,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
@@ -2353,34 +2349,6 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(en=
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdb8fc0e7368..dcf065ec2774 100644
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
@@ -2766,7 +2762,6 @@ static bool is_spillable_regtype(enum bpf_reg_type ty=
pe)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BUF:
@@ -3659,9 +3654,6 @@ static int check_sock_access(struct bpf_verifier_env =
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
@@ -3818,9 +3810,6 @@ static int check_ptr_alignment(struct bpf_verifier_en=
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
@@ -6740,9 +6729,6 @@ static int check_helper_call(struct bpf_verifier_env =
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
@@ -7457,7 +7443,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifie=
r_env *env,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
@@ -10832,7 +10817,6 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 		/* Only valid matches are exact, which memcmp() above
 		 * would have accepted
@@ -11363,7 +11347,6 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type =
type)
 	case PTR_TO_SOCKET:
 	case PTR_TO_SOCK_COMMON:
 	case PTR_TO_TCP_SOCK:
-	case PTR_TO_MPTCP_SOCK:
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 		return false;
@@ -12788,9 +12771,6 @@ static int convert_ctx_accesses(struct bpf_verifier=
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
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5332469fbb28..d1dbdf5d60b0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -11,52 +11,9 @@
=20
 #include "protocol.h"
=20
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
 BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
 {
-	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptcp(=
sk)) {
+	if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_=
mptcp(sk)) {
 		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);
=20
 		return (unsigned long)mptcp_sfc->conn;
@@ -67,6 +24,6 @@ BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
 const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
 	.func           =3D bpf_mptcp_sock,
 	.gpl_only       =3D false,
-	.ret_type       =3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,
+	.ret_type       =3D RET_PTR_TO_BTF_ID_OR_NULL,
 	.arg1_type      =3D ARG_PTR_TO_SOCK_COMMON,
 };
--=20
2.34.1

