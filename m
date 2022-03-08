Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86248D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646745435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QczyTf36WLF6RiwPjZcEUbZdKCp4RFvJhvgbWA4SnIA=;
	b=XP4TzrA8Lq33PrreE2vbuQ7qzINLdxDjoRypGqjLI+4Ki/HwpGccbxT9jsbmmfSe57o6bi
	TEiai0DeBvlUbkUc/B5W5v1/UED8WwQGYMD6v3Ky8tJD0oXDI+M//haFCV8LYTnd4xVwbM
	i1cNbmFDFwXxyncoQ05C5Sh4EkmB+BY=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-EubEZLF3N5C_Tc32ygGUfw-1; Tue, 08 Mar 2022 14:17:14 +0100
X-MC-Unique: EubEZLF3N5C_Tc32ygGUfw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/TRNQkplciUxn0hs7f77a7JvvCw4TXrKazL4bSttYRra+e67rH9aItT8Ojd5EAGPwUOFJAhK9HRgtZObEvR4a1Noq2AAJBkqDSlAAYi7Fb7hicA89Pl5q13acJwlZm5HiIWZIMsS1mjrm33kWHHL177N3tctfDAVA1JhAR24KE9S0frkCNJCtz7zckJETSXUpk0P8IAI+AfII9fYF0TyQ8pXprJtBnEld8j4AQH0kpoj5NS0SnXbicB/kBJYqU/sCCtNmeEZ4WZKIxYLFoLBvYOOS6nle5DI1gJMDH5hzGb4c+kIsN/SnubnZc8EG/K2ctHyG2LChGPF5SsD/Pd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ0l557PIJKHti6t23iVEEtFuxpn33BRZk+pmmHRMtM=;
 b=iaWP54zvemo+VsaluWf4MRmwX0aEwzOIHk1XifC1GRNxRZroH3ejkTxl2yzL5RB4iRlTrkyGKm99tYkTNMpSZ464Ld2xL8DrekeoTsnL4ysH0f9sBB+vknzPmJqAKq5/ujHZmxZQdWG2kp+PsbRQqs3XK24LRo28trVUfgqwsjtv/0oSmlSRLYK69qiTN06uQr5rhKj4NverTxPHey7VPCNEdVHNmaTuD79rwGon+MO7Re3o/W014hvW3VK0St4ROJlVOrySOoSIEeB8A/mi2v0aLhaARbEV4/whx81FpmzikW/GqilpyWE7WGthmfpiHwR+crPtHSmudr2Ii5P+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 13:17:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:17:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/5] Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
