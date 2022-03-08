Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB27C
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646736470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QczyTf36WLF6RiwPjZcEUbZdKCp4RFvJhvgbWA4SnIA=;
	b=JhzkINpxdCXU2EkYrc7FUuqK/Ow/teBNiuEHE4gZU1YuRAF+g3mE+n5i1i4LYQXA+VON84
	E7+/5V2fNBSRDUM+a1mMROIOf+dZn6rF81BL7TGIKNQyuXuXOCdwOHOf+cYqp7yWQQzMW8
	0JTxzCh3Jm2NNrXbtTiVuP6VDwwqjSw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-4Y5BfxhPPsqnDDgLigedZg-1; Tue, 08 Mar 2022 11:47:49 +0100
X-MC-Unique: 4Y5BfxhPPsqnDDgLigedZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQr0/96X4PGjSB+EZxZYUc9DugsI0To5j+o7QLBVP/DyZgu63DMaRMCXXjYJ49ljOuaYAMgLr2oEcKa2LGccfVO9pF5pxE6GHaGrqlJTRqut5gj+9eaRtdnFVBTIsBKJ6Pv2fSOQOKTpylFQ1DMOFI+jya9QZgrYwNLpcek5hcHoFCi2+2/lNDnVMmVI56UhZfdDW0mhtscWYk3S2c+zwuYpIGIgFR9n3OFK/rkdpnkVa7wZQGjmOZhyLkfwiOV+wgS2F990c7GOVxwfsB8rMLspMHtmqzkNzizSGaWc3VMWD8u1z6xVRcFXzZypXCOLDWrpI2xFOzWnlS39+hBEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ0l557PIJKHti6t23iVEEtFuxpn33BRZk+pmmHRMtM=;
 b=HNGtEI7axNhDvuUrtRk+CpGQcfbkjgJJoVUjfgqYM6SSnIaJmdbCktzf7ypeX8RRrWD1NqPVji87KBse/X+IE1sX+kon7yzrFfOuR98MrAt9cz1JDjQ6/ZcRc2BkN78i1EyoZm2qirTOZclglJTyd3mVIESLGzjXwC26VXHXrJ7P3Qp9hb4GTKxvfnGWaJYWamivU7TDIcA1XN6gPwmuM+wvg3gMAfFdUZjOznqBkHjbRjSC1aLfU5MOsJP2Y5d4mQb9kPZ3mlq+Hbi1n25FCtFYHinqJLXq86ufvqnnvu/32Tik2/fiCfMpOaakqMsETwhCPJl5T9ZaHQKWGHW04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 10:47:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:47:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/5] Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
