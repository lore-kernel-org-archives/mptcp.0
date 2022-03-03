Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408E7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646320978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IH9+kUQv02ud/elnbzWmF7DM3/FVlMWljyY6Jc8P7U=;
	b=GW1tGPETmpOZOXWiuRCgTa6D9i+2azJN/3eWl+6y2ANWIMygFtsvuZKQ/+QJOIRu9liqcx
	/Qc5+z2FHfH57IZH2on+OY22QgegTs5uoGnYr5Sf+lhT5hUk0wyE2SNnKB3p1fjSKVNhA6
	Yf8D7PfVzW1jUE94xJt3spuQC9FTV1c=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-iQt6oM0aMtqjW0vClhQ8BA-1; Thu, 03 Mar 2022 16:22:57 +0100
X-MC-Unique: iQt6oM0aMtqjW0vClhQ8BA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc3F+iQXBcBWDF9KkItYybaxNjrsJzNKtwXP5G5vGpERWrRHe11TNfKsAJsZ7Dn0CIqMT8ro7U8DiPHxUrtRIxHcbXvC/XKaH1HSDD1WlMbY8ejv45YW/+VSuhxZnfANpqb4VYNC/lW7AqSFpGFDveKMw/Ot9WJvUBHXvOMbH6nVhlfGI4rUKKw7gn7/F0Q55+/ba2tLnDwlbwFGEhft8a/WAa753pnUWYXldqrnIoPANsZWC6XbGOikogZAKMsydMpo+NW6ogdUseiHMWW/jk3nJsXuFyn/S9n6PGdpvSjfPYbG6HtQf1Nou2qmRvwWVJCt0x5M3Z5PQc0jYRKERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDzRSS2A/gHsMNtV8dH55DKgEtAQJA7cJ0mafdZ0V2g=;
 b=OPFa0MCTQ/t9kswitoN7h3qadi0X3L+ZAuI7FOKJpul2o7aNq/16BoCMCW71fCJ4efarLT6+IT2dODLgWof3n0d+kTvyZLvV84PNgAFvRYB87ICDjzuUS6Uo7VwFmQ33a8TKBtL1DIZhCqOs0eBMBMywREfTTxSi9b5j5DxWOXH+MFzQSORch2g8V8dL0Zd0UNmMp+Al9MW4Y9bQRpWd0S6z2M3nAAcaMfzBUIhuvN77/TGUdY8kS9OVOq5RclAlRUokcQD6/9LTrXrYsXeqq+dEFIDFxEZaLjFkD6XPnR0GN5oQ1pMtx6ZzNKQxtQOiVr9lFQcf1vaPBqMltcp1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3213.eurprd04.prod.outlook.com (2603:10a6:802:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 15:22:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 15:22:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 1/3] Squash to "bpf: add 'bpf_mptcp_sock' structure and helper"