Date: Tue,  8 Mar 2022 21:16:54 +0800
Message-ID: <f44e1094d7b65fcd79c8813b8674c578377b42c7.1646745228.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646745228.git.geliang.tang@suse.com>
References: <cover.1646745228.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4fd4bf6-012e-4b6c-11e0-08da0105f541
X-MS-TrafficTypeDiagnostic: PAXPR04MB8142:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8142A7C64B2810977DB88658F8099@PAXPR04MB8142.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RYNV8OjlNIJYP46VvZjffSaZGAMTPcQ/4Elomr0Hv+sPMECzav8/mNEtMCwJ2PY36G1di9EQoaYvpGoCaiY8uyCS4+UfECa2Z57PaXNmRZKqm5D5qW0uZMABSICNzYOlLoM5cJohBxvYVQB1KpOiqBWntOhuMtBuyoLsRh2UHr6zQ4zeE5JaXYVuejDH/XayQIcA+cHdBFBzgKfuI1y0GzGi1GnhrO4w3W6jxd8quvF0TG6Qy1eMhC7eSL4vKvOMpIGDqTM5NPQ+LO4CabtXK7bUSNrHaN5ZJ+lxeL6mIhWvNZSiFSvDh/xfS9VlNE7k1CNu6GzFE3BFS2nvzbt9u1uWAvB8d7bwMzj6i0IUw1gtmo+YJsTpnUAj3i9Qfl7aODJwY1QVHa9XeUQURO99rNHPtmisrPl6hQt7Uju5XolzYn1R89NZCNsQobq28SWzlObjFfJkph47r1KV7O6yXFUqq+D+hywnzizkagfYTBJiwhUab/wmrFWCgqmTvPTwRhUgxd5tKfDrTFfafim4HWXXH5sH27iPcPzEYoEEZmjs4If3McVtkp1wWtQJT4cNMW4yElclfMGrwvDrfzNpn9dQ5wHzuMBCkwGgX4/9+RVDuUE1NqF0H9Y+I8bSVpPq4iSZnizaCxNDOzE0C3O0+4Tq+FOsCCMsqFBmmBXo2zL49sLiwRxg1t1bCjIg9RK6Jm531ITRVOmexDw34Yyh4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(6916009)(2616005)(6512007)(107886003)(44832011)(36756003)(2906002)(8936002)(5660300002)(26005)(4326008)(66476007)(66556008)(508600001)(6666004)(66946007)(38100700002)(86362001)(6506007)(6486002)(83380400001)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUpTbncoqpQmwvno7grTCTcUr9/uFUa3m1O7jQKnl/wmVgL3kacSZ3j7repl?=
 =?us-ascii?Q?HwJ9pmzacm74LsziBk0kdnPKttBH8E2dFveu/rZ6WB9PWcEfVKsYowYmLcRy?=
 =?us-ascii?Q?vm5fXPU88gXW+fCwVjnnKZbegtU6rrIRIJGtNKcKWQvZMQf2xurp9Se4+vGr?=
 =?us-ascii?Q?czPoRe+Tw15GQWMwsdMw0d+igodh03LwzkNzmdKcYZdyipUjqv6ymm6t5GyG?=
 =?us-ascii?Q?yGLOWTWW2hXjc/je4VFaPyzjPRUCS/8yxtT1xXBsGQSYDTZJIDU/BRBEF5cb?=
 =?us-ascii?Q?lqlkISO/NWeV2zwCOEJnjLdFxfL1J19huMpwsvLfgcV5Vq2zCjfQdkK8KLEa?=
 =?us-ascii?Q?cFX2zoRraKHAYntrqYddo1i57bolX/41BNDcPR531iUBsrnhnvM617KSbMa3?=
 =?us-ascii?Q?wdU63JcJR6bkoiF35h1rmgMN6pc24ahkhqf5tePJANfjlzmNRSDPYf130W1c?=
 =?us-ascii?Q?XHcFWswdVQmozz/gssPfbTkQJEQdXX7qA0HWRsmc/MXRWwkxbBdMRWsdDMYK?=
 =?us-ascii?Q?XMPbAQi1zYYjQGCZWeUfZ41HzEPL1GW3IOc7RAvxn03NaWwKvv45AcxkOFBp?=
 =?us-ascii?Q?7x+3tvbmAgCeqMfmJfEl6DpY+wk7wuJd2U3+WMF/SVprnTtlhijW27t41Yf5?=
 =?us-ascii?Q?+1FhannUzYeUyNZXdOlGoq5cMYTGhfAV8QAyuoUmJ2UY2Fh+rH1jTrffwgFS?=
 =?us-ascii?Q?/9AkIqDHwO7oxcHgmzRuldQ6ftszxWN9Zxgz8B34eOQqCh8Kd3nV/v9JmKdv?=
 =?us-ascii?Q?WpSn8v5eMpQXMD9rchnJ80QA6uGPDSR6etLHDTU5BMflsCXioo3fMcsTYeaF?=
 =?us-ascii?Q?xIqAZM7ZHgDYWfs/6z/b091IZ58c4iFtK04SXc0tvjkfu/iY9lh5Kq1QkrUa?=
 =?us-ascii?Q?+2KToxx7caxYRt624H+4I4J1PIDxuXn9ggF9IV9tTFqu/N4Owq3Zc+KzZ+qe?=
 =?us-ascii?Q?u6UiMPjSWUqSo/X5VuhH5leTR7X2PrG0Mf6HBPGFLcvs+avuGvjH01jrDGa4?=
 =?us-ascii?Q?wTL/W5LetyjRJh+zFWPHIQMzhgh+MSI9O5m/6nZaCgVaxNi+RFEvDscWIve2?=
 =?us-ascii?Q?icaHy+dJz8mSFgdfzUmXVVKKT0DG9Wv0SXfrm42RhOmPOzMmN6S39TNgdXf2?=
 =?us-ascii?Q?hoBGJnqoewOV0JPkzPRBWOFTIoZ8rcQUakb5XGhvXeVX/I4Z4xV2p4c3eEdZ?=
 =?us-ascii?Q?ZyORBrDaIUppQta4QMTVdgeAfm4FSjCD3TMlR7RkhGGq/CnhXWutAyBQCSJT?=
 =?us-ascii?Q?35v3PJ826OvUh3o/+iLfeYFXbE8MniMyOI97602oQketiI6sr72LdNxx6N+g?=
 =?us-ascii?Q?a7TL0PPiHcNmTFLRAy0njsJcb11CNzGRDrApulAW3dIeEGN0qnjYhWrAX+Y/?=
 =?us-ascii?Q?zEgKXx6L4tNQ0TtTmGDn7wdVtZBbwdnVo0jj2Iy+Gn618n4zyDlq3IuERFum?=
 =?us-ascii?Q?CrwYrXLh4Ts2qJoCpo2tZo77yfIjgLCc/6Z2jScZfGjzLERjZKbpMa/Hvb4K?=
 =?us-ascii?Q?8Qi8JrqpOOAVfXhkP7tkHlUrcsdEm4AQupgTZrEU8FvXVMGJPcqd2N+XmDON?=
 =?us-ascii?Q?Dfv4a2zWZwgKFvG/qa3aelu1vqq4de/tqp2vybrf6Mk2HZZtTe30Cz/yeuKL?=
 =?us-ascii?Q?hz+AjXNFstwquq4aOAWyczI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd4bf6-012e-4b6c-11e0-08da0105f541
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:17:13.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6xcta+Z/EBBRF2xtEXUJvgDg/FFmo07MCMLvBxYbHGeHcHcJtTJgs2sVt5zrLDKoYCmSK6lchothMKvrlEjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142

This reverts commit f48f0143286db0d8dbded9542d9a2535533dd3b9.
---
 tools/testing/selftests/bpf/verifier/sock.c | 63 ---------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/se=
lftests/bpf/verifier/sock.c
index 1f85588091ab..8c224eac93df 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -731,66 +731,3 @@
 	.result_unpriv =3D REJECT,
 	.errstr_unpriv =3D "unknown func",
 },
-{
-	"bpf_mptcp_sock(skops->sk): no !skops->sk check",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "type=3Dsock_or_null expected=3Dsock_common",
-},
-{
-	"bpf_mptcp_sock(skops->sk): no NULL check on ret",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "invalid mem access 'mptcp_sock_or_null'",
-},
-{
-	"bpf_mptcp_sock(skops->sk): msk->token",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_mptcp_sock, =
token)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D ACCEPT,
-},
-{
-	"bpf_mptcp_sock(skops->sk): msk->token cannot be modified",
-	.insns =3D {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct bpf_sock_ops, s=
k)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_mptcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_ST_MEM(BPF_W, BPF_REG_0, offsetof(struct bpf_mptcp_sock, token), 0x2a=
),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-	.result =3D REJECT,
-	.errstr =3D "cannot write into mptcp_sock",
-},
--=20
2.34.1