Date: Tue,  8 Mar 2022 18:47:28 +0800
Message-ID: <f44e1094d7b65fcd79c8813b8674c578377b42c7.1646736285.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646736285.git.geliang.tang@suse.com>
References: <cover.1646736285.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab664c67-f69a-4ebb-d765-08da00f11635
X-MS-TrafficTypeDiagnostic: DBBPR04MB7929:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB79295EFBD1900AD927389F84F8099@DBBPR04MB7929.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6926vL2WNrEy0EbAKOWLKs7TQZYIQ/wP3JWZHZHnO0i/k/UlgCL8RBXVhq3Kqj+2OFfGeUzZmQCmy4R2/x+vlpHJw9KXhQw3Vg3AW6p6uufN23LPVMeVVdke4Otoa1vJXZvSY4jrcYrVyGqiloTF7LeHPWj081O4jEjNehBH57coqrxJ+6SyeK94R48beXB6rWSKbW+j7mlJ6Id1DJu+Kr6JPY2zvEyWSdnM5u+7HbG6oOwQ41MK85fa273+RqPhm1cjeisQ1Rw+CRGt9Y3hc1qKNDZ6078mRIr+0kfpF2wOCd+31r/lrfO/RvpzF/Zg4TCPIclqaol8pQQeE5JY4/sSvlTwY7XfJ22jNi1FPHZ+zEUG3pNodtYhdsc0EBWRMvE/79CkrjZbPjiZ5pbpZRScyry/swtcCnKduNr0988pKT4ShePZtkRv0DOLZImpy3/Th5w5NR8paI1FULnkagq2+/sh/htJh2KqPaNGKip9jn85/wr5QA1+i+Ro8n9nY+PNm29saPbGXQ659b9whUwadEE0DqAG2objoVs9/OfwxNVY0I0hv/bcVhmFbIudUqryay3gL3daBT790CBH2esb0PReHdDQpG/j0nFOf7gKKc84UF4/lYlm1Cpwt7WHS/1cPMa9maDPkfa4YuuIoR5oBwGzMUFumjQu6/6MFP5K5akz39wewy9YRT2qpP/v1K6Bf+4d4yR8gtBx8voX6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(107886003)(186003)(6666004)(6506007)(2616005)(38100700002)(83380400001)(4326008)(66946007)(44832011)(66476007)(8936002)(8676002)(5660300002)(6512007)(66556008)(36756003)(2906002)(508600001)(6916009)(6486002)(316002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2ZWztqxfZENBNxZItYPAi0DXbovwx7iCl4Ns1lx4dHUOl9nyXLb1K+D+iSa?=
 =?us-ascii?Q?WIBr7TkMH1Co3d++Rmu7iIBIbIpfOsGPHM2z0U9Ioo71SqlP0EEX7/uTQIW8?=
 =?us-ascii?Q?I1GejMErm+ho/iR1HQl79R70H5kunbjcDF6T67848Ek2nOgiX8Oh69dKiNLu?=
 =?us-ascii?Q?0RY+nZ/QGQH90y2MPTNSyjZARA0uRLqcFrfRuA0cchXvP+bWfDp1hkN3weFl?=
 =?us-ascii?Q?LUs3uCIrcuAvgr6+PvW9GpUUpJxnj1wjb7A4OEVuNC0XPXKKaraFMawL4N2m?=
 =?us-ascii?Q?7YS0ORukkb0e9lA/toHTwFcXiWcW6V2PBmZtlaDzAfoRat1UNqlEmGMEMJ2u?=
 =?us-ascii?Q?XcwKpFsddGBt2CoCO0PQK9CTdUihhyip3rHcSppx1073YGgIUomgE57F1h70?=
 =?us-ascii?Q?Za1oQWAKoTdYOTmHnuXihkRWKCXbo9bpy9d93oK54NerHmbAsGuqRioqQllP?=
 =?us-ascii?Q?q0s2oVjU8OA6zJOiolqUwI0OaOf9Je7B1F6h5bQnXOMFOsZ0KwkNrIYIeokB?=
 =?us-ascii?Q?rny/l+nat3Hpzs4K8GFcTivHHy2VSKtuZbGpA59xhYPZFQfIZtxl3dB9cepG?=
 =?us-ascii?Q?3SYBU/OZjhxKsSSLeskNelveojb2kfmNg4uHUDoicrsLS7BlMZhOIR5BP3nV?=
 =?us-ascii?Q?LN4nwMnaRqEjemnk6JnD4nIdP6G07q0JGxcYZow1AabXW9v9pH384nBUAtT3?=
 =?us-ascii?Q?/Sd11bNJdCHWN3XdCClJJbf+D823kmGBXinxzgHlQ+fuvbtN/AqQmVrAJJRh?=
 =?us-ascii?Q?PvZi1ZRfZlc+0SUVKMs/KMzMzQSa/wIeo+lxvm2+Lr8XQaEMb8lMiADY5oDX?=
 =?us-ascii?Q?0DrupDyBJr49lsNvq8sUe9qkfdTvkSC1nR5isqUkOVPQrx9yrfVAt93RQXNd?=
 =?us-ascii?Q?u8sNdmkKWpGFZF0xvaNhM+LJ8dAB5Ig6q6jvcRowYAcUkP4UzAGXKs6PSFfh?=
 =?us-ascii?Q?oukEvVMcZnKm2gopBRyCJdJBeeegO4uLDc2ZtrcoIrQeI50d8Gynb7w1BzXS?=
 =?us-ascii?Q?iwe33aZ3pl4HPoaJqrF4CB7fphsSlyc+/e8xbCYjFs9Lu/V2zFRn6KbGME0C?=
 =?us-ascii?Q?4bEuPYjMkYdrclTLc93pmJdeSj5cRZqR4Ox/vKST5aJ7zu9kw7NrQtT9zcW7?=
 =?us-ascii?Q?ph+GEy+HFjVcXWWGzWD3h5iCzQeQhYXetjPwO8P0REYCv/ql6O32ASwh6IqZ?=
 =?us-ascii?Q?vkpGIeQuhrXOv8BHpp/iI/tFlYErlW2kmI/Hc4Wx1WvZHAA416ofjyJn6eDr?=
 =?us-ascii?Q?eAjvPCg8XpfcBw/ZOyiUd6WFBgiPmgg360pDh37J/CLlABGOjsijAgcHzXsH?=
 =?us-ascii?Q?XpnECmNFZKGoUA7f+UjaKIJ5XjxfvPIftT9Kq6Df1bfFBg1ofgZ4fLi7knz+?=
 =?us-ascii?Q?52nlZYdzxwWcn/eYlamn6XYe3n6H5YKi1sTA8z6HmaZ/5EjEguBlP12Svoex?=
 =?us-ascii?Q?Sf+fRIXJBOV3WwCQIc0kCsdPtb85Udt4ruuql3rA3q4KHeE1mfOz2nuqW2ip?=
 =?us-ascii?Q?56Klt9lRdfxCp7IxXLPwz3r8sj1u+Fb7+xoi1S3qmmMq7GfPzNv15lEEEauN?=
 =?us-ascii?Q?OSBAAtb7PQ1EjPR5n25Apwl3tg3sxDivw3m3YAGAqBFZ3A4fsIIgfXcutikU?=
 =?us-ascii?Q?3Qy8K5BMEC/NvLMHLFFFsis=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab664c67-f69a-4ebb-d765-08da00f11635
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:47:48.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjCLFf501wTV2WUBbZQ4KdXRerEXkPvh289BUIkfwTdRW/zmXDJ4ALE5+YBzCZw4oVp+ZxOM4ZpVIP2MkVl8ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

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