Date: Thu,  3 Mar 2022 23:22:36 +0800
Message-ID: <bf46de1436af717fa8eff55a9c20ccaaa261796d.1646320786.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646320786.git.geliang.tang@suse.com>
References: <cover.1646320786.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:202::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d49fa01-8f1d-4de1-09c5-08d9fd29b0f9
X-MS-TrafficTypeDiagnostic: VI1PR04MB3213:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB32133591876CBCB33FFCDC87F8049@VI1PR04MB3213.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kd3Ywf0J1t2SLKptww6H+ZeoMeezZ1nu/Cb9hAyxB4ihEe+I6olKqiIg0TdtG+ldat6TLM3PxIIZsxtYNNTpJ6ema2m4X8Hf/ma/ap26OajQBIshoHhIwZMV3g+7GnYeMOVMobzIsvzO/Qt4xB8TIuJrCA9CpvMjZZFYiUslHKhD3Jr8UThXH+HI2jEMXSnQs0ane5qL7yRwbEaPq5Q4DefsQ6/cBsXimAXqYA6b56qBiz2m69o9w3O8EmHTWNMRyZ7oiSMHEhI8f5OWw8EbRnYk+dIPgjvRQPL4HWWW0A2FdioCxJwqR3ITlTo8qvwxUNytA95kX/KURdNXnDluVfsZNOrBxYr736CoXsV4dCju8jSivHVeSybmR/Np28juWS5xO4d2j3K4wGKFZW20GsgXjiOr7ZEztkTI41Bow1NOLTQTEJNJ9A7XFFgILmrYJlITPtt5xBcYBphiFVP4sDHRW09W6vi+2tO0iRl9CQvx6TPPqFPvyqb8F3SLaYPOGy+AFYGkf5jWEFHsqFqlfrZh5AbFC5rdyGeaMFvhMjVLUdBXAZg0e5Ugyytrl0pvaa01Eq+tOSYPJb1aRcJw2CwjMxi5//EOHPnJiZR+Z1G3Pk9JTAl3CTSjBpgrL+wyeTukAnIjqhuQE3Z/w5rZMfK3aN2/1UcJdDqRQcuyYZdf/gPQ7BIj+vuia1Vuh8jIsbuOt/LdPbdDIVpPOyryvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(4326008)(66946007)(2906002)(66476007)(2616005)(107886003)(6666004)(5660300002)(6506007)(8936002)(8676002)(6512007)(44832011)(316002)(86362001)(26005)(186003)(6486002)(6916009)(508600001)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4d2H4Zb/vjz32kZc3oKIV4CQ4v6qPsG+F4n0bzMhIakOgnrCv+gwZ/SR21pH?=
 =?us-ascii?Q?J6BU886T6DbslHjOf7YXZ9vvAOFk7HnyA/UlF1bfBXfryHFiIroEO12FOc7y?=
 =?us-ascii?Q?rH3tiqGs0rGAMD0MQ/KeCnFQd4cwrKlFWWnrGZbXAZ1eqRwrvq9EBL/fqkx3?=
 =?us-ascii?Q?KXgJMJgYXQEcVHOOi39qacMFygePmt6AlulmgOmJ/JcZcBkxotu+KuCv06AV?=
 =?us-ascii?Q?RLwXI2gja60xHqY6TUIkMCIgzbZDDboy2S53EjUi/6Evtb/Jh8U3Tqql8SN2?=
 =?us-ascii?Q?pm9Ypbx3ewqfkS1WkX7VlSmnBq+ignUGTt0WCkdApt2+4IkIMXuE28yKkXQN?=
 =?us-ascii?Q?gCiSFGvRarOHyAPcrunufYvnAg9KBA7R/l/uqzzc0GLt/5iEh15FXKHJHAmt?=
 =?us-ascii?Q?9F3kTEtkLWU/8HpFG7uCpykKwpEW8EwqqaDdYFM3s+Q27sgUWwC2KzXxw9Ao?=
 =?us-ascii?Q?hwzPXM++HMzJt/WFGo3edyjaPhDu9J9PgXQGUKXNQ5LV9j1neFpXGpmxNzb2?=
 =?us-ascii?Q?Wes6uyJXRTd7ZZNEMh2jIsVnnbQ+YiEdpmtuJ8GHSVt/+g8znFA+bDUoLvMG?=
 =?us-ascii?Q?gws5PlTTCZsoH1/NDTpERYevenxREz9rtY+GqOoe3Zz2LAS8aJ64H8jxT67Y?=
 =?us-ascii?Q?m1utLJ8+l4mYrMnSSyUE3VpA2aRyccAEhtcLnExQs/mfhTJYiTKpDRM4uVA0?=
 =?us-ascii?Q?noPFCBYU258cjM1DrzWTbXZUypBC9ds0/0aJwoKqfvfIn8wdioTAmogrvxbd?=
 =?us-ascii?Q?SzGY71wbyTjfOuoEqn7erYMdy3Kl9OlcJ4YWK2y8K3HfvyrhCmU69Z1mLdPn?=
 =?us-ascii?Q?8TWCZhgQ/XJSp9Vcg/4m6195ILoVV24ER1hheXxj7Uf56KoB8TERN0TKIaqS?=
 =?us-ascii?Q?JWdVrsMhDZ1Wi5CRR9eT02Z1F8LNUMQpgk+j9QponNp7hVD0DttrVcnx4uJn?=
 =?us-ascii?Q?MGX3d+goSAJDJJ8d44l4ZIsVIsOfVBk13n8+DF5zq6HndfG+jIWuBxrfz371?=
 =?us-ascii?Q?urjA7KLc6fABwTatOG43V3fAo/NjzMgARF2NAe0oo00mHHRFfcouHRYF+N5z?=
 =?us-ascii?Q?Y+V9TyNBMZXznK37p/qXxjGajbRFQlJZHmmsWeb0zSVsQadmIZlfH5zP0CA2?=
 =?us-ascii?Q?E3/B7N6jl2zKFToraWHQ10DMkekdnNxmixDa2WB3RJbpjFvuHitXR6Ki/AEb?=
 =?us-ascii?Q?COtAm3VTE/oAs4Fd7YZzHEzPbA5rZ1E6uhwVh7tFoLrkuWdpP098cZ2pYnab?=
 =?us-ascii?Q?mCeLDhmpQfpsqXzy8WpUp7uWaRR8xUcGbkHxKEEZ3aDaT7QlKFn98O272AxS?=
 =?us-ascii?Q?mumUyXvtSKsmMynPkutlGTO2hP8Q9yFJfwA25Kr86BP11xRt7g8TMxoAAlhf?=
 =?us-ascii?Q?MXk+czw5Omuevk/GlkbD3uGBc9kzN0/Fh1kO3A08NY0SnpJVJziJIHPzJQ7d?=
 =?us-ascii?Q?vXOtYBQRmWyJULRJcA6P0q3VfsNsyeL9+k2uvQoSPFlwmxSIunt0+XCCvZLV?=
 =?us-ascii?Q?CWWWuLzQwP3eI/05PCpKhBG0UKZwShbqKiT/nbRxSMl5r8XKhgaHPWRrIA63?=
 =?us-ascii?Q?pqc2QalP5vyxKhrb2UP6QXDH3haR8+/vYWrJ6QxjKPE/Z+stfyYl3lJAhO2X?=
 =?us-ascii?Q?yIIlAvThRV/90Qyfxg60Brs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49fa01-8f1d-4de1-09c5-08d9fd29b0f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:22:55.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDGeHjSg9erw6eO2uz1IU4Z1+CA55PK9ecxU+zig++aY6giITZtj5S7JbPNaH/Ncq5ZCG3mWcIlFPSPvDASsjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3213

Drop RET_PTR_TO_MPTCP_SOCK and bpf_mptcp_sock_convert_ctx_access as
Alexei suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h   | 20 -------------------
 kernel/bpf/verifier.c | 20 -------------------
 net/core/filter.c     |  4 ----
 net/mptcp/bpf.c       | 45 -------------------------------------------
 4 files changed, 89 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a17c1e3a6bc..0ae57df2f226 100644
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
@@ -2365,11 +2359,6 @@ bool bpf_mptcp_sock_is_valid_access(int off, int siz=
e,
 				    enum bpf_access_type type,
 				    struct bpf_insn_access_aux *info);
=20
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
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5332469fbb28..2e42a95d1206 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -25,48 +25,3 @@ bool bpf_mptcp_sock_is_valid_access(int off, int size, e=
num bpf_access_type type
 		return size =3D=3D sizeof(__u32);
 	}
 }
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
--=20
2.34.1

